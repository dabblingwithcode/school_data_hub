import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/services/api/api_settings.dart';
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

  Future<List<PupilData>> updateBackendPupilsDatabase(
      {required File file}) async {
    _notificationService.apiRunning(true);

    try {
      final pupils = await _client.admin.updateBackendPupilDataState(file);

      _notificationService.apiRunning(false);

      return pupils.toList();
    } catch (e) {
      _notificationService.apiRunning(false);

      _log.severe('Error while updating backend pupils database', e,
          StackTrace.current);

      _notificationService.showSnackBar(NotificationType.error,
          'Die Schüler konnten nicht aktualisiert werden: ${e.toString()}');

      throw ApiException('Failed to update backend pupils database', 500);
    }
  }

  //- fetch list of pupils

  Future<List<PupilData>> fetchListOfPupils({
    required List<int> internalPupilIds,
  }) async {
    final pupilIdsSet = internalPupilIds.toSet();

    try {
      _notificationService.apiRunning(true);

      final pupils = await _client.pupil.fetchPupilsById(pupilIdsSet);

      _notificationService.apiRunning(false);

      return pupils;
    } catch (e) {
      _notificationService.apiRunning(false);

      _log.severe('Error while fetching pupils', e, StackTrace.current);

      _notificationService.showSnackBar(NotificationType.error,
          'Die Schüler konnten nicht geladen werden: ${e.toString()}');

      throw ApiException('Failed to fetch pupils', 500);
    }
  }

  //- update communication skills
  Future<PupilData> updateCommunicationSkills({
    required int pupilId,
    required CommunicationSkills? communicationSkills,
  }) async {
    try {
      _notificationService.apiRunning(true);
      final updatedPupil = await _client.pupilUpdate.updateCommunicationSkills(
        pupilId: pupilId,
        communicationSkills: communicationSkills,
      );
      _notificationService.apiRunning(false);
      return updatedPupil;
    } catch (e) {
      _notificationService.apiRunning(false);

      _log.severe('Error while updating pupil', e, StackTrace.current);

      _notificationService.showSnackBar(NotificationType.error,
          'Die Schüler konnten nicht aktualisiert werden: ${e.toString()}');

      throw Exception('Failed to update pupil, $e');
    }
  }

  // - update credit
  Future<PupilData> updateCredit({
    required int pupilId,
    required int credit,
    String? comment,
  }) async {
    try {
      _notificationService.apiRunning(true);
      final updatedPupil =
          await _client.pupilUpdate.updateCredit(pupilId, credit, comment);
      _notificationService.apiRunning(false);
      return updatedPupil;
    } catch (e) {
      _notificationService.apiRunning(false);

      _log.severe('Error while updating pupil', e, StackTrace.current);

      _notificationService.showSnackBar(NotificationType.error,
          'Die Schüler konnten nicht aktualisiert werden: ${e.toString()}');

      throw Exception('Failed to update pupil, $e');
    }
  }
  // //- update pupil one of the pupil properties being a string

  Future<PupilData> updateStringProperty(
      {required int pupilId,
      required String property,
      required String? value}) async {
    try {
      _notificationService.apiRunning(true);
      final updatedPupil = await _client.pupilUpdate
          .updateStringProperty(pupilId, property, value);
      _notificationService.apiRunning(false);
      return updatedPupil;
    } catch (e) {
      _notificationService.apiRunning(false);

      _log.severe('Error while updating pupil property', e, StackTrace.current);

      _notificationService.showSnackBar(NotificationType.error,
          'Die Schüler konnten nicht aktualisiert werden: ${e.toString()}');

      throw Exception('Failed to update pupil property, $e');
    }
  }

  // - update tutor info

  Future<PupilData> updateTutorInfo({
    required int pupilId,
    required TutorInfo tutorInfo,
  }) async {
    try {
      _notificationService.apiRunning(true);
      final updatedPupil =
          await _client.pupilUpdate.updateTutorInfo(pupilId, tutorInfo);
      _notificationService.apiRunning(false);

      return updatedPupil;
    } catch (e) {
      _notificationService.apiRunning(false);

      _log.severe('Error while updating pupil', e, StackTrace.current);

      _notificationService.showSnackBar(NotificationType.error,
          'Die Schüler konnten nicht aktualisiert werden: ${e.toString()}');

      throw Exception('Failed to update pupil, $e');
    }
  }
  //- update siblings tutor info

  Future<List<PupilData>> updateSiblingsTutorInfo({
    required List<int> siblingsInternalIds,
    required TutorInfo tutorInfo,
  }) async {
    final siblingsTutorInfo = SiblingsTutorInfo(
      siblingsInternalIds: siblingsInternalIds.toSet(),
      tutorInfo: tutorInfo,
    );

    try {
      _notificationService.apiRunning(true);
      final updatedSiblings =
          await _client.pupilUpdate.updateSiblingsTutorInfo(siblingsTutorInfo);
      _notificationService.apiRunning(false);

      return updatedSiblings;
    } catch (e) {
      _notificationService.apiRunning(false);

      _log.severe('Error while updating siblings', e, StackTrace.current);

      _notificationService.showSnackBar(NotificationType.error,
          'Die Geschwister konnten nicht aktualisiert werden: ${e.toString()}');

      throw Exception('Failed to update siblings: $e');
    }
  }

  //- update pupil avatar

  Future<PupilData> updatePupilWithAvatar({
    required int pupilId,
    required File file,
  }) async {
    final documentId = Uuid().v4();
    final path = p.join('avatar', '$documentId.jpg');
    final uploadDescription =
        await _client.files.getUploadDescription('private', path);
    if (uploadDescription != null) {
      // Create an uploader
      final uploader = FileUploader(uploadDescription);

      // Upload the file
      final fileStream = file.openRead();

      final fileLength = await file.length();
      _notificationService.apiRunning(true);
      await uploader.upload(fileStream, fileLength);
      _notificationService.apiRunning(false);

      // Verify the upload
      final success = await _client.files.verifyUpload('private', path);

      if (success) {
        try {
          final updatedPupil =
              await _client.pupilUpdate.updatePupilAvatar(pupilId, path);
          _notificationService.apiRunning(false);

          return updatedPupil;
        } catch (e) {
          _notificationService.apiRunning(false);

          _log.severe(
              'Error while updating pupil avatar', e, StackTrace.current);

          _notificationService.showSnackBar(NotificationType.error,
              'Das Profilbild konnte nicht aktualisiert werden: ${e.toString()}');

          throw Exception('Failed to update pupil avatar, $e');
        }
      }
    } else {
      _notificationService.apiRunning(false);

      _log.severe('Error while uploading file', null, StackTrace.current);

      _notificationService.showSnackBar(NotificationType.error,
          'Das Profilbild konnte nicht hochgeladen werden: ${uploadDescription.toString()}');

      throw Exception('Failed to upload file, $uploadDescription');
    }
    throw Exception('Failed to upload file, $uploadDescription');
  }

