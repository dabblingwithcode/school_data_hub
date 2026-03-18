import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/data/competence_report_api_service.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/data/competence_report_check_api_service.dart';

final _log = Logger('CompetenceReportManager');

class CompetenceReportManager {
  final _reportApiService = CompetenceReportApiService();
  final _checkApiService = CompetenceReportCheckApiService();
  final _notificationService = di<NotificationManager>();

  final _reportsByPupil = ValueNotifier<Map<int, List<CompetenceReport>>>({});
  ValueListenable<Map<int, List<CompetenceReport>>> get reportsByPupil =>
      _reportsByPupil;

  final Set<int> _loadedPupilIds = {};

  StreamSubscription<dynamic>? _hubSubscription;

  CompetenceReportManager();

  Future<CompetenceReportManager> init() async {
    _hubSubscription = di<HubStreamService>().events.listen(_onHubEvent);
    return this;
  }

  void dispose() {
    _hubSubscription?.cancel();
    _hubSubscription = null;
    _reportsByPupil.dispose();
    _loadedPupilIds.clear();
  }

  void _onHubEvent(dynamic event) {
    if (event is CompetenceReport) {
      _log.info('Stream: CompetenceReport pupilId=${event.pupilId}');
      upsertReportFromStream(event);
    } else if (event is CompetenceReportCheck) {
      _log.info(
        'Stream: CompetenceReportCheck pupilId=${event.pupilId} '
        'reportId=${event.competenceReportId} '
        'competenceId=${event.competenceId} '
        'achievement=${event.achievement}',
      );
      upsertCheckFromStream(event);
    } else if (event is HubDeleteEvent) {
      if (event.objectType == HubObjectType.competenceReport) {
        deleteReportFromStream(event.id);
      } else if (event.objectType == HubObjectType.competenceReportCheck) {
        deleteCheckFromStream(event.id);
      }
    } else if (event is HubReconnected) {
      for (final pupilId in _reportsByPupil.value.keys.toList()) {
        fetchReportsForPupil(pupilId);
      }
    } else if (event is HubSelectiveReconnect) {
      if (event.changedTypes.contains(HubObjectType.competenceReport) ||
          event.changedTypes.contains(HubObjectType.competenceReportCheck)) {
        for (final pupilId in _reportsByPupil.value.keys.toList()) {
          fetchReportsForPupil(pupilId);
        }
      }
    }
  }

  void upsertReportFromStream(CompetenceReport report) {
    final map = Map<int, List<CompetenceReport>>.from(_reportsByPupil.value);
    final list = List<CompetenceReport>.from(map[report.pupilId] ?? []);
    final index = list.indexWhere(
      (r) =>
          r.id == report.id ||
          (r.reportId == report.reportId && report.reportId.isNotEmpty),
    );
    if (index >= 0) {
      list[index] = report;
    } else {
      list.add(report);
    }
    map[report.pupilId] = list;
    _reportsByPupil.value = map;
  }

  void upsertCheckFromStream(CompetenceReportCheck check) {
    final map = Map<int, List<CompetenceReport>>.from(_reportsByPupil.value);

    // Find the report by competenceReportId across ALL loaded pupils.
    // check.pupilId may differ from the report's pupilId (the report owns
    // the canonical pupil association).
    int? ownerPupilId;
    List<CompetenceReport>? list;
    int reportIndex = -1;
    for (final entry in map.entries) {
      final idx = entry.value.indexWhere(
        (r) => r.id == check.competenceReportId,
      );
      if (idx != -1) {
        ownerPupilId = entry.key;
        list = entry.value;
        reportIndex = idx;
        break;
      }
    }

    if (list == null || reportIndex == -1) {
      _log.warning(
        'upsertCheck: report id=${check.competenceReportId} not found '
        'in any loaded pupil (check.pupilId=${check.pupilId}, '
        'loaded pupils: ${map.keys.toList()}) — fetching',
      );
      // Fall back to fetching by the report's pupil — try check.pupilId as
      // best guess, but it may be wrong.
      fetchReportsForPupil(check.pupilId);
      return;
    }

    _log.info(
      'upsertCheck: found report id=${check.competenceReportId} '
      'under pupilId=$ownerPupilId',
    );
    final report = list[reportIndex];
    final checks = List<CompetenceReportCheck>.from(
      report.competenceReportChecks ?? [],
    );
    final checkIndex = checks.indexWhere(
      (c) =>
          c.id == check.id ||
          (c.publicId == check.publicId && check.publicId.isNotEmpty),
    );
    if (checkIndex >= 0) {
      checks[checkIndex] = check;
    } else {
      checks.add(check);
    }
    final updatedReport = report.copyWith(competenceReportChecks: checks);
    final newList = List<CompetenceReport>.from(list);
    newList[reportIndex] = updatedReport;
    final newMap = Map<int, List<CompetenceReport>>.from(map);
    newMap[ownerPupilId!] = newList;
    _log.info(
      'upsertCheck: applied check competenceId=${check.competenceId} '
      'achievement=${check.achievement} — notifying listeners',
    );
    _reportsByPupil.value = newMap;
  }

