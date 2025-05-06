import 'dart:io';

import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();
final _serverpodSessionManager = di<ServerpodSessionManager>();
final _client = di<Client>();
final _log = Logger('PupilDataApiService');

class PupilDataApiService {
  // Private constructor
  PupilDataApiService._internal();

  // Singleton instance
  static final PupilDataApiService _instance = PupilDataApiService._internal();

  // Factory constructor to return the singleton instance
  factory PupilDataApiService() {
    return _instance;
  }

  // - update backend pupil database

  Future<List<PupilData>> updateBackendPupilsDatabase(
      {required File file}) async {
    final pupils = await ClientHelper.apiCall(
      call: () => _client.admin.updateBackendPupilDataState(file),
      errorMessage: 'Die Schüler konnten nicht aktualisiert werden',
    );
    return pupils.toList();
  }

  //- fetch list of pupils

  Future<List<PupilData>> fetchListOfPupils({
    required List<int> pupilInternalIds,
  }) async {
    final pupilIdsSet = pupilInternalIds.toSet();
    final pupils = await ClientHelper.apiCall(
      call: () => _client.pupil.fetchPupilsById(pupilIdsSet),
      errorMessage: 'Die Schüler konnten nicht geladen werden',
    );
    return pupils;
  }

  //- update communication skills

  Future<PupilData> updateCommunicationSkills({
    required int pupilId,
    required CommunicationSkills? communicationSkills,
  }) async {
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _client.pupilUpdate.updateCommunicationSkills(
        pupilId: pupilId,
        communicationSkills: communicationSkills,
      ),
      errorMessage: 'Die Schüler konnten nicht aktualisiert werden',
    );
    return updatedPupil;
  }

  // - update credit

  Future<PupilData> updateCredit({
    required int pupilId,
    required int credit,
    String? comment,
  }) async {
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _client.pupilUpdate.updateCredit(
          pupilId, credit, comment, _serverpodSessionManager.userName!),
      errorMessage: 'Die Schüler konnten nicht aktualisiert werden',
    );
    return updatedPupil;
  }

  //- update pupil one of the pupil properties being a string

  Future<PupilData> updateStringProperty(
      {required int pupilId,
      required String property,
      required String? value}) async {
    final updatedPupil = await ClientHelper.apiCall(
      call: () =>
          _client.pupilUpdate.updateStringProperty(pupilId, property, value),
      errorMessage: 'Die Schüler konnten nicht aktualisiert werden',
    );
    return updatedPupil;
  }

  // - tutor info

  Future<PupilData> updateTutorInfo({
    required int pupilId,
    required TutorInfo? tutorInfo,
  }) async {
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _client.pupilUpdate.updateTutorInfo(pupilId, tutorInfo),
      errorMessage: 'Die Schüler konnten nicht aktualisiert werden',
    );
    return updatedPupil;
  }

  Future<List<PupilData>> updateSiblingsTutorInfo({
    required List<int> siblingsIds,
    required TutorInfo? tutorInfo,
  }) async {
    final siblingsTutorInfo = SiblingsTutorInfo(
      siblingsIds: siblingsIds.toSet(),
      tutorInfo: tutorInfo,
    );
    final updatedSiblings = await ClientHelper.apiCall(
      call: () =>
          _client.pupilUpdate.updateSiblingsTutorInfo(siblingsTutorInfo),
      errorMessage: 'Die Geschwister konnten nicht aktualisiert werden',
    );
    return updatedSiblings;
  }

  //- hub document

  Future<PupilData> updatePupilDocument({
    required int pupilId,
    required File file,
    required PupilDocumentType documentType,
  }) async {
    final result = await ClientFileUpload.uploadFile(
        file,
        documentType == PupilDocumentType.avatar
            ? ServerStorageFolder.avatars
            : ServerStorageFolder.documents);
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _client.pupilUpdate.updatePupilDocument(pupilId, result.path!,
          _serverpodSessionManager.userName!, documentType),
      errorMessage: 'Das Profilbild konnte nicht aktualisiert werden',
    );
    return updatedPupil;
  }

//- delete pupil document

  Future<PupilData> deletePupilDocument(
      {required int pupilId, required PupilDocumentType documentType}) async {
    _notificationService.apiRunning(true);
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _client.pupil.deletePupilDocument(pupilId, documentType),
      errorMessage: 'Das Dokument konnte nicht gelöscht werden',
    );
    return updatedPupil;
  }

//- public media auth

  Future<PupilData> resetPublicMediaAuth({required int pupilId}) async {
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _client.pupil
          .resetPublicMediaAuth(pupilId, _serverpodSessionManager.userName!),
      errorMessage:
          'Die Einwilligung für öffentliche Medien konnte nicht gelöscht werden',
    );
    return updatedPupil;
  }

  Future<PupilData> updatePublicMediaAuth(
      int pupilId, PublicMediaAuth publicMediaAuth) async {
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _client.pupilUpdate.updatePublicMediaAuth(
        pupilId,
        publicMediaAuth,
      ),
      errorMessage:
          'Die Einwilligung für öffentliche Medien konnte nicht aktualisiert werden',
    );
    return updatedPupil;
  }

  //- support level

  Future<PupilData> updateSupportLevel({
    required int pupilIdId,
    required int supportLevelValue,
    required DateTime createdAt,
    required String createdBy,
    required String comment,
  }) async {
    final supportLevel = SupportLevel(
        level: supportLevelValue,
        comment: comment,
        createdAt: createdAt,
        createdBy: createdBy,
        pupilIdId: pupilIdId);
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _client.pupilUpdate.updateSupportLevel(supportLevel),
      errorMessage: 'Die Förderebene konnte nicht aktualisiert werden',
    );
    return updatedPupil;
  }

  Future<PupilData> deleteSupportLevelHistoryItem({
    required int internalId,
    required int supportLevelId,
  }) async {
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _client.pupil
          .deleteSupportLevelHistoryItem(internalId, supportLevelId),
      errorMessage: 'Die Förderebene konnte nicht gelöscht werden',
    );
    return updatedPupil;
  }
}
