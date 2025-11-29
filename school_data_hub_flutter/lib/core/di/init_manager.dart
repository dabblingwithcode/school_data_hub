import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/di/di_on_active_env.dart';
import 'package:school_data_hub_flutter/core/di/di_on_user_auth.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_connectivity_monitor.dart';
import 'package:school_data_hub_flutter/core/updater/shorebird_update_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_credentials.dart';
import 'package:watch_it/watch_it.dart';

enum DiScope { onActiveEnvScope, onLoggedInUserScope, onMatrixEnvScope }

final _log = Logger('InitManager');

class InitManager {
  static final InitManager _instance = InitManager._internal();

  factory InitManager() => _instance;

  InitManager._internal();

  static Future<void> registerCoreManagers() async {
    di.registerSingletonAsync<EnvManager>(() async {
      final envManager = EnvManager();

      await envManager.init();

      return envManager;
    });

    di.registerSingleton<DefaultCacheManager>(DefaultCacheManager());

    di.registerSingleton<NotificationService>(NotificationService());

    di.registerSingleton<ServerpodConnectivityMonitor>(
      ServerpodConnectivityMonitor(),
    );

    // Register ShorebirdUpdateManager
    di.registerSingletonAsync<ShorebirdUpdateManager>(() async {
      final updateManager = ShorebirdUpdateManager();
      await updateManager.initialize();
      return updateManager;
    });
  }

  static Future<void> pushActiveEnvScopeAndRegisterDependentManagers() async {
    if (di.hasScope(DiScope.onActiveEnvScope.name)) {
      _log.warning(
        'Active environment scope already exists, skipping registration',
      );
      return;
    }

    await di.pushNewScopeAsync(
      scopeName: DiScope.onActiveEnvScope.name,
      dispose: () {
        _log.warning('[DI] Disposing [activeEnvScope]');
      },
      init: (getIt) async {
        _log.fine('========================================================');
        _log.fine('[DI] Pushing Scope [activeEnvScope]');
        _log.warning(
          '========================================================',
        );

        await InitOnActiveEnv.registerManagers();
        _log.info(
          ' Managers dependent on [activeEnvScope] are being initialized...',
        );
      },
    );
  }

  /// These managers are initialized after the session manager authenticates
  /// the session. it is called in the [HubSessionManager] class after the session is authenticated.
  static Future<void> registerManagersDependingOnAuthedSession() async {
    _log.info('[DI] Registering managers depending on session');

    if (di.hasScope(DiScope.onLoggedInUserScope.name)) {
      _log.info(
        '[DI] [loggedInUserScope] already exists, skipping registration',
      );
      return;
    }

    await di.pushNewScopeAsync(
      scopeName: DiScope.onLoggedInUserScope.name,
      dispose: () {
        _log.warning(
          '########################################################',
        );

        _log.severe('[DI] Disposing Scope [loggedInUserScope]');
        _log.warning(
          '########################################################',
        );
      },
      init: (getIt) async {
        _log.warning(
          '########################################################',
        );

        _log.fine('[DI] Pushing Scope [loggedInUserScope]');
        _log.warning(
          '########################################################',
        );

        await DiInitOnUserAuth.registerManagers();
      },
    );

    _log.info(
      '[Init] Managers depending on authentication are being initialized...',
    );
  }

  static Future<void> dropOnLoggedInUserScope() async {
    if (di.hasScope(DiScope.onLoggedInUserScope.name)) {
      _log.severe(
        '[DI] Unregistering managers depending on session - dropping [loggedInUserScope]',
      );

      await di.dropScope(
        DiScope.onLoggedInUserScope.name,
      ); // This will dispose the 'logged_in_user_scope'
      _log.warning('########################################################');

      _log.info('[DI] [loggedInUserScope] dropped successfully');
      _log.warning('########################################################');
    } else {
      _log.severe(
        '[DI] [loggedInUserScope] does not exist, skipping drop operation',
      );
    }
  }

