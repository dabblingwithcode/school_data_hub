import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
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

final _log = Logger('DiManager');

class DiManager {
  static final DiManager _instance = DiManager._internal();

  factory DiManager() => _instance;

  DiManager._internal();

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

  static Future<void> registerManagersOnActiveEnvScope() async {
    if (di.hasScope(DiScope.onActiveEnvScope.name)) {
      _log.info(
        'Active environment scope already exists, skipping registration',
      );
      return;
    }

    di.pushNewScopeAsync(
      scopeName: DiScope.onActiveEnvScope.name,
      dispose: () {
        _log.warning('[DI] Disposing [activeEnvScope]');
      },
      init: (getIt) async {
        _log.info('[DI] Pushing Scope [activeEnvScope]');
        await DiOnActiveEnv.registerManagers();
        _log.info('[DI] Managers dependent on [activeEnvScope] initialized');
      },
    );
  }

  /// These managers are initialized after the session manager authenticates
  /// the session. it is called in the [HubSessionManager] class after the session is authenticated.
  static Future<void> registerManagersDependingOnAuthedSession() async {
    _log.info('[DI] Registering managers depending on session');

    if (di.hasScope(DiScope.onLoggedInUserScope.name)) {
      _log.severe(
        '[DI] [loggedInUserScope] already exists, dropping [loggedInUserScope] it to reinitialize managers...',
      );
      await di.dropScope(DiScope.onLoggedInUserScope.name);

      return;
    }
    di.pushNewScopeAsync(
      scopeName: DiScope.onLoggedInUserScope.name,
      dispose: () {
        _log.severe('[DI] Disposing Scope [loggedInUserScope]', [
          StackTrace.current,
        ]);
      },
      init: (getIt) async {
        _log.info('[DI] Pushing Scope [loggedInUserScope]');
        await DiInitOnUserAuth.registerManagers();
        _log.info(
          '[DI] Managers depending on authenticated session initialized',
        );
      },
    );
  }

  static Future<void> dropOnLoggedInUserScope() async {
    if (di.hasScope(DiScope.onLoggedInUserScope.name)) {
      _log.severe(
        '[DI] Unregistering managers depending on session - dropping [loggedInUserScope]',
      );

      di.dropScope(
        DiScope.onLoggedInUserScope.name,
      ); // This will dispose the 'logged_in_user_scope'
    } else {
      _log.info(
        '[DI] [loggedInUserScope] does not exist, skipping drop operation',
      );
    }
  }

  static Future<void> switchEnvironmentAndReinitializeManagers() async {
    _log.info(
      '[DI] switchEnvironmentAndReinitializeManagers: starting environment switch...',
    );

    if (di.hasScope(DiScope.onLoggedInUserScope.name)) {
      _log.severe(
        '[DI] switchEnvironmentAndReinitializeManagers: [loggedInUserScope] already exists, dropping it...',
      );
      await di.dropScope(DiScope.onLoggedInUserScope.name);
    }

    //- TODO IMPORTANT: check if this is necessary - makes trouble setting up the first env
    if (di.hasScope(DiScope.onActiveEnvScope.name)) {
      _log.severe('[DI] [activeEnvScope] already exists, dropping it...');
      await di.dropScope(DiScope.onActiveEnvScope.name);
    }

    // Also drop matrix scope if it exists (it's environment-dependent)
    _log.warning(
      '[DI] switchEnvironmentAndReinitializeManagers: dropping matrix scope...',
    );
    await dropMatrixScope();

    _log.info('[DI] Environment managers switched and reinitialized');

    // Re-register active environment scope with new environment data
    // This ensures PupilIdentityManager and other environment-dependent managers are available
    await registerManagersOnActiveEnvScope();

    _log.info(
      '[DI] switchEnvironmentAndReinitializeManagers: completed successfully',
    );
  }

