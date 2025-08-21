import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/data/pupil_data_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_selector_filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_helper_functions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

final _envManager = di<EnvManager>();

enum PupilIdentityStreamRole {
  sender,
  receiver,
}

class PupilIdentityManager {
  final _notificationService = di<NotificationService>();

  final _mainMenuBottomNavManager = di<BottomNavManager>();

  final _log = Logger('PupilIdentityManager');

  final secureStorageKey = _envManager.storageKeyForPupilIdentities;

  Map<int, PupilIdentity> _pupilIdentities = {};

  final _groups = ValueNotifier<Set<String>>({});
  ValueListenable<Set<String>> get groups => _groups;

  StreamSubscription<PupilIdentityDto>? _encryptedPupilIdsSubscription;

  // List<int> get availablePupilIds => _pupilIdentities.keys.toList();

  List<int> get availablePupilIds {
    _log.fine(
        'getter returning [${_pupilIdentities.keys.length}] available pupil ids');
    return _pupilIdentities.keys.toList();
  }

  PupilIdentity? getPupilIdentityByInternalId(int internalId) {
    if (_pupilIdentities.containsKey(internalId) == false) {
      _notificationService.showSnackBar(NotificationType.warning,
          'Schülerdaten nicht gefunden (ID: $internalId)');
      _notificationService.showInformationDialog(
          '''Die Schülerdaten mit der ID $internalId konnten nicht gefunden werden.
          
          Bitte überprüfen Sie die ID und versuchen Sie es erneut.''');
      return null;
    }
    return _pupilIdentities[internalId]!;
  }

  Future<PupilIdentityManager> init() async {
    await getPupilIdentitiesForEnv();
    return this;
  }

  void dispose() {
    _groups.dispose();
    _pupilIdentities.clear();
    _log.info('PupilIdentityManager disposed');
  }

  Future<void> deleteAllPupilIdentities() async {
    await HubSecureStorage().remove(secureStorageKey);
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

    _pupilIdentities.clear();
    _pupilIdentities = pupilIdentities;
    if (pupilIdentities.isEmpty) {
      _log.warning(
          'No stored pupil identities found for ${activeEnv.serverName}');
    } else {
      _log.info(
          '${pupilIdentities.length} Pupil identities for [${activeEnv.serverName}] loaded from secure storage: ${_pupilIdentities.length}');
    }

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
            PupilIdentityHelper.decodePupilIdentityFromStringList(
                pupilIdentityValues);
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
    if (updateGroupFilters) {
      final availableGroups =
          _pupilIdentities.values.map((e) => e.group).toSet();
      _groups.value = availableGroups;
      di<PupilsFilter>().populateGroupFilters(availableGroups.toList());
    }
    await _envManager.updateActiveEnv(
        lastIdentitiesUpdate: DateTime.now().toUtc());

    _mainMenuBottomNavManager.setBottomNavPage(0);
  }

  Future<void> writePupilIdentitiesToStorage() async {
    final Map<String, Map<String, dynamic>> jsonMap = _pupilIdentities.map(
      (key, value) => MapEntry(key.toString(), value.toJson()),
    );

    final jsonPupilIdentitiesAsString = json.encode(jsonMap);
    await HubSecureStorage()
        .setString(secureStorageKey, jsonPupilIdentitiesAsString);
    _log.info(
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
            PupilIdentityHelper.decodePupilIdentityFromStringList(
                pupilIdentityValues);

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

    final fileResponse = await ClientFileUpload.uploadFile(
      textFile,
      ServerStorageFolder.temp,
    );
    if (fileResponse.success == false) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Die Datei konnte nicht hochgeladen werden!');
      return;
    }
    final List<PupilData>? updatedPupilDataRepository =
        await PupilDataApiService()
            .updateBackendPupilsDatabase(filePath: fileResponse.path!);
    if (updatedPupilDataRepository == null) {
      return;
    }
    for (PupilData pupil in updatedPupilDataRepository) {
      di<PupilManager>().updatePupilProxyWithPupilData(pupil);
    }
    // We don't need the temp file any more, let's delete it
    textFile.delete();

    for (PupilIdentity element in importedPupilIdentityList) {
      _pupilIdentities[element.id] = element;
    }

    await HubSecureStorage().setString(
        secureStorageKey, jsonEncode(_pupilIdentities.values.toList()));

    await ClientHelper.apiCall(
      call: () => di<Client>().pupilIdentity.updateLastPupilIdentitiesUpdate(
            DateTime.now().toUtc(),
          ),
      errorMessage: 'Die letzte Aktualisierung konnte nicht gespeichert werden',
    );

    await di<PupilManager>().fetchAllPupils();

    _notificationService.showSnackBar(NotificationType.success,
        '${_pupilIdentities.length} Schülerdaten wurden aktualisiert!');

    _mainMenuBottomNavManager.setBottomNavPage(0);

    return;
  }