  static Future<void> dropOldActiveEnvAndRelatedScopes() async {
    _log.severe('[DI] Dropping old active environment scope');
    _log.warning('########################################################');

    if (di.hasScope(DiScope.onLoggedInUserScope.name)) {
      _log.severe('[DI] Dropping [loggedInUserScope] ...');

      await di.dropScope(DiScope.onLoggedInUserScope.name);
    }

    if (di.hasScope(DiScope.onActiveEnvScope.name)) {
      _log.severe('[DI] [activeEnvScope]  exists, dropping it...');
      _log.warning('########################################################');
      await di.dropScope(DiScope.onActiveEnvScope.name);
    }

    // Also drop matrix scope if it exists (it's environment-dependent)
    if (di.hasScope(DiScope.onMatrixEnvScope.name)) {
      _log.severe('[DI] dropping matrix scope...');
      _log.warning('########################################################');
      await dropMatrixScope();
    }
  }

  // static Future<void> cleanupAllEnvironmentManagers() async {
  //   _log.warning('[DI]cleanupAllEnvironmentManagers: starting...');
  //   try {
  //     _log.warning('[DI]cleanupAllEnvironmentManagers: dropping scopes...');
  //     if (di.hasScope(DiScope.onLoggedInUserScope.name)) {
  //       _log.warning(
  //         '[DI] cleanupAllEnvironmentManagers: [loggedInUserScope] exists, dropping it ...',
  //       );
  //       await di.dropScope(DiScope.onLoggedInUserScope.name);
  //     }

  //     if (di.hasScope(DiScope.onActiveEnvScope.name)) {
  //       await di.dropScope(DiScope.onActiveEnvScope.name);
  //       _log.warning('[DI] dropped [activeEnvScope]');
  //     } else {
  //       _log.info(
  //         '[DI] [activeEnvScope] does not exist, skipping drop operation',
  //       );
  //     }

  //     // Also drop matrix scope if it exists
  //     _log.warning(
  //       '[DI] cleanupAllEnvironmentManagers: dropping matrix scope...',
  //     );
  //     await dropMatrixScope();
  //     _log.warning('[DI]cleanupAllEnvironmentManagers: completed successfully');
  //   } catch (e) {
  //     _log.severe(
  //       '[DI]cleanupAllEnvironmentManagers: error occurred: $e',
  //       StackTrace.current,
  //     );
  //     rethrow;
  //   }
  // }

  /// Reads matrix credentials from secure storage.
  /// Returns null if credentials don't exist or are invalid.
  static Future<MatrixCredentials?> _readMatrixCredentialsFromStorage() async {
    try {
      // Wait for EnvManager to be ready before accessing it
      await di.isReady<EnvManager>();
      final envManager = await di.getAsync<EnvManager>();
      final secureStorage = HubSecureStorage();
      final storageKey = envManager.storageKeyForMatrixCredentials;

      _log.info('[DI] Reading matrix credentials from secure storage');
      final String? matrixStoredValues = await secureStorage.getString(
        storageKey,
      );

      if (matrixStoredValues == null) {
        _log.warning('[DI] No matrix credentials found in secure storage');
        return null;
      }

      final credentials = MatrixCredentials.fromJson(
        jsonDecode(matrixStoredValues),
      );

      _log.info('[DI] Matrix credentials successfully read from storage');
      return credentials;
    } catch (e) {
      _log.severe(
        '[DI] Error reading matrix credentials from storage: $e',
        StackTrace.current,
      );
      return null;
    }
  }

