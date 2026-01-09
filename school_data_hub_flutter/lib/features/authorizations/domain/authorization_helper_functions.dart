import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:watch_it/watch_it.dart';

class AuthorizationHelper {
  static Map<String, int> authorizationStats(Authorization authorization) {
    int countYes = 0;
    int countNo = 0;
    int countNull = 0;
    int countComment = 0;
    for (PupilAuthorization pupilAuthorization
        in authorization.authorizedPupils!) {
      if (di<PupilProxyManager>().getPupilByPupilId(
            pupilAuthorization.pupilId,
          ) ==
          null) {
        continue;
      }
      pupilAuthorization.status == true
          ? countYes++
          : pupilAuthorization.status == false
          ? countNo++
          : countNull++;
      pupilAuthorization.comment != null &&
              pupilAuthorization.comment!.isNotEmpty
          ? countComment++
          : countComment;
    }

    return {
      'yes': countYes,
      'no': countNo,
      'null': countNull,
      'comment': countComment,
    };
  }
}
