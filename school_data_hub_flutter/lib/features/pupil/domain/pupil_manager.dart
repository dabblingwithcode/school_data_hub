import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/data/pupil_book_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/data/pupil_data_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter_impl.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:watch_it/watch_it.dart';

class PupilManager extends ChangeNotifier {
  final _log = Logger('PupilManager');

  final _notificationService = di<NotificationService>();

  final _hubSessionManager = di<HubSessionManager>();

  final _pupilDataApiService = PupilDataApiService();

  final _pupilBookApiService = PupilBookApiService();

  final _pupilIdPupilsMap = <int, PupilProxy>{};

  List<PupilProxy> get allPupils => _pupilIdPupilsMap.values.toList();

  PupilManager();

  Future<void> init() async {
    await fetchAllPupils();
  }

  //- HELPER METHODS

  void clearData() {
    _pupilIdPupilsMap.clear();
    return;
  }

  PupilProxy? getPupilByPupilId(int pupilId) {
    if (!_pupilIdPupilsMap.containsKey(pupilId)) {
      _log.warning('Pupil $pupilId not found');
      return null;
    }
    return _pupilIdPupilsMap[pupilId];
  }

  List<PupilProxy> getPupilsFromPupilIds(List<int> pupilIds) {
    List<PupilProxy> pupilsfromPupilIds = [];

    for (int pupilId in pupilIds) {
      final PupilProxy? pupil = _pupilIdPupilsMap.values.firstWhereOrNull(
        (pupil) => pupil.pupilId == pupilId,
      );
      if (pupil != null) {
        pupilsfromPupilIds.add(pupil);
      }
    }

    return pupilsfromPupilIds;
  }

  List<PupilProxy> getPupilsFromInternalIds(List<int> internalIds) {
    List<PupilProxy> pupilsfromInternalIds = [];

    for (int internalId in internalIds) {
      final PupilProxy? pupil = _pupilIdPupilsMap.values.firstWhereOrNull(
        (pupil) => pupil.internalId == internalId,
      );
      if (pupil != null) {
        pupilsfromInternalIds.add(pupil);
      }
    }

    return pupilsfromInternalIds;
  }

  List<int> getInternalIdsFromPupils(List<PupilProxy> pupils) {
    return pupils.map((pupil) => pupil.internalId).toList();
  }

  List<int> getPupilIdsFromPupils(List<PupilProxy> pupils) {
    return pupils.map((pupil) => pupil.pupilId).toList();
  }

  List<int> getInternalIdsFromPupilIds(List<int> pupilIds) {
    List<int> internalIds = [];
    for (int pupilId in pupilIds) {
      final PupilProxy? pupil = _pupilIdPupilsMap[pupilId];
      if (pupil != null) {
        internalIds.add(pupil.internalId);
      }
    }
    return internalIds;
  }

  List<PupilProxy> getPupilsNotListed(List<int> pupilIds) {
    Map<int, PupilProxy> allPupilsMap = Map<int, PupilProxy>.of(
      _pupilIdPupilsMap,
    );
    allPupilsMap.removeWhere((key, value) => pupilIds.contains(key));
    return allPupilsMap.values.toList();
  }

  List<PupilProxy> getSiblings(PupilProxy pupil) {
    if (pupil.family == null) {
      return [];
    }

    Map<int, PupilProxy> allPupilsMap = Map<int, PupilProxy>.of(
      _pupilIdPupilsMap,
    );

    // Filter by family value of the pupil
    allPupilsMap.removeWhere((key, value) => value.family != pupil.family);

    // Remove the pupil itself from the list of siblings
    allPupilsMap.remove(pupil.pupilId);

    final pupilSiblings = allPupilsMap.values.toList();

    return pupilSiblings;
  }

  List<PupilProxy> getPupilsWithBirthdaySinceDate(DateTime date) {
    Map<int, PupilProxy> allPupils = Map<int, PupilProxy>.of(_pupilIdPupilsMap);

    final DateTime now = DateTime.now().toUtc();

    allPupils.removeWhere((key, pupil) {
      final birthdayThisYear = DateTime(
        now.year,
        pupil.birthday.month,
        pupil.birthday.day,
      );

      // Ensure the birthday this year is not before the specified date and not after today.
      return !(birthdayThisYear.isAtSameMomentAs(date) ||
          (birthdayThisYear.isAfter(date) && birthdayThisYear.isBefore(now)));
    });

    final pupilsWithBirthdaySinceDate = allPupils.values.toList();

    pupilsWithBirthdaySinceDate.sort((b, a) {
      final birthdayA = DateTime(
        DateTime.now().year,
        a.birthday.month,
        a.birthday.day,
      );

      final birthdayB = DateTime(
        DateTime.now().year,
        b.birthday.month,
        b.birthday.day,
      );

      return birthdayA.compareTo(birthdayB);
    });

    return pupilsWithBirthdaySinceDate;
  }

