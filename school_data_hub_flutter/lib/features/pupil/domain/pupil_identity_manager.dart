import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/utils/extensions.dart';
import 'package:school_data_hub_flutter/common/utils/logger.dart';
import 'package:school_data_hub_flutter/common/utils/secure_storage.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_identity.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_helper_functions.dart';
import 'package:watch_it/watch_it.dart';

class PupilIdentityManager {
  Map<int, PupilIdentity> _pupilIdentities = {};

  final _groups = ValueNotifier<Set<String>>({});
  ValueListenable<Set<String>> get groups => _groups;

  List<int> get availablePupilIds => _pupilIdentities.keys.toList();

  PupilIdentity getPupilIdentity(int pupilId) {
    if (_pupilIdentities.containsKey(pupilId) == false) {
      throw StateError('Pupil with id $pupilId not found in pupil identities!');
    }
    return _pupilIdentities[pupilId]!;
  }

  Future<PupilIdentityManager> init() async {
    await getPupilIdentitiesForEnv();
    return this;
  }

  Future<void> deleteAllPupilIdentities() async {
    await AppSecureStorage.delete(SecureStorageKey.pupilIdentities.value);
    _pupilIdentities.clear();

    //- TODO: fix this
    // di<PupilsFilter>().clearFilteredPupils();
    // di<PupilManager>().clearData();
  }

  void clearPupilIdentities() {
    _pupilIdentities.clear();
    return;
  }

  Future<void> getPupilIdentitiesForEnv() async {
    final activeEnv = di<EnvManager>().activeEnv!;

    final Map<int, PupilIdentity> pupilIdentities =
        await PupilIdentityHelper.readPupilIdentitiesFromStorage(
            envKey: activeEnv.name);

    if (pupilIdentities.isEmpty) {
      logger.w(
          'No stored pupil identities found for ${SecureStorageKey.pupilIdentities.value}_$activeEnv');
    } else {
      logger.i(
          '${pupilIdentities.length} Pupil identities loaded from secure storage');
    }

    _pupilIdentities = pupilIdentities;

    _groups.value = _pupilIdentities.values.map((e) => e.group).toSet();

    return;
  }

  Future<void> decryptAndAddOrUpdatePupilIdentities(
      List<String> encryptedCodes) async {
    // We need the decrypted information as a string with line breaks.
    // Since every string in the list of the argument i an encrypted code,
    // we need to decrypt them and aggregate them to a string with line breaks
    // in which every line will be a pupil identity.
    String decryptedString = '';
    for (String code in encryptedCodes) {
      decryptedString += '${customEncrypter.decryptString(code)}\n';
    }

    addOrUpdateNewPupilIdentities(identitiesInStringLines: decryptedString);
  }

  Future<void> addOrUpdateNewPupilIdentities(
      {required String identitiesInStringLines}) async {
    late final String? decryptedIdentitiesAsString;

    // If the string is imported in windows, it comes from a .txt file and it's not encrypted
    decryptedIdentitiesAsString = identitiesInStringLines;

    // The pupils in the string are separated by a '\n' - let's split them apart
    List<String> splittedPupilIdentities =
        decryptedIdentitiesAsString.split('\n');
    // The properties are separated by commas, let's build the PupilIdentity objects with them

    bool updateGroupFilters = false;
    for (String data in splittedPupilIdentities) {
      if (data != '') {
        List<String> pupilIdentityValues = data.split(',');
        final newPupilIdentity =
            PupilIdentityHelper.pupilIdentityFromString(pupilIdentityValues);

        // TODO: fix this
        // if (!PupilProxy.groupFilters.any((filter) =>
        //         (filter as GroupFilter).name == newPupilIdentity.group) ==
        //     false) {
        //   updateGroupFilters = true;
        // }
        //- add the new pupil to the pupilIdentities map
        _pupilIdentities[newPupilIdentity.id] = newPupilIdentity;

        // TODO: fix this
        // final existingPupilProxy =
        //     di<PupilManager>().getPupilById(newPupilIdentity.id);

        // if (existingPupilProxy != null) {
        //   existingPupilProxy
        //       .updatePupilIdentityFromMoreRecentSource(newPupilIdentity);
        // }
      }
    }

    writePupilIdentitiesToStorage(envKey: di<EnvManager>().defaultEnv);

    // TODO: fix this
    // if (updateGroupFilters) {
    //   final availableGroups =
    //       _pupilIdentities.values.map((e) => e.group).toSet();
    //   _groups.value = availableGroups;
    //   di<PupilsFilter>().populateGroupFilters(availableGroups.toList());
    // }

    // await di<PupilManager>().fetchAllPupils();
    // di<MainMenuBottomNavManager>().setBottomNavPage(0);
    // di<MainMenuBottomNavManager>().pageViewController.value.jumpToPage(0);
  }

