// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:school_data_hub_flutter/common/models/enums.dart';
// import 'package:school_data_hub_flutter/common/services/notification_service.dart';
// import 'package:school_data_hub_flutter/common/utils/logger.dart';
// import 'package:school_data_hub_flutter/core/dependency_injection.dart';
// import 'package:school_data_hub_flutter/core/env/env_manager.dart';
// import 'package:school_data_hub_flutter/core/session/models/hub_session.dart';
// import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
// import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/landing_bottom_nav_bar.dart';
// import 'package:school_data_hub_flutter/utils/secure_storage.dart';
// import 'package:watch_it/watch_it.dart';

// class HubSessionManager with ChangeNotifier {
//   final _sessions = ValueNotifier<Map<String, HubSession>>({});
//   ValueListenable<Map<String, HubSession>> get sessions => _sessions;

//   final _credentials = ValueNotifier<HubSession>(HubSession());
//   ValueListenable<HubSession> get credentials => _credentials;

//   final _isAuthenticated = ValueNotifier<bool>(false);
//   ValueListenable<bool> get isAuthenticated => _isAuthenticated;

//   final _isAdmin = ValueNotifier<bool>(false);
//   ValueListenable<bool> get isAdmin => _isAdmin;

//   bool _isCalendarPopulated = false;
//   bool get isCalendarPopulated => _isCalendarPopulated;

//   bool _isSchoolSemesterPopulated = false;
//   bool get isSchoolSemesterPopulated => _isSchoolSemesterPopulated;

//   void setCalendarPopulated(bool value) {
//     _isCalendarPopulated = value;
//   }

//   void setSchoolSemesterPopulated(bool value) {
//     _isSchoolSemesterPopulated = value;
//   }

//   final _matrixPolicyManagerRegistrationStatus = ValueNotifier<bool>(false);
//   ValueListenable<bool> get matrixPolicyManagerRegistrationStatus =>
//       _matrixPolicyManagerRegistrationStatus;





//   bool isAuthorized(String user) {
//     return _credentials.value.username == user || _isAdmin.value;
//   }



//   Future<void> updateHubSessionData(HubSession session) async {
//     // final HubSession updatedHubSession =
//     //     await userApiService.updateHubSessionData(session);
//     // _credentials.value =
//     //     updatedHubSession.copyWith(jwt: _credentials.value.jwt);

//     // await saveHubSession(updatedHubSession);
//   }

//   Future<void> checkStoredCredentials() async {
//     if (di<EnvManager>().env == null) {
//       logger.w('Checking credentials, but no environment found!',
//           stackTrace: StackTrace.current);
//       _isAuthenticated.value = false;
//       return;
//     }
//     final validCredentials = await di<HubSessionManager>().initialize();
//     if (!validCredentials) {
//       logger.w('No valid credentials found!');
//       _isAuthenticated.value = false;
//       return;
//     }
//     logger.i('Valid credentials found!');
//     _isAuthenticated.value = true;
//     _isAdmin.value = di<HubSessionManager>()
//         .signedInUser!
//         .scopeNames
//         .contains('serverpod.admin');

//     final HubSession? linkedHubSession =
//         _sessions.value[di<EnvManager>().env!.name];

//     if (linkedHubSession == null) {
//       logger.w('No session found for ${di<EnvManager>().env!.name}');
//       //- TODO: this call is there in case the credentials are checked
//       //- after calling a new instance and is hacky
//       //- find a better way to handle this
//       di<NotificationService>().setNewInstanceLoadingValue(false);
//       return;
//     }
//     logger.i('HubSession found for ${linkedHubSession.!}');
//     _credentials.value = linkedHubSession;

//     // check if the session is still valid

//     // There are sessions stored - let's decode them
//     try {
//       // check if the session is still valid

//       log('Stored session is valid!');
//       authenticate(_credentials.value);
//       log('HubSession isAuthenticated is ${_isAuthenticated.value.toString()}');

