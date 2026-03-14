import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/data/pupil_data_api_service.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupil_selector_filters.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class PupilIdentityManager {
  final _log = Logger('PupilIdentityManager');

  final _notificationService = di<NotificationManager>();
  final _envManager = di<EnvManager>();

  final _mainMenuBottomNavManager = di<BottomNavManager>();

  final _secureStorageKey = di<EnvManager>().storageKeyForPupilIdentities;

  // data holders and getters

  Map<int, PupilIdentity> _pupilIdentities = {};

  final _groups = ValueNotifier<Set<String>>({});
  ValueListenable<Set<String>> get groups => _groups;

  final ValueNotifier<DateTime?> _remoteLastIdentitiesUpdate = ValueNotifier(
    null,
  );
  ValueNotifier<DateTime?> get remoteLastIdentitiesUpdate =>
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
        NotificationType.error,
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
    final activeEnv = _envManager.activeEnv!;

    // Legacy identities (e.g. specialNeeds as String, missing deputyGroupTutor/
    // nationality/schoolTransitionRecommendation) are normalized in
    // PupilIdentityHelper._jsonDecodePupilIdentities before fromJson.
    // TODO: remove after transition has been made in production
    final Map<int, PupilIdentity> pupilIdentities =
        await PupilIdentityHelper.readPupilIdentitiesFromStorage(
          secureStorageKey: _secureStorageKey,
        );

    _pupilIdentities.clear();
    _pupilIdentities = pupilIdentities;
    if (pupilIdentities.isEmpty) {
      _log.warning(
        'No stored pupil identities found for ${activeEnv.serverName}',
      );
    } else {
      _log.info(
        '${pupilIdentities.length} Pupil identities for [${activeEnv.serverName}] loaded from secure storage: ${_pupilIdentities.length}',
      );
    }

    _groups.value = _pupilIdentities.values.map((e) => e.group).toSet();

    // Now we check if the identities are outdated

    final remoteLastIdentitiesUpdate = await PupilDataApiService()
        .fetchLastIdentitiesUpdate();
    _remoteLastIdentitiesUpdate.value = remoteLastIdentitiesUpdate;

    return;
  }

  Future<void> updatePupilIdentitiesFromEncryptedText(
    DateTime updateTimestamp,
    String encryptedText,
  ) async {
    final normalizedTimestamp = updateTimestamp.toUtc();
    final decryptedText = customEncrypter.decryptString(encryptedText);

    updatePupilIdentitiesFromUnencryptedSource(
      pupilIdentityTextLines: decryptedText,
      updateTimestamp: normalizedTimestamp,
    );
  }

  Future<void> updatePupilIdentitiesFromUnencryptedSource({
    required String pupilIdentityTextLines,
    required DateTime? updateTimestamp,
  }) async {
    final normalizedUpdateTimestamp = updateTimestamp?.toUtc();

    // The pupils in the string are separated by a '\n' - let's split them apart
    List<String> pupilIdentityTextLineList = pupilIdentityTextLines.split('\n');

    // The properties are separated by commas, let's build the PupilIdentity objects with them

    bool updateGroupFilters = false;
    String pupilIdentitiesWithBirthday = '';
    for (String textLine in pupilIdentityTextLineList) {
      if (textLine != '') {
        final newPupilIdentity =
            PupilIdentityHelper.decodePupilIdentityFromTextLine(textLine);

        //- check if the group filter needs to be updated
        if (di<PupilsFilter>().groupFilters.any(
              (filter) =>
                  (filter as GroupFilter).name == newPupilIdentity.group,
            ) ==
            false) {
          //- group filter needs to be updated, set the updateGroupFilters flag to true
          updateGroupFilters = true;
        }
        //- add the new pupil to the pupilIdentities map
        _pupilIdentities[newPupilIdentity.id] = newPupilIdentity;
        pupilIdentitiesWithBirthday =
            '$pupilIdentitiesWithBirthday${newPupilIdentity.group}, ${newPupilIdentity.firstName}, Geburtstag: ${newPupilIdentity.birthday},\n ';
      }
    }
    _log.info('Pupil identities with birthday:\n$pupilIdentitiesWithBirthday');

    await _writePupilIdentitiesToStorage();

    if (updateGroupFilters) {
      final availableGroups = _pupilIdentities.values
          .map((e) => e.group)
          .toSet();
      _groups.value = availableGroups;
      di<PupilsFilter>().populateGroupFilters(availableGroups.toList());
    }
    di<PupilProxyManager>().clearData();
    await di<EnvManager>().updateActiveEnv(
      lastIdentitiesUpdate: normalizedUpdateTimestamp,
    );
    di<PupilProxyManager>().fetchAllPupils();
    _mainMenuBottomNavManager.setBottomNavPage(0);
  }

  Future<void> _writePupilIdentitiesToStorage() async {
    final Map<String, Map<String, dynamic>> jsonMap = _pupilIdentities.map(
      (key, value) => MapEntry(key.toString(), value.toJson()),
    );

    final jsonPupilIdentitiesAsString = json.encode(jsonMap);

    try {
      await HubSecureStorage().setString(
        _secureStorageKey,
        jsonPupilIdentitiesAsString,
      );
      _log.info(
        '${_pupilIdentities.length} pupil identities written to secure storage with key $_secureStorageKey',
      );
    } catch (e, stack) {
      _log.severe(
        'Failed to write ${_pupilIdentities.length} pupil identities to secure storage with key $_secureStorageKey: $e',
        e,
        stack,
      );
      rethrow;
    }
  }

  Future<void> updateServerFromPupilIdentityExternalSource(
    String textFileContent,
  ) async {
    final reducedContent = PupilIdentityHelper.buildReducedPupilSyncContent(
      textFileContent,
    );

    // Update backend with reduced content (id,afterSchoolCare per line). Server accepts string; no file upload.
    final List<PupilData>? updatedPupilDataRepository =
        await PupilDataApiService().updateBackendPupilsDatabase(
          reducedContent: reducedContent,
        );
    if (updatedPupilDataRepository == null) {
      return;
    }

    // Only update local state after successful server update.
    final newLastIdentitiesUpdate = DateTime.now().toUtc();
    updatePupilIdentitiesFromUnencryptedSource(
      pupilIdentityTextLines: textFileContent,
      updateTimestamp: newLastIdentitiesUpdate,
    );
    for (PupilData pupil in updatedPupilDataRepository) {
      di<PupilProxyManager>().updatePupilProxyWithPupilData(pupil);
    }

    // Update server timestamp for last identities (env and fetchAllPupils already done by updatePupilIdentitiesFromUnencryptedSource).
    await PupilDataApiService().insertLastIdentitiesUpdate(
      newLastIdentitiesUpdate,
    );

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