  Future<void> fetchLastIdentitiesUpdate() async {
    final lastUpdate = await PupilDataApiService().fetchLastIdentitiesUpdate();
    if (lastUpdate == null) {
      _notificationService.showSnackBar(NotificationType.error,
          'Die letzte Aktualisierung konnte nicht geladen werden');
      return;
    }
    _notificationService.showSnackBar(NotificationType.success,
        'Letzte Aktualisierung: ${lastUpdate.formatForJson()}');
  }

  Future<String> generatePupilIdentitiesQrData(List<int> internalIds) async {
    String qrString = '';
    for (int internalId in internalIds) {
      PupilIdentity pupilIdentity = _pupilIdentities.values
          .where((element) => element.id == internalId)
          .single;
      final migrationSupportEnds = pupilIdentity.migrationSupportEnds != null
          ? pupilIdentity.migrationSupportEnds!.formatForJson()
          : '';
      // We need
      final specialNeeds = pupilIdentity.specialNeeds ?? '';
      final family = pupilIdentity.family ?? '';

      final String pupilIdentityString = [
            pupilIdentity.id.toString(),
            pupilIdentity.firstName,
            pupilIdentity.lastName,
            pupilIdentity.group,
            pupilIdentity.groupTutor,
            pupilIdentity.schoolGrade,
            specialNeeds,
            '', // this is a placeholder for the second special needs field in the administrative data source
            pupilIdentity.gender,
            pupilIdentity.language,
            family,
            pupilIdentity.birthday.formatForJson(),
            migrationSupportEnds,
            pupilIdentity.pupilSince.formatForJson(),
            pupilIdentity.afterSchoolCare,
            pupilIdentity.religion ?? '',
            pupilIdentity.religionLessonsSince?.formatForJson() ?? '',
            pupilIdentity.leavingDate?.formatForJson() ?? '',
          ].join(',') +
          ',\n';
      qrString = qrString + pupilIdentityString;
    }
    final encryptedString = customEncrypter.encryptString(qrString);
    return encryptedString;
  }

  // List<Map<String, Object>> generateAllPupilIdentitiesQrData(
  //     {required int pupilsPerCode}) {
  //   final List<PupilIdentity> pupilIdentity = _pupilIdentities.values.toList();
  //   // First we group the pupils by their group in a map
  //   Map<String, List<PupilIdentity>> groupedPupils =
  //       pupilIdentity.groupListsBy((element) => element.group);
  //   Map<String, int> groupLengths = {};
  //   final Map<String, String> finalGroupedList = {};

  //   // Now we iterate over the groupedPupils and generate maps with smaller lists
  //   // with no more than [pupilsPerCode] items and add to the group name the subgroup number
  //   for (String groupName in groupedPupils.keys) {
  //     final List<PupilIdentity> group = groupedPupils[groupName]!;
  //     groupLengths[groupName] = group.length;
  //     int numSubgroups = (group.length / pupilsPerCode).ceil();

  //     for (int i = 0; i < numSubgroups; i++) {
  //       List<PupilIdentity> smallerGroup = [];
  //       int start = i * pupilsPerCode;
  //       int end = (i + 1) * pupilsPerCode;
  //       if (end > group.length) {
  //         end = group.length;
  //       }
  //       smallerGroup.addAll(group.sublist(start, end));
  //       String qrString = '';
  //       for (PupilIdentity pupilIdentity in smallerGroup) {
  //         final migrationSupportEnds =
  //             pupilIdentity.migrationSupportEnds != null
  //                 ? pupilIdentity.migrationSupportEnds!.formatForJson()
  //                 : '';
  //         final specialNeeds = pupilIdentity.specialNeeds ?? '';
  //         final family = pupilIdentity.family ?? '';
  //         final String pupilIdentityString =
  //             '${pupilIdentity.id},${pupilIdentity.firstName},${pupilIdentity.lastName},${pupilIdentity.group},${pupilIdentity.schoolGrade},$specialNeeds,,${pupilIdentity.gender},${pupilIdentity.language},$family,${pupilIdentity.birthday.formatForJson()},$migrationSupportEnds,${pupilIdentity.pupilSince.formatForJson()},\n';
  //         qrString = qrString + pupilIdentityString;
  //       }
  //       final encryptedString = customEncrypter.encryptString(qrString);
  //       String subgroupName = "$groupName - ${i + 1}/$numSubgroups";
  //       finalGroupedList[subgroupName] = encryptedString;
  //     }
  //   }
  //   // Extracting entries from the map and sorting them based on keys
  //   List<MapEntry<String, String>> sortedEntries = finalGroupedList.entries
  //       .toList()
  //     ..sort((a, b) => a.key.compareTo(b.key));
  //   groupLengths = Map.fromEntries(
  //       groupLengths.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
  //   // Creating a new map with sorted entries
  //   Map<String, String> sortedQrGroupLists = Map.fromEntries(sortedEntries);
  //   return [groupLengths, sortedQrGroupLists];
  // }