  Future<void> writePupilIdentitiesToStorage({required String envKey}) async {
    final Map<String, Map<String, dynamic>> jsonMap = _pupilIdentities.map(
      (key, value) => MapEntry(key.toString(), value.toJson()),
    );

    final jsonPupilIdentities = json.encode(jsonMap);
    await AppSecureStorage.write(
        '${SecureStorageKey.pupilIdentities.value}_$envKey',
        jsonPupilIdentities);
    log('Pupil identities written to secure storage for ${SecureStorageKey.pupilIdentities.value}_$envKey');
  }

  Future<void> updateBackendPupilsFromSchoolPupilIdentitySource(
      String textFileContent) async {
    // The pupils in the string are separated by a line break - let's split them out
    List<String> splittedPupilIdentities = textFileContent.split('\n');
    // Wer prepare a string with the pupils that are going to be updated later in the server
    String pupilListTxtFileContentForBackendUpdate = '';
    // The properties are separated by commas, let's build the pupilbase objects with them
    List<PupilIdentity> importedPupilIdentityList = [];

    for (String data in splittedPupilIdentities) {
      if (data != '') {
        List<String> pupilIdentityValues = data.split(',');

        PupilIdentity pupilIdentity =
            PupilIdentityHelper.pupilIdentityFromString(pupilIdentityValues);

        importedPupilIdentityList.add(pupilIdentity);

        final bool ogsStatus =
            pupilIdentityValues[13] == 'OFFGANZ' ? true : false;

        final idAndOgsStatus =
            '${int.parse(pupilIdentityValues[0])},$ogsStatus';

        pupilListTxtFileContentForBackendUpdate += '$idAndOgsStatus\n';
      }
    }
    // We have the latest dataset from the school database.
    // Now let's update the pupils in the server with a txt file
    // First we generate a txt file with updatedPupils
    // The server will automatically archive pupils that are not in the list,
    // update the ones that are in the list,
    // and create the ones that are not in the server.

    final textFile = File('temp.txt')
      ..writeAsStringSync(pupilListTxtFileContentForBackendUpdate);
    // TODO: fix this
    // final List<PupilData> updatedPupilDataRepository =
    //     await PupilDataApiService().updateBackendPupilsDatabase(file: textFile);
    // for (PupilData pupil in updatedPupilDataRepository) {
    //   di<PupilManager>().updatePupilProxyWithPupilData(pupil);
    // }
    // We don't need the temp file any more, let's delete it
    textFile.delete();

    for (PupilIdentity element in importedPupilIdentityList) {
      _pupilIdentities[element.id] = element;
    }

    await AppSecureStorage.write(
        '${SecureStorageKey.sessions.value}_${di<EnvManager>().defaultEnv}',
        jsonEncode(_pupilIdentities.values.toList()));

    // TODO: fix this
    // await di<PupilManager>().fetchAllPupils();

    di<NotificationService>().showSnackBar(NotificationType.success,
        '${_pupilIdentities.length} Schülerdaten wurden aktualisiert!');
    // TODO: fix this
    // di<MainMenuBottomNavManager>().setBottomNavPage(0);
    // di<MainMenuBottomNavManager>().pageViewController.value.jumpToPage(0);
    return;
  }

