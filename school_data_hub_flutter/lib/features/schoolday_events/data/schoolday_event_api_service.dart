import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/models/nullable_records.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();
final _notificationService = di<NotificationService>();
final _serverpodSessionManager = di<ServerpodSessionManager>();
final _log = Logger('SchooldayEventApiService');

class SchooldayEventApiService {
  //- post schooldayEvent

  Future<SchooldayEvent> postSchooldayEvent(int pupilId, int schooldayId,
      SchooldayEventType type, String reason) async {
    final userName = _serverpodSessionManager.userName!;
    _notificationService.apiRunning(true);
    try {
      final event = await _client.schooldayEvent.createSchooldayEvent(
        pupilId: pupilId,
        schooldayId: schooldayId,
        type: type,
        reason: reason,
        createdBy: userName,
      );

      _notificationService.apiRunning(false);

      return event;
    } catch (e) {
      _notificationService.apiRunning(false);

      throw Exception('Failed to post an schooldayEvent: $e');
    }
  }

  //- GET

  Future<List<SchooldayEvent>> fetchSchooldayEvents() async {
    _notificationService.apiRunning(true);
    try {
      final events = await _client.schooldayEvent.fetchSchooldayEvents();

      _notificationService.apiRunning(false);

      return events;
    } catch (e) {
      _notificationService.apiRunning(false);

      throw Exception('Failed to fetch schooldayEvents: $e');
    }
  }

  //- UPDATE

  Future<SchooldayEvent> updateSchooldayEvent(
      {required SchooldayEvent schooldayEvent,
      String? createdBy,
      SchooldayEventType? type,
      String? reason,
      bool? processed,
      //String? file,
      NullableStringRecord? processedBy,
      NullableDateTimeRecord? processedAt,
      int? schooldayId}) async {
    bool changedProcessedToFalse = false;
    // if the schooldayEvent is patched as processed,
    // processing user and processed date are automatically added

    if (processed == true && processedBy == null && processedAt == null) {
      processedBy = (value: _serverpodSessionManager.user!.userInfo!.userName!);

      processedAt = (value: DateTime.now());
    }

    // if the schooldayEvent is patched as not processed,
    // processing user and processed date are set to null

    if (processed == false) {
      processedBy = (value: null);
      processedAt = (value: null);
      changedProcessedToFalse = true;
    }
    final schooldayEventToUpdate = schooldayEvent.copyWith(
      createdBy: createdBy ?? schooldayEvent.createdBy,
      eventType: type ?? schooldayEvent.eventType,
      eventReason: reason ?? schooldayEvent.eventReason,
      schooldayId: schooldayId ?? schooldayEvent.schooldayId,
      processed: processed ?? schooldayEvent.processed,
      processedBy:
          processedBy != null ? processedBy.value : schooldayEvent.processedBy,
      processedAt:
          processedAt != null ? processedAt.value : schooldayEvent.processedAt,
    );

    try {
      _notificationService.apiRunning(true);
      final updatedSchooldayEvent = await _client.schooldayEvent
          .updateSchooldayEvent(
              schooldayEventToUpdate, changedProcessedToFalse);
      _notificationService.apiRunning(false);
      return updatedSchooldayEvent;
    } catch (e) {
      _notificationService.apiRunning(false);
      throw Exception('Failed to update schooldayEvent: $e');
    }
  }

  //- upload file to document an schooldayEvent

  //- an schooldayEvent can be documented with an image file of a document
  //- the file is encrypted before it is uploaded
  //- there are two possible endpoints for the file upload, depending on whether the schooldayEvent is processed or not
  Future<SchooldayEvent> updateSchooldayEventFile({
    required int schooldayEventId,
    required File file,
    required bool isProcessed,
  }) async {
    final documentId = Uuid().v4();
    final path = p.join('event', '$documentId.jpg');
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
          final updatedSchooldayEvent = await _client.schooldayEvent
              .updateSchooldayEventFile(schooldayEventId, path,
                  _serverpodSessionManager.userName!, isProcessed);
          _notificationService.apiRunning(false);

          return updatedSchooldayEvent;
        } catch (e) {
          _notificationService.apiRunning(false);

          _log.severe(
              'Error while updating pupil avatar', e, StackTrace.current);

          _notificationService.showSnackBar(NotificationType.error,
              'Das Profilbild konnte nicht aktualisiert werden: ${e.toString()}');

          throw Exception('Failed to update schoolday event file, $e');
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

  //- delete schooldayEvent

  Future<bool> deleteSchooldayEvent(int schooldayEventId) async {
    try {
      final success = await _client.schooldayEvent.deleteSchooldayEvent(
        schooldayEventId,
      );
      return success;
    } catch (e) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen des Ereignisses!: $e');
      return false;
    }
  }

//- delete schooldayEvent file
//- depending on isProcessed, there are two possible endpoints for the file deletion

  Future<SchooldayEvent> deleteSchooldayEventFile(
      int schooldayEventId, bool isProcessed) async {
    try {
      final schooldayEvent = await _client.schooldayEvent
          .deleteSchooldayEventFile(schooldayEventId, isProcessed);
      return schooldayEvent;
    } catch (e) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen der Datei!: $e');
      rethrow;
    }
  }
}
