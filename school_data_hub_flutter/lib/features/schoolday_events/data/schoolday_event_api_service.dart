import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();
final _notificationService = di<NotificationService>();
final _sessionManager = di<ServerpodSessionManager>();

class SchooldayEventApiService {
  //- post schooldayEvent

  Future<SchooldayEvent> postSchooldayEvent(int pupilId, int schooldayId,
      SchooldayEventType type, SchooldayEventReason reason) async {
    final userName = _sessionManager.user!.userInfo!.userName!;
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
      SchooldayEventReason? reason,
      bool? processed,
      //String? file,
      String? processedBy,
      DateTime? processedAt,
      int? schooldayId}) async {
    // if the schooldayEvent is patched as processed,
    // processing user and processed date are automatically added

    if (processed == true && processedBy == null && processedAt == null) {
      processedBy = _sessionManager.user!.userInfo!.userName!;

      processedAt = DateTime.now();
    }

    // if the schooldayEvent is patched as not processed,
    // processing user and processed date are set to null

    if (processed == false) {
      processedBy = null;
      processedAt = null;
    }
    final schooldayEventToUpdate = schooldayEvent.copyWith(
      createdBy: createdBy ?? schooldayEvent.createdBy,
      eventType: type ?? schooldayEvent.eventType,
      eventReason: reason ?? schooldayEvent.eventReason,
      schooldayId: schooldayId ?? schooldayEvent.schooldayId,
      processed: processed ?? schooldayEvent.processed,
      processedBy: processedBy ?? schooldayEvent.processedBy,
      processedAt: processedAt ?? schooldayEvent.processedAt,
    );

    try {
      _notificationService.apiRunning(true);
      final updatedSchooldayEvent = await _client.schooldayEvent
          .updateSchooldayEvent(schooldayEventToUpdate);
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

  // Future<PupilData> patchSchooldayEventWithFile(
  //     File imageFile, String schooldayEventId, bool isProcessed) async {
  //   locator<NotificationService>().apiRunning(true);

  //   String endpoint;

  //   final encryptedFile = await customEncrypter.encryptFile(imageFile);

  //   String fileName = encryptedFile.path.split('/').last;

  //   var formData = FormData.fromMap({
  //     'file': await MultipartFile.fromFile(
  //       encryptedFile.path,
  //       filename: fileName,
  //     ),
  //   });

  //   // choose endpoint depending on isProcessed
  //   if (isProcessed) {
  //     endpoint = _patchSchooldayEventProcessedFileUrl(schooldayEventId);
  //   } else {
  //     endpoint = _patchSchooldayEventFileUrl(schooldayEventId);
  //   }

  //   final Response response = await _client.patch(
  //     '${_baseUrl()}$endpoint',
  //     data: formData,
  //     options: _client.hubOptions,
  //   );

  //   if (response.statusCode != 200) {
  //     locator<NotificationService>().showSnackBar(
  //         NotificationType.warning, 'Fehler beim Hochladen des Bildes!');

  //     locator<NotificationService>().apiRunning(false);

  //     throw ApiException(
  //         'Failed to upload schooldayEvent file', response.statusCode);
  //   }

  //   final PupilData responsePupil = PupilData.fromJson(response.data);

  //   locator<NotificationService>().apiRunning(false);

  //   return responsePupil;
  // }

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

  // Future<PupilData> deleteSchooldayEventFile(
  //     String schooldayEventId, String cacheKey, bool isProcessed) async {
  //   locator<NotificationService>().apiRunning(true);

  //   // choose endpoint depending on isProcessed
  //   String endpoint;
  //   if (isProcessed) {
  //     endpoint = _deleteSchooldayEventProcessedFileUrl(schooldayEventId);
  //   } else {
  //     endpoint = _deleteSchooldayEventFileUrl(schooldayEventId);
  //   }

  //   final Response response = await _client.delete(
  //     '${_baseUrl()}$endpoint',
  //     options: _client.hubOptions,
  //   );

  //   if (response.statusCode != 200) {
  //     locator<NotificationService>().showSnackBar(
  //         NotificationType.warning, 'Fehler beim Löschen der Datei!');

  //     locator<NotificationService>().apiRunning(false);

  //     throw ApiException(
  //         'Failed to delete schooldayEvent', response.statusCode);
  //   }

  //   final PupilData responsePupil = PupilData.fromJson(response.data);

  //   // Delete the file from the cache
  //   final cacheManager = locator<DefaultCacheManager>();
  //   await cacheManager.removeFile(cacheKey);

  //   _notificationService.apiRunning(false);

  //   return responsePupil;
  // }
}
