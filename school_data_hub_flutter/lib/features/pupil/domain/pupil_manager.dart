import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/pupil/data/pupil_data_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter_impl.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('PupilManager');
final _notificationService = di<NotificationService>();
final _cacheManager = di<DefaultCacheManager>();
final _pupilIdentityManager = di<PupilIdentityManager>();
final _schooldayManager = di<SchooldayManager>();
final _pupilDataApiService = PupilDataApiService();

class PupilManager extends ChangeNotifier {
  final _pupilsInternalIdMap = <int, PupilProxy>{};

  List<PupilProxy> get allPupils => _pupilsInternalIdMap.values.toList();

  PupilManager();

  Future<void> init() async {
    await fetchAllPupils();
  }

  //- HELPER METHODS

  void clearData() {
    _pupilsInternalIdMap.clear();
    return;
  }

  PupilProxy? getPupilByInternalId(int internalId) {
    if (!_pupilsInternalIdMap.containsKey(internalId)) {
      _log.severe('Pupil $internalId not found', StackTrace.current);
      return null;
    }
    return _pupilsInternalIdMap[internalId];
  }

  List<PupilProxy> pupilsFromInternalIds(List<int> internalIds) {
    List<PupilProxy> pupilsfromInternalIds = [];

    for (int internalId in internalIds) {
      pupilsfromInternalIds.add(_pupilsInternalIdMap[internalId]!);
    }

    return pupilsfromInternalIds;
  }

  List<int> internalIdsFromPupils(List<PupilProxy> pupils) {
    return pupils.map((pupil) => pupil.internalId).toList();
  }

  List<PupilProxy> pupilsNotListed(List<int> internalIds) {
    Map<int, PupilProxy> allPupils =
        Map<int, PupilProxy>.of(_pupilsInternalIdMap);
    allPupils.removeWhere((key, value) => internalIds.contains(key));
    return allPupils.values.toList();
  }

  List<PupilProxy> siblings(PupilProxy pupil) {
    if (pupil.family == null) {
      return [];
    }

    Map<int, PupilProxy> allPupils =
        Map<int, PupilProxy>.of(_pupilsInternalIdMap);

    // Filter by family value of the pupil
    allPupils.removeWhere((key, value) => value.family != pupil.family);
    // Remove the pupil itself from the list of siblings
    allPupils.remove(pupil.internalId);
    final pupilSiblings = allPupils.values.toList();
    return pupilSiblings;
  }

  List<PupilProxy> pupilsWithBirthdaySinceDate(DateTime date) {
    Map<int, PupilProxy> allPupils =
        Map<int, PupilProxy>.of(_pupilsInternalIdMap);
    final DateTime now = DateTime.now();
    allPupils.removeWhere((key, pupil) {
      final birthdayThisYear =
          DateTime(now.year, pupil.birthday.month, pupil.birthday.day);
      // Ensure the birthday this year is not before the specified date and not after today.
      return !(birthdayThisYear.isAtSameMomentAs(date) ||
          (birthdayThisYear.isAfter(date) && birthdayThisYear.isBefore(now)));
    });
    final pupilsWithBirthdaySinceDate = allPupils.values.toList();
    pupilsWithBirthdaySinceDate.sort((b, a) {
      final birthdayA =
          DateTime(DateTime.now().year, a.birthday.month, a.birthday.day);
      final birthdayB =
          DateTime(DateTime.now().year, b.birthday.month, b.birthday.day);
      return birthdayA.compareTo(birthdayB);
    });
    return pupilsWithBirthdaySinceDate;
  }

  //- API CALLS

  //- Fetch all available pupils from the backend

  Future<void> fetchAllPupils() async {
    final pupilsToFetch = _pupilIdentityManager.availablePupilIds;
    if (pupilsToFetch.isEmpty) {
      return;
    }
    await fetchPupilsByInternalId(pupilsToFetch);
  }

  Future<void> updatePupilList(List<PupilProxy> pupils) async {
    await fetchPupilsByInternalId(pupils.map((e) => e.internalId).toList());
  }

  //- Fetch pupils with the given internal ids

