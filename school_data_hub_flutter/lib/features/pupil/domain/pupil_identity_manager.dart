import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/data/pupil_data_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_selector_filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_helper_functions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:signals/signals_flutter.dart';
import 'package:watch_it/watch_it.dart';

class PupilIdentityManager {
  final _log = Logger('PupilIdentityManager');

  final _notificationService = di<NotificationService>();
  final _envManager = di<EnvManager>();

  final _mainMenuBottomNavManager = di<BottomNavManager>();

  final secureStorageKey = di<EnvManager>().storageKeyForPupilIdentities;

  // data holders and getters

  Map<int, PupilIdentity> _pupilIdentities = {};

  final _groups = ValueNotifier<Set<String>>({});
  ValueListenable<Set<String>> get groups => _groups;

  final Signal<DateTime?> _remoteLastIdentitiesUpdate = signal(null);
  Signal<DateTime?> get remoteLastIdentitiesUpdate =>
      _remoteLastIdentitiesUpdate;

  List<PupilIdentity> get pupilIdentities => _pupilIdentities.values.toList();

  List<int> get availablePupilIds {
    return _pupilIdentities.keys.toList();
  }

  Future<PupilIdentityManager> init() async {
    await _getPupilIdentitiesForEnv();
    return this;
  }

  void dispose() {
    _groups.dispose();
    _remoteLastIdentitiesUpdate.dispose();
    _pupilIdentities.clear();
    _log.info('PupilIdentityManager disposed');
  }

  PupilIdentity? getPupilIdentityByInternalId(int internalId) {
    if (_pupilIdentities.containsKey(internalId) == false) {
      _notificationService.showInformationDialog(
        '''Die Schülerdaten mit der ID $internalId konnten nicht gefunden werden.
          Bitte überprüfen Sie die ID und versuchen Sie es erneut.''',
      );
      return null;
    }
    return _pupilIdentities[internalId]!;
  }

  void clearPupilIdentities() {
    _pupilIdentities.clear();
    return;
  }

  Future<void> _getPupilIdentitiesForEnv() async {
    final _activeEnv = _envManager.activeEnv!;

    final Map<int, PupilIdentity> pupilIdentities =
        await PupilIdentityHelper.readPupilIdentitiesFromStorage(
          secureStorageKey: secureStorageKey,
        );

    _pupilIdentities.clear();
    _pupilIdentities = pupilIdentities;
    if (pupilIdentities.isEmpty) {
      _log.warning(
        'No stored pupil identities found for ${_activeEnv.serverName}',
      );
    } else {
      _log.info(
        '${pupilIdentities.length} Pupil identities for [${_activeEnv.serverName}] loaded from secure storage: ${_pupilIdentities.length}',
      );
    }

    _groups.value = _pupilIdentities.values.map((e) => e.group).toSet();

    // Now we check if the identities are outdated

    final lastIdentitiesUpdate = await PupilDataApiService()
        .fetchLastIdentitiesUpdate();
    _remoteLastIdentitiesUpdate.value = lastIdentitiesUpdate;
    if (lastIdentitiesUpdate != null &&
        _activeEnv.lastIdentitiesUpdate != null) {
      if (lastIdentitiesUpdate.isAfter(_activeEnv.lastIdentitiesUpdate!)) {
        _notificationService.showInformationDialog(
          '''Die gespeicherten Schüler*innen-Ids vom ${_activeEnv.lastIdentitiesUpdate!.formatDateAndTimeForUser()} sind veraltet.
          
          Die neueste Version ist vom ${lastIdentitiesUpdate.formatDateAndTimeForUser()}.
          
          Schüler*innen-Ids aus einer vertrauenswürdigen Quelle aktualisieren!''',
        );
      } else {
        _log.info('Pupil identities are up to date.');
      }
    } else {
      _log.warning('No last identities update found in the server.');
    }
    return;
  }

  Future<void> updatePupilIdentitiesFromEncryptedText(
    DateTime updateTimestamp,
    String encryptedText,
  ) async {
    final normalizedTimestamp = updateTimestamp.toUtc();
    final decryptedText = customEncrypter.decryptString(encryptedText);

    _updatePupilIdentitiesFromUnencryptedSource(
      pupilIdentityTextLines: decryptedText,
      updateTimestamp: normalizedTimestamp,
    );
  }

  Future<void> _updatePupilIdentitiesFromUnencryptedSource({
    required String pupilIdentityTextLines,
    required DateTime? updateTimestamp,
  }) async {
    final normalizedUpdateTimestamp = updateTimestamp?.toUtc();

    // The pupils in the string are separated by a '\n' - let's split them apart
    List<String> pupilIdentityTextLineList = pupilIdentityTextLines.split('\n');

    // The properties are separated by commas, let's build the PupilIdentity objects with them

    bool updateGroupFilters = false;

    for (String textLine in pupilIdentityTextLineList) {
      if (textLine != '') {
        final newPupilIdentity =
            PupilIdentityHelper.decodePupilIdentityFromTextLine(textLine);

        //- check if the group filter needs to be updated
        if (PupilProxy.groupFilters.any(
              (filter) =>
                  (filter as GroupFilter).name == newPupilIdentity.group,
            ) ==
            false) {
          //- group filter needs to be updated, set the updateGroupFilters flag to true
          updateGroupFilters = true;
        }
        //- add the new pupil to the pupilIdentities map
        _pupilIdentities[newPupilIdentity.id] = newPupilIdentity;
      }
    }
    _log.info(
      'Pupil identities decoded from unencrypted source: ${_pupilIdentities.length}',
    );
    await _writePupilIdentitiesToStorage();

    if (updateGroupFilters) {
      final availableGroups = _pupilIdentities.values
          .map((e) => e.group)
          .toSet();
      _groups.value = availableGroups;
      di<PupilsFilter>().populateGroupFilters(availableGroups.toList());
    }
    await di<EnvManager>().updateActiveEnv(
      lastIdentitiesUpdate: normalizedUpdateTimestamp,
    );
    di<PupilManager>().fetchAllPupils();
    _mainMenuBottomNavManager.setBottomNavPage(0);
  }

