import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:flutter_it/flutter_it.dart';

class CompetenceReportApiService {
  Client get _client => di<Client>();

  Future<CompetenceReport> postCompetenceReport({
    required int pupilId,
    required int schoolSemesterId,
    required String achievement,
    required DateTime achievedAt,
    required String createdBy,
  }) async {
    return _client.competenceReport.postCompetenceReport(
      pupilId: pupilId,
      schoolSemesterId: schoolSemesterId,
      achievement: achievement,
      achievedAt: achievedAt,
      createdBy: createdBy,
    );
  }

  Future<List<CompetenceReport>> fetchCompetenceReports(int pupilId) async {
    return _client.competenceReport.fetchCompetenceReports(pupilId);
  }

  Future<CompetenceReport> updateCompetenceReport(
    String reportId, {
    ({String value})? achievement,
    ({DateTime value})? achievedAt,
    ({String value})? modifiedBy,
    ({DateTime? value})? modifiedAt,
  }) async {
    return _client.competenceReport.updateCompetenceReport(
      reportId,
      achievement: achievement,
      achievedAt: achievedAt,
      modifiedBy: modifiedBy,
      modifiedAt: modifiedAt,
    );
  }

  Future<bool> deleteCompetenceReport(String reportId) async {
    return _client.competenceReport.deleteCompetenceReport(reportId);
  }
}
