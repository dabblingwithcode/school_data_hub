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

  static Future<void> resetActiveEnvDependentManagers() async {
    if (di.hasScope(DiScope.onLoggedInUserScope.name)) {
      _log.severe(
        '[DI] resetActiveEnvDependentManagers: [loggedInUserScope] already exists, dropping it...',
      );
      await di.dropScope(DiScope.onLoggedInUserScope.name);
    }
    //- TODO IMPORTANT: check if this is necessary - makes trouble setting up the first env
    if (di.hasScope(DiScope.onActiveEnvScope.name)) {
      _log.severe('[DI] [activeEnvScope] already exists, dropping it...');
      await di.dropScope(DiScope.onActiveEnvScope.name);
    }

    _log.warning('[DI]Active environment dependent managers reset');
    await registerManagersOnActiveEnvScope();
  }

  static Future<void> unregisterManagersDependentOnEnv() async {
    _log.warning('[DI]unregisterManagersDependentOnEnv: dropping scopes...');
    if (di.hasScope(DiScope.onLoggedInUserScope.name)) {
      _log.warning(
        '[DI] unregisterManagersDependentOnEnv: [loggedInUserScope] exists, dropping it ...',
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
    await dropMatrixScope();
  }

  static Future<void> registerMatrixManagers(
    MatrixCredentials? matrixCredentials,
  ) async {
    // Drop existing matrix scope if it exists
    if (di.hasScope(DiScope.onMatrixEnvScope.name)) {
      _log.info(
        '[DI] Dropping existing matrix scope before registering new one',
      );
      di.dropScope(DiScope.onMatrixEnvScope.name);
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
                ).init();

            _log.info('[DI] Matrix managers initialized');

            di<HubSessionManager>().changeMatrixPolicyManagerRegistrationStatus(
              true,
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
  }

  static Future<void> dropMatrixScope() async {
    if (di.hasScope(DiScope.onMatrixEnvScope.name)) {
      _log.info('[DI] Dropping matrix scope');
      di.dropScope(DiScope.onMatrixEnvScope.name);
    } else {
      _log.info('[DI] Matrix scope does not exist, skipping drop operation');
    }
  }
}