  /// **TODO:** Do we need this?
  PupilsFilter getPupilFilter() {
    //return PupilsFilterImplementation(this, sortMode: sortMode);
    return PupilsFilterImplementation(this);
  }

  //- API CALLS

  //- Fetch all available pupils from the backend

  Future<void> fetchAllPupils() async {
    final pupilsToFetch = di<PupilIdentityManager>().availablePupilIds;

    if (pupilsToFetch.isEmpty) {
      _log.info(
        'No pupil identities available, canot fetch pupils without ids',
      );
      return;
    }
    await fetchPupilsByInternalId(pupilsToFetch);
  }

  Future<void> updatePupilList(List<PupilProxy> pupils) async {
    await fetchPupilsByInternalId(pupils.map((e) => e.pupilId).toList());
  }

  Future<void> updatePupilData(int pupilId) async {
    final fetchedPupil = await _pupilDataApiService.fetchListOfPupils(
      pupilInternalIds: [pupilId],
    );
    if (fetchedPupil == null) {
      return;
    }
    if (fetchedPupil.isNotEmpty) {
      updatePupilProxyWithPupilData(fetchedPupil.first);
    }
  }
  //- Fetch pupils with the given internal ids

  Future<void> fetchPupilsByInternalId(List<int> pupilInternalIds) async {
    _notificationService.showSnackBar(
      NotificationType.info,
      'Lade Schülerdaten vom Server. Bitte warten...',
    );

    // fetch the pupils from the backend
    final fetchedPupils = await _pupilDataApiService.fetchListOfPupils(
      pupilInternalIds: pupilInternalIds,
    );
    if (fetchedPupils == null) {
      return;
    }
    // check if we did not get a pupil response for some ids
    // if so, we will delete the personal data for those ids later
    final List<int> outdatedPupilIdentitiesIds = pupilInternalIds
        .where(
          (element) =>
              !fetchedPupils.any((pupil) => pupil.internalId == element),
        )
        .toList();

    // now we match the pupils from the response with their personal data

    for (PupilData fetchedPupil in fetchedPupils) {
      final proxyInRepository = _pupilIdPupilsMap[fetchedPupil.id!];
      if (proxyInRepository != null) {
        proxyInRepository.updatePupil(fetchedPupil);
      } else {
        // if the pupil is not in the repository, that would be weird
        // since we did not send the id to the backend

        final pupilIdentity = di<PupilIdentityManager>()
            .getPupilIdentityByInternalId(fetchedPupil.internalId);

        _pupilIdPupilsMap[fetchedPupil.id!] = PupilProxy(
          pupilData: fetchedPupil,
          pupilIdentity: pupilIdentity!,
        );
      }
    }

    // remove the outdated pupil identities that
    // did not get a response from the backend
    // because this means the pupil is not in the database anymore
    // and we need to delete the personal data from the device

    if (outdatedPupilIdentitiesIds.isNotEmpty) {
      final deletedPupilIdentities = await di<PupilIdentityManager>()
          .deleteOrphanPupilIdentities(outdatedPupilIdentitiesIds);
      _notificationService.showInformationDialog(
        'Diese Schüler_innen existieren nicht mehr in der Datenbank, Ihre Ids wurden aus dem Gerät gelöscht:\n\n$deletedPupilIdentities',
      );
    }
    _notificationService.showSnackBar(
      NotificationType.success,
      'Schülerdaten geladen!',
    );

    notifyListeners();
  }

  void updatePupilProxyWithPupilData(PupilData pupilData) {
    final proxy = _pupilIdPupilsMap[pupilData.id!];
    if (proxy != null) {
      proxy.updatePupil(pupilData);
      //- TODO ADVICE: Is this true? No need to call notifyListeners here, because the proxy will notify the listeners itself
      notifyListeners();
    }
  }

