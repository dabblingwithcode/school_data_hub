import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_helper.dart';

final _log = Logger('SessionHelper');

class SessionHelper {
  static Future<void> clearInstanceSessionServerData() async {
    _log.info('Clearing instance server data');
    await di<DefaultCacheManager>().emptyCache();

    return;
  }

  static Future<void> logoutAndDeleteAllInstanceData({
    String? reason,
  }) async {
    _log.info('Deleting all instance data...');
    await PupilIdentityHelper.deletePupilIdentitiesForEnv(
      di<EnvManager>().storageKeyForPupilIdentities,
    );

    await di<HubSessionManager>().signOutDevice();

    await di<EnvManager>().deleteEnv();

    final cacheManager = di<DefaultCacheManager>();

    await cacheManager.emptyCache();

    if (reason != null) {
      di<NotificationService>().showInformationDialog(
        NotificationType.warning,
        reason,
      );
    } else {
      di<NotificationService>().showSnackBar(
        NotificationType.success,
        'Alle Daten gelöscht!',
      );
    }
  }

  static bool isAuthorized(String createdBy) {
    return di<HubSessionManager>().signedInUser!.userName == createdBy ||
        di<HubSessionManager>().isAdmin ||
        di<HubSessionManager>().signedInUser!.scopeNames.any(
          (scopeName) => scopeName == 'SchooldayEventsManagement',
        );
  }
}
