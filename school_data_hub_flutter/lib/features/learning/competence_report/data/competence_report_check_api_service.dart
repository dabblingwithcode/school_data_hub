import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:flutter_it/flutter_it.dart';

class CompetenceReportCheckApiService {
  Client get _client => di<Client>();

  Future<CompetenceReportCheck> postCompetenceReportCheck({
    required int pupilId,
    required int competenceReportItemId,
    required int competenceReportId,
    required int achievement,
    required String comment,
    required String createdBy,
    bool? shouldPrint,
  }) async {
    return _client.competenceReportCheck.postCompetenceReportCheck(
      pupilId: pupilId,
      competenceReportItemId: competenceReportItemId,
      competenceReportId: competenceReportId,
      achievement: achievement,
      comment: comment,
      createdBy: createdBy,
      shouldPrint: shouldPrint,
    );
  }

  Future<CompetenceReportCheck> updateCompetenceReportCheck(
    String publicId, {
    ({int value})? achievement,
    ({String value})? comment,
    ({bool? value})? shouldPrint,
  }) async {
    return _client.competenceReportCheck.updateCompetenceReportCheck(
      publicId,
      achievement: achievement,
      comment: comment,
      shouldPrint: shouldPrint,
    );
  }

  Future<bool> deleteCompetenceReportCheck(String publicId) async {
    return _client.competenceReportCheck.deleteCompetenceReportCheck(publicId);
  }
}
