import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/models/nullable_records.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/data/schoolday_event_api_service.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/models/pupil_schoolday_events_proxy.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('SchooldayEventManager');

final _notificationService = di<NotificationService>();

final _pupilManager = di<PupilManager>();

final _schooldayEventApiService = SchooldayEventApiService();

class SchooldayEventManager {
  final ValueNotifier<List<SchooldayEvent>> _schooldayEvents =
      ValueNotifier([]);
  ValueListenable<List<SchooldayEvent>> get schooldayEvents => _schooldayEvents;

  final Map<int, PupilSchooldayEventsProxy> _pupilSchooldayEventsMap = {};

  SchooldayEventManager() {
    init();
  }

  Future<void> init() async {
    // we must have a proxy object for every pupil because we need to
    // watch them in the UI unconditionally (even if there are no entries)
    final pupilIds = _pupilManager.allPupils.map((e) => e.pupilId).toList();
    for (var pupilId in pupilIds) {
      _pupilSchooldayEventsMap[pupilId] = PupilSchooldayEventsProxy();
    }
    _log.info('SchooldayEventManager initialized');
  }

  //- Getters

  PupilSchooldayEventsProxy getPupilSchooldayEventsProxy(int pupilId) {
    return _pupilSchooldayEventsMap[pupilId]!;
  }

  //- Handle collections

  void updateSchooldayEventInCollections(SchooldayEvent event) {
    _log.info('updateSchooldayEventInCollections: $event');
    final pupilId = event.pupilId;

    // 1. Update the event in the main list
    int index =
        _schooldayEvents.value.indexWhere((element) => element.id == event.id);
    if (index != -1) {
      final newList = List<SchooldayEvent>.from(_schooldayEvents.value);
      newList[index] = event;
      _schooldayEvents.value = newList;
    } else {
      _schooldayEvents.value = [..._schooldayEvents.value, event];
    }
    // 2. Update pupil map
    _pupilSchooldayEventsMap[pupilId]!.updateSchooldayEvent(event);
  }

  void updateSchooldayEventsInCollections(List<SchooldayEvent> events) {
    _log.info('updateSchooldayEventsInCollections: $events');
    for (var event in events) {
      updateSchooldayEventInCollections(event);
    }
  }

  void removeSchooldayEventFromCollections(SchooldayEvent event) {
    _log.info('removeSchooldayEventFromCollections: $event');
    final pupilId = event.pupilId;
    // 1. Remove the event from the main list
    int index =
        _schooldayEvents.value.indexWhere((element) => element.id == event.id);
    if (index != -1) {
      final newList = List<SchooldayEvent>.from(_schooldayEvents.value);
      newList.removeAt(index);
      _schooldayEvents.value = newList;
    }
    // 2. Remove pupil map
    _pupilSchooldayEventsMap[pupilId]!.removeSchooldayEvent(event);
  }

//- CRUD operantions

  //- post schoolday event

  Future<void> postSchooldayEvent(
    int pupilId,
    int schooldayId,
    SchooldayEventType type,
    String reason,
  ) async {
    final SchooldayEvent schooldayEvent = await _schooldayEventApiService
        .postSchooldayEvent(pupilId, schooldayId, type, reason);

    updateSchooldayEventInCollections(schooldayEvent);
    _notificationService.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich!');

    return;
  }

  //- get schoolday events

  Future<void> fetchSchooldayEvents() async {
    try {
      final List<SchooldayEvent> events =
          await _schooldayEventApiService.fetchSchooldayEvents();

      _schooldayEvents.value = events;
      updateSchooldayEventsInCollections(events);
    } catch (e) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Laden der Einträge: $e');
    }
  }

  //- update schoolday event

  Future<void> updateSchooldayEvent({
    required SchooldayEvent eventToUpdate,
    String? createdBy,
    String? reason,
    SchooldayEventType? schoolEventType,
    bool? processed,
    NullableStringRecord? processedBy,
    NullableDateTimeRecord? processedAt,
    int? schooldayId,
  }) async {
    final SchooldayEvent schooldayEvent =
        await _schooldayEventApiService.updateSchooldayEvent(
            schooldayEvent: eventToUpdate,
            createdBy: createdBy,
            reason: reason,
            processed: processed,
            processedBy: processedBy,
            processedAt: processedAt,
            schooldayId: schooldayId,
            type: schoolEventType);

    updateSchooldayEventInCollections(schooldayEvent);

    _notificationService.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich geändert!');

    return;
  }

  // Future<void> patchSchooldayEventWithFile(
  //     File imageFile, String schooldayEventId, bool isProcessed) async {
  //   final PupilData responsePupil = await _apiSchooldayEventService
  //       .patchSchooldayEventWithFile(imageFile, schooldayEventId, isProcessed);

  //   pupilManager.updatePupilProxyWithPupilData(responsePupil);

  //   _notificationService.showSnackBar(
  //       NotificationType.success, 'Datei erfolgreich hochgeladen!');

  //   return;
  // }

  // Future<void> deleteSchooldayEventFile(
  //     String schooldayEventId, String cacheKey, bool isProcessed) async {
  //   final PupilData responsePupil = await _apiSchooldayEventService
  //       .deleteSchooldayEventFile(schooldayEventId, cacheKey, isProcessed);

  //   pupilManager.updatePupilProxyWithPupilData(responsePupil);

  //   _notificationService.showSnackBar(
  //       NotificationType.success, 'Datei erfolgreich gelöscht!');

  //   return;
  // }

  Future<void> deleteSchooldayEvent(int schooldayEventId) async {
    try {
      _notificationService.apiRunning(true);

      await _schooldayEventApiService.deleteSchooldayEvent(schooldayEventId);

      _notificationService.apiRunning(false);

      final eventToDelete = _schooldayEvents.value
          .firstWhere((element) => element.id == schooldayEventId);

      removeSchooldayEventFromCollections(eventToDelete);
    } catch (e) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen des Eintrags: $e');

      return;
    }

    return;
  }
}
