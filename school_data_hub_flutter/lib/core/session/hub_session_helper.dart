import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/models/hub_session.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('SessionHelper');

class SessionHelper {
  // static String tokenLifetimeLeft(String token) {
  //   Duration remainingTime = JwtDecoder.getRemainingTime(token);
  //   String days = remainingTime.inDays == 1 ? 'Tag' : 'Tage';
  //   String hours = remainingTime.inHours == 1 ? 'Stunde' : 'Stunden';
  //   String minutes = remainingTime.inMinutes == 1 ? 'Minute' : 'Minuten';
  //   String timeLeft =
  //       '${remainingTime.inDays} $days, ${remainingTime.inHours % 24} $hours, ${remainingTime.inMinutes % 60} $minutes';
  //   return timeLeft;
  // }

  static Future<void> clearInstanceSessionServerData() async {
    _log.info('Clearing instance server data');
    await di<DefaultCacheManager>().emptyCache();
    // di<PupilIdentityManager>().clearPupilIdentities();
    // locator<PupilsFilter>().clearFilteredPupils();
    // locator<PupilManager>().clearData();
    // locator<UserManager>().clearUsers();
    // locator<SchooldayManager>().clearData();
    // locator<LearningSupportManager>().clearData();
    // locator<CompetenceManager>().clearData();
    // locator<SchoolListManager>().clearData();
    // locator<AuthorizationManager>().clearData();
    // locator<WorkbookManager>().clearData();
    return;
  }

  static void logoutAndDeleteAllInstanceData() async {
    await di<PupilIdentityManager>().deleteAllPupilIdentities();

    await di<EnvManager>().deleteEnv();

    await di<ServerpodSessionManager>().signOutDevice();

    final cacheManager = di<DefaultCacheManager>();

    await cacheManager.emptyCache();

    di<NotificationService>()
        .showSnackBar(NotificationType.success, 'Alle Daten gelöscht!');
  }

  static bool isAuthorized(String createdBy) {
    return di<ServerpodSessionManager>().signedInUser!.userName == createdBy ||
            di<ServerpodSessionManager>().isAdmin
        ? true
        : false;
  }

  static Future<Map<String, HubSession>?> sessionsInStorage() async {
    if (await AppSecureStorage.containsKey(SecureStorageKey.sessions.value) ==
        true) {
      // if so, read them
      final String? storedHubSessions =
          await AppSecureStorage.read(SecureStorageKey.sessions.value);
      _log.info('HubSession(s) found!');
      // decode the stored sessions
      final Map<String, HubSession> sessions =
          (json.decode(storedHubSessions!) as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                  key, HubSession.fromJson(value as Map<String, dynamic>)));
      // check if the sessions in the secure storage are empty
      if (sessions.isEmpty) {
        _log.warning('Empty sessions found in secure storage! Deleting...');
        await AppSecureStorage.delete(SecureStorageKey.sessions.value);
        return null;
      }

      return sessions;
    }
    _log.info('No HubSession(s) found!');
    return null;
  }
}
