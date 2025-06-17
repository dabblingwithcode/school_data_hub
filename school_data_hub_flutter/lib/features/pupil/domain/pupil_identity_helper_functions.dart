import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('PupilIdentityHelper');

class PupilIdentityHelper {
  //- LOCAL STORAGE HELPERS

  static Future<Map<int, PupilIdentity>> readPupilIdentitiesFromStorage(
      {required String secureStorageKey}) async {
    final pupilsJson = await HubSecureStorage().getString(secureStorageKey);
    if (pupilsJson == null) return {};

    final Map<String, dynamic> decodedJson = jsonDecode(pupilsJson);

    return Map<int, PupilIdentity>.fromEntries(decodedJson.entries.map(
      (entry) {
        final int pupilId = int.parse(entry.key);

        final PupilIdentity pupilIdentity = PupilIdentity.fromJson(entry.value);

        return MapEntry(pupilId, pupilIdentity);
      },
    ));
  }

  static Future<void> deletePupilIdentitiesForEnv(
      String secureStorageKey) async {
    await HubSecureStorage().remove(secureStorageKey);
    _log.warning(
        'Pupil identities for environment $secureStorageKey have been deleted.');
    di<PupilIdentityManager>().clearPupilIdentities();

    di<PupilsFilter>().clearFilteredPupils();

    di<PupilManager>().clearData();
  }

  //- OBJECT HELPERS

  static PupilIdentity decodePupilIdentityFromStringList(
      List<String> pupilIdentityStringItems) {
    final SchoolGrade schoolgrade;
    switch (pupilIdentityStringItems[5]) {
      case 'E1':
        schoolgrade = SchoolGrade.E1;
        break;
      case 'E2':
        schoolgrade = SchoolGrade.E2;
        break;
      case 'E3':
        schoolgrade = SchoolGrade.E3;
        break;
      case '03':
        schoolgrade = SchoolGrade.K3;
        break;
      case 'K3':
        schoolgrade = SchoolGrade.K3;
        break;
      case '04':
        schoolgrade = SchoolGrade.K4;
        break;
      case 'K4':
        schoolgrade = SchoolGrade.K4;
        break;
      default:
        throw Exception('Unknown school grade: ${pupilIdentityStringItems[5]}');
    }

    final newPupilIdentity = PupilIdentity(
      id: int.parse(pupilIdentityStringItems[0]),
      firstName: pupilIdentityStringItems[1],
      lastName: pupilIdentityStringItems[2],
      group: pupilIdentityStringItems[3],
      groupTutor: pupilIdentityStringItems[4],
      schoolGrade: schoolgrade,
      // If there is a special needs string, it may be split into two parts
      // and concatenated to form the full special needs string.
      specialNeeds: pupilIdentityStringItems[6] == ''
          ? null
          : '${pupilIdentityStringItems[6]}${pupilIdentityStringItems[7]}',
      gender: pupilIdentityStringItems[8],
      language: pupilIdentityStringItems[9],
      family: pupilIdentityStringItems[10] == ''
          ? null
          : pupilIdentityStringItems[10],
      birthday: DateTime.tryParse(pupilIdentityStringItems[11])!,
      migrationSupportEnds: pupilIdentityStringItems[12] == ''
          ? null
          : DateTime.tryParse(pupilIdentityStringItems[12])!,
      pupilSince: DateTime.tryParse(pupilIdentityStringItems[13])!,
      afterSchoolCare: pupilIdentityStringItems[14] != '' ? true : false,
      religion: pupilIdentityStringItems[15] == ''
          ? null
          : pupilIdentityStringItems[15],
      religionLessonsSince: pupilIdentityStringItems[16] == ''
          ? null
          : DateTime.tryParse(pupilIdentityStringItems[16])!,
      familyLanguageLessonsSince: pupilIdentityStringItems[17] == ''
          ? null
          : DateTime.tryParse(pupilIdentityStringItems[17])!,
      leavingDate: pupilIdentityStringItems[18] == '' ||
              pupilIdentityStringItems[18] == null
          ? null
          : DateTime.tryParse(pupilIdentityStringItems[18]),
    );
    return newPupilIdentity;
  }
}
