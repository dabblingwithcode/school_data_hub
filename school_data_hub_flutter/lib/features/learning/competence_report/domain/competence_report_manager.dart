import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/data/competence_report_api_service.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/data/competence_report_check_api_service.dart';

class CompetenceReportManager {
  final _reportApiService = CompetenceReportApiService();
  final _checkApiService = CompetenceReportCheckApiService();
  final _notificationService = di<NotificationService>();

  final _reportsByPupil =
      ValueNotifier<Map<int, List<CompetenceReport>>>({});
  ValueListenable<Map<int, List<CompetenceReport>>> get reportsByPupil =>
      _reportsByPupil;

  CompetenceReportManager();

  void dispose() {
    _reportsByPupil.dispose();
  }

  List<CompetenceReport> getReportsForPupil(int pupilId) {
    return _reportsByPupil.value[pupilId] ?? [];
  }

  Future<void> fetchReportsForPupil(int pupilId) async {
    final reports = await _reportApiService.fetchCompetenceReports(pupilId);
    final map = Map<int, List<CompetenceReport>>.from(_reportsByPupil.value);
    map[pupilId] = reports;
    _reportsByPupil.value = map;
  }

  Future<void> postReport({
    required int pupilId,
    required int schoolSemesterId,
    required String achievement,
    required DateTime achievedAt,
  }) async {
    final createdBy = di<HubSessionManager>().userName!;
    final report = await _reportApiService.postCompetenceReport(
      pupilId: pupilId,
      schoolSemesterId: schoolSemesterId,
      achievement: achievement,
      achievedAt: achievedAt,
      createdBy: createdBy,
    );

    final map = Map<int, List<CompetenceReport>>.from(_reportsByPupil.value);
    map[pupilId] = [...(map[pupilId] ?? []), report];
    _reportsByPupil.value = map;

    _notificationService.showSnackBar(
      NotificationType.success,
      'Zeugnis erstellt',
    );
  }

  Future<void> updateReport({
    required int pupilId,
    required String reportId,
    ({String value})? achievement,
    ({DateTime value})? achievedAt,
    ({DateTime? value})? modifiedAt,
  }) async {
    final modifiedBy = di<HubSessionManager>().userName!;
    final updated = await _reportApiService.updateCompetenceReport(
      reportId,
      achievement: achievement,
      achievedAt: achievedAt,
      modifiedBy: (value: modifiedBy),
      modifiedAt: modifiedAt ?? (value: DateTime.now().toUtc()),
    );

    final map = Map<int, List<CompetenceReport>>.from(_reportsByPupil.value);
    final list = List<CompetenceReport>.from(map[pupilId] ?? []);
    final index = list.indexWhere((r) => r.reportId == reportId);
    if (index != -1) {
      list[index] = updated;
    }
    map[pupilId] = list;
    _reportsByPupil.value = map;

    _notificationService.showSnackBar(
      NotificationType.success,
      'Zeugnis aktualisiert',
    );
  }

  Future<void> deleteReport({
    required int pupilId,
    required String reportId,
  }) async {
    final success = await _reportApiService.deleteCompetenceReport(reportId);
    if (success) {
      final map =
          Map<int, List<CompetenceReport>>.from(_reportsByPupil.value);
      final list = List<CompetenceReport>.from(map[pupilId] ?? []);
      list.removeWhere((r) => r.reportId == reportId);
      map[pupilId] = list;
      _reportsByPupil.value = map;

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

    await fetchReportsForPupil(pupilId);

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

    await fetchReportsForPupil(pupilId);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Zeugniseintrag aktualisiert',
    );
  }

  Future<void> deleteReportCheck({
    required int pupilId,
    required String publicId,
  }) async {
    final success =
        await _checkApiService.deleteCompetenceReportCheck(publicId);
    if (success) {
      await fetchReportsForPupil(pupilId);

      _notificationService.showSnackBar(
        NotificationType.success,
        'Zeugniseintrag gelöscht',
      );
    }
  }
}