//       if (!di<EnvManager>().dependentManagersRegistered.value) {
//         logger.i(
//             'Authenticated on first run - registering dependent managers...');
//         await DiManager.registerDependentManagers();
//       } else {
//         logger.i('Authenticated on env change - propagating new env...');
//         // di<EnvManager>().propagateNewEnv();
//       }

//       return;
//     } catch (e) {
//       logger.f(
//         'Error reading session from secureStorage: $e',
//         stackTrace: StackTrace.current,
//       );
//       // if not, delete the session
//       await removeHubSession(server: di<EnvManager>().env!.name);

//       return;
//     }
//   }

//   Future<void> refreshToken(String password) async {
//     // final HubSession session = await userApiService.login(
//     //     username: _credentials.value.username!, password: password);

//     // authenticate(session);
//     // await saveHubSession(session);
//     // di<ApiClient>()
//     //     .setApiOptions(tokenKey: Token.hub, token: _credentials.value.jwt!);

//     // return;
//   }

//   Future<void> changePassword(
//       String currentPassword, String newPassword) async {
//     // final User? user = await userApiService.changePassword(
//     //   oldPassword: currentPassword,
//     //   newPassword: newPassword,
//     // );
//     // //- TO-DO: Not finished - implement this!!
//     // // authenticate(session);
//     // // await saveHubSession(session);
//     // if (user == null) {
//     //   di<NotificationService>().showSnackBar(
//     //       NotificationType.error, 'Fehler beim Ändern des Passworts');
//     //   return;
//     // } else {
//     //   di<NotificationService>().showSnackBar(
//     //       NotificationType.success, 'Passwort erfolgreich geändert!');
//     // }

//     // return;
//   }

//   Future<void> attemptLogin(
//       {required String username, required String password}) async {
//     // TODO: uncomment and fix
//     // final HubSession session = await userApiService.login(
//     //   username: username,
//     //   password: password,
//     // );
//     // await saveHubSession(session);
//     // authenticate(session);

//     di<NotificationService>()
//         .showSnackBar(NotificationType.success, 'Login erfolgreich!');

//     await registerDependentManagers();

//     return;
//   }

//   Future<void> saveHubSession(HubSession session) async {
//     final Map<String, HubSession> updatedHubSessions = _sessions.value;
//     updatedHubSessions[session.server!] = session;
//     final updatedHubSessionsAsJson = json.encode(updatedHubSessions);
//     await AppSecureStorage.write(
//         SecureStorageKey.sessions.value, updatedHubSessionsAsJson);
//     // let's keep them in memory as well
//     _sessions.value = updatedHubSessions;
//     logger.i('${updatedHubSessions.length} HubSession(s) stored');

//     return;
//   }

//   Future<void> removeHubSession({required String server}) async {
//     final Map<String, HubSession> updatedHubSessions = _sessions.value;
//     updatedHubSessions.remove(server);
//     _sessions.value = updatedHubSessions;
//     if (updatedHubSessions.isNotEmpty) {
//       await saveHubSession(_credentials.value);
//     } else {
//       await AppSecureStorage.delete(SecureStorageKey.sessions.value);
//     }
//     _credentials.value = HubSession();
//     di<NotificationService>().showSnackBar(
//         NotificationType.success, 'HubSession erfolgreich gelöscht!');

//     return;
//   }

//   logout() async {
//     removeHubSession(server: _credentials.value.server!);

//     di<NotificationService>()
//         .showSnackBar(NotificationType.success, 'Logout erfolgreich!');

//     di.get<MainMenuBottomNavManager>().setBottomNavPage(0);
//     _isAuthenticated.value = false;
//     _credentials.value = HubSession();

//     //  await unregisterDependentManagers();
//     return;
//   }

//   void changeMatrixPolicyManagerRegistrationStatus(bool isRegistered) {
//     _matrixPolicyManagerRegistrationStatus.value = isRegistered;
//   }
// }