  /// Creates the matrix scope and registers managers with the given credentials.
  /// Returns the initialized MatrixPolicyManager instance.
  static Future<MatrixPolicyManager> _createMatrixScopeAndRegisterManagers(
    MatrixCredentials credentials,
  ) async {
    _log.info('[DI] Creating matrix scope and registering managers');

    // Drop existing matrix scope if it exists
    if (di.hasScope(DiScope.onMatrixEnvScope.name)) {
      _log.info('[DI] Dropping existing matrix scope before creating new one');
      await di.dropScope(DiScope.onMatrixEnvScope.name);
      await Future.delayed(const Duration(milliseconds: 50));
    }

    await di.pushNewScopeAsync(
      scopeName: DiScope.onMatrixEnvScope.name,
      dispose: () {
        _log.warning(
          '########################################################',
        );

        _log.severe('[DI] Disposing [matrixScope]');
        _log.warning(
          '########################################################',
        );
      },
      init: (getIt) async {
        _log.warning(
          '########################################################',
        );

        _log.fine('[DI] Pushing Scope [matrixScope]');
        _log.warning(
          '########################################################',
        );

        // Register the manager inside the matrix scope
        getIt.registerLazySingletonAsync<MatrixPolicyManager>(() async {
          _log.info('[DI] Registering MatrixPolicyManager in matrix scope');

          // Wait for HubSessionManager to be ready (we check this inside the factory
          // since registerLazySingletonAsync doesn't support dependsOn)
          await di.isReady<HubSessionManager>();

          final policyManager = await MatrixPolicyManager(
            credentials.url,
            credentials.policyToken,
            credentials.matrixToken,
            credentials.matrixAdmin,
            credentials.encryptionKey,
            credentials.encryptionIv,
          ).init();

          _log.info('[DI] Matrix managers initialized');

          // Set the registration status to true after the manager is fully initialized
          // Since we depend on HubSessionManager, it should be ready now
          di<HubSessionManager>().changeMatrixPolicyManagerRegistrationStatus(
            true,
          );
          _log.info(
            '[DI] Matrix registration status set to true after initialization',
          );

          return policyManager;
        });

        getIt.registerSingletonWithDependencies(() {
          return MatrixPolicyFilterManager(getIt<MatrixPolicyManager>());
        }, dependsOn: [MatrixPolicyManager]);
      },
    );

    // Wait for the manager to be ready
    await di.isReady<MatrixPolicyManager>();

    // Get the manager instance from the matrix scope
    // Use getAsync to avoid triggering the factory again
    final manager = await di.getAsync<MatrixPolicyManager>();
    _log.info('[DI] MatrixPolicyManager retrieved from matrix scope');

    di<NotificationService>().showSnackBar(
      NotificationType.success,
      '[DI] Matrix-Räumeverwaltung initialisiert',
    );

    return manager;
  }

