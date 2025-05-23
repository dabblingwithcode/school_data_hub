import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/data/pupil_data_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_selector_filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_identity.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_helper_functions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

final _envManager = di<EnvManager>();
final _notificationService = di<NotificationService>();
final _mainMenuBottomNavManager = di<BottomNavManager>();

class PupilIdentityManager {
  final log = Logger('PupilIdentityManager');

  final secureStorageKey = _envManager.storageKeyForPupilIdentities;
  Map<int, PupilIdentity> _pupilIdentities = {};

  final _groups = ValueNotifier<Set<String>>({});
  ValueListenable<Set<String>> get groups => _groups;

  List<int> get availablePupilIds => _pupilIdentities.keys.toList();

  PupilIdentity getPupilIdentity(int internalId) {
    if (_pupilIdentities.containsKey(internalId) == false) {
      throw StateError(
          'Pupil with id $internalId not found in pupil identities!');
    }
    return _pupilIdentities[internalId]!;
  }

  Future<PupilIdentityManager> init() async {
    await getPupilIdentitiesForEnv();
    return this;
  }

  Future<void> deleteAllPupilIdentities() async {
    await LegacySecureStorage.delete(secureStorageKey);
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
    final activeEnv = _envManager.activeEnv!;

    final Map<int, PupilIdentity> pupilIdentities =
        await PupilIdentityHelper.readPupilIdentitiesFromStorage(
            secureStorageKey: secureStorageKey);

    if (pupilIdentities.isEmpty) {
      log.warning(
          'No stored pupil identities found for ${activeEnv.serverName}');
    } else {
      log.info(
          '${pupilIdentities.length} Pupil identities for [${activeEnv.serverName}] loaded from secure storage');
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
        // TODO: DonÄt forgert to create the attendance map entry for the new pupil
        // TODO: fix this
        if (!PupilProxy.groupFilters.any((filter) =>
                (filter as GroupFilter).name == newPupilIdentity.group) ==
            false) {
          updateGroupFilters = true;
        }
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

    writePupilIdentitiesToStorage();

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

  Future<void> writePupilIdentitiesToStorage() async {
    final Map<String, Map<String, dynamic>> jsonMap = _pupilIdentities.map(
      (key, value) => MapEntry(key.toString(), value.toJson()),
    );

    final jsonPupilIdentitiesAsString = json.encode(jsonMap);
    await LegacySecureStorage.write(
        secureStorageKey, jsonPupilIdentitiesAsString);
    log.info(
        'Pupil identities written to secure storage with key $secureStorageKey');
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

    final filePath = await ClientFileUpload.uploadFile(
      textFile,
      ServerStorageFolder.temp,
    );
    if (filePath.success == false) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Die Datei konnte nicht hochgeladen werden!');
      return;
    }
    final List<PupilData> updatedPupilDataRepository =
        await PupilDataApiService()
            .updateBackendPupilsDatabase(filePath: filePath.path!);
    for (PupilData pupil in updatedPupilDataRepository) {
      di<PupilManager>().updatePupilProxyWithPupilData(pupil);
    }
    // We don't need the temp file any more, let's delete it
    textFile.delete();

    for (PupilIdentity element in importedPupilIdentityList) {
      _pupilIdentities[element.id] = element;
    }

    await LegacySecureStorage.write(
        secureStorageKey, jsonEncode(_pupilIdentities.values.toList()));

    // TODO: fix this
    await di<PupilManager>().fetchAllPupils();

    _notificationService.showSnackBar(NotificationType.success,
        '${_pupilIdentities.length} Schülerdaten wurden aktualisiert!');

    // TODO: fix this
    _mainMenuBottomNavManager.setBottomNavPage(0);
    // _mainMenuBottomNavManager.pageViewController.value.jumpToPage(0);
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
      // We need
      final specialNeeds = pupilIdentity.specialNeeds ?? '';
      final family = pupilIdentity.family ?? '';
      final String pupilbaseString = '''
          ${pupilIdentity.id},
          ${pupilIdentity.firstName},
          ${pupilIdentity.lastName},
          ${pupilIdentity.group},
          ${pupilIdentity.schoolGrade},
          $specialNeeds,, 
          ${pupilIdentity.gender},
          ${pupilIdentity.language},
          $family,
          ${pupilIdentity.birthday.formatForJson()},
          $migrationSupportEnds,
          ${pupilIdentity.pupilSince.formatForJson()},
          \n''';
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

  Future<String> deleteOrphanPupilIdentities(
      List<int> toBeDeletedPupilIds) async {
    List<String> toBeDeletedPupilIdentities = [];

    for (int id in toBeDeletedPupilIds) {
      toBeDeletedPupilIdentities.add(
          '${_pupilIdentities[id]!.firstName} ${_pupilIdentities[id]!.lastName}, ${_pupilIdentities[id]!.group}');

      _pupilIdentities.remove(id);
    }

    writePupilIdentitiesToStorage();

    log.info(
        ' ${toBeDeletedPupilIds.length} pupils are not in the database any moreand wer deleted.');

    return toBeDeletedPupilIdentities.join('\n');
  }
}
