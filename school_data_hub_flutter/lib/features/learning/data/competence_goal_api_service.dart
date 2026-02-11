import 'dart:io';

import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';

class CompetenceGoalApiService {
  // Private constructor
  CompetenceGoalApiService._internal();
  // Singleton instance
  static final CompetenceGoalApiService _instance =
      CompetenceGoalApiService._internal();
  // Factory constructor to return the singleton instance
  factory CompetenceGoalApiService() {
    return _instance;
  }
  Client get _client => di<Client>();

  HubSessionManager get _hubSessionManager => di<HubSessionManager>();

  // - post a competence goal
  Future<PupilData?> postCompetenceGoal({
    required int pupilId,
    required int competenceId,
    required String description,
    required List<String> strategies,
  }) async {
    final response = ClientHelper.apiCall(
      call: () => _client.competenceGoal.postCompetenceGoal(
        competenceId: competenceId,
        pupilId: pupilId,
        description: description,
        strategies: strategies,
        createdBy: _hubSessionManager.userName!,
      ),
    );
    return response;
  }

  // - update a competence goal
  Future<PupilData> updateCompetenceGoal({
    required String publicId,
    ({int? value})? score,
    ({DateTime? value})? achievedAt,
    ({String value})? description,
    ({List<String>? value})? strategies,
  }) async {
    final result = await ClientHelper.apiCall(
      call: () => _client.competenceGoal.updateCompetenceGoal(
        publicId,
        score: score,
        achievedAt: achievedAt,
        description: description,
        strategies: strategies,
        modifiedBy: (value: _hubSessionManager.userName!),
      ),
      errorMessage: 'Fehler beim Aktualisieren des Lernziels',
    );
    return result!;
  }

  // - delete a competence goal
  Future<PupilData> deleteCompetenceGoal(String publicId) async {
    final pupilData = await ClientHelper.apiCall(
      call: () => _client.competenceGoal.deleteCompetenceGoal(publicId),
      errorMessage: 'Fehler beim Löschen des Lernziels',
    );
    return pupilData!;
  }

  // - add a file to a competence goal
  Future<PupilData> addFileToCompetenceGoal(
    String publicId,
    File file,
    String createdBy,
  ) async {
    final path = await ClientFileUpload.uploadFile(
      file: file,
      storageId: StorageId.private,
      folder: ServerStorageFolder.documents,
    );
    final result = await ClientHelper.apiCall(
      call: () => _client.competenceGoal.addFileToCompetenceGoal(
        publicId,
        path.path!,
        createdBy,
      ),
      errorMessage: 'Fehler beim Hinzufügen der Datei zum Lernziel',
    );
    return result!;
  }

  // - remove a file from a competence goal
  Future<PupilData> removeFileFromCompetenceGoal(
    String publicId,
    String documentId,
  ) async {
    final result = await ClientHelper.apiCall(
      call: () => _client.competenceGoal.removeFileFromCompetenceGoal(
        publicId,
        documentId,
      ),
      errorMessage: 'Fehler beim Entfernen der Datei vom Lernziel',
    );
    return result!;
  }
}
