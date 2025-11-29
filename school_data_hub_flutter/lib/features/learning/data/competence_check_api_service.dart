import 'dart:io';

import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:watch_it/watch_it.dart';

class CompetenceCheckApiService {
  Client get _client => di<Client>();
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

  Future<PupilData> updateCompetenceCheck({
    required String competenceCheckId,
    ({int value})? score,
    ({String? value})? competenceComment,
    ({DateTime? value})? createdAt,
    ({String value})? createdBy,
    ({double value})? valueFactor,
  }) async {
    final result = await ClientHelper.apiCall(
      call:
          () => _client.competenceCheck.updateCompetenceCheck(
            competenceCheckId,
            score: score,
            comment: competenceComment,
            createdBy: createdBy,
            valueFactor: valueFactor,
          ),
    );
    return result!;
  }

  Future<PupilData> addFileToCompetenceCheck(
    String competenceCheckId,
    File file,
    String createdBy,
  ) async {
    final path = await ClientFileUpload.uploadFile(
      file,
      ServerStorageFolder.documents,
    );
    final result = await ClientHelper.apiCall(
      call:
          () => _client.competenceCheck.addFileToCompetenceCheck(
            competenceCheckId,
            path.path!,
            createdBy,
          ),
      errorMessage: 'Fehler beim Hinzufügen des Bildes zum Kompetenzcheck',
    );
    return result!;
  }

  Future<PupilData> removeFileFromCompetenceCheck(
    String competenceCheckId,
    String fileId,
  ) async {
    final result = await ClientHelper.apiCall(
      call:
          () => _client.competenceCheck.removeFileFromCompetenceCheck(
            competenceCheckId,
            fileId,
          ),
      errorMessage: 'Fehler beim Entfernen des Bildes vom Kompetenzcheck',
    );
    return result!;
  }

  // //- delete

  Future<PupilData> deleteCompetenceCheck(String competenceCheckId) async {
    final pupilData = await ClientHelper.apiCall(
      call:
          () =>
              _client.competenceCheck.deleteCompetenceCheck(competenceCheckId),
      errorMessage: 'Fehler beim Löschen des Kompetenzchecks',
    );
    return pupilData!;
  }

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
