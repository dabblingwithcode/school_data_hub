import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/domain/models/nullable_records.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/data/schoolday_event_api_service.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/models/pupil_schoolday_events_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventManager with ChangeNotifier {
  final _cacheManager = di<DefaultCacheManager>();

  final _log = Logger('SchooldayEventManager');

  final _notificationService = di<NotificationService>();

  final _pupilManager = di<PupilManager>();

  final _schooldayEventApiService = SchooldayEventApiService();

  final Map<int, SchooldayEvent> _schooldayEventsMap = {};

  List<SchooldayEvent> get schooldayEvents =>
      _schooldayEventsMap.values.toList();

  final Map<int, PupilSchooldayEventsProxy> _pupilSchooldayEventsMap = {};

  SchooldayEventManager() {
    init();
  }

  Future<void> init() async {
    _pupilManager.addListener(_updatePupilProxies);
    _updatePupilProxies();
    // Defer fetching events until next frame to ensure proxies are ready
    Future.microtask(() => fetchSchooldayEvents());
    _log.info('SchooldayEventManager initialized');
  }

  void _updatePupilProxies() {
    final pupilIds = _pupilManager.allPupils.map((e) => e.pupilId).toList();
    for (var pupilId in pupilIds) {
      if (!_pupilSchooldayEventsMap.containsKey(pupilId)) {
        _pupilSchooldayEventsMap[pupilId] = PupilSchooldayEventsProxy();
      }
    }
  }

  @override
  void dispose() {
    _pupilManager.removeListener(_updatePupilProxies);
    super.dispose();
  }

  //- Getters

  PupilSchooldayEventsProxy getPupilSchooldayEventsProxy(int pupilId) {
    if (!_pupilSchooldayEventsMap.containsKey(pupilId)) {
      _log.warning('No PupilSchooldayEventsProxy found for pupilId: $pupilId');
      _pupilSchooldayEventsMap[pupilId] = PupilSchooldayEventsProxy();
    }
    return _pupilSchooldayEventsMap[pupilId]!;
  }

  //- Handle collections

  void _updateSchooldayEventCollections(SchooldayEvent event) {
    final pupilId = event.pupilId;
    // Ensure the pupil proxy exists
    if (!_pupilSchooldayEventsMap.containsKey(pupilId)) {
      _pupilSchooldayEventsMap[pupilId] = PupilSchooldayEventsProxy();
    }
    // 1. Update pupil map
    _pupilSchooldayEventsMap[pupilId]!.updateSchooldayEvent(event);

    // 2. Update the event in the main map
    if (_schooldayEventsMap.containsKey(event.id!)) {
      _schooldayEventsMap[event.id!] = event;
      notifyListeners();
    } else {
      _schooldayEventsMap[event.id!] = event;
      notifyListeners();
    }
  }

  void updateSchooldayEventsBatchInCollections(List<SchooldayEvent> events) {
    for (var event in events) {
      _updateSchooldayEventCollections(event);
    }
  }

  void removeSchooldayEventFromCollections(SchooldayEvent event) {
    final pupilId = event.pupilId;

    // 1. Remove pupil map
    _pupilSchooldayEventsMap[pupilId]!.removeSchooldayEvent(event);

    // 2. Remove the event from the main map
    if (_schooldayEventsMap.containsKey(event.id!)) {
      _schooldayEventsMap.remove(event.id!);
      notifyListeners();
    }
  }

  //- CRUD operantions

  //- post schoolday event

  Future<void> postSchooldayEvent(
    int pupilId,
    int schooldayId,
    DateTime dateTime,
    SchooldayEventType type,
    String reason,
  ) async {
    final SchooldayEvent
    schooldayEvent = await _schooldayEventApiService.postSchooldayEvent(
      '${di<PupilManager>().getPupilByPupilId(pupilId)!.firstName} (${di<PupilManager>().getPupilByPupilId(pupilId)!.group})',
      pupilId,
      schooldayId,
      dateTime,
      type,
      reason,
    );

    _updateSchooldayEventCollections(schooldayEvent);
    _notificationService.showSnackBar(
      NotificationType.success,
      'Eintrag erfolgreich!',
    );

    return;
  }

  //- get schoolday events

  Future<void> fetchSchooldayEvents() async {
    try {
      final List<SchooldayEvent> events = await _schooldayEventApiService
          .fetchSchooldayEvents();

      updateSchooldayEventsBatchInCollections(events);
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Laden der Einträge: $e',
      );
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
    NullableStringRecord? comment,
  }) async {
    String? cacheKey;
    if (processed == false && eventToUpdate.processedDocumentId != null) {
      cacheKey = eventToUpdate.processedDocument!.documentId;
    }
    final SchooldayEvent schooldayEvent = await _schooldayEventApiService
        .updateSchooldayEvent(
          schooldayEvent: eventToUpdate,
          createdBy: createdBy,
          reason: reason,
          processed: processed,
          processedBy: processedBy,
          processedAt: processedAt,
          schooldayId: schooldayId,
          type: schoolEventType,
          comment: comment,
        );

    _updateSchooldayEventCollections(schooldayEvent);
    if (cacheKey != null) {
      await _cacheManager.removeFile(cacheKey);
    }
    _notificationService.showSnackBar(
      NotificationType.success,
      'Eintrag erfolgreich geändert!',
    );

    return;
  }

  Future<void> updateSchooldayEventFile({
    required File imageFile,
    required int schooldayEventId,
    required bool isProcessed,
  }) async {
    final encryptedFile = await customEncrypter.encryptFile(imageFile);
    final SchooldayEvent? responseEvent = await _schooldayEventApiService
        .updateSchooldayEventFile(
          schooldayEventId: schooldayEventId,
          file: encryptedFile,
          isProcessed: isProcessed,
        );
    if (responseEvent == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Datei konnte nicht hochgeladen werden!',
      );
      return;
    }
    _updateSchooldayEventCollections(responseEvent);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Datei erfolgreich hochgeladen!',
    );

    return;
  }

  Future<void> deleteSchooldayEventFile(
    int schooldayEventId,
    String cacheKey,
    bool isProcessed,
  ) async {
    final SchooldayEvent schooldayEvent = await _schooldayEventApiService
        .deleteSchooldayEventFile(schooldayEventId, isProcessed);
    await _cacheManager.removeFile(cacheKey);
    _updateSchooldayEventCollections(schooldayEvent);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Datei erfolgreich gelöscht!',
    );

    return;
  }

  Future<void> deleteSchooldayEvent(int schooldayEventId) async {
    try {
      _notificationService.apiRunning(true);

      await _schooldayEventApiService.deleteSchooldayEvent(schooldayEventId);

      _notificationService.apiRunning(false);

      final eventToDelete = _schooldayEventsMap[schooldayEventId];

      removeSchooldayEventFromCollections(eventToDelete!);
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Löschen des Eintrags: $e',
      );

      return;
    }

    return;
  }
}