  void deleteReportFromStream(int reportId) {
    final map = Map<int, List<CompetenceReport>>.from(_reportsByPupil.value);
    var changed = false;
    for (final entry in map.entries) {
      final list = entry.value;
      final newList = list.where((r) => r.id != reportId).toList();
      if (newList.length != list.length) {
        map[entry.key] = newList;
        changed = true;
        break;
      }
    }
    if (changed) {
      _reportsByPupil.value = map;
    }
  }

  void deleteCheckFromStream(int checkId) {
    final map = Map<int, List<CompetenceReport>>.from(_reportsByPupil.value);
    var changed = false;
    for (final pupilId in map.keys) {
      final list = map[pupilId]!;
      for (var i = 0; i < list.length; i++) {
        final report = list[i];
        final checks = report.competenceReportChecks;
        if (checks == null) continue;
        final newChecks = checks.where((c) => c.id != checkId).toList();
        if (newChecks.length != checks.length) {
          final newList = List<CompetenceReport>.from(list);
          newList[i] = report.copyWith(competenceReportChecks: newChecks);
          map[pupilId] = newList;
          changed = true;
          break;
        }
      }
      if (changed) break;
    }
    if (changed) {
      _reportsByPupil.value = map;
    }
  }

  List<CompetenceReport> getReportsForPupil(int pupilId) {
    return _reportsByPupil.value[pupilId] ?? [];
  }

  /// Fetches reports only if not already loaded for this pupil.
  Future<void> ensureReportsLoaded(int pupilId) async {
    if (_loadedPupilIds.contains(pupilId)) return;
    await fetchReportsForPupil(pupilId);
  }

  Future<void> fetchReportsForPupil(int pupilId) async {
    _log.info('fetchReportsForPupil: pupilId=$pupilId');
    final reports = await _reportApiService.fetchCompetenceReports(pupilId);
    if (reports != null) {
      final totalChecks = reports.fold<int>(
        0,
        (sum, r) => sum + (r.competenceReportChecks?.length ?? 0),
      );
      _log.info(
        'fetchReportsForPupil: got ${reports.length} reports, '
        '$totalChecks checks — notifying',
      );
      final map = Map<int, List<CompetenceReport>>.from(_reportsByPupil.value);
      map[pupilId] = reports;
      _reportsByPupil.value = map;
      _loadedPupilIds.add(pupilId);
    } else {
      _log.warning('fetchReportsForPupil: API returned null for pupilId=$pupilId');
    }
  }

  Future<void> postReport({
    required int pupilId,
    required int schoolSemesterId,
    required String achievement,
    required DateTime achievedAt,
  }) async {
    final createdBy = di<HubSessionManager>().userName!;
    final result = await _reportApiService.postCompetenceReport(
      pupilId: pupilId,
      schoolSemesterId: schoolSemesterId,
      achievement: achievement,
      achievedAt: achievedAt,
      createdBy: createdBy,
    );
    if (result != null) {
      _notificationService.showSnackBar(
        NotificationType.success,
        'Zeugnis erstellt',
      );
    }
  }

  Future<void> updateReport({
    required int pupilId,
    required String reportId,
    ({String value})? achievement,
    ({DateTime value})? achievedAt,
    ({DateTime? value})? modifiedAt,
  }) async {
    final modifiedBy = di<HubSessionManager>().userName!;
    final result = await _reportApiService.updateCompetenceReport(
      reportId,
      achievement: achievement,
      achievedAt: achievedAt,
      modifiedBy: (value: modifiedBy),
      modifiedAt: modifiedAt ?? (value: DateTime.now().toUtc()),
    );
    if (result != null) {
      _notificationService.showSnackBar(
        NotificationType.success,
        'Zeugnis aktualisiert',
      );
    }
  }

  Future<void> deleteReport({
    required int pupilId,
    required String reportId,
  }) async {
    final success = await _reportApiService.deleteCompetenceReport(reportId);
    if (success == true) {
      _notificationService.showSnackBar(
        NotificationType.success,
        'Zeugnis gelöscht',
      );
    }
  }

  Future<void> postReportCheck({
    required int pupilId,
    required int competenceReportItemId,
    required int competenceReportId,
    required int achievement,
    required String comment,
    bool? shouldPrint,
  }) async {
    final createdBy = di<HubSessionManager>().userName!;
    await _checkApiService.postCompetenceReportCheck(
      pupilId: pupilId,
      competenceReportItemId: competenceReportItemId,
      competenceReportId: competenceReportId,
      achievement: achievement,
      comment: comment,
      createdBy: createdBy,
      shouldPrint: shouldPrint,
    );

    _notificationService.showSnackBar(
      NotificationType.success,
      'Zeugniseintrag erstellt',
    );
  }

  Future<void> updateReportCheck({
    required int pupilId,
    required String publicId,
    ({int value})? achievement,
    ({String value})? comment,
    ({bool? value})? shouldPrint,
  }) async {
    await _checkApiService.updateCompetenceReportCheck(
      publicId,
      achievement: achievement,
      comment: comment,
      shouldPrint: shouldPrint,
    );

    _notificationService.showSnackBar(
      NotificationType.success,
      'Zeugniseintrag aktualisiert',
    );
  }

  Future<void> deleteReportCheck({
    required int pupilId,
    required String publicId,
  }) async {
    final success = await _checkApiService.deleteCompetenceReportCheck(
      publicId,
    );
    if (success) {
      _notificationService.showSnackBar(
        NotificationType.success,
        'Zeugniseintrag gelöscht',
      );
    }
  }
}
