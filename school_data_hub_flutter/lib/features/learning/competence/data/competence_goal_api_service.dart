import 'dart:io';

import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';

class CompetenceGoalApiService {
  Client get _client => di<Client>();

  HubSessionManager get _hubSessionManager => di<HubSessionManager>();

  // - fetch all competence goals (for reconnect / bulk)
  Future<List<CompetenceGoal>?> fetchAllCompetenceGoals() async {
    return ClientHelper.apiCall(
      call: () => _client.competenceGoal.fetchAllCompetenceGoals(),
      errorMessage: 'Fehler beim Laden der Lernziele',
    );
  }

  // - fetch competence goals for a single pupil (lazy loading)
  Future<List<CompetenceGoal>?> fetchCompetenceGoalsForPupil(
    int pupilId,
  ) async {
    return ClientHelper.apiCall(
      call: () => _client.competenceGoal.fetchCompetenceGoalsForPupil(pupilId),
      errorMessage: 'Fehler beim Laden der Lernziele',
    );
  }

  // - post a competence goal
  Future<bool?> postCompetenceGoal({
    required int pupilId,
    required int competenceId,
    required String description,
    required List<String> strategies,
  }) async {
    return ClientHelper.apiCall(
      call: () => _client.competenceGoal.postCompetenceGoal(
        competenceId: competenceId,
        pupilId: pupilId,
        description: description,
        strategies: strategies,
        createdBy: _hubSessionManager.userName!,
      ),
    );
  }

  // - update a competence goal
  Future<bool?> updateCompetenceGoal({
    required String publicId,
    ({int? value})? score,
    ({DateTime? value})? achievedAt,
    ({String value})? description,
    ({List<String>? value})? strategies,
  }) async {
    return ClientHelper.apiCall(
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
  }

  // - delete a competence goal
  Future<bool?> deleteCompetenceGoal(String publicId) async {
    return ClientHelper.apiCall(
      call: () => _client.competenceGoal.deleteCompetenceGoal(publicId),
      errorMessage: 'Fehler beim Löschen des Lernziels',
    );
  }

  // - add a file to a competence goal
  Future<bool?> addFileToCompetenceGoal(
    String publicId,
    File file,
    String createdBy,
    String? fileInfo,
  ) async {
    final path = await ClientFileUpload.uploadFile(
      file: file,
      fileInfo: fileInfo,
      storageId: StorageId.private,
      folder: ServerStorageFolder.documents,
    );
    return ClientHelper.apiCall(
      call: () => _client.competenceGoal.addFileToCompetenceGoal(
        publicId,
        path.path!,
        createdBy,
      ),
      errorMessage: 'Fehler beim Hinzufügen der Datei zum Lernziel',
    );
  }

  // - remove a file from a competence goal
  Future<bool?> removeFileFromCompetenceGoal(
    String publicId,
    String documentId,
  ) async {
    return ClientHelper.apiCall(
      call: () => _client.competenceGoal.removeFileFromCompetenceGoal(
        publicId,
        documentId,
      ),
      errorMessage: 'Fehler beim Entfernen der Datei vom Lernziel',
    );
  }
}
