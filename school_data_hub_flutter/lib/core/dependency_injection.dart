import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/auth/hub_auth_key_manager.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/landing_bottom_nav_bar.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:watch_it/watch_it.dart';

class DiManager {
  static final DiManager _instance = DiManager._internal();
  factory DiManager() => _instance;
  DiManager._internal();

  static void registerBaseManagers() {
    di.registerSingletonAsync<EnvManager>(() async {
      final envManager = EnvManager();
      await envManager.init();
      return envManager;
    });

    di.registerSingleton<NotificationService>(NotificationService());
    di.registerSingleton<MainMenuBottomNavManager>(MainMenuBottomNavManager());
  }

  static Future<void> registerManagersDependingOnActiveEnv() async {
    di.registerSingletonWithDependencies<HubAuthKeyManager>(() {
      return HubAuthKeyManager(
        runMode: di<EnvManager>().activeEnvRunMode.value.name,
        envName: di<EnvManager>().env!.name,
      );
    }, dependsOn: [EnvManager]);
    di.registerSingletonWithDependencies<Client>(() {
      return Client(
        di<EnvManager>().env!.serverUrl,
        authenticationKeyManager: di<HubAuthKeyManager>(),
      )..connectivityMonitor = FlutterConnectivityMonitor();
    }, dependsOn: [HubAuthKeyManager]);
    di.registerSingletonAsync<ServerpodSessionManager>(() async {
      // like described in the serverpod documentation
      // https://docs.serverpod.dev/concepts/authentication/setup#app-setup
      final sessionManager = ServerpodSessionManager(
        caller: di<Client>().modules.auth,
      );
      // this will initialize the session manager and load the stored user info
      // it returns a bool

      await sessionManager.initialize();
      return sessionManager;
    }, dependsOn: [Client]);
  }

  static Future<void> unregisterManagersDependingOnActiveEnv() async {
    await di.unregister<ServerpodSessionManager>();
    await di.unregister<HubAuthKeyManager>();
    await di.unregister<Client>();
  }
}
