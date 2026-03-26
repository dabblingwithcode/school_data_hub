import 'dart:io';

import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/client/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/domain/models/nullable_records.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class SchooldayEventApiService {
  Client get _client => di<Client>();
  HubSessionManager get _hubSessionManager => di<HubSessionManager>();
  //- post schooldayEvent

  Future<SchooldayEvent?> postSchooldayEvent(
    String pupilName,
    int pupilId,
    int schooldayId,
    DateTime dateTime,
    SchooldayEventType type,
    String reason,
    String eventTime,
  ) async {
    final userName = _hubSessionManager.userName!;
    final pupil = di<PupilProxyManager>().getPupilByPupilId(pupilId);
    final tutor = pupil?.groupTutor;

    final event = await ClientHelper.apiCall(
      call: () => _client.schooldayEvent.createSchooldayEvent(
        pupilNameAndGroup: pupilName,
        dateAsString: dateTime.formatDateForUser(),
        pupilId: pupilId,
        schooldayId: schooldayId,
        type: type,
        reason: reason,
        createdBy: userName,
        eventTime: eventTime,
        tutor: tutor ?? '',
      ),
      errorMessage: 'Fehler beim Erstellen des Vorfalls',
    );
    if (event == null) return null;

    return await updateSchooldayEvent(
      schooldayEvent: event,
      eventTime: eventTime,
    );
  }

  //- GET

  Future<List<SchooldayEvent>?> fetchSchooldayEvents({
    DateTime? sinceDate,
  }) async {
    return await ClientHelper.apiCall(
      call: () => _client.schooldayEvent.fetchSchooldayEvents(
        sinceDate: sinceDate,
      ),
      errorMessage: 'Fehler beim Laden der Vorfälle',
    );
  }

  //- UPDATE

  Future<SchooldayEvent?> updateSchooldayEvent({
    required SchooldayEvent schooldayEvent,
    String? createdBy,
    SchooldayEventType? type,
    String? reason,
    bool? processed,
    NullableStringRecord? processedBy,
    NullableDateTimeRecord? processedAt,
    int? schooldayId,
    NullableStringRecord? comment,
    String? eventTime,
  }) async {
    bool changedProcessedStatus = false;
    // if the schooldayEvent is patched as processed,
    // processing user and processed date are automatically added

    if (processed == true && processedBy == null && processedAt == null) {
      processedBy = (value: _hubSessionManager.user!.userInfo!.userName!);

      processedAt = (value: di<SchoolCalendarManager>().thisDate.value);
      changedProcessedStatus = true;
    }

    // if the schooldayEvent is patched as not processed,
    // processing user and processed date are set to null

    if (processed == false) {
      processedBy = (value: null);
      processedAt = (value: null);
      changedProcessedStatus = true;
    }
    final schooldayEventToUpdate = schooldayEvent.copyWith(
      createdBy: createdBy ?? schooldayEvent.createdBy,
      eventType: type ?? schooldayEvent.eventType,
      eventReason: reason ?? schooldayEvent.eventReason,
      schooldayId: schooldayId ?? schooldayEvent.schooldayId,
      processed: processed ?? schooldayEvent.processed,
      processedBy: processedBy != null
          ? processedBy.value
          : schooldayEvent.processedBy,
      processedAt: processedAt != null
          ? processedAt.value
          : schooldayEvent.processedAt,
      comment: comment != null ? comment.value : schooldayEvent.comment,
      eventTime: eventTime ?? schooldayEvent.eventTime,
    );
    final pupil = di<PupilProxyManager>().getPupilByPupilId(
      schooldayEvent.pupilId,
    )!;

    return await ClientHelper.apiCall(
      call: () => _client.schooldayEvent.updateSchooldayEvent(
        schooldayEventToUpdate,
        changedProcessedStatus,
        '${pupil.firstName} (${pupil.group})',
        '${pupil.groupTutor}',
        di<HubSessionManager>().userName!,
        DateTime.now().formatDateForUser(),
      ),
      errorMessage: 'Fehler beim Aktualisieren des Vorfalls',
    );
  }

  //- upload file to document an schooldayEvent

  //- an schooldayEvent can be documented with an image file of a document
  //- the file is encrypted before it is uploaded
  //- there are two possible endpoints for the file upload, depending on whether the schooldayEvent is processed or not
  Future<SchooldayEvent?> updateSchooldayEventFile({
    required int schooldayEventId,
    required File file,
    required bool isProcessed,
  }) async {
    final result = await ClientFileUpload.uploadFile(
      file: file,
      storageId: StorageId.private,
      folder: ServerStorageFolder.events,
    );
    if (result.cancelled || !result.success || result.path == null) {
      return null;
    }
    return await ClientHelper.apiCall(
      call: () => _client.schooldayEvent.updateSchooldayEventFile(
        schooldayEventId,
        result.path!,
        _hubSessionManager.userName!,
        isProcessed,
      ),
      errorMessage: 'Das Dokument konnte nicht aktualisiert werden',
    );
  }

  //- delete schooldayEvent

  Future<bool?> deleteSchooldayEvent(int schooldayEventId) async {
    return await ClientHelper.apiCall(
      call: () => _client.schooldayEvent.deleteSchooldayEvent(schooldayEventId),
      errorMessage: 'Fehler beim Löschen des Vorfalls',
    );
  }

  //- delete schooldayEvent file
  //- depending on isProcessed, there are two possible endpoints for the file deletion

  Future<SchooldayEvent?> deleteSchooldayEventFile(
    int schooldayEventId,
    bool isProcessed,
  ) async {
    return await ClientHelper.apiCall(
      call: () => _client.schooldayEvent.deleteSchooldayEventFile(
        schooldayEventId,
        isProcessed,
      ),
      errorMessage: 'Fehler beim Löschen der Datei',
    );
  }
}