  static Future<void> cleanupAllEnvironmentManagers() async {
    _log.warning('[DI]cleanupAllEnvironmentManagers: starting...');
    try {
      _log.warning('[DI]cleanupAllEnvironmentManagers: dropping scopes...');
      if (di.hasScope(DiScope.onLoggedInUserScope.name)) {
        _log.warning(
          '[DI] cleanupAllEnvironmentManagers: [loggedInUserScope] exists, dropping it ...',
        );
        await di.dropScope(DiScope.onLoggedInUserScope.name);
      }

      if (di.hasScope(DiScope.onActiveEnvScope.name)) {
        await di.dropScope(DiScope.onActiveEnvScope.name);
        _log.warning('[DI] dropped [activeEnvScope]');
      } else {
        _log.info(
          '[DI] [activeEnvScope] does not exist, skipping drop operation',
        );
      }

      // Also drop matrix scope if it exists
      _log.warning(
        '[DI] cleanupAllEnvironmentManagers: dropping matrix scope...',
      );
      await dropMatrixScope();
      _log.warning('[DI]cleanupAllEnvironmentManagers: completed successfully');
    } catch (e) {
      _log.severe(
        '[DI]cleanupAllEnvironmentManagers: error occurred: $e',
        StackTrace.current,
      );
      rethrow;
    }
  }

  static Future<void> registerMatrixManagers(
    MatrixCredentials? matrixCredentials,
  ) async {
    try {
      _log.info(
        '[DI] registerMatrixManagers: checking if matrix scope exists...',
      );
      final hasScope = di.hasScope(DiScope.onMatrixEnvScope.name);
      _log.info('[DI] registerMatrixManagers: hasScope = $hasScope');

      // Drop existing matrix scope if it exists
      if (hasScope) {
        _log.info(
          '[DI] Dropping existing matrix scope before registering new one',
        );
        await di.dropScope(DiScope.onMatrixEnvScope.name);
        // Add a small delay to ensure the scope is fully dropped
        await Future.delayed(const Duration(milliseconds: 50));

        // Check if scope was actually dropped
        final scopeStillExists = di.hasScope(DiScope.onMatrixEnvScope.name);
        _log.info(
          '[DI] registerMatrixManagers: scope still exists after drop: $scopeStillExists',
        );

        // If scope still exists, try to force drop it
        if (scopeStillExists) {
          _log.warning(
            '[DI] Matrix scope still exists after drop, trying force drop...',
          );
          try {
            await di.dropScope(DiScope.onMatrixEnvScope.name);
            await Future.delayed(const Duration(milliseconds: 100));
            final scopeStillExistsAfterForce = di.hasScope(
              DiScope.onMatrixEnvScope.name,
            );
            _log.info(
              '[DI] After force drop, scope still exists: $scopeStillExistsAfterForce',
            );
          } catch (e) {
            _log.warning('[DI] Error during force drop: $e');
          }
        }
      }

      di.pushNewScopeAsync(
        scopeName: DiScope.onMatrixEnvScope.name,
        dispose: () {
          _log.info('[DI] Disposing [matrixScope]');
        },
        init: (getIt) async {
          _log.info('[DI] Pushing Scope [matrixScope]');

          di.registerSingletonAsync<MatrixPolicyManager>(
            () async {
              _log.info('[DI] Registering MatrixPolicyManager');

              final policyManager =
                  await MatrixPolicyManager(
                    matrixCredentials!.url,
                    matrixCredentials.policyToken,
                    matrixCredentials.matrixToken,
                    matrixCredentials.matrixAdmin,
                    matrixCredentials.encryptionKey,
                    matrixCredentials.encryptionIv,
                  ).init();

              _log.info('[DI] Matrix managers initialized');

              // Set the registration status to true after the manager is fully initialized
              // Since we depend on HubSessionManager, it should be ready now
              di<HubSessionManager>()
                  .changeMatrixPolicyManagerRegistrationStatus(true);
              _log.info(
                '[DI] Matrix registration status set to true after initialization',
              );

              return policyManager;
            },
            dependsOn: [HubSessionManager],
          ); // TODO: add dependency to PupilManager?

          di.registerSingletonWithDependencies(() {
            return MatrixPolicyFilterManager(di<MatrixPolicyManager>());
          }, dependsOn: [MatrixPolicyManager]);
        },
      );

      di<NotificationService>().showSnackBar(
        NotificationType.success,
        '[DI] Matrix-Räumeverwaltung initialisiert',
      );
    } catch (e) {
      _log.severe(
        '[DI] Error registering matrix managers: $e',
        StackTrace.current,
      );
      // Try to clean up any partial registration
      try {
        if (di.hasScope(DiScope.onMatrixEnvScope.name)) {
          await di.dropScope(DiScope.onMatrixEnvScope.name);
        }
      } catch (cleanupError) {
        _log.warning('[DI] Error during cleanup: $cleanupError');
      }
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
