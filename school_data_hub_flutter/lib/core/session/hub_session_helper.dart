import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('SessionHelper');

class SessionHelper {
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
    // TODO: Check if we really considered everything here
    _log.info('Deleting all instance data...');
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
}