  Future<void> fetchPupilsByInternalId(List<int> internalPupilIds) async {
    _notificationService.showSnackBar(
        NotificationType.info, 'Lade Schülerdaten vom Server. Bitte warten...');

    // fetch the pupils from the backend
    final fetchedPupils = await _pupilDataApiService.fetchListOfPupils(
        internalPupilIds: internalPupilIds);

    // check if we did not get a pupil response for some ids
    // if so, we will delete the personal data for those ids later
    final List<int> outdatedPupilIdentitiesIds = internalPupilIds
        .where((element) =>
            !fetchedPupils.any((pupil) => pupil.internalId == element))
        .toList();

    // now we match the pupils from the response with their personal data

    for (PupilData fetchedPupil in fetchedPupils) {
      final proxyInRepository = _pupilsInternalIdMap[fetchedPupil.internalId];
      if (proxyInRepository != null) {
        proxyInRepository.updatePupil(fetchedPupil);
      } else {
        // if the pupil is not in the repository, that would be weird
        // since we did not send the id to the backend

        final pupilIdentity =
            _pupilIdentityManager.getPupilIdentity(fetchedPupil.internalId);

        _pupilsInternalIdMap[fetchedPupil.internalId] =
            PupilProxy(pupilData: fetchedPupil, pupilIdentity: pupilIdentity);
      }
    }

    // remove the outdated pupil identities that
    // did not get a response from the backend
    // because this means the pupil is not in the database anymore
    // and we need to delete the personal data from the device

    if (outdatedPupilIdentitiesIds.isNotEmpty) {
      final deletedPupilIdentities = await _pupilIdentityManager
          .deleteOrphanPupilIdentities(outdatedPupilIdentitiesIds);
      _notificationService.showInformationDialog(
          'Diese Schüler_innen existieren nicht mehr in der Datenbank, Ihre Ids wurden aus dem Gerät gelöscht:\n\n$deletedPupilIdentities');
    }
    _notificationService.showSnackBar(
        NotificationType.success, 'Schülerdaten geladen!');

    notifyListeners();
  }

  void updatePupilProxyWithPupilData(PupilData pupilData) {
    final proxy = _pupilsInternalIdMap[pupilData.internalId];
    if (proxy != null) {
      proxy.updatePupil(pupilData);
      //- TODO: Is this true: No need to call notifyListeners here, because the proxy will notify the listeners itself
      notifyListeners();
    }
  }

  void updatePupilProxiesWithPupilData(List<PupilData> pupils) {
    for (PupilData pupil in pupils) {
      updatePupilProxyWithPupilData(pupil);
    }
  }

  Future<void> postAvatarImage(
    File imageFile,
    PupilProxy pupilProxy,
  ) async {
    // first we encrypt the file

    final encryptedFile = await customEncrypter.encryptFile(imageFile);

    // if the pupil already has an avatar, we need to get the old documentId
    // and delete the old avatar from the cache
    if (pupilProxy.avatar != null) {
      final cacheKey = pupilProxy.avatar!.documentId;
      _cacheManager.removeFile(cacheKey.toString());
    }

    // send the Api request

    final PupilData pupilUpdate =
        await _pupilDataApiService.updatePupilWithAvatar(
      pupilId: pupilProxy.pupilId,
      file: encryptedFile,
    );

    // update the pupil in the repository
    updatePupilProxyWithPupilData(pupilUpdate);
    //  pupilProxy.updatePupil(pupilUpdate);
  }

  Future<void> updateCredit({required int pupilId, required int credit}) async {
    // send the Api request
    final PupilData pupilUpdate = await _pupilDataApiService.updateCredit(
      pupilId: pupilId,
      credit: credit,
    );

    // update the pupil in the repository
    updatePupilProxyWithPupilData(pupilUpdate);
  }

  // Future<void> postAvatarAuthImage(
  //   File imageFile,
  //   PupilProxy pupilProxy,
  // ) async {
  //   // first we encrypt the file

  //   final encryptedFile = await customEncrypter.encryptFile(imageFile);

  //   // Now we prepare the form data for the request.

  //   // send the Api request

  //   final PupilData pupilUpdate =
  //       await pupilDataApiService.updatePupilWithAvatarAuth(
  //     pupilId: pupilProxy.internalId,
  //     file: await encryptedFile
  //         .readAsBytes()
  //         .then((bytes) => ByteData.view(bytes.buffer)),
  //   );

  //   // update the pupil in the repository
  //   updatePupilProxyWithPupilData(pupilUpdate);
  //   //  pupilProxy.updatePupil(pupilUpdate);

  //   // Delete the outdated encrypted file.

  //   final cacheKey = pupilProxy.avatar!.documentId;

  //   _cacheManager.removeFile(cacheKey.toString());
  // }

//   Future<void> postPublicMediaAuthImage(
//     File imageFile,
//     PupilProxy pupilProxy,
//   ) async {
//     // first we encrypt the file

//     final encryptedFile = await customEncrypter.encryptFile(imageFile);

//     // Now we prepare the form data for the request.

//     String fileName = encryptedFile.path.split('/').last;
//     var formData = FormData.fromMap({
//       'file': await MultipartFile.fromFile(
//         encryptedFile.path,
//         filename: fileName,
//       ),
//     });

//     // send the Api request

//     final PupilData pupilUpdate =
//         await pupilDataApiService.updatePupilWithPublicMediaAuth(
//       id: pupilProxy.internalId,
//       formData: formData,
//     );

//     // update the pupil in the repository
//     updatePupilProxyWithPupilData(pupilUpdate);
//     //  pupilProxy.updatePupil(pupilUpdate);

//     // Delete the outdated encrypted file.

//     final cacheKey = pupilProxy.avatar!.documentId;

//     _cacheManager.removeFile(cacheKey.toString());
//   }

