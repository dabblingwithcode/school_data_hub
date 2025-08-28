import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/data/pupil_data_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class PupilManagerOperations {
  // Private constructor
  PupilManagerOperations._internal();

  // The single instance
  static final PupilManagerOperations _instance =
      PupilManagerOperations._internal();

  // Factory constructor returns the same instance
  factory PupilManagerOperations() => _instance;

  final _cacheManager = di<DefaultCacheManager>();
  final _pupilDataApiService = PupilDataApiService();
  final _pupilManager = di<PupilManager>();
  final _hubSessionManager = di<HubSessionManager>();

  Future<void> updateStringProperty({
    required int pupilId,
    required String property,
    required String? value,
  }) async {
    final PupilData? pupilData = await _pupilDataApiService
        .updateStringProperty(
          pupilId: pupilId,
          property: property,
          value: value,
        );
    if (pupilData == null) {
      return;
    }
    _pupilManager.updatePupilProxyWithPupilData(pupilData);
  }

  Future<void> updatePupilDocument({
    required File imageFile,
    required PupilProxy pupilProxy,
    required PupilDocumentType documentType,
  }) async {
    // first we encrypt the file

    final encryptedFile = await customEncrypter.encryptFile(imageFile);

    // if the pupil already has an avatar, we need to get the old documentId
    // and delete the old avatar from the cache
    if (pupilProxy.avatar != null) {
      final cacheKey = pupilProxy.avatar!.documentId;
      _cacheManager.removeFile(cacheKey.toString());
    }

    // send the Api request

    final PupilData? pupilUpdate = await _pupilDataApiService
        .updatePupilDocument(
          pupilId: pupilProxy.pupilId,
          file: encryptedFile,
          documentType: documentType,
        );
    if (pupilUpdate == null) {
      return;
    }
    // update the pupil in the repository
    _pupilManager.updatePupilProxyWithPupilData(pupilUpdate);
    //  pupilProxy.updatePupil(pupilUpdate);
  }

  Future<void> deletePupilDocument(
    int pupilId,
    String cacheKey,
    PupilDocumentType documentType,
  ) async {
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
    _pupilManager.updatePupilProxyWithPupilData(pupilUpdate);
    // _pupils[pupilId]!.clearAvatar();
  }

  Future<void> updatePreSchoolMedicalStatus({
    required int pupilId,
    required PreSchoolMedicalStatus preSchoolMedicalStatus,
    required String createdBy,
  }) async {
    // send the Api request
    final PupilData? pupilUpdate = await _pupilDataApiService
        .updatePreSchoolMedicalStatus(
          pupilId: pupilId,
          preSchoolMedical: preSchoolMedicalStatus,
          createdBy: createdBy,
        );
    if (pupilUpdate == null) {
      return;
    }
    // update the pupil in the repository
    _pupilManager.updatePupilProxyWithPupilData(pupilUpdate);
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
      groupPicturesOnWebsite:
          groupPicturesOnWebsite ??
          pupil.publicMediaAuth.groupPicturesOnWebsite,
      groupPicturesInPress:
          groupPicturesInPress ?? pupil.publicMediaAuth.groupPicturesInPress,
      portraitPicturesOnWebsite:
          portraitPicturesOnWebsite ??
          pupil.publicMediaAuth.portraitPicturesOnWebsite,
      portraitPicturesInPress:
          portraitPicturesInPress ??
          pupil.publicMediaAuth.portraitPicturesInPress,
      nameOnWebsite: nameOnWebsite ?? pupil.publicMediaAuth.nameOnWebsite,
      nameInPress: nameInPress ?? pupil.publicMediaAuth.nameInPress,
      videoOnWebsite: videoOnWebsite ?? pupil.publicMediaAuth.videoOnWebsite,
      videoInPress: videoInPress ?? pupil.publicMediaAuth.videoInPress,
    );

    final updatedPupil = await _pupilDataApiService.updatePublicMediaAuth(
      pupil.pupilId,
      authToUpdate,
    );
    if (updatedPupil == null) {
      return;
    }
    _pupilManager.updatePupilProxyWithPupilData(updatedPupil);
  }

  Future<void> resetPublicMediaAuth(int pupilId) async {
    // we need the cacheKey if the api request is successful
    // to delete the old image from the cache
    final pupil = _pupilManager.getPupilByPupilId(pupilId)!;
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
    _pupilManager.updatePupilProxyWithPupilData(pupilUpdate);
  }

  Future<void> updateTutorInfo({
    required int pupilId,
    required TutorInfo? tutorInfo,
  }) async {
    // check if the pupil is a sibling and handle them if true
    final pupilSiblings = _pupilManager.getSiblings(
      _pupilManager.getPupilByPupilId(pupilId)!,
    );
    if (pupilSiblings.isNotEmpty) {
      // create list with ids of all pupils with the same family value
      final List<int> siblingIds = pupilSiblings.map((p) => p.pupilId).toList();

      // call the endpoint to update the siblings

      final List<PupilData>? siblingsUpdate = await _pupilDataApiService
          .updateSiblingsTutorInfo(
            tutorInfo: tutorInfo,
            siblingsIds: [...siblingIds, pupilId],
          );

      if (siblingsUpdate == null) {
        return;
      }
      // now update the siblings with the new data

      for (PupilData sibling in siblingsUpdate) {
        _pupilManager.updatePupilProxyWithPupilData(sibling);
      }

      return;
    }
    // send the Api request
    final pupilToUpdate = _pupilManager.getPupilByPupilId(pupilId)!;

    final PupilData? pupilUpdate = await _pupilDataApiService.updateTutorInfo(
      pupilId: pupilToUpdate.pupilId,
      tutorInfo: tutorInfo,
    );

    if (pupilUpdate == null) {
      return;
    }
    // update the pupil in the repository
    _pupilManager.updatePupilProxyWithPupilData(pupilUpdate);
  }

  Future<void> updatePupilCommunicationSkills({
    required int pupilId,
    required CommunicationSkills? communicationSkills,
  }) async {
    final PupilData? pupilData = await _pupilDataApiService
        .updateCommunicationSkills(
          pupilId: pupilId,
          communicationSkills: communicationSkills,
        );
    if (pupilData == null) {
      return;
    }
    _pupilManager.updatePupilProxyWithPupilData(pupilData);
  }

  Future<void> updateParentsContact(
    PupilProxy pupil,
    ({String? value}) parentsContact,
  ) async {
    if (pupil.tutorInfo == null) {
      // if there is no tutor info, we create a new one
      final newTutorInfo = TutorInfo(
        communicationTutor1: null,
        communicationTutor2: null,
        parentsContact: parentsContact.value,
        createdBy: _hubSessionManager.userName!,
      );
      await updateTutorInfo(pupilId: pupil.pupilId, tutorInfo: newTutorInfo);
    } else {
      final updatedTutorInfo = pupil.tutorInfo!.copyWith(
        parentsContact: parentsContact.value,
      );
      await updateTutorInfo(
        pupilId: pupil.pupilId,
        tutorInfo: updatedTutorInfo,
      );
    }
  }

  Future<void> updateCredit({required int pupilId, required int credit}) async {
    final PupilData? pupilUpdate = await _pupilDataApiService.updateCredit(
      pupilId: pupilId,
      credit: credit,
    );
    if (pupilUpdate == null) {
      return;
    }

    _pupilManager.updatePupilProxyWithPupilData(pupilUpdate);
  }

  Future<void> updateCommunicationSkills({
    required int pupilId,
    required CommunicationSkills? skills,
  }) async {
    final PupilData? pupilData = await _pupilDataApiService
        .updateCommunicationSkills(
          pupilId: pupilId,
          communicationSkills: skills,
        );
    if (pupilData == null) {
      return;
    }
    _pupilManager.updatePupilProxyWithPupilData(pupilData);
  }

  Future<void> updatePupilSupportLevel({
    required int pupilId,
    required int level,
    required DateTime createdAt,
    required String createdBy,
    required String comment,
  }) async {
    final PupilData? updatedPupil = await _pupilDataApiService
        .updateSupportLevel(
          pupilId: pupilId,
          supportLevelValue: level,
          createdAt: createdAt,
          createdBy: createdBy,
          comment: comment,
        );
    if (updatedPupil == null) {
      return;
    }
    _pupilManager.updatePupilProxyWithPupilData(updatedPupil);
  }

  Future<void> deleteSupportLevelHistoryItem({
    required int pupilId,
    required int supportLevelId,
  }) async {
    final PupilData? updatedPupil = await _pupilDataApiService
        .deleteSupportLevelHistoryItem(
          pupilId: pupilId,
          supportLevelId: supportLevelId,
        );
    if (updatedPupil == null) {
      return;
    }

    _pupilManager.updatePupilProxyWithPupilData(updatedPupil);
  }
}
