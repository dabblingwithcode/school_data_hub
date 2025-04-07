import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/auth/hub_auth_key_manager.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/landing_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('DiManager');

class DiManager {
  static final DiManager _instance = DiManager._internal();

  factory DiManager() => _instance;

  DiManager._internal();

  static void registerNonDependentManagers() {
    di.registerSingletonAsync<EnvManager>(() async {
      final envManager = EnvManager();

      await envManager.init();

      return envManager;
    });

    di.registerSingleton<DefaultCacheManager>(DefaultCacheManager());

    di.registerSingleton<NotificationService>(NotificationService());

    di.registerSingleton<MainMenuBottomNavManager>(MainMenuBottomNavManager());
  }

  static Future<void> registerManagersDependingOnActiveEnv() async {
    di.registerSingletonWithDependencies<HubAuthKeyManager>(() {
      return HubAuthKeyManager(
        runMode: di<EnvManager>().activeEnvRunMode.value.name,
        envName: di<EnvManager>().activeEnv!.name,
      );
    }, dependsOn: [EnvManager]);

    di.registerSingletonWithDependencies<Client>(() {
      return Client(
        di<EnvManager>().activeEnv!.serverUrl,
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
      _log.info('SessionManager initialized');
      return sessionManager;
    }, dependsOn: [Client]);

    _log.info('Managers dependent on ServerpodSessionManager initialized');

    registerManagersDependingOnSession();
  }

  static Future<void> registerManagersDependingOnSession() async {
    di.registerSingletonAsync<PupilIdentityManager>(() async {
      final pupilIdentityManager = PupilIdentityManager();

      await pupilIdentityManager.init();

      _log.info('PupilIdentityManager initialized');

      return pupilIdentityManager;
    }, dependsOn: [ServerpodSessionManager]);
  }

  static Future<void> unregisterManagersDependingOnActiveEnv() async {
    di<ServerpodSessionManager>().dispose();
    await di.unregister<ServerpodSessionManager>();
    _log.info('ServerpodSessionManager unregistered');
    await di.unregister<HubAuthKeyManager>();
    _log.info('HubAuthKeyManager unregistered');
    await di.unregister<Client>();
    _log.info('Client unregistered');
  }

  static Future<void> resetManagersDependingOnActiveEnv() async {
    await unregisterManagersDependingOnActiveEnv();
    await registerManagersDependingOnActiveEnv();
    _log.info('Managers depending on active env reset');
  }
}
