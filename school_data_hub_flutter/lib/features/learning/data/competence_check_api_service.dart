import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();

class CompetenceCheckApiService {
  //- create

  Future<PupilData?> postCompetenceCheck({
    required int competenceId,
    required int pupilId,
    required String createdBy,
    String? comment,
  }) async {
    final PupilData? pupil = await ClientHelper.apiCall(
      call:
          () => _client.competenceCheck.postCompetenceCheck(
            competenceId: competenceId,
            pupilId: pupilId,
            score: 0,
            valueFactor: 1,
            comment: comment,
            createdBy: createdBy,
          ),
    );
    return pupil;
  }

  // //- update

  // String _patchCompetenceCheck(String competenceCheckId) {
  //   return '/competence_checks/$competenceCheckId';
  // }

  // Future<PupilData> updateCompetenceCheck({
  //   required String competenceCheckId,
  //   int? competenceStatus,
  //   String? comment,
  //   DateTime? createdAt,
  //   String? createdBy,
  // }) async {
  //   final data = jsonEncode({
  //     if (competenceStatus != null) "competence_status": competenceStatus,
  //     if (comment != null) "comment": comment,
  //     if (createdAt != null) "created_at": createdAt.formatForJson(),
  //     if (createdBy != null) "created_by": createdBy,
  //   });
  //   _notificationService.apiRunning(true);
  //   final Response response = await _client.patch(
  //     '${_baseUrl()}${_patchCompetenceCheck(competenceCheckId)}',
  //     data: data,
  //     options: _client.hubOptions,
  //   );
  //   _notificationService.apiRunning(false);
  //   if (response.statusCode != 200) {
  //     _notificationService.showSnackBar(
  //         NotificationType.error, 'Failed to patch a competence check');

  //     throw ApiException(
  //         'Failed to patch a competence check', response.statusCode);
  //   }

  //   final pupilData = PupilData.fromJson(response.data);

  //   return pupilData;
  // }
  // // String patchCompetenceCheckWithFile(String competenceCheckId) {
  // //   return '/competence/check/$competenceCheckId';
  // // }

  // //- delete

  // String _deleteCompetenceCheck(String competenceCheckId) {
  //   return '/competence_checks/$competenceCheckId';
  // }

  // Future<PupilData> deleteCompetenceCheck(String competenceCheckId) async {
  //   _notificationService.apiRunning(true);
  //   final Response response = await _client.delete(
  //     '${_baseUrl()}${_deleteCompetenceCheck(competenceCheckId)}',
  //     options: _client.hubOptions,
  //   );
  //   _notificationService.apiRunning(false);
  //   if (response.statusCode != 200) {
  //     _notificationService.showSnackBar(
  //         NotificationType.error, 'Failed to delete a competence check');

  //     throw ApiException(
  //         'Failed to delete a competence check', response.statusCode);
  //   }

  //   final pupilData = PupilData.fromJson(response.data);

  //   return pupilData;
  // }

  // String _deleteCompetenceCheckFile(String fileId) {
  //   return '/competence_checks/file/$fileId';
  // }

  // Future<PupilData> deleteCompetenceCheckFile(String fileId) async {
  //   _notificationService.apiRunning(true);

  //   final Response response = await _client.delete(
  //     '${_baseUrl()}${_deleteCompetenceCheckFile(fileId)}',
  //     options: _client.hubOptions,
  //   );

  //   _notificationService.apiRunning(false);

  //   if (response.statusCode != 200) {
  //     _notificationService.showSnackBar(
  //         NotificationType.error, 'Failed to delete a competence check file');

  //     throw ApiException(
  //         'Failed to delete a competence check file', response.statusCode);
  //   }

  //   final pupilData = PupilData.fromJson(response.data);

  //   return pupilData;
  // }
}
