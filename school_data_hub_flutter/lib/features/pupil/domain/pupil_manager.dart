import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/data/pupil_book_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/data/pupil_data_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter_impl.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:watch_it/watch_it.dart';

class PupilManager extends ChangeNotifier {
  final _log = Logger('PupilManager');

  final _notificationService = di<NotificationService>();

  final _cacheManager = di<DefaultCacheManager>();

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
      _log.severe('Pupil $pupilId not found', StackTrace.current);
      return null;
    }
    return _pupilIdPupilsMap[pupilId];
  }

  List<PupilProxy> getPupilsFromPupilIds(List<int> pupilIds) {
    List<PupilProxy> pupilsfromPupilIds = [];

    for (int pupilId in pupilIds) {
      final PupilProxy? pupil = _pupilIdPupilsMap.values
          .firstWhereOrNull((pupil) => pupil.pupilId == pupilId);
      if (pupil != null) {
        pupilsfromPupilIds.add(pupil);
      }
    }

    return pupilsfromPupilIds;
  }

  List<PupilProxy> getPupilsFromInternalIds(List<int> internalIds) {
    List<PupilProxy> pupilsfromInternalIds = [];

    for (int internalId in internalIds) {
      final PupilProxy? pupil = _pupilIdPupilsMap.values
          .firstWhereOrNull((pupil) => pupil.internalId == internalId);
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
    Map<int, PupilProxy> allPupilsMap =
        Map<int, PupilProxy>.of(_pupilIdPupilsMap);
    allPupilsMap.removeWhere((key, value) => pupilIds.contains(key));
    return allPupilsMap.values.toList();
  }

  List<PupilProxy> getSiblings(PupilProxy pupil) {
    if (pupil.family == null) {
      return [];
    }

    Map<int, PupilProxy> allPupilsMap =
        Map<int, PupilProxy>.of(_pupilIdPupilsMap);

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
      _log.info('No pupil identities to fetch data from the backend');
      return;
    }
    await fetchPupilsByInternalId(pupilsToFetch);
  }

  Future<void> updatePupilList(List<PupilProxy> pupils) async {
    await fetchPupilsByInternalId(pupils.map((e) => e.pupilId).toList());
  }

  Future<void> updatePupilData(int pupilId) async {
    final fetchedPupil = await _pupilDataApiService
        .fetchListOfPupils(pupilInternalIds: [pupilId]);
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
        NotificationType.info, 'Lade Schülerdaten vom Server. Bitte warten...');

    // fetch the pupils from the backend
    final fetchedPupils = await _pupilDataApiService.fetchListOfPupils(
        pupilInternalIds: pupilInternalIds);
    if (fetchedPupils == null) {
      return;
    }
    // check if we did not get a pupil response for some ids
    // if so, we will delete the personal data for those ids later
    final List<int> outdatedPupilIdentitiesIds = pupilInternalIds
        .where((element) =>
            !fetchedPupils.any((pupil) => pupil.internalId == element))
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

        _pupilIdPupilsMap[fetchedPupil.id!] =
            PupilProxy(pupilData: fetchedPupil, pupilIdentity: pupilIdentity!);
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
          'Diese Schüler_innen existieren nicht mehr in der Datenbank, Ihre Ids wurden aus dem Gerät gelöscht:\n\n$deletedPupilIdentities');
    }
    _notificationService.showSnackBar(
        NotificationType.success, 'Schülerdaten geladen!');

    notifyListeners();
  }

  void updatePupilProxyWithPupilData(PupilData pupilData) {
    final proxy = _pupilIdPupilsMap[pupilData.id!];
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

  Future<void> updatePupilDocument(
    File imageFile,
    PupilProxy pupilProxy,
    PupilDocumentType documentType,
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

    final PupilData? pupilUpdate =
        await _pupilDataApiService.updatePupilDocument(
            pupilId: pupilProxy.pupilId,
            file: encryptedFile,
            documentType: documentType);
    if (pupilUpdate == null) {
      return;
    }
    // update the pupil in the repository
    updatePupilProxyWithPupilData(pupilUpdate);
    //  pupilProxy.updatePupil(pupilUpdate);
  }

  Future<void> deletePupilDocument(
      int pupilId, String cacheKey, PupilDocumentType documentType) async {
    // send the Api request
    final pupilUpdate = await _pupilDataApiService.deletePupilDocument(
      pupilId: pupilId,
      documentType: documentType,
    );
    if (pupilUpdate == null) {
      return;
    }
    // Delete the outdated encrypted file in the cache.

    await _cacheManager.removeFile(cacheKey);

    // and update the repository
    updatePupilProxyWithPupilData(pupilUpdate);
    // _pupils[pupilId]!.clearAvatar();
  }

  Future<void> updatePreSchoolMedicalStatus(
      {required int pupilId,
      required PreSchoolMedicalStatus preSchoolMedicalStatus,
      required String createdBy}) async {
    // send the Api request
    final PupilData? pupilUpdate =
        await _pupilDataApiService.updatePreSchoolMedicalStatus(
            pupilId: pupilId,
            preSchoolMedical: preSchoolMedicalStatus,
            createdBy: createdBy);
    if (pupilUpdate == null) {
      return;
    }
    // update the pupil in the repository
    updatePupilProxyWithPupilData(pupilUpdate);
  }

  Future<void> updatePublicMediaAuth({
    required PupilProxy pupil,
    bool? groupPicturesOnWebsite,
    bool? groupPicturesInPress,
    bool? portraitPicturesOnWebsite,
    bool? portraitPicturesInPress,
    bool? nameOnWebsite,
    bool? nameInPress,
    bool? videoOnWebsite,
    bool? videoInPress,
  }) async {
    final PublicMediaAuth authToUpdate = pupil.publicMediaAuth.copyWith(
      groupPicturesOnWebsite: groupPicturesOnWebsite ??
          pupil.publicMediaAuth.groupPicturesOnWebsite,
      groupPicturesInPress:
          groupPicturesInPress ?? pupil.publicMediaAuth.groupPicturesInPress,
      portraitPicturesOnWebsite: portraitPicturesOnWebsite ??
          pupil.publicMediaAuth.portraitPicturesOnWebsite,
      portraitPicturesInPress: portraitPicturesInPress ??
          pupil.publicMediaAuth.portraitPicturesInPress,
      nameOnWebsite: nameOnWebsite ?? pupil.publicMediaAuth.nameOnWebsite,
      nameInPress: nameInPress ?? pupil.publicMediaAuth.nameInPress,
      videoOnWebsite: videoOnWebsite ?? pupil.publicMediaAuth.videoOnWebsite,
      videoInPress: videoInPress ?? pupil.publicMediaAuth.videoInPress,
    );

    final updatedPupil = await _pupilDataApiService.updatePublicMediaAuth(
        pupil.pupilId, authToUpdate);
    if (updatedPupil == null) {
      return;
    }
    updatePupilProxyWithPupilData(updatedPupil);
  }

  Future<void> resetPublicMediaAuth(int pupilId) async {
    // we need the cacheKey if the api request is successful
    // to delete the old image from the cache
    final pupil = allPupils.firstWhere(
      (pupil) => pupil.pupilId == pupilId,
      orElse: () => throw Exception('Pupil not found'),
    );
    final cacheKey = pupil.publicMediaAuthDocument?.documentId;

    // send the Api request
    final pupilUpdate = await _pupilDataApiService.resetPublicMediaAuth(
      pupilId: pupilId,
    );
    if (pupilUpdate == null) {
      return;
    }
    if (cacheKey != null) {
      // Delete the outdated encrypted file in the cache.
      await _cacheManager.removeFile(cacheKey.toString());
    }
    // and update the repository
    updatePupilProxyWithPupilData(pupilUpdate);
  }

  Future<void> updateTutorInfo(
      {required int pupilId, required TutorInfo? tutorInfo}) async {
    // check if the pupil is a sibling and handle them if true
    final pupilSiblings = getSiblings(getPupilByPupilId(pupilId)!);
    if (pupilSiblings.isNotEmpty) {
      // create list with ids of all pupils with the same family value
      final List<int> siblingIds = pupilSiblings.map((p) => p.pupilId).toList();

      // call the endpoint to update the siblings

      final List<PupilData>? siblingsUpdate = await _pupilDataApiService
          .updateSiblingsTutorInfo(
              tutorInfo: tutorInfo, siblingsIds: [...siblingIds, pupilId]);

      if (siblingsUpdate == null) {
        return;
      }
      // now update the siblings with the new data

      for (PupilData sibling in siblingsUpdate) {
        updatePupilProxyWithPupilData(sibling);
      }

      _notificationService.showSnackBar(
          NotificationType.success, 'Geschwister erfolgreich aktualisiert!');

      return;
    }
    // send the Api request
    final pupilToUpdate = getPupilByPupilId(pupilId)!;

    final PupilData? pupilUpdate = await _pupilDataApiService.updateTutorInfo(
        pupilId: pupilToUpdate.pupilId, tutorInfo: tutorInfo);

    if (pupilUpdate == null) {
      return;
    }
    // update the pupil in the repository
    updatePupilProxyWithPupilData(pupilUpdate);
  }

  Future<void> updatePupilCommunicationSkills(
      {required int pupilId,
      required CommunicationSkills? communicationSkills}) async {
    final PupilData? pupilData =
        await _pupilDataApiService.updateCommunicationSkills(
      pupilId: pupilId,
      communicationSkills: communicationSkills,
    );
    if (pupilData == null) {
      return;
    }
    updatePupilProxyWithPupilData(pupilData);
  }

  Future<void> updateCredit({required int pupilId, required int credit}) async {
    final PupilData? pupilUpdate = await _pupilDataApiService.updateCredit(
      pupilId: pupilId,
      credit: credit,
    );
    if (pupilUpdate == null) {
      return;
    }

    updatePupilProxyWithPupilData(pupilUpdate);
  }

  Future<void> updateStringProperty(
      {required int pupilId,
      required String property,
      required String? value}) async {
    final PupilData? pupilData =
        await _pupilDataApiService.updateStringProperty(
      pupilId: pupilId,
      property: property,
      value: value,
    );
    if (pupilData == null) {
      return;
    }
    updatePupilProxyWithPupilData(pupilData);
  }

  Future<void> updateCommunicationSkills(
      {required int pupilId, required CommunicationSkills? skills}) async {
    final PupilData? pupilData =
        await _pupilDataApiService.updateCommunicationSkills(
      pupilId: pupilId,
      communicationSkills: skills,
    );
    if (pupilData == null) {
      return;
    }
    updatePupilProxyWithPupilData(pupilData);
  }

  Future<void> updatePupilSupportLevel(
      {required int pupilId,
      required int level,
      required DateTime createdAt,
      required String createdBy,
      required String comment}) async {
    final PupilData? updatedPupil =
        await _pupilDataApiService.updateSupportLevel(
      pupilId: pupilId,
      supportLevelValue: level,
      createdAt: createdAt,
      createdBy: createdBy,
      comment: comment,
    );
    if (updatedPupil == null) {
      return;
    }
    _pupilIdPupilsMap[pupilId]!.updatePupil(updatedPupil);
  }

  Future<void> deleteSupportLevelHistoryItem(
      {required int pupilId, required int supportLevelId}) async {
    final PupilData? updatedPupil =
        await _pupilDataApiService.deleteSupportLevelHistoryItem(
      pupilId: pupilId,
      supportLevelId: supportLevelId,
    );
    if (updatedPupil == null) {
      return;
    }
    _pupilIdPupilsMap[pupilId]!.updatePupil(updatedPupil);
  }

  Future<void> updateSchoolyearHeldBackDate(
      {required int pupilId, required ({DateTime? value}) date}) async {
    final PupilData? updatedPupil =
        await _pupilDataApiService.updateSchoolyearHeldBackDate(
      pupilId: pupilId,
      date: date,
    );
    if (updatedPupil == null) {
      return;
    }
    updatePupilProxyWithPupilData(updatedPupil);
  }

  Future<void> postPupilBookLending(
      {required int pupilId, required String libraryId}) async {
    final userName = _hubSessionManager.userName;

    final PupilData? updatedPupil =
        await _pupilBookApiService.postPupilBookLending(
            pupilId: pupilId, libraryId: libraryId, lentBy: userName!);
    if (updatedPupil == null) {
      return;
    }
    _pupilIdPupilsMap[pupilId]!.updatePupil(updatedPupil);

    return;
  }

  Future<void> deletePupilBook({required int lendingId}) async {
    final pupil = await _pupilBookApiService.deletePupilBook(lendingId);
    if (pupil == null) {
      return;
    }
    _pupilIdPupilsMap[pupil.id!]!.updatePupil(pupil);

    return;
  }

  Future<void> returnLibraryBook(
      {required PupilBookLending pupilBookLending}) async {
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

  Future<void> updatePupilBook(
      {required PupilBookLending pupilBookLending,
      DateTime? lentAt,
      String? lentBy,
      ({String? value})? status,
      ({int? value})? score,
      ({DateTime? value})? returnedAt,
      ({String? value})? receivedBy}) async {
    final updatedBookLending = pupilBookLending.copyWith(
      lentAt: lentAt ?? pupilBookLending.lentAt,
      lentBy: lentBy ?? pupilBookLending.lentBy,
      status: status != null ? status.value : pupilBookLending.status,
      score: score != null ? score.value : pupilBookLending.score,
      returnedAt:
          returnedAt != null ? returnedAt.value : pupilBookLending.returnedAt,
      receivedBy:
          receivedBy != null ? receivedBy.value : pupilBookLending.receivedBy,
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
}