  void updatePupilProxiesWithPupilData(List<PupilData> pupils) {
    for (PupilData pupil in pupils) {
      updatePupilProxyWithPupilData(pupil);
    }
  }

  //-TODO: These functions should be somewhere else

  Future<void> updateSchoolyearHeldBackDate({
    required int pupilId,
    required ({DateTime? value}) date,
  }) async {
    final PupilData? updatedPupil = await _pupilDataApiService
        .updateSchoolyearHeldBackDate(pupilId: pupilId, date: date);
    if (updatedPupil == null) {
      return;
    }
    updatePupilProxyWithPupilData(updatedPupil);
  }

  Future<void> postPupilBookLending({
    required int pupilId,
    required String libraryId,
  }) async {
    final userName = _hubSessionManager.userName;

    final PupilData? updatedPupil = await _pupilBookApiService
        .postPupilBookLending(
          pupilId: pupilId,
          libraryId: libraryId,
          lentBy: userName!,
        );
    if (updatedPupil == null) {
      return;
    }
    _pupilIdPupilsMap[pupilId]!.updatePupil(updatedPupil);

    return;
  }

  Future<void> deletePupilBook({required String lendingId}) async {
    final pupil = await _pupilBookApiService.deletePupilBook(lendingId);
    if (pupil == null) {
      return;
    }
    _pupilIdPupilsMap[pupil.id!]!.updatePupil(pupil);

    return;
  }

  Future<void> returnLibraryBook({
    required PupilBookLending pupilBookLending,
  }) async {
    final updatedBookLending = pupilBookLending.copyWith(
      returnedAt: DateTime.now().toUtc(),
      receivedBy: _hubSessionManager.userName,
    );

    final pupil = await _pupilBookApiService.updatePupilBookLending(
      bookLending: updatedBookLending,
    );
    if (pupil == null) {
      return;
    }
    _pupilIdPupilsMap[pupil.id!]!.updatePupil(pupil);

    return;
  }

  Future<void> updatePupilBookLending({
    required PupilBookLending pupilBookLending,
    DateTime? lentAt,
    String? lentBy,
    ({String? value})? status,
    ({int? value})? score,
    ({DateTime? value})? returnedAt,
    ({String? value})? receivedBy,
  }) async {
    final updatedBookLending = pupilBookLending.copyWith(
      lentAt: lentAt ?? pupilBookLending.lentAt,
      lentBy: lentBy ?? pupilBookLending.lentBy,
      status: status != null ? status.value : pupilBookLending.status,
      score: score != null ? score.value : pupilBookLending.score,
      returnedAt: returnedAt != null
          ? returnedAt.value
          : pupilBookLending.returnedAt,
      receivedBy: receivedBy != null
          ? receivedBy.value
          : pupilBookLending.receivedBy,
    );
    final pupil = await _pupilBookApiService.updatePupilBookLending(
      bookLending: updatedBookLending,
    );
    if (pupil == null) {
      return;
    }
    _pupilIdPupilsMap[pupil.id!]!.updatePupil(pupil);

    return;
  }

  //- IMPORT FUNCTIONS

  // Future<void> importSupportLevelsFromJson() async {
  //   final jsonFilePath = await FilePicker.platform
  //       .pickFiles(type: FileType.custom, allowedExtensions: ['json'])
  //       .then((result) => result?.files.single.path);

  //   int totalRecords = 0;

  //   int successCount = 0;
  //   int notMatchedCount = 0;

  //   _log.info('Starting support level import from: $jsonFilePath');

  //   // Read and parse JSON file
  //   final file = File(jsonFilePath!);
  //   if (!await file.exists()) {
  //     throw Exception('File not found: $jsonFilePath');
  //   }

  //   final jsonString = await file.readAsString();
  //   final List<dynamic> jsonData = json.decode(jsonString);
  //   for (var entry in jsonData) {
  //     totalRecords++;
  //     final int internalId = entry['pupil_id'] as int;
  //     final level = entry['level'] as String;
  //     final String comment =
  //         entry['comment'] != ''
  //             ? customEncrypter.encryptString(entry['comment'] as String)
  //             : '';
  //     final DateTime createdAt = DateTime.parse(entry['created_at'] as String);
  //     final String createdBy = entry['created_by'] as String;