  Future<void> deleteAvatarImage(int pupilId, String cacheKey) async {
    // send the Api request
    final pupilUpdate = await _pupilDataApiService.deletePupilAvatar(
      internalId: pupilId,
    );

    // Delete the outdated encrypted file in the cache.

    await _cacheManager.removeFile(cacheKey);

    // and update the repository
    updatePupilProxyWithPupilData(pupilUpdate);
    // _pupils[pupilId]!.clearAvatar();
  }

  Future<void> updatePupilWithAvatarAuth(
    File imageFile,
    PupilProxy pupil,
  ) async {
    // first we encrypt the file

    final encryptedFile = await customEncrypter.encryptFile(imageFile);

    // send the Api request

    final PupilData pupilUpdate =
        await _pupilDataApiService.updatePupilWithAvatarAuth(
      pupilId: pupil.pupilId,
      file: encryptedFile,
    );

    // update the pupil in the repository
    updatePupilProxyWithPupilData(pupilUpdate);
  }
//   Future<void> deleteAvatarAuthImage(int pupilId, String cacheKey) async {
//     // send the Api request
//     await pupilDataApiService.deletePupilAvatarAuth(
//       internalId: pupilId,
//     );

//     // Delete the outdated encrypted file in the cache.

//     await _cacheManager.removeFile(cacheKey);
// final ScheduledLesson scheduledLesson = ScheduledLesson(recordtest: (testString: "l", testint: 2))
//     // and update the repository
//     _pupils[pupilId]!.deleteAvatarAuthId();
//   }

//   Future<void> deletePublicMediaAuthImage(int pupilId, String cacheKey) async {
//     // send the Api request
//     await pupilDataApiService.deletePupilPublicMediaAuthImage(
//       internalId: pupilId,
//     );

//     // Delete the outdated encrypted file in the cache.

//     await _cacheManager.removeFile(cacheKey);

//     // and update the repository
//     _pupils[pupilId]!.deletePublicMediaAuthId();
//   }

  Future<void> updateTutorInfo(
      {required int internalId, required TutorInfo tutorInfo}) async {
    // check if the pupil is a sibling and handle them if true
    final pupilSiblings = siblings(getPupilByInternalId(internalId)!);
    if (pupilSiblings.isNotEmpty) {
      // create list with ids of all pupils with the same family value
      final List<int> siblingIds =
          pupilSiblings.map((p) => p.internalId).toList();

      // call the endpoint to update the siblings

      final List<PupilData> siblingsUpdate = await _pupilDataApiService
          .updateSiblingsTutorInfo(
              tutorInfo: tutorInfo,
              siblingsInternalIds: [...siblingIds, internalId]);

      // now update the siblings with the new data

      for (PupilData sibling in siblingsUpdate) {
        _pupilsInternalIdMap[sibling.internalId]!.updatePupil(sibling);
      }

      _notificationService.showSnackBar(
          NotificationType.success, 'Geschwister erfolgreich aktualisiert!');

      return;
    }
    // send the Api request
    final pupilToUpdate = getPupilByInternalId(internalId)!;

    final PupilData pupilUpdate = await _pupilDataApiService.updateTutorInfo(
        pupilId: pupilToUpdate.pupilId, tutorInfo: tutorInfo);

    // update the pupil in the repository
    updatePupilProxyWithPupilData(pupilUpdate);
  }

  Future<void> updatePupilCommunicationSkills(
      {required int pupilId,
      required CommunicationSkills communicationSkills}) async {
    try {
      final PupilData pupilData =
          await _pupilDataApiService.updateCommunicationSkills(
        pupilId: pupilId,
        communicationSkills: communicationSkills,
      );
      updatePupilProxyWithPupilData(pupilData);
    } catch (e) {
      _log.severe('Error updating communication skills: $e');
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Aktualisieren der Daten!');
    }
  }

