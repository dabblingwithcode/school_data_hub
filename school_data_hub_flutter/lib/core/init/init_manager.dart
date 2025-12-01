import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/init/init_on_active_env.dart';
import 'package:school_data_hub_flutter/core/init/init_on_user_auth.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_connectivity_monitor.dart';
import 'package:school_data_hub_flutter/core/updater/shorebird_update_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_credentials.dart';
import 'package:watch_it/watch_it.dart';

enum DiScope { onActiveEnvScope, onLoggedInUserScope, onMatrixEnvScope }

final _log = Logger('[Init][Manager]');

class InitManager {
  static final InitManager _instance = InitManager._internal();

  factory InitManager() => _instance;

  InitManager._internal();

  static Future<void> registerCoreManagers() async {
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

    di.registerSingleton<EnvManager>(EnvManager());
  }

  static Future<void> pushActiveEnvScopeAndRegisterDependentManagers() async {
    if (di.hasScope(DiScope.onActiveEnvScope.name)) {
      _log.warning(
        'Active environment scope already exists, skipping registration',
      );
      return;
    }

    di.pushNewScope(
      scopeName: DiScope.onActiveEnvScope.name,
      dispose: () {
        _log.info('Dropping scope[activeEnvScope]');
        _log.warning(
          '======================================================== [SCOPE] [activeEnvScope]',
        );
      },
      init: (getIt) async {
        _log.info('Pushing scope [activeEnvScope]');
        _log.fine(
          '======================================================== [SCOPE] [activeEnvScope]',
        );

        InitOnActiveEnv.registerManagers();
        _log.info(
          ' Managers dependent on [activeEnvScope] are being initialized...',
        );
      },
    );
  }

  /// These managers are initialized after the session manager authenticates
  /// the session. it is called in the [HubSessionManager] class after the session is authenticated.
  static Future<void> registerManagersDependingOnAuthedSession() async {
    _log.info('Registering managers depending on session');

    if (di.hasScope(DiScope.onLoggedInUserScope.name)) {
      _log.info('[loggedInUserScope] already exists, skipping registration');
      return;
    }

    await di.pushNewScopeAsync(
      scopeName: DiScope.onLoggedInUserScope.name,
      dispose: () {
        _log.info('Dropping scope [loggedInUserScope]');
        _log.warning(
          '======================================================== [SCOPE] [loggedInUserScope]',
        );
      },
      init: (getIt) async {
        _log.info('Pushing scope [loggedInUserScope]');
        _log.fine(
          '======================================================== [SCOPE] [loggedInUserScope]',
        );

        await InitOnUserAuth.registerManagers();
      },
    );
  }

  static Future<void> dropOnLoggedInUserScope() async {
    if (di.hasScope(DiScope.onLoggedInUserScope.name)) {
      _log.info('Dropping scope [loggedInUserScope]...');

      await di.dropScope(
        DiScope.onLoggedInUserScope.name,
      ); // This will dispose the 'logged_in_user_scope'
      _log.info('[loggedInUserScope] dropped successfully');
      _log.warning(
        '======================================================== [SCOPE] [loggedInUserScope]',
      );
    } else {
      _log.severe(
        '[loggedInUserScope] does not exist, skipping drop operation',
        StackTrace.current,
      );
      _log.severe(
        '======================================================== [SCOPE] [loggedInUserScope]',
      );
    }
  }

  static Future<void> dropOldActiveEnvAndRelatedScopes() async {
    _log.info('Dropping old [activeEnv] and related scopes...');

    if (di.hasScope(DiScope.onLoggedInUserScope.name)) {
      await di.dropScope(DiScope.onLoggedInUserScope.name);
      _log.info('[loggedInUserScope] dropped successfully');
      _log.warning(
        '======================================================== [SCOPE] [loggedInUserScope]',
      );
    }

    if (di.hasScope(DiScope.onActiveEnvScope.name)) {
      await di.dropScope(DiScope.onActiveEnvScope.name);
      _log.info('[activeEnvScope] dropped successfully');
      _log.warning(
        '======================================================== [SCOPE] [activeEnvScope]',
      );
    }

    // Also drop matrix scope if it exists (it's environment-dependent)
    if (di.hasScope(DiScope.onMatrixEnvScope.name)) {
      _log.info('Matrix scope exists, dropping it...');
      _log.warning('========================================================');
      await dropMatrixScope();
      _log.info('[matrixScope] dropped successfully');
      _log.warning(
        '======================================================== [SCOPE] [matrixScope]',
      );
    }
  }

