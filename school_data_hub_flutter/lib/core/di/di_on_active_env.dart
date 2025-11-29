import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/auth/hub_auth_key_manager.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_connectivity_monitor.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('DiOnActiveEnv');

class DiOnActiveEnv {
  static Future<void> registerManagers() async {
    _log.info('[DI] Registering managers on active environment scope');
    di.registerSingletonWithDependencies<HubAuthKeyManager>(() {
      return HubAuthKeyManager(
        storageKeyForAuthKey: di<EnvManager>().storageKeyForAuthKey,
      );
    }, dependsOn: [EnvManager]);

    di.registerSingletonWithDependencies<Client>(() {
      final envManager = di<EnvManager>();
      final activeEnv = envManager.activeEnv;

      _log.info('[DI] Registering Client for environment:');
      _log.info('[DI]   - Name: ${activeEnv?.serverName}');
      _log.info('[DI]   - Server URL: ${activeEnv?.serverUrl}');
      _log.info('[DI]   - Run Mode: ${activeEnv?.runMode.name}');

      final serverUrl = activeEnv!.serverUrl;
      _log.info('[DI] Creating Client with server URL: $serverUrl');

      return Client(
        serverUrl,
        authenticationKeyManager: di<HubAuthKeyManager>(),
      )..connectivityMonitor = di<ServerpodConnectivityMonitor>();
    }, dependsOn: [HubAuthKeyManager]);

    di.registerSingletonAsync<HubSessionManager>(
      () async {
        // like described in the serverpod documentation
        // https://docs.serverpod.dev/concepts/authentication/setup#app-setup
        final sessionManager = HubSessionManager(
          caller: di<Client>().modules.auth,
        );

        // this will initialize the session manager and load the stored user info
        // it returns a bool
        await sessionManager.initialize();
        _log.info('SessionManager initialized');
        return sessionManager;
      },
      dependsOn: [EnvManager, Client],
      dispose: (param) => param.dispose(),
    );

    // Register BottomNavManager in active environment scope so it's always available
    di.registerSingleton<BottomNavManager>(BottomNavManager());
  }
}
