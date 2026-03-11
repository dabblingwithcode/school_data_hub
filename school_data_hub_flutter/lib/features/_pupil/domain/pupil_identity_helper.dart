import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_identity_extensions.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';

final _log = Logger('PupilIdentityHelper');

class PupilIdentityHelper {
  static List<String> getFamilyGroups(String familyCode) {
    final pupilIdentityManager = di<PupilIdentityManager>();
    final pupilIdentities = pupilIdentityManager.pupilIdentities;
    final familyGroups = pupilIdentities
        .where((pupilIdentity) => pupilIdentity.family == familyCode)
        .map((pupilIdentity) => pupilIdentity.group)
        .toList();

    return familyGroups;
  }

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
        PupilIdentity.fromJson(
          _normalizeLegacyPupilIdentityJson(
            Map<String, dynamic>.from(value as Map),
          ),
        ),
      ),
    );
  }

  /// Normalizes legacy stored identities so fromJson succeeds after model changes.
  /// Converts specialNeeds String (e.g. "LE*SQ") to [List<String>]; ensures new
  /// fields (deputyGroupTutor, nationality, schoolTransitionRecommendation) exist.
  /// TODO: remove after transition has been made in production
  static Map<String, dynamic> _normalizeLegacyPupilIdentityJson(
    Map<String, dynamic> raw,
  ) {
    final normalized = Map<String, dynamic>.from(raw);

    // Legacy: specialNeeds was stored as String, often with '*' between two codes
    final sn = normalized['specialNeeds'];
    if (sn is String) {
      final s = (sn as String).trim();
      if (s.isEmpty) {
        normalized['specialNeeds'] = null;
      } else {
        normalized['specialNeeds'] = s
            .split(RegExp(r'\*'))
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      }
    }

    normalized['deputyGroupTutor'];
    normalized['nationality'];
    normalized['schoolTransitionRecommendation'];
    normalized['migrationBackground'] ??= false;

    return normalized;
  }

  static void checkForOutdatedPupilIdentities() {
    final lastIdentitiesUpdate =
        di<EnvManager>().activeEnv?.lastIdentitiesUpdate;
    final remoteLastIdentitiesUpdate =
        di<PupilIdentityManager>().remoteLastIdentitiesUpdate.value;
    if (lastIdentitiesUpdate != null && remoteLastIdentitiesUpdate != null) {
      if (remoteLastIdentitiesUpdate.isAfter(lastIdentitiesUpdate)) {
        di<NotificationService>().showInformationDialog(
          'Die gespeicherten Schüler*innen-Ids vom\n${lastIdentitiesUpdate.formatDateAndTimeForUser()}\n sind veraltet. Die neueste Version ist vom \n ${remoteLastIdentitiesUpdate.formatDateAndTimeForUser()}.\n Schüler*innen-Ids aus einer vertrauenswürdigen Quelle aktualisieren!',
        );
      }
    } else {
      di<NotificationService>().showInformationDialog(
        'No last identities update found in the server.',
      );
    }
  }

  static Future<void> deletePupilIdentitiesForEnv(
    String secureStorageKey,
  ) async {
    await HubSecureStorage().remove(secureStorageKey);
    _log.warning(
      'Pupil identities for environment $secureStorageKey have been deleted.',
    );
    di<PupilIdentityManager>().clearPupilIdentities();

    di<EnvManager>().updateActiveEnv(lastIdentitiesUpdate: null);

    di<PupilsFilter>().clearFilteredPupils();

    di<PupilProxyManager>().clearData();
  }

  //- OBJECT HELPERS

  /// Builds the reduced sync content (id,afterSchoolCare per line) from full
  /// newline-separated text. Column 15: OFFGANZ or non-empty -> true, else false.
  /// Used when sending to backend via string transport.
  static String buildReducedPupilSyncContent(String fullCsvContent) {
    final lines = fullCsvContent.split('\n');
    final reduced = <String>[];
    for (final textLine in lines) {
      if (textLine.isEmpty) continue;
      final parts = textLine.split(',');
      if (parts.isEmpty) continue;
      final id = int.tryParse(parts[0].trim());
      if (id == null) continue;
      final afterSchoolCare =
          parts.length > 15 &&
          (parts[15] == 'OFFGANZ' || parts[15].trim().isNotEmpty);
      reduced.add('$id,$afterSchoolCare');
    }
    return reduced.join('\n');
  }

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
      specialNeeds: _specialNeedsListFromCanonical(
        pupilIdentityStringItems[6],
        pupilIdentityStringItems[7],
      ),
      deputyGroupTutor: pupilIdentityStringItems.length > 21
          ? _emptyToNull(pupilIdentityStringItems[21])
          : null,
      gender: pupilIdentityStringItems[8],
      language: pupilIdentityStringItems[9],
      migrationBackground: _parseBoolCanonical(
        pupilIdentityStringItems.length > 10
            ? pupilIdentityStringItems[10]
            : '',
      ),
      nationality: pupilIdentityStringItems.length > 22
          ? _emptyToNull(pupilIdentityStringItems[22])
          : null,
      family: pupilIdentityStringItems[11] == ''
          ? null
          : pupilIdentityStringItems[11],
      birthday: pupilIdentityStringItems[12].toDateOnlyUtc(),
      migrationSupportEnds: pupilIdentityStringItems[13] == ''
          ? null
          : pupilIdentityStringItems[13].toDateOnlyUtc(),
      pupilSince: pupilIdentityStringItems[14].toDateOnlyUtc(),
      afterSchoolCare: pupilIdentityStringItems[15] != '' ? true : false,
      religion: pupilIdentityStringItems[16] == ''
          ? null
          : pupilIdentityStringItems[16],
      religionLessonsSince: pupilIdentityStringItems[17] == ''
          ? null
          : pupilIdentityStringItems[17].tryToDateOnlyUtc(),
      religionLessonsCancelledAt: pupilIdentityStringItems[18] == ''
          ? null
          : pupilIdentityStringItems[18].tryToDateOnlyUtc(),
      familyLanguageLessonsSince: pupilIdentityStringItems[19] == ''
          ? null
          : pupilIdentityStringItems[19].tryToDateOnlyUtc(),
      leavingDate: pupilIdentityStringItems[20] == ''
          ? null
          : pupilIdentityStringItems[20].tryToDateOnlyUtc(),
      schoolTransitionRecommendation: pupilIdentityStringItems.length > 23
          ? _emptyToNull(pupilIdentityStringItems[23])
          : null,
    );

    return newPupilIdentity;
  }

  static List<String>? _specialNeedsListFromCanonical(
    String col6,
    String col7,
  ) {
    final list = [
      col6,
      col7,
    ].map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    return list.isEmpty ? null : list;
  }

  static String? _emptyToNull(String s) {
    final t = s.trim();
    return t.isEmpty ? null : t;
  }

  static bool _parseBoolCanonical(String s) {
    final t = s.trim().toLowerCase();
    return t == 'true' ||
        t == '1' ||
        t == 'ja' ||
        t == 'j' ||
        t == 'x' ||
        t == 'yes';
  }

  Future<String> generateEncryptedPupilIdentitiesTransferString(
    List<int> internalIds,
  ) async {
    String transferString = '';
    for (int internalId in internalIds) {
      PupilIdentity pupilIdentity = di<PupilIdentityManager>()
          .getPupilIdentityByInternalId(internalId)!;

      final String pupilIdentityString = '${pupilIdentity.toTextLine()},\n';
      transferString = transferString + pupilIdentityString;
    }
    final encryptedString = customEncrypter.encryptString(transferString);
    return encryptedString;
  }
}