  /// Creates the matrix scope and registers managers with the given credentials.
  /// Returns the initialized MatrixPolicyManager instance.
  static Future<MatrixPolicyManager> _createMatrixScopeAndRegisterManagers(
    MatrixCredentials credentials,
  ) async {
    _log.info('Creating matrix scope and registering managers');

    // Drop existing matrix scope if it exists
    if (di.hasScope(DiScope.onMatrixEnvScope.name)) {
      _log.info('Dropping existing matrix scope before creating new one');
      await di.dropScope(DiScope.onMatrixEnvScope.name);
      await Future.delayed(const Duration(milliseconds: 50));
    }

    await di.pushNewScopeAsync(
      scopeName: DiScope.onMatrixEnvScope.name,
      dispose: () {
        _log.fine('Dropping scope [matrixScope]');
        _log.warning(
          '======================================================== [SCOPE] [matrixScope]',
        );
      },
      init: (getIt) async {
        _log.info('Pushing scope [matrixScope]');
        _log.fine(
          '======================================================== [SCOPE] [matrixScope]',
        );

        // Register the manager inside the matrix scope
        getIt.registerLazySingletonAsync<MatrixPolicyManager>(() async {
          _log.info('Registering MatrixPolicyManager in matrix scope');

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

          _log.info('Matrix managers initialized');

          // Set the registration status to true after the manager is fully initialized
          // Since we depend on HubSessionManager, it should be ready now
          di<HubSessionManager>().changeMatrixPolicyManagerRegistrationStatus(
            true,
          );
          _log.info(
            'Matrix registration status set to true after initialization',
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
    _log.info('MatrixPolicyManager retrieved from matrix scope');

    di<NotificationService>().showSnackBar(
      NotificationType.success,
      'Matrix-Räumeverwaltung initialisiert',
    );

    return manager;
  }

  /// Registers matrix managers lazily. If credentials are passed, they are stored
  /// in secure storage. The actual scope and managers are created on first access.
  ///
  /// [storageKey] is optional. If provided, it will be used instead of accessing
  /// EnvManager from DI. This is useful when called during EnvManager initialization
  /// to avoid deadlocks.
  static Future<void> registerMatrixManagers() async {
    try {
      _log.info('RegisterMatrixManagers: starting lazy registration');
      // Note: setIsMatrixSessionConfigured will be called when the manager is actually initialized

      // Mark that matrix session is configured immediately
      // This ensures UI updates correctly even if the manager is initialized lazily
      // Use .then() to avoid deadlock since HubSessionManager depends on EnvManager
      if (di.isRegistered<HubSessionManager>()) {
        di.isReady<HubSessionManager>().then((_) {
          di<HubSessionManager>().setIsMatrixSessionConfigured(true);
          _log.info(
            'Matrix session configured set to true (credentials assumed available)',
          );
        });
      } else {
        _log.warning(
          'HubSessionManager not registered yet, cannot set matrix session configured',
        );
      }

      // Note: GetIt may call the factory during registration for validation,
      // but with signalsReady: false, it won't block allReady().
      // The actual initialization only happens when code explicitly accesses it.
      if (!di.isRegistered<MatrixPolicyManager>()) {
        _log.info('Registering MatrixPolicyManager async singleton lazily');

        di.registerLazySingletonAsync<MatrixPolicyManager>(() async {
          _log.info(
            'MatrixPolicyManager called (parent scope) - initializing...',
          );

          // Wait for HubSessionManager to be ready
          await di.isReady<HubSessionManager>();

          // Check if matrix scope already exists and manager is registered there
          if (di.hasScope(DiScope.onMatrixEnvScope.name)) {
            _log.info('Matrix scope already exists, checking for manager');
            try {
              await di.isReady<MatrixPolicyManager>();
              final manager = await di.getAsync<MatrixPolicyManager>();
              _log.info('Found existing MatrixPolicyManager in matrix scope');
              return manager;
            } catch (e) {
              _log.warning(
                'Matrix scope exists but manager not found, will create new one: $e',
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
          _log.info('MatrixPolicyManager successfully initialized');
          return manager;
        });

        _log.info('MatrixPolicyManager factory registered');
      } else {
        _log.info('MatrixPolicyManager already registered, skipping');
      }
    } catch (e) {
      _log.severe('Error registering matrix managers: $e', StackTrace.current);
      rethrow;
    }
  }

  /// Reads matrix credentials from secure storage.
  /// Returns null if credentials don't exist or are invalid.
  static Future<MatrixCredentials?> _readMatrixCredentialsFromStorage() async {
    try {
      // Wait for EnvManager to be ready before accessing it
      await di.isReady<EnvManager>();
      final envManager = await di.getAsync<EnvManager>();
      final secureStorage = HubSecureStorage();
      final storageKey = envManager.storageKeyForMatrixCredentials;

      _log.info('Reading matrix credentials from secure storage');
      final String? matrixStoredValues = await secureStorage.getString(
        storageKey,
      );

      if (matrixStoredValues == null) {
        _log.warning('No matrix credentials found in secure storage');
        return null;
      }

      final credentials = MatrixCredentials.fromJson(
        jsonDecode(matrixStoredValues),
      );

      _log.info('Matrix credentials successfully read from storage');
      return credentials;
    } catch (e) {
      _log.severe(
        'Error reading matrix credentials from storage: $e',
        StackTrace.current,
      );
      return null;
    }
  }

  static Future<void> dropMatrixScope() async {
    try {
      final hasScope = di.hasScope(DiScope.onMatrixEnvScope.name);

      if (hasScope) {
        _log.info('Dropping scope [matrixScope]...');
        _log.warning(
          '======================================================== [SCOPE] [matrixScope]',
        );
        await di.dropScope(DiScope.onMatrixEnvScope.name);
        _log.info('[matrixScope] dropped successfully');
        _log.warning(
          '======================================================== [SCOPE] [matrixScope]',
        );
        // Add a small delay to ensure the scope is fully dropped
        // await Future.delayed(const Duration(milliseconds: 50));

        // Check if scope was actually dropped
        final scopeStillExists = di.hasScope(DiScope.onMatrixEnvScope.name);
        if (!scopeStillExists) _log.info('Matrix scope dropped successfully!');

        // Reset the registration status in HubSessionManager
        try {
          if (di.isRegistered<HubSessionManager>()) {
            di<HubSessionManager>().changeMatrixPolicyManagerRegistrationStatus(
              false,
            );
            _log.info('Matrix registration status reset to false');
          }
        } catch (e) {
          _log.warning('Error resetting matrix registration status: $e');
        }
      } else {
        _log.info('Matrix scope does not exist, skipping drop operation');
      }
    } catch (e) {
      _log.warning('Error dropping matrix scope: $e');
      // Don't rethrow as this is cleanup operation
    }
  }
}
