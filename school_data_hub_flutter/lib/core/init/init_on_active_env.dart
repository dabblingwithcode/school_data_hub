import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/auth/hub_auth_key_manager.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_connectivity_monitor.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('[Init][OnActiveEnv]');

class InitOnActiveEnv {
  static Future<void> registerManagers() async {
    _log.info('Registering managers on active environment scope');
    di.registerSingleton<HubAuthKeyManager>(
      HubAuthKeyManager(
        storageKeyForAuthKey: di<EnvManager>().storageKeyForAuthKey,
      ),
    );

    di.registerSingleton<Client>(
      (() {
        final envManager = di<EnvManager>();
        final activeEnv = envManager.activeEnv;
        final serverUrl = activeEnv!.serverUrl;
        _log.info('ClientURL: [${activeEnv.serverUrl}]');
        _log.fine(
          '======================================================== [CLIENT] [${activeEnv.serverName}] [${activeEnv.runMode.name}]',
        );

        return Client(
          serverUrl,
          authenticationKeyManager: di<HubAuthKeyManager>(),
        )..connectivityMonitor = di<ServerpodConnectivityMonitor>();
      })(),
    );

    di.registerSingletonAsync<HubSessionManager>(() async {
      // like described in the serverpod documentation
      // https://docs.serverpod.dev/concepts/authentication/setup#app-setup
      final sessionManager = HubSessionManager(
        caller: di<Client>().modules.auth,
      );

      // this will initialize the session manager and load the stored user info
      // it returns a bool
      await sessionManager.initialize();
      _log.fine('HubSessionManager initialized');
      _log.info('========================================================');
      return sessionManager;
    }, dispose: (param) => param.dispose());

    // Register BottomNavManager in active environment scope so it's always available
    di.registerSingleton<BottomNavManager>(BottomNavManager());
  }
}