  Future<void> updateStringProperty(
      {required int pupilId,
      required String property,
      required String? value}) async {
    try {
      final PupilData pupilData =
          await _pupilDataApiService.updateStringProperty(
        pupilId: pupilId,
        property: property,
        value: value,
      );
      updatePupilProxyWithPupilData(pupilData);
    } catch (e) {
      _log.severe('Error updating string property: $e');
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Aktualisieren der Daten!');
    }
    // if the value is relevant to siblings, check for siblings first and handle them if true

    // if (jsonKey == 'communication_tutor1' ||
    //     jsonKey == 'communication_tutor2' ||
    //     jsonKey == 'parents_contact' ||
    //     jsonKey == 'emergency_care') {
    //   final PupilProxy pupil = getPupilByInternalId(pupilId)!;
    //   if (pupil.family != null) {
    //     // we have a sibling
    //     // create list with ids of all pupils with the same family value

    //     final List<int> pupilIdsWithSameFamily = _pupils.values
    //         .where((p) => p.family == pupil.family)
    //         .map((p) => p.internalId)
    //         .toList();

    //     // call the endpoint to update the siblings

    //     final List<PupilData> siblingsUpdate =
    //         await pupilDataApiService.updateSiblingsProperty(
    //             siblingsPupilIds: pupilIdsWithSameFamily,
    //             property: jsonKey,
    //             value: value);

    //     // now update the siblings with the new data

    //     for (PupilData sibling in siblingsUpdate) {
    //       _pupils[sibling.internalId]!.updatePupil(sibling);
    //     }

    //     _notificationService.showSnackBar(
    //         NotificationType.success, 'Geschwister erfolgreich gepatcht!');
    //   }
    // }

    // The pupil is no sibling. Make the api call for the single pupil

    // final PupilData pupilUpdate =
    //     await pupilDataApiService.updateNonParentInfoPupilProperty(
    //         id: pupilId, property: jsonKey, value: value);

    // // now update the pupil in the repository

    // _pupils[pupilId]!.updatePupil(pupilUpdate);
    notifyListeners();
  }

  Future<void> updateCommunicationSkills(
      {required int pupilId, required CommunicationSkills? skills}) async {
    try {
      final PupilData pupilData =
          await _pupilDataApiService.updateCommunicationSkills(
        pupilId: pupilId,
        communicationSkills: skills,
      );
      updatePupilProxyWithPupilData(pupilData);
    } catch (e) {
      _log.severe('Error updating communication skills: $e');
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Aktualisieren der Daten!');
    }
  }

  Future<void> patchPupilWithNewSupportLevel(
      {required int internalId,
      required int level,
      required DateTime createdAt,
      required String createdBy,
      required String comment}) async {
    final pupilIdId = getPupilByInternalId(internalId)!.pupilId;

    final PupilData updatedPupil =
        await _pupilDataApiService.updateSupportLevel(
      pupilIdId: pupilIdId,
      supportLevelValue: level,
      createdAt: createdAt,
      createdBy: createdBy,
      comment: comment,
    );

    _pupilsInternalIdMap[internalId]!.updatePupil(updatedPupil);
  }

  Future<void> deleteSupportLevelHistoryItem(
      {required int pupilId, required String supportLevelId}) async {
    final PupilData updatedPupil =
        await _pupilDataApiService.deleteSupportLevelHistoryItem(
      internalId: pupilId,
      supportLevelId: int.parse(supportLevelId),
    );

    _pupilsInternalIdMap[pupilId]!.updatePupil(updatedPupil);
  }

  PupilsFilter getPupilFilter() {
    //return PupilsFilterImplementation(this, sortMode: sortMode);
    return PupilsFilterImplementation(this);
  }

  // Future<void> borrowBook(
  //     {required int pupilId, required String bookId}) async {
  //   final pupilBookApiService = PupilBookApiService();
  //   final PupilData updatedPupil = await pupilBookApiService
  //       .postNewPupilWorkbook(pupilId: pupilId, bookId: bookId);

  //   _pupils[pupilId]!.updatePupil(updatedPupil);

  //   return;
  // }

  // Future<void> deletePupilBook({required String lendingId}) async {
  //   final pupilBookRepository = PupilBookApiService();
  //   final pupil = await pupilBookRepository.deletePupilBook(lendingId);

  //   _pupils[pupil.internalId]!.updatePupil(pupil);

  //   return;
  // }

  // Future<void> returnBook({required String lendingId}) async {
  //   final returnedAt = DateTime.now();
  //   final receivedBy = locator<SessionManager>().credentials.value.username;
  //   final pupil = await PupilBookApiService().patchPupilBook(
  //       returnedAt: returnedAt, receivedBy: receivedBy, lendingId: lendingId);

  //   _pupils[pupil.internalId]!.updatePupil(pupil);

  //   return;
  // }

  // Future<void> patchPupilBook(
  //     {required String lendingId,
  //     DateTime? lentAt,
  //     String? lentBy,
  //     String? comment,
  //     int? rating,
  //     DateTime? returnedAt,
  //     String? receivedBy}) async {
  //   final pupil = await PupilBookApiService().patchPupilBook(
  //       lendingId: lendingId,
  //       lentAt: lentAt,
  //       lentBy: lentBy,
  //       state: comment,
  //       rating: rating,
  //       returnedAt: returnedAt,
  //       receivedBy: receivedBy);

  //   _pupils[pupil.internalId]!.updatePupil(pupil);

  //   return;
  // }
}