  Future<void> _writePupilIdentitiesToStorage() async {
    final Map<String, Map<String, dynamic>> jsonMap = _pupilIdentities.map(
      (key, value) => MapEntry(key.toString(), value.toJson()),
    );

    final jsonPupilIdentitiesAsString = json.encode(jsonMap);

    try {
      await HubSecureStorage().setString(
        secureStorageKey,
        jsonPupilIdentitiesAsString,
      );
      _log.info(
        '${_pupilIdentities.length} pupil identities written to secure storage with key $secureStorageKey',
      );
    } catch (e, stack) {
      _log.severe(
        'Failed to write ${_pupilIdentities.length} pupil identities to secure storage with key $secureStorageKey: $e',
        e,
        stack,
      );
      rethrow;
    }
  }

  Future<void> updateServerFromPupilIdentityExternalSource(
    String textFileContent,
  ) async {
    // The pupils in the string are separated by a line break - let's split them out
    List<String> pupilIdentityTextLines = textFileContent.split('\n');
    // Wer prepare a string with the pupils that are going to be updated later in the server
    String pupilListTxtFileContentForBackendUpdate = '';
    // The properties are separated by commas, let's build the pupilbase objects with them
    List<PupilIdentity> importedPupilIdentityList = [];

    for (String textLine in pupilIdentityTextLines) {
      if (textLine != '') {
        PupilIdentity pupilIdentity =
            PupilIdentityHelper.decodePupilIdentityFromTextLine(textLine);

        importedPupilIdentityList.add(pupilIdentity);

        final bool afterSchoolCareStatus = textLine.split(',')[14] == 'OFFGANZ'
            ? true
            : false;

        final internalIdAndAfterSchoolCareData =
            '${int.parse(textLine.split(',')[0])},$afterSchoolCareStatus';

        pupilListTxtFileContentForBackendUpdate +=
            '$internalIdAndAfterSchoolCareData\n';
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
        NotificationType.error,
        'Die Datei konnte nicht hochgeladen werden!',
      );
      return;
    }

    // The backend successfuly updated the pupils, let's get the new update timestamp
    final updateTimestamp = await PupilDataApiService()
        .fetchLastIdentitiesUpdate();

    // Now we need to store the updated pupil identities in storage
    _updatePupilIdentitiesFromUnencryptedSource(
      pupilIdentityTextLines: textFileContent,
      updateTimestamp: updateTimestamp,
    );
    final List<PupilData>? updatedPupilDataRepository =
        await PupilDataApiService().updateBackendPupilsDatabase(
          filePath: fileResponse.path!,
        );
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

    // This is the new reference data for all the clients to adopt.
    // We need to update the active environment and the backend with the new last identities update.
    final newLastIdentitiesUpdate = DateTime.now().toUtc();
    await di<EnvManager>().updateActiveEnv(
      lastIdentitiesUpdate: newLastIdentitiesUpdate,
    );
    await PupilDataApiService().updateLastIdentitiesUpdate(
      newLastIdentitiesUpdate,
    );
    await di<PupilManager>().fetchAllPupils();

    _notificationService.showSnackBar(
      NotificationType.success,
      '${_pupilIdentities.length} Schülerdaten wurden aktualisiert!',
    );

    _mainMenuBottomNavManager.setBottomNavPage(0);

    return;
  }

  Future<void> fetchServerIdentitiesTimestamp() async {
    final lastUpdate = await PupilDataApiService().fetchLastIdentitiesUpdate();
    if (lastUpdate == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Zeitstempel für die letzte Aktualisierung der personenbezogenen Daten konnte nicht geladen werden',
      );
      return;
    }
    _notificationService.showSnackBar(
      NotificationType.success,
      'Letzte Aktualisierung personenbezogener Daten: ${lastUpdate.formatDateForUser()}',
    );
  }

  Future<String> deleteOrphanPupilIdentities(
    List<int> toBeDeletedPupilIds,
  ) async {
    List<String> deletedPupilIdentities = [];

    for (int id in toBeDeletedPupilIds) {
      deletedPupilIdentities.add(
        '${_pupilIdentities[id]!.firstName} ${_pupilIdentities[id]!.lastName}, ${_pupilIdentities[id]!.group}',
      );

      _pupilIdentities.remove(id);
    }

    _writePupilIdentitiesToStorage();

    _log.info(
      ' ${toBeDeletedPupilIds.length} pupils are not in the database any more and were deleted.',
    );

    return deletedPupilIdentities.join('\n');
  }
}
