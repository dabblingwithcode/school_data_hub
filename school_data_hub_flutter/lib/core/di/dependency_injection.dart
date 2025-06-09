import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/di/di_on_active_env.dart';
import 'package:school_data_hub_flutter/core/di/di_on_user_auth.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_connectivity_monitor.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_credentials.dart';
import 'package:watch_it/watch_it.dart';

enum DiScope {
  activeEnvScope,
  loggedInUserScope,
  matrixScope,
}

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

    di.registerSingleton<BottomNavManager>(BottomNavManager());
  }

  static Future<void> registerManagersDependingOnActiveEnv() async {
    if (di.hasScope(DiScope.activeEnvScope.name)) {
      _log.info(
          'Active environment scope already exists, skipping registration');
      return;
    }

    di.pushNewScopeAsync(
      scopeName: DiScope.activeEnvScope.name,
      dispose: () {
        _log.info('Disposing activeEnvScope');
      },
      init: (getIt) async {
        _log.info('Registering managers depending on activeEnvScope');
        await DiOnActiveEnv.registerManagers();
        _log.info('Managers dependent on active environment initialized');
      },
    );
  }

  /// These managers are initialized after the session manager authenticates
  /// the session. it is called in the [HubSessionManager] class after the session is authenticated.
  static Future<void> registerManagersDependingOnAuthedSession() async {
    _log.info('Registering managers depending on session');

    if (di.hasScope(DiScope.loggedInUserScope.name)) {
      await di.dropScope(DiScope.loggedInUserScope.name);
      _log.info(
          'Logged in user scope already exists, resetting it to reinitialize managers');
      return;
    }
    di.pushNewScopeAsync(
      scopeName: DiScope.loggedInUserScope.name,
      dispose: () {
        _log.info('Disposing loggedInUserScope');
      },
      init: (getIt) async {
        await DiOnUserAuth.registerManagers();
        _log.info('Managers depending on authenticated session initialized');
      },
    );
  }

  static Future<void> unregisterManagersDependingOnSession() async {
    _log.info('Unregistering managers depending on session');

    di.dropScope(DiScope.loggedInUserScope
        .name); // This will dispose the 'logged_in_user_scope'
  }

  static Future<void> resetActiveEnvDependentManagers() async {
    if (di.hasScope(DiScope.loggedInUserScope.name)) {
      await di.dropScope(DiScope.loggedInUserScope.name);
    }

    await di.dropScope(DiScope.activeEnvScope.name);
    _log.info('Active environment dependent managers reset');
    await registerManagersDependingOnActiveEnv();
  }

  static Future<void> unregisterManagersDependentOnEnv() async {
    _log.info('Unregistering managers depending on environment');

    await di.dropScope(DiScope.loggedInUserScope.name);
    await di.dropScope(DiScope.activeEnvScope.name);
  }

  static Future<void> registerMatrixManagers(
      MatrixCredentials? matrixCredentials) async {
    di.pushNewScopeAsync(
      scopeName: DiScope.matrixScope.name,
      dispose: () {
        _log.info('Disposing matrixScope');
      },
      init: (getIt) async {
        di.registerSingletonAsync<MatrixPolicyManager>(() async {
          _log.info('Registering MatrixPolicyManager');

          final policyManager = await MatrixPolicyManager(
                  matrixCredentials!.url,
                  matrixCredentials.policyToken,
                  matrixCredentials.matrixToken,
                  matrixCredentials.compulsoryRooms ?? [])
              .init();

          _log.info('Matrix managers initialized');

          di<HubSessionManager>()
              .changeMatrixPolicyManagerRegistrationStatus(true);

          return policyManager;
        }, dependsOn: [
          HubSessionManager
        ]); // TODO: add dependency to PupilManager?

        di.registerSingletonWithDependencies(() {
          return MatrixPolicyFilterManager(di<MatrixPolicyManager>());
        }, dependsOn: [MatrixPolicyManager]);
      },
    );

    di<NotificationService>().showSnackBar(
        NotificationType.success, 'Matrix-Räumeverwaltung initialisiert');
  }
}
