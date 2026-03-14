import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/domain/models/nullable_records.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/data/schoolday_event_api_service.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/models/pupil_schoolday_events_proxy.dart';

class SchooldayEventManager with ChangeNotifier {
  final _cacheManager = di<DefaultCacheManager>();

  final _log = Logger('SchooldayEventManager');

  final _notificationService = di<NotificationManager>();

  final _pupilManager = di<PupilProxyManager>();

  final _schooldayEventApiService = SchooldayEventApiService();

  final Map<int, SchooldayEvent> _schooldayEventsMap = {};
  final _schooldayEvents = ListNotifier<SchooldayEvent>();

  ValueListenable<List<SchooldayEvent>> get schooldayEvents => _schooldayEvents;

  final Map<int, PupilSchooldayEventsProxy> _pupilSchooldayEventsMap = {};

  ListenableSubscription? _pupilManagerSubscription;
  StreamSubscription<dynamic>? _hubSubscription;

  SchooldayEventManager() {
    init();
  }

  @override
  void dispose() {
    _hubSubscription?.cancel();
    _hubSubscription = null;
    _pupilManagerSubscription?.cancel();
    _pupilSchooldayEventsMap.clear();
    _schooldayEventsMap.clear();
    _schooldayEvents.dispose();
    super.dispose();
  }

  Future<void> init() async {
    _pupilManagerSubscription = _pupilManager.listen(
      (_) => _updatePupilProxies(),
    );
    _updatePupilProxies();
    Future.microtask(() => fetchSchooldayEvents());
    _hubSubscription = di<HubStreamService>().events.listen(_onHubEvent);
    _log.info('SchooldayEventManager initialized');
  }

  void _onHubEvent(dynamic event) {
    if (event is SchooldayEvent) {
      upsertFromStream(event);
    } else if (event is HubDeleteEvent &&
        event.objectType == HubObjectType.schooldayEvent) {
      deleteFromStream(event.id);
    } else if (event is HubReconnected) {
      fetchSchooldayEvents();
    } else if (event is HubSelectiveReconnect) {
      if (event.changedTypes.contains(HubObjectType.schooldayEvent)) {
        fetchSchooldayEvents();
      }
    }
  }

  void _updatePupilProxies() {
    final pupilIds = _pupilManager.allPupils.map((e) => e.pupilId).toList();
    for (var pupilId in pupilIds) {
      if (!_pupilSchooldayEventsMap.containsKey(pupilId)) {
        _pupilSchooldayEventsMap[pupilId] = PupilSchooldayEventsProxy();
      }
    }
  }

  //- Getters

  PupilSchooldayEventsProxy getPupilSchooldayEventsProxy(int pupilId) {
    if (!_pupilSchooldayEventsMap.containsKey(pupilId)) {
      _log.warning('No PupilSchooldayEventsProxy found for pupilId: $pupilId');
      _pupilSchooldayEventsMap[pupilId] = PupilSchooldayEventsProxy();
    }
    return _pupilSchooldayEventsMap[pupilId]!;
  }

  /// Schoolday events grouped by date (local date-only key). Null schoolday skipped.
  Map<DateTime, List<SchooldayEvent>> get schooldayEventsByDate {
    final byDate = <DateTime, List<SchooldayEvent>>{};
    for (final event in _schooldayEvents.value) {
      if (event.schoolday == null) continue;
      final d = event.schoolday!.schoolday.toLocal();
      final key = DateTime(d.year, d.month, d.day);
      byDate.putIfAbsent(key, () => []).add(event);
    }
    return byDate;
  }

  /// Count of schoolday events per date (derived from [schooldayEventsByDate]).
  Map<DateTime, int> get schooldayEventsCountByDate =>
      schooldayEventsByDate.map((k, v) => MapEntry(k, v.length));

  //- Handle collections

  void _updateSchooldayEventCollections(SchooldayEvent event) {
    final pupilId = event.pupilId;
    if (!_pupilSchooldayEventsMap.containsKey(pupilId)) {
      _pupilSchooldayEventsMap[pupilId] = PupilSchooldayEventsProxy();
    }
    _pupilSchooldayEventsMap[pupilId]!.updateSchooldayEvent(event);

    _schooldayEventsMap[event.id!] = event;
    final index = _schooldayEvents.value.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      _schooldayEvents[index] = event;
    } else {
      _schooldayEvents.add(event);
    }
    notifyListeners();
  }

  void updateSchooldayEventsBatchInCollections(List<SchooldayEvent> events) {
    _schooldayEvents.startTransAction();
    for (var event in events) {
      _updateSchooldayEventCollections(event);
    }
    _schooldayEvents.endTransAction();
  }

  void removeSchooldayEventFromCollections(SchooldayEvent event) {
    final pupilId = event.pupilId;
    _pupilSchooldayEventsMap[pupilId]?.removeSchooldayEvent(event);
    _schooldayEventsMap.remove(event.id!);
    final index = _schooldayEvents.value.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      _schooldayEvents.removeAt(index);
    }
    notifyListeners();
  }

  //- Stream entry points (called by HubStreamService)

  void upsertFromStream(SchooldayEvent event) {
    _log.fine('[STREAM] upsert schooldayEvent ${event.id}');
    _updateSchooldayEventCollections(event);
  }

  void deleteFromStream(int id) {
    _log.fine('[STREAM] delete schooldayEvent $id');
    final event = _schooldayEventsMap[id];
    if (event != null) {
      removeSchooldayEventFromCollections(event);
    }
  }

  //- CRUD operations

  Future<void> postSchooldayEvent({
    required int pupilId,
    required int schooldayId,
    required DateTime dateTime,
    required SchooldayEventType type,
    required String reason,
    required String eventTime,
  }) async {
    final SchooldayEvent
    schooldayEvent = await _schooldayEventApiService.postSchooldayEvent(
      '${di<PupilProxyManager>().getPupilByPupilId(pupilId)!.firstName} (${di<PupilProxyManager>().getPupilByPupilId(pupilId)!.group})',
      pupilId,
      schooldayId,
      dateTime,
      type,
      reason,
      eventTime,
    );

    _updateSchooldayEventCollections(schooldayEvent);
  }

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
    String? eventTime,
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
          eventTime: eventTime,
        );

    _updateSchooldayEventCollections(schooldayEvent);
    if (cacheKey != null) {
      await _cacheManager.removeFile(cacheKey);
    }
    _log.info('SchooldayEvent updated!');
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
  }

  Future<void> deleteSchooldayEvent(int schooldayEventId) async {
    try {
      _notificationService.apiRunning(true);

      await _schooldayEventApiService.deleteSchooldayEvent(schooldayEventId);

      _notificationService.apiRunning(false);

      final eventToDelete = _schooldayEventsMap[schooldayEventId];
      if (eventToDelete != null) {
        removeSchooldayEventFromCollections(eventToDelete);
      }
    } catch (e) {
      _notificationService.apiRunning(false);
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Löschen des Eintrags: $e',
      );
    }
  }
}
