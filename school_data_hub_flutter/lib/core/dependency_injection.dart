import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/auth/hub_auth_key_manager.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_connectivity_monitor.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/app/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/competence/domain/filters/competence_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_credentials.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('DiManager');

class DiManager {
  static final DiManager _instance = DiManager._internal();

  factory DiManager() => _instance;

  DiManager._internal();

  static void registerCoreManagers() {
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

    di.registerSingleton<MainMenuBottomNavManager>(MainMenuBottomNavManager());
  }

  static Future<void> registerManagersDependingOnActiveEnv() async {
    di.registerSingletonWithDependencies<HubAuthKeyManager>(() {
      return HubAuthKeyManager(
        storageKeyForAuthKey: di<EnvManager>().storageKeyForAuthKey,
      );
    }, dependsOn: [EnvManager]);

    di.registerSingletonWithDependencies<Client>(() {
      return Client(
        di<EnvManager>().activeEnv!.serverUrl,
        authenticationKeyManager: di<HubAuthKeyManager>(),
      )..connectivityMonitor = di<ServerpodConnectivityMonitor>();
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
    }, dependsOn: [EnvManager, Client]);

    di.registerSingletonAsync<PupilIdentityManager>(() async {
      final pupilIdentityManager = PupilIdentityManager();

      await pupilIdentityManager.init();

      _log.info('PupilIdentityManager initialized');

      return pupilIdentityManager;
    }, dependsOn: [EnvManager]);

    _log.info('Managers dependent on ServerpodSessionManager initialized');
  }

  /// These manager are initialized after the session manager authenticates
  /// the session. it is called in the [ServerpodSessionManager] class after the session is authenticated.
  static Future<void> registerManagersDependingOnSession() async {
    di.registerSingletonAsync<SchooldayManager>(() async {
      final schooldayManager = SchooldayManager();

      await schooldayManager.init();

      _log.info('SchooldayManager initialized');

      return schooldayManager;
    });

    di.registerSingletonAsync<LearningSupportManager>(() async {
      final learningSupportManager = LearningSupportManager();

      await learningSupportManager.init();

      _log.info('LearningSupportmanager initialized');

      return learningSupportManager;
    });

    di.registerSingletonAsync<CompetenceManager>(() async {
      final competenceManager = CompetenceManager();

      await competenceManager.init();

      _log.info('CompetenceManager initialized');

      return competenceManager;
    });

    di.registerSingletonWithDependencies<CompetenceFilterManager>(() {
      return CompetenceFilterManager();
    }, dependsOn: [CompetenceManager]);

    _log.info('Managers depending on ServerpodSessionManager initialized');
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

  static Future<void> registerMatrixManagers(
      MatrixCredentials? matrixCredentials) async {
    di.registerSingletonAsync<MatrixPolicyManager>(() async {
      _log.info('Registering MatrixPolicyManager');

      final policyManager = await MatrixPolicyManager(
              matrixCredentials!.url,
              matrixCredentials.policyToken,
              matrixCredentials.matrixToken,
              matrixCredentials.compulsoryRooms ?? [])
          .init();

      _log.info('Matrix managers initialized');

      di<ServerpodSessionManager>()
          .changeMatrixPolicyManagerRegistrationStatus(true);

      return policyManager;
    }, dependsOn: [
      ServerpodSessionManager
    ]); // TODO: add dependency to PupilManager

    di.registerSingletonWithDependencies(() {
      return MatrixPolicyFilterManager(di<MatrixPolicyManager>());
    }, dependsOn: [MatrixPolicyManager]);
    di<NotificationService>().showSnackBar(
        NotificationType.success, 'Matrix-Räumeverwaltung initialisiert');
  }
}
