import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/models/pupil_list_entry_proxy.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:watch_it/watch_it.dart';

class SchoolListHelper {
  static SchoolListManager get _schoolListManager => di<SchoolListManager>();
  static String listOwner(int listId) {
    final SchoolList schoolList = _schoolListManager.getSchoolListById(listId);
    return schoolList.createdBy;
  }

  static String listOwners(SchoolList schoolList) {
    String owners = '';
    if (schoolList.public == true) {
      return 'ADM';
    }
    if (schoolList.authorizedUsers == null ||
        schoolList.authorizedUsers!.isEmpty) {
      return '';
    }
    schoolList.authorizedUsers!.split('*').forEach((element) {
      if (element.isNotEmpty) {
        owners += ' + $element';
      }
    });
    return owners;
  }

  static String shareList(String teacher, SchoolList schoolList) {
    String authorizedUsers = schoolList.authorizedUsers!;
    authorizedUsers += '*$teacher';
    return authorizedUsers;
  }

  static Map<String, int> schoolListStatsForGivenPupils(
    SchoolList schoolList,
    List<PupilProxy> pupilsInList,
  ) {
    int countYes = 0;
    int countNo = 0;
    int countNull = 0;
    int countComment = 0;
    final pupilEntriesProxy = _schoolListManager
        .getPupilEntriesProxyFromSchoolList(schoolList.id!);

    for (PupilProxy pupil in pupilsInList) {
      for (PupilListEntryProxy pupilEntryProxy
          in pupilEntriesProxy.pupilEntries.values) {
        if (pupilEntryProxy.pupilEntry.pupilId == pupil.pupilId) {
          pupilEntryProxy.pupilEntry.status == true
              ? countYes++
              : pupilEntryProxy.pupilEntry.status == false
              ? countNo++
              : countNull++;
          pupilEntryProxy.pupilEntry.comment != null &&
                  pupilEntryProxy.pupilEntry.comment!.isNotEmpty
              ? countComment++
              : countComment;
        }
      }
    }

    return {
      'yes': countYes,
      'no': countNo,
      'null': countNull,
      'comment': countComment,
    };
  }
}
