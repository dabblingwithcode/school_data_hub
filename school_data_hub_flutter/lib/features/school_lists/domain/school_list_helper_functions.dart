import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:watch_it/watch_it.dart';

final _schoolListManager = di<SchoolListManager>();

class SchoolListHelper {
  static String listOwner(int listId) {
    final SchoolList schoolList = _schoolListManager.getSchoolListById(listId);
    return schoolList.createdBy;
  }

  static String listOwners(SchoolList schoolList) {
    String owners = '';
    if (schoolList.public == true) {
      return 'ADM';
    }
    if (schoolList.public == false) {
      return '';
    }
    schoolList.authorizedUsers!.split('*').forEach((element) {
      if (element.isNotEmpty) {
        owners += ' - $element';
      }
    });
    return owners;
  }

  static String shareList(String teacher, SchoolList schoolList) {
    String authorizedUsers = schoolList.authorizedUsers!;
    authorizedUsers += '*$teacher';
    return authorizedUsers;
  }

  static Map<String, int> schoolListStats(
      SchoolList schoolList, List<PupilProxy> pupilsInList) {
    int countYes = 0;
    int countNo = 0;
    int countNull = 0;
    int countComment = 0;
    final pupilEntries =
        _schoolListManager.schoolListIdPupilEntriesMap[schoolList.id!];
    if (pupilEntries != null) {
      for (PupilProxy pupil in pupilsInList) {
        for (PupilListEntry pupilEntry in pupilEntries) {
          if (pupilEntry.pupilId == pupil.pupilId) {
            pupilEntry.status == true
                ? countYes++
                : pupilEntry.status == false
                    ? countNo++
                    : countNull++;
            pupilEntry.comment != null && pupilEntry.comment!.isNotEmpty
                ? countComment++
                : countComment;
          }
        }
      }
    }
    return {
      'yes': countYes,
      'no': countNo,
      'null': countNull,
      'comment': countComment
    };
  }
}
