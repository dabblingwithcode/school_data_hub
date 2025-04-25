import 'dart:convert';

import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_identity.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:watch_it/watch_it.dart';

final _pupilIdentityManager = di<PupilIdentityManager>();

class PupilIdentityHelper {
  //- LOCAL STORAGE HELPERS
  static Future<Map<int, PupilIdentity>> readPupilIdentitiesFromStorage(
      {required String secureStorageKey}) async {
    final pupilsJson = await LegacySecureStorage.read(secureStorageKey);
    if (pupilsJson == null) return {};

    final Map<String, dynamic> decoded = jsonDecode(pupilsJson);
    return decoded.map((key, value) =>
        MapEntry(int.parse(key), PupilIdentity.fromJson(value)));
  }

  static Future<void> deletePupilIdentitiesForEnv(
      String secureStorageKey) async {
    await LegacySecureStorage.delete(secureStorageKey);
    _pupilIdentityManager.clearPupilIdentities();

    // TODO: fix this
    // di<PupilsFilter>().clearFilteredPupils();

    // di<PupilManager>().clearData();
  }

  //- OBJECT HELPERS
  static PupilIdentity pupilIdentityFromString(
      List<String> pupilIdentityStringItems) {
    //-TODO implement enum for the schoolyear
    final schoolyear = pupilIdentityStringItems[4] == '03'
        ? 'S3'
        : pupilIdentityStringItems[4] == '04'
            ? 'S4'
            : pupilIdentityStringItems[4];
    final newPupilIdentity = PupilIdentity(
      id: int.parse(pupilIdentityStringItems[0]),
      firstName: pupilIdentityStringItems[1],
      lastName: pupilIdentityStringItems[2],
      group: pupilIdentityStringItems[3],
      schoolGrade: schoolyear,
      specialNeeds: pupilIdentityStringItems[5] == ''
          ? null
          : '${pupilIdentityStringItems[5]}${pupilIdentityStringItems[6]}',
      gender: pupilIdentityStringItems[7],
      language: pupilIdentityStringItems[8],
      family: pupilIdentityStringItems[9] == ''
          ? null
          : pupilIdentityStringItems[9],
      birthday: DateTime.tryParse(pupilIdentityStringItems[10])!,
      migrationSupportEnds: pupilIdentityStringItems[11] == ''
          ? null
          : DateTime.tryParse(pupilIdentityStringItems[11])!,
      pupilSince: DateTime.tryParse(pupilIdentityStringItems[12])!,
      // TODO: check this
      afterSchoolCare: null,
    );
    return newPupilIdentity;
  }
}