  /// Registers matrix managers lazily. If credentials are passed, they are stored
  /// in secure storage. The actual scope and managers are created on first access.
  ///
  /// [storageKey] is optional. If provided, it will be used instead of accessing
  /// EnvManager from DI. This is useful when called during EnvManager initialization
  /// to avoid deadlocks.
  static Future<void> registerMatrixManagers(
    MatrixCredentials? matrixCredentials, {
    String? storageKey,
  }) async {
    try {
      _log.info('[DI] registerMatrixManagers: starting lazy registration');
      // Note: setIsMatrixSessionConfigured will be called when the manager is actually initialized
      // If credentials are passed, store them in secure storage
      if (matrixCredentials != null) {
        _log.info('[DI] Storing matrix credentials in secure storage');
        final secureStorage = HubSecureStorage();

        // Use provided storage key, or get it from EnvManager if available
        String? keyToUse = storageKey;
        if (keyToUse == null) {
          // Only try to access EnvManager if storage key wasn't provided
          // This avoids deadlocks when called during EnvManager initialization
          try {
            await di.isReady<EnvManager>();
            final envManager = await di.getAsync<EnvManager>();
            keyToUse = envManager.storageKeyForMatrixCredentials;
          } catch (e) {
            _log.warning(
              '[DI] Could not access EnvManager, credentials may not be stored: $e',
            );
            // Continue without storing - credentials might already be in storage
            keyToUse = null;
          }
        }

        if (keyToUse != null) {
          await secureStorage.setString(
            keyToUse,
            jsonEncode(matrixCredentials.toJson()),
          );
          _log.info('[DI] Matrix credentials stored successfully');

          // Mark that matrix session is configured immediately when credentials are available
          // This ensures UI updates correctly even if the manager is initialized lazily
          // Use .then() to avoid deadlock since HubSessionManager depends on EnvManager
          if (di.isRegistered<HubSessionManager>()) {
            di.isReady<HubSessionManager>().then((_) {
              di<HubSessionManager>().setIsMatrixSessionConfigured(true);
              _log.info(
                '[DI] Matrix session configured set to true (credentials available)',
              );
            });
          } else {
            _log.warning(
              '[DI] HubSessionManager not registered yet, cannot set matrix session configured',
            );
          }
        } else {
          _log.info(
            '[DI] Skipping credential storage (storage key not available)',
          );
        }
      }

      // Register the async singleton factory.
      // Note: GetIt may call the factory during registration for validation,
      // but with signalsReady: false, it won't block allReady().
      // The actual initialization only happens when code explicitly accesses it.
      if (!di.isRegistered<MatrixPolicyManager>()) {
        _log.info(
          '[DI] Registering MatrixPolicyManager async singleton factory',
        );

        di.registerLazySingletonAsync<MatrixPolicyManager>(() async {
          _log.info(
            '[DI] MatrixPolicyManager factory called (parent scope) - initializing...',
          );

          // Wait for HubSessionManager to be ready
          await di.isReady<HubSessionManager>();

          // Check if matrix scope already exists and manager is registered there
          if (di.hasScope(DiScope.onMatrixEnvScope.name)) {
            _log.info('[DI] Matrix scope already exists, checking for manager');
            try {
              await di.isReady<MatrixPolicyManager>();
              final manager = await di.getAsync<MatrixPolicyManager>();
              _log.info(
                '[DI] Found existing MatrixPolicyManager in matrix scope',
              );
              return manager;
            } catch (e) {
              _log.warning(
                '[DI] Matrix scope exists but manager not found, will create new one: $e',
              );
            }
          }

          // Read credentials from storage
          final credentials = await _readMatrixCredentialsFromStorage();
          if (credentials == null) {
            throw Exception(
              'Matrix credentials not found in secure storage. '
              'Please configure matrix environment first.',
            );
          }

          // Create scope and register managers, get the manager instance
          // This will register the manager inside the matrix scope
          final manager = await _createMatrixScopeAndRegisterManagers(
            credentials,
          );
          _log.info('[DI] MatrixPolicyManager successfully initialized');
          return manager;
        });

        _log.info('[DI] MatrixPolicyManager factory registered');
      } else {
        _log.info('[DI] MatrixPolicyManager already registered, skipping');
      }
    } catch (e) {
      _log.severe(
        '[DI] Error registering matrix managers: $e',
        StackTrace.current,
      );
      rethrow;
    }
  }

  static Future<void> dropMatrixScope() async {
    try {
      _log.info('[DI] dropMatrixScope: checking if matrix scope exists...');
      final hasScope = di.hasScope(DiScope.onMatrixEnvScope.name);
      _log.info('[DI] dropMatrixScope: hasScope = $hasScope');

      if (hasScope) {
        // Clear matrix credentials before dropping the scope
        try {
          if (di.isRegistered<MatrixPolicyManager>()) {
            final matrixManager = di<MatrixPolicyManager>();
            matrixManager.clearMatrixCredentials();
            _log.info('[DI] Matrix credentials cleared before dropping scope');
          }
        } catch (e) {
          _log.warning('[DI] Error clearing matrix credentials: $e');
        }

        _log.info('[DI] Dropping matrix scope');
        await di.dropScope(DiScope.onMatrixEnvScope.name);
        // Add a small delay to ensure the scope is fully dropped
        await Future.delayed(const Duration(milliseconds: 50));

        // Check if scope was actually dropped
        final scopeStillExists = di.hasScope(DiScope.onMatrixEnvScope.name);
        _log.info(
          '[DI] Matrix scope dropped successfully, scope still exists: $scopeStillExists',
        );

        // Reset the registration status in HubSessionManager
        try {
          if (di.isRegistered<HubSessionManager>()) {
            di<HubSessionManager>().changeMatrixPolicyManagerRegistrationStatus(
              false,
            );
            _log.info('[DI] Matrix registration status reset to false');
          }
        } catch (e) {
          _log.warning('[DI] Error resetting matrix registration status: $e');
        }
      } else {
        _log.info('[DI] Matrix scope does not exist, skipping drop operation');
      }
    } catch (e) {
      _log.warning('[DI] Error dropping matrix scope: $e');
      // Don't rethrow as this is cleanup operation
    }
  }
}