//- update pupil avatar auth image

  Future<PupilData> updatePupilWithAvatarAuth({
    required int pupilId,
    required File file,
  }) async {
    final path =
        p.join('documents', '${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadDescription =
        await _client.files.getUploadDescription('private', path);
    if (uploadDescription != null) {
      // Create an uploader
      final uploader = FileUploader(uploadDescription);

      // Upload the file
      final fileStream = file.openRead();

      final fileLength = await file.length();
      _notificationService.apiRunning(true);
      await uploader.upload(fileStream, fileLength);
      _notificationService.apiRunning(false);

      // Verify the upload
      final success = await _client.files.verifyUpload('private', path);

      if (success) {
        try {
          _notificationService.apiRunning(true);

          final updatedPupil = await _client.pupilUpdate.updatePupilAvatarAuth(
              pupilId, path, _serverpodSessionManager.userName!);
          _notificationService.apiRunning(false);

          return updatedPupil;
        } catch (e) {
          _notificationService.apiRunning(false);

          _log.severe(
              'Error while updating pupil avatar', e, StackTrace.current);

          _notificationService.showSnackBar(NotificationType.error,
              'Das Profilbild konnte nicht aktualisiert werden: ${e.toString()}');

          throw Exception('Failed to update pupil avatar, $e');
        }
      }
    } else {
      _notificationService.apiRunning(false);

      _log.severe('Error while uploading file', null, StackTrace.current);

      _notificationService.showSnackBar(NotificationType.error,
          'Das Profilbild konnte nicht hochgeladen werden: ${uploadDescription.toString()}');

      throw Exception('Failed to upload file, $uploadDescription');
    }
    throw Exception('Failed to upload file, $uploadDescription');
  }

//- update pupil public media auth image

  // Future<PupilData> updatePupilWithPublicMediaAuth({
  //   required int id,
  //   required ByteData formData,
  // }) async {
  //   try {
  //     _notificationService.apiRunning(true);
  //     final updatedPupil =
  //         _client.pupil.updatePupilWithPublicMediaAuth(id, formData);
  //     _notificationService.apiRunning(false);
  //     return updatedPupil;
  //   } catch (e) {
  //     _notificationService.apiRunning(false);
  //     _log.severe('Error while updating pupil public media auth', e,
  //         StackTrace.current);
  //     _notificationService.showSnackBar(NotificationType.error,
  //         'Die Einwilligung für öffentliche Medien konnte nicht aktualisiert werden: ${e.toString()}');
  //     throw Exception('Failed to update pupil public media auth, $e');
  //   }
  // }

//- delete pupil avatar

  Future<PupilData> deletePupilAvatar({required int internalId}) async {
    _notificationService.apiRunning(true);
    try {
      _notificationService.apiRunning(true);
      final updatedPupil = await _client.pupil.deleteAvatar(internalId);
      _notificationService.apiRunning(false);
      return updatedPupil;
    } catch (e) {
      _notificationService.apiRunning(false);
      _log.severe('Error while deleting pupil avatar', e, StackTrace.current);
      _notificationService.showSnackBar(NotificationType.error,
          'Das Profilbild konnte nicht gelöscht werden: ${e.toString()}');
      throw Exception('Failed to delete pupil avatar, $e');
    }
  }

  Future<PupilData> deletePupilAvatarAuth({required int internalId}) async {
    try {
      _notificationService.apiRunning(true);
      final updatedPupil = await _client.pupil.deleteAvatarAuth(internalId);
      _notificationService.apiRunning(false);
      return updatedPupil;
    } catch (e) {
      _notificationService.apiRunning(false);
      _log.severe(
          'Error while deleting pupil avatar auth', e, StackTrace.current);
      _notificationService.showSnackBar(NotificationType.error,
          'Die avatar Einwilligung konnte nicht gelöscht werden: ${e.toString()}');
      throw Exception('Failed to delete pupil avatar auth, $e');
    }
  }

//- delete pupil public media auth

  Future<PupilData> resetPublicMediaAuth({required int internalId}) async {
    try {
      _notificationService.apiRunning(true);
      final updatedPupil = _client.pupil.resetPublicMediaAuth(internalId);
      _notificationService.apiRunning(false);
      return updatedPupil;
    } catch (e) {
      _notificationService.apiRunning(false);
      _log.severe('Error while deleting pupil public media auth', e,
          StackTrace.current);
      _notificationService.showSnackBar(NotificationType.error,
          'Die Einwilligung für öffentliche Medien konnte nicht gelöscht werden: ${e.toString()}');
      throw Exception('Failed to delete pupil public media auth, $e');
    }
  }

//- update support level

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

    try {
      _notificationService.apiRunning(true);
      final updatedPupil =
          await _client.pupilUpdate.updateSupportLevel(supportLevel);
      _notificationService.apiRunning(false);
      return updatedPupil;
    } catch (e) {
      _notificationService.apiRunning(false);
      _log.severe('Error while updating support level', e, StackTrace.current);
      _notificationService.showSnackBar(NotificationType.error,
          'Die Förderstufe konnte nicht aktualisiert werden: ${e.toString()}');
      throw Exception('Failed to update support level, $e');
    }
  }

  Future<PupilData> deleteSupportLevelHistoryItem({
    required int internalId,
    required int supportLevelId,
  }) async {
    try {
      _notificationService.apiRunning(true);

      final updatedPupil = await _client.pupil
          .deleteSupportLevelHistoryItem(internalId, supportLevelId);
      _notificationService.apiRunning(false);
      return updatedPupil;
    } catch (e) {
      _notificationService.apiRunning(false);
      _log.severe('Error while deleting support level history item', e,
          StackTrace.current);
      _notificationService.showSnackBar(NotificationType.error,
          'Die Förderstufe konnte nicht gelöscht werden: ${e.toString()}');
      throw Exception('Failed to delete support level history item, $e');
    }
  }
}
