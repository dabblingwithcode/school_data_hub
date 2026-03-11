import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:flutter_it/flutter_it.dart';

class CompetenceReportApiService {
  Client get _client => di<Client>();

  Future<CompetenceReport?> postCompetenceReport({
    required int pupilId,
    required int schoolSemesterId,
    required String achievement,
    required DateTime achievedAt,
    required String createdBy,
  }) async {
    return ClientHelper.apiCall(
      call: () => _client.competenceReport.postCompetenceReport(
        pupilId: pupilId,
        schoolSemesterId: schoolSemesterId,
        achievement: achievement,
        achievedAt: achievedAt,
        createdBy: createdBy,
      ),
      errorMessage: 'Kompetenzbericht erstellen',
    );
  }

  Future<List<CompetenceReport>?> fetchCompetenceReports(int pupilId) async {
    return ClientHelper.apiCall(
      call: () => _client.competenceReport.fetchCompetenceReports(pupilId),
      errorMessage: 'Kompetenzberichte',
    );
  }

  Future<CompetenceReport?> updateCompetenceReport(
    String reportId, {
    ({String value})? achievement,
    ({DateTime value})? achievedAt,
    ({String value})? modifiedBy,
    ({DateTime? value})? modifiedAt,
  }) async {
    return ClientHelper.apiCall(
      call: () => _client.competenceReport.updateCompetenceReport(
        reportId,
        achievement: achievement,
        achievedAt: achievedAt,
        modifiedBy: modifiedBy,
        modifiedAt: modifiedAt,
      ),
      errorMessage: 'Kompetenzbericht aktualisieren',
    );
  }

  Future<bool?> deleteCompetenceReport(String reportId) async {
    return ClientHelper.apiCall(
      call: () => _client.competenceReport.deleteCompetenceReport(reportId),
      errorMessage: 'Kompetenzbericht löschen',
    );
  }
}
