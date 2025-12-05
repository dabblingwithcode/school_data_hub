import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/datetime_extensions.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('PupilIdentityHelper');

class PupilIdentityHelper {
  //- LOCAL STORAGE HELPERS

  static Future<Map<int, PupilIdentity>> readPupilIdentitiesFromStorage({
    required String secureStorageKey,
  }) async {
    final pupilsJson = await HubSecureStorage().getString(secureStorageKey);
    if (pupilsJson == null) return {};

    final Map<String, dynamic> decodedJson = await compute(
      (json) => jsonDecode(json),
      pupilsJson,
    );

    return Map<int, PupilIdentity>.fromEntries(
      decodedJson.entries.map((entry) {
        final int pupilId = int.parse(entry.key);

        // Clone the JSON map and convert DateTime strings from Berlin to UTC
        final Map<String, dynamic> jsonData = Map<String, dynamic>.from(
          entry.value as Map,
        );

        final PupilIdentity pupilIdentity = PupilIdentity.fromJson(jsonData);

        return MapEntry(pupilId, pupilIdentity);
      }),
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

    di<PupilManager>().clearData();
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
      birthday: DateTime.parse(pupilIdentityStringItems[11]),
      migrationSupportEnds: pupilIdentityStringItems[12] == ''
          ? null
          : DateTime.tryParse(pupilIdentityStringItems[12]),
      pupilSince: DateTime.tryParse(pupilIdentityStringItems[13])!,
      afterSchoolCare: pupilIdentityStringItems[14] != '' ? true : false,
      religion: pupilIdentityStringItems[15] == ''
          ? null
          : pupilIdentityStringItems[15],
      religionLessonsSince: pupilIdentityStringItems[16] == ''
          ? null
          : DateTime.tryParse(pupilIdentityStringItems[16])!,
      religionLessonsCancelledAt: pupilIdentityStringItems[17] == ''
          ? null
          : DateTime.tryParse(pupilIdentityStringItems[17])!,
      familyLanguageLessonsSince: pupilIdentityStringItems[18] == ''
          ? null
          : DateTime.tryParse(pupilIdentityStringItems[18])!,
      leavingDate: pupilIdentityStringItems[19] == ''
          ? null
          : DateTime.tryParse(pupilIdentityStringItems[19]),
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

  static String generateTextLinesFromPupilIdentities(
    List<PupilIdentity> pupilIdentities,
  ) {
    String textLines = '';
    for (PupilIdentity pupilIdentity in pupilIdentities) {
      textLines = textLines + pupilIdentity.toTextLine() + '\n';
    }
    return textLines;
  }
}

extension PupilIdentityExtension on PupilIdentity {
  String toTextLine() {
    final migrationSupportEnds = this.migrationSupportEnds != null
        ? this.migrationSupportEnds!.formatDateForJson()
        : '';

    final specialNeeds = this.specialNeeds ?? '';

    return [
      this.id.toString(),
      this.firstName,
      this.lastName,
      this.group,
      this.groupTutor,
      this.schoolGrade,
      specialNeeds,
      '', // this is a placeholder for the second special needs field in the administrative data source
      this.gender,
      this.language,
      this.family ?? '',
      this.birthday.formatDateForJson(),
      migrationSupportEnds,
      this.pupilSince.formatDateForJson(),
      this.afterSchoolCare ? 'OFFGANZ' : '',
      this.religion ?? '',
      this.religionLessonsSince?.formatDateForJson() ?? '',
      this.religionLessonsCancelledAt?.formatDateForJson() ?? '',
      this.familyLanguageLessonsSince?.formatDateForJson() ?? '',
      this.leavingDate?.formatDateForJson() ?? '',
    ].join(',');
  }

  bool isEqual(PupilIdentity other) {
    return this.id == other.id &&
        this.firstName == other.firstName &&
        this.lastName == other.lastName &&
        this.group == other.group &&
        this.groupTutor == other.groupTutor &&
        this.schoolGrade == other.schoolGrade &&
        this.specialNeeds == other.specialNeeds &&
        this.gender == other.gender &&
        this.language == other.language &&
        this.family == other.family &&
        this.birthday == other.birthday &&
        this.migrationSupportEnds == other.migrationSupportEnds &&
        this.pupilSince == other.pupilSince &&
        this.afterSchoolCare == other.afterSchoolCare &&
        this.religion == other.religion &&
        this.religionLessonsSince == other.religionLessonsSince &&
        this.religionLessonsCancelledAt == other.religionLessonsCancelledAt &&
        this.familyLanguageLessonsSince == other.familyLanguageLessonsSince &&
        this.leavingDate == other.leavingDate;
  }
}