  //     final pupil = getPupilsFromInternalIds([internalId]).firstOrNull;
  //     if (pupil == null) {
  //       notMatchedCount++;
  //       _log.warning(
  //         'No pupil found for internal ID $internalId - skipping...',
  //       );
  //       continue;
  //     }
  //     await PupilMutator().updatePupilSupportLevel(
  //       pupilId: pupil.pupilId,
  //       level: int.parse(level),
  //       comment: comment.isEmpty ? 'Kein Eintrag gefunden' : comment,
  //       createdAt: createdAt,
  //       createdBy: createdBy,
  //     );
  //     _log.warning('Imported support level for pupil ID $internalId');
  //     // final result = await _updateSupportLevelWithJsonRecord(internalId, entry);

  //     // if (result == true) {
  //     //   successCount++;
  //     // } else if (result == false) {
  //     //   notMatchedCount++;
  //     // } else {
  //     //   // result is null, indicating an error during import
  //     //   _log.warning('Failed to import support level for pupil ID $internalId');
  //     // }
  //   }

  //   _log.info(
  //     'Import completed. Total records: $totalRecords, Successfully updated: $successCount, Not matched: $notMatchedCount',
  //   );
  // }

  /// Import pupil data from a JSON file
  /// Maps contact and parents_contact fields to existing pupils
  /// Uses array index to match pupils since JSON doesn't contain internal_id
  Future<void> importPupilDataFromJson() async {
    final jsonFilePath = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['json'])
        .then((result) => result?.files.single.path);

    if (jsonFilePath == null) {
      return;
    }

    int totalRecords = 0;

    int successCount = 0;
    int notMatchedCount = 0;

    _log.info('Starting pupil data import from: $jsonFilePath');

    // Read and parse JSON file
    final file = File(jsonFilePath);
    if (!await file.exists()) {
      throw Exception('File not found: $jsonFilePath');
    }

    final jsonString = await file.readAsString();
    final List<dynamic> jsonData = json.decode(jsonString);
    for (var entry in jsonData) {
      totalRecords++;
      final int internalId = entry['internal_id'] as int;

      final result = await _updatePupilWithJsonRecord(internalId, entry);

      if (result == true) {
        successCount++;
      } else if (result == false) {
        notMatchedCount++;
      } else {
        // result is null, indicating an error during import
        _log.warning('Failed to import data for pupil ID $internalId');
      }
    }

    _log.info(
      'Import completed. Total records: $totalRecords, Successfully updated: $successCount, Not matched: $notMatchedCount',
    );
  }

  /// Process the import data and update pupils

  /// Import individual pupil record
  Future<bool?> _updatePupilWithJsonRecord(
    int internalId,
    Map<String, dynamic> data,
  ) async {
    bool hasUpdates = false;
    _log.info('Querying internal ID: $internalId');
    final pupil = getPupilsFromInternalIds([internalId]).firstOrNull;

    if (pupil == null) {
      _log.warning('Pupil not found for internal ID: $internalId');
      return false;
    }

    try {
      final avatarAuthId = data['avatar_auth_id'] as String?;
      if (avatarAuthId != null) {
        // Find the avatar file in the decrypted folder
        final decryptedFolderPath =
            'H:/code/dabblingwithcode/school_data_hub/private/old_instance/media_upload/auth/decrypted';
        final avatarFileName = '_${avatarAuthId}.jpg';
        final avatarFile = File('$decryptedFolderPath/$avatarFileName');

        if (await avatarFile.exists()) {
          _log.info('Avatar file found: $avatarFileName');
          try {
            // Update the pupil with the avatar file
            await PupilMutator().updatePupilDocument(
              imageFile: avatarFile,
              pupilProxy: pupil,
              documentType: PupilDocumentType.avatarAuth,
            );
            hasUpdates = true;
            _log.info(
              'Updated avatar auth for pupil ${pupil.internalId} with file: $avatarFileName',
            );
          } catch (e) {
            _log.warning(
              'Failed to update avatar auth for pupil ${pupil.internalId}: $e',
            );
          }
        } else {
          _log.warning('Avatar file not found: $avatarFileName');
        }
      }

      if (hasUpdates) {
        return true;
      }
    } catch (e, stackTrace) {
      _log.severe('Error importing data for pupil $internalId', e, stackTrace);
      return null;
    }
    return false;
  }
}