  Future<String> generatePupilIdentitiesQrData(List<int> pupilIds) async {
    String qrString = '';
    for (int pupilId in pupilIds) {
      PupilIdentity pupilIdentity = _pupilIdentities.values
          .where((element) => element.id == pupilId)
          .single;
      final migrationSupportEnds = pupilIdentity.migrationSupportEnds != null
          ? pupilIdentity.migrationSupportEnds!.formatForJson()
          : '';
      final specialNeeds = pupilIdentity.specialNeeds ?? '';
      final family = pupilIdentity.family ?? '';
      final String pupilbaseString =
          '${pupilIdentity.id},${pupilIdentity.firstName},${pupilIdentity.lastName},${pupilIdentity.group},${pupilIdentity.schoolGrade},$specialNeeds,,${pupilIdentity.gender},${pupilIdentity.language},$family,${pupilIdentity.birthday.formatForJson()},$migrationSupportEnds,${pupilIdentity.pupilSince.formatForJson()},\n';
      qrString = qrString + pupilbaseString;
    }
    final encryptedString = customEncrypter.encryptString(qrString);
    return encryptedString;
  }

  List<Map<String, Object>> generateAllPupilIdentitiesQrData(
      {required int pupilsPerCode}) {
    final List<PupilIdentity> pupilIdentity = _pupilIdentities.values.toList();
    // First we group the pupils by their group in a map
    Map<String, List<PupilIdentity>> groupedPupils =
        pupilIdentity.groupListsBy((element) => element.group);
    Map<String, int> groupLengths = {};
    final Map<String, String> finalGroupedList = {};

    // Now we iterate over the groupedPupils and generate maps with smaller lists
    // with no more than [pupilsPerCode] items and add to the group name the subgroup number
    for (String groupName in groupedPupils.keys) {
      final List<PupilIdentity> group = groupedPupils[groupName]!;
      groupLengths[groupName] = group.length;
      int numSubgroups = (group.length / pupilsPerCode).ceil();

      for (int i = 0; i < numSubgroups; i++) {
        List<PupilIdentity> smallerGroup = [];
        int start = i * pupilsPerCode;
        int end = (i + 1) * pupilsPerCode;
        if (end > group.length) {
          end = group.length;
        }
        smallerGroup.addAll(group.sublist(start, end));
        String qrString = '';
        for (PupilIdentity pupilIdentity in smallerGroup) {
          final migrationSupportEnds =
              pupilIdentity.migrationSupportEnds != null
                  ? pupilIdentity.migrationSupportEnds!.formatForJson()
                  : '';
          final specialNeeds = pupilIdentity.specialNeeds ?? '';
          final family = pupilIdentity.family ?? '';
          final String pupilIdentityString =
              '${pupilIdentity.id},${pupilIdentity.firstName},${pupilIdentity.lastName},${pupilIdentity.group},${pupilIdentity.schoolGrade},$specialNeeds,,${pupilIdentity.gender},${pupilIdentity.language},$family,${pupilIdentity.birthday.formatForJson()},$migrationSupportEnds,${pupilIdentity.pupilSince.formatForJson()},\n';
          qrString = qrString + pupilIdentityString;
        }
        final encryptedString = customEncrypter.encryptString(qrString);
        String subgroupName = "$groupName - ${i + 1}/$numSubgroups";
        finalGroupedList[subgroupName] = encryptedString;
      }
    }
    // Extracting entries from the map and sorting them based on keys
    List<MapEntry<String, String>> sortedEntries = finalGroupedList.entries
        .toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    groupLengths = Map.fromEntries(
        groupLengths.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
    // Creating a new map with sorted entries
    Map<String, String> sortedQrGroupLists = Map.fromEntries(sortedEntries);
    return [groupLengths, sortedQrGroupLists];
  }

  Future<String> deletePupilIdentities(List<int> toBeDeletedPupilIds) async {
    List<String> toBeDeletedPupilIdentities = [];

    for (int id in toBeDeletedPupilIds) {
      toBeDeletedPupilIdentities.add(
          '${_pupilIdentities[id]!.firstName} ${_pupilIdentities[id]!.lastName}, ${_pupilIdentities[id]!.group}');

      _pupilIdentities.remove(id);
    }

    writePupilIdentitiesToStorage(envKey: di<EnvManager>().defaultEnv);

    log(' ${toBeDeletedPupilIds.length} SuS sind nicht mehr in der Datenbank und wurden gelöscht!');

    return toBeDeletedPupilIdentities.join('\n');
  }
}
