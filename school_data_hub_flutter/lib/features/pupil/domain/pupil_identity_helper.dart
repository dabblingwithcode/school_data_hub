import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_identity_extensions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('PupilIdentityHelper');

class PupilIdentityHelper {
  //- LOCAL STORAGE HELPERS

  static Future<Map<int, PupilIdentity>> readPupilIdentitiesFromStorage({
    required String secureStorageKey,
  }) async {
    final pupilsJson = await HubSecureStorage().getString(secureStorageKey);
    if (pupilsJson == null) return {};

    return compute(_jsonDecodePupilIdentities, pupilsJson);
  }

  /// Decode JSON from secure storage into a map of pupilId -> PupilIdentity
  /// off the main isolate.
  static Map<int, PupilIdentity> _jsonDecodePupilIdentities(String json) {
    final Map<String, dynamic> decodedJson =
        jsonDecode(json) as Map<String, dynamic>;

    return decodedJson.map(
      (key, value) => MapEntry(
        int.parse(key),
        PupilIdentity.fromJson(Map<String, dynamic>.from(value as Map)),
      ),
    );
  }

  static Future<void> deletePupilIdentitiesForEnv(
    String secureStorageKey,
  ) async {
    await HubSecureStorage().remove(secureStorageKey);
    _log.warning(
      'Pupil identities for environment $secureStorageKey have been deleted.',
    );
    di<PupilIdentityManager>().clearPupilIdentities();

    di<PupilsFilter>().clearFilteredPupils();

    di<PupilProxyManager>().clearData();
  }

  //- OBJECT HELPERS

  static PupilIdentity decodePupilIdentityFromTextLine(String textLine) {
    final List<String> pupilIdentityStringItems = textLine.split(',');

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
      //
      gender: pupilIdentityStringItems[8],
      language: pupilIdentityStringItems[9],
      family: pupilIdentityStringItems[10] == ''
          ? null
          : pupilIdentityStringItems[10],
      birthday: DateTime.parse(pupilIdentityStringItems[11]).toUtcSafe(),
      migrationSupportEnds: pupilIdentityStringItems[12] == ''
          ? null
          : DateTime.parse(pupilIdentityStringItems[12]).toUtcSafe(),
      pupilSince: DateTime.parse(pupilIdentityStringItems[13]).toUtcSafe(),
      afterSchoolCare: pupilIdentityStringItems[14] != '' ? true : false,
      religion: pupilIdentityStringItems[15] == ''
          ? null
          : pupilIdentityStringItems[15],
      religionLessonsSince: pupilIdentityStringItems[16] == ''
          ? null
          : DateTime.parse(pupilIdentityStringItems[16]).toUtcSafe(),
      religionLessonsCancelledAt: pupilIdentityStringItems[17] == ''
          ? null
          : DateTime.parse(pupilIdentityStringItems[17]).toUtcSafe(),
      familyLanguageLessonsSince: pupilIdentityStringItems[18] == ''
          ? null
          : DateTime.parse(pupilIdentityStringItems[18]).toUtcSafe(),
      leavingDate: pupilIdentityStringItems[19] == ''
          ? null
          : DateTime.parse(pupilIdentityStringItems[19]).toUtcSafe(),
    );
    return newPupilIdentity;
  }

  Future<String> generateEncryptedPupilIdentitiesTransferString(
    List<int> internalIds,
  ) async {
    String transferString = '';
    for (int internalId in internalIds) {
      PupilIdentity pupilIdentity = di<PupilIdentityManager>()
          .getPupilIdentityByInternalId(internalId)!;

      final String pupilIdentityString = pupilIdentity.toTextLine() + ',\n';
      transferString = transferString + pupilIdentityString;
    }
    final encryptedString = customEncrypter.encryptString(transferString);
    return encryptedString;
  }
}