  Future<String> deleteOrphanPupilIdentities(
      List<int> toBeDeletedPupilIds) async {
    List<String> toBeDeletedPupilIdentities = [];

    for (int id in toBeDeletedPupilIds) {
      toBeDeletedPupilIdentities.add(
          '${_pupilIdentities[id]!.firstName} ${_pupilIdentities[id]!.lastName}, ${_pupilIdentities[id]!.group}');

      _pupilIdentities.remove(id);
    }

    writePupilIdentitiesToStorage();

    _log.info(
        ' ${toBeDeletedPupilIds.length} pupils are not in the database any more and wer deleted.');

    return toBeDeletedPupilIdentities.join('\n');
  }

  StreamSubscription<PupilIdentityDto> encryptedPupilIdsStreamSubscription({
    required String channelName,
    required PupilIdentityStreamRole role,
    String? encryptedPupilIds,
    required Function() onConnected,
    required Function(String message) onStatusUpdate,
    required Function() onCompleted,
  }) {
    _log.info(
        'encryptedPupilIdsStreamSubscription called with channelName: $channelName and role: $role');
    final _client = di<Client>();
    _log.info('starting missedSchooldayStreamSubscription');
    // just in case we have a previous subscription, we cancel it first
    _encryptedPupilIdsSubscription?.cancel();
    _encryptedPupilIdsSubscription =
        _client.pupilIdentity.streamEncryptedPupilIds(channelName).listen(
      (PupilIdentityDto event) async {
        onConnected();
        switch (role) {
          //- Stream behavior for sender role
          case PupilIdentityStreamRole.sender:
            // - Handle the event based on its type
            switch (event.type) {
              case 'request':
                _notificationService.showInformationDialog(
                    'Empfänger ${event.value} hat die verschlüsselten Schülerdaten angefordert.');
                _log.info(
                    'Sender requested encrypted pupil identities, sending data...');

                onStatusUpdate('Sende Daten...');

                await _client.pupilIdentity.sendPupilIdentityMessage(
                  channelName,
                  PupilIdentityDto(
                      type: 'data', value: encryptedPupilIds ?? ''),
                );

                break;
              case 'ok':
                onCompleted();
                _log.info('Receiver acknowledged the data');

                return;
            }
            break;
          //- Stream behavior for receiver role
          case PupilIdentityStreamRole.receiver:
            switch (event.type) {
              // case 'request':
              //   onStatusUpdate(
              //       'Empfänger ${event.value} hat die verschlüsselten Schülerdaten angefordert.');

              //   _log.info('Sender requested encrypted pupil identities');
              //   break;
              case 'data':
                onStatusUpdate('Verschlüsselte Schülerdaten empfangen.');
                _log.info(
                    'Received encrypted pupil identities: ${event.value.length} characters');
                await decryptAndAddOrUpdatePupilIdentities([event.value]);
                await _client.pupilIdentity.sendPupilIdentityMessage(
                  channelName,
                  PupilIdentityDto(type: 'ok', value: ''),
                );
                _encryptedPupilIdsSubscription!.cancel();
                return;
            }
        }
      },
      onError: (error) async {
        final errorString = error.toString();
        ;
        _log.severe('Error in pupil identity stream: $error');
        if (error.toString().contains('Unauthorized')) {
          _encryptedPupilIdsSubscription!.cancel();
          return di<HubSessionManager>().signOutDevice();
        } else if (error.toString().contains('Netzwerkverbindung abgelehnt')) {
          // TODO: Implement server not responding
          //- This is very buggy
          _notificationService.showInformationDialog(
              'Der Server konnte nicht gefunden werden. Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.');
        } else {
          _notificationService.showSnackBar(NotificationType.error,
              'Ein unbekannter Fehler ist aufgetreten: $errorString');
        }
        // retry the subscription after a delay
        await Future.delayed(const Duration(seconds: 1));
        _encryptedPupilIdsSubscription!.cancel();
        encryptedPupilIdsStreamSubscription(
          channelName: channelName,
          role: role,
          encryptedPupilIds: encryptedPupilIds,
          onConnected: onConnected,
          onStatusUpdate: onStatusUpdate,
          onCompleted: onCompleted,
        );
      },
      onDone: () {
        _notificationService.showSnackBar(
            NotificationType.success, 'Verbindung zum Client geschlossen.');
      },
    );

    return _encryptedPupilIdsSubscription!;
  }
}

enum PupilIdentityDtoType {
  request,
  data,
  ok,
}
