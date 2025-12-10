import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_helper.dart';
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

  static Future<void> logoutAndDeleteAllInstanceData() async {
    // TODO: Check if we really considered everything here
    _log.info('Deleting all instance data...');
    await PupilIdentityHelper.deletePupilIdentitiesForEnv(
      di<EnvManager>().storageKeyForPupilIdentities,
    );

    await di<HubSessionManager>().signOutDevice();

    await di<EnvManager>().deleteEnv();

    final cacheManager = di<DefaultCacheManager>();

    await cacheManager.emptyCache();

    di<NotificationService>().showSnackBar(
      NotificationType.success,
      'Alle Daten gelöscht!',
    );
  }

  static bool isAuthorized(String createdBy) {
    return di<HubSessionManager>().signedInUser!.userName == createdBy ||
            di<HubSessionManager>().isAdmin
        ? true
        : false;
  }
}
