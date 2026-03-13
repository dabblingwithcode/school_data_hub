import 'dart:io';

import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';

class LearningSupportApiService {
  Client get _client => di<Client>();
  //- LEARNING SUPPORT PLANS ------------------------------------------

  Future<LearningSupportPlan?> postLearningSupportPlan(
    LearningSupportPlan plan,
  ) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.createLearningSupportPlan(plan),
      errorMessage: 'Fehler beim Erstellen des Förderplans',
    );
    return response;
  }

  Future<bool> updateLearningSupportPlan(LearningSupportPlan plan) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.updateLearningSupportPlan(plan),
      errorMessage: 'Fehler beim Aktualisieren des Förderplans',
    );
    return response ?? false;
  }

  //- SUPPORT CATEGORIES --------------------------------------------------

  //- CREATE

  Future<bool> createSupportCategory(SupportCategory category) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.supportCategory.createSupportCategory(category),
      errorMessage: 'Fehler beim Erstellen der Kategorie',
    );
    return response ?? false;
  }

  //- UPDATE

  Future<bool> updateSupportCategory(SupportCategory category) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.supportCategory.updateSupportCategory(category),
      errorMessage: 'Fehler beim Aktualisieren der Kategorie',
    );
    return response ?? false;
  }

  //- READ
  Future<List<SupportCategory>?> fetchSupportCategories() async {
    final response = await ClientHelper.apiCall(
      call: () => _client.supportCategory.fetchSupportCategories(),
      errorMessage: 'Fehler beim Laden der Kategorien',
    );
    return response;
  }

  //- DELETE
  Future<bool> deleteSupportCategory(SupportCategory category) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.supportCategory.deleteSupportCategory(category),
      errorMessage: 'Fehler beim Löschen der Kategorie',
    );
    return response ?? false;
  }

  //- STATUSES ---------------------------------------------------------

  Future<PupilData?> postSupportCategoryStatus({
    required int pupilId,
    required int supportCategoryId,
    required int learningSupportPlanId,
    required int status,
    required String? comment,
    required String createdBy,
  }) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.postSupportCategoryStatus(
        pupilId,
        supportCategoryId,
        learningSupportPlanId,
        status,
        comment,
        createdBy,
      ),
      errorMessage: 'Fehler beim Posten des Status',
    );

    return response;
  }

  //- update category status

  Future<SupportCategoryStatus?> updateCategoryStatus(
    int pupilId,
    int statusId,
    int? status,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
  ) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.updateCategoryStatus(
        pupilId,
        statusId,
        status,
        comment,
        createdBy,
        createdAt,
      ),
      errorMessage: 'Fehler beim Aktualisieren des Status',
    );
    return response;
  }

  Future<PupilData?> deleteSupportCategoryStatus(
    int pupilId,
    int statusId,
  ) async {
    final pupil = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.deleteSupportCategoryStatus(
        pupilId,
        statusId,
      ),
      errorMessage: 'Fehler beim Löschen des Status',
    );

    return pupil;
  }

  //- SUPPORT GOALS: FETCH ------------------------------------------------

  Future<List<SupportGoal>?> fetchAllSupportGoals() async {
    return ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.fetchAllSupportGoals(),
      errorMessage: 'Fehler beim Laden der Förderziele',
    );
  }

  Future<List<SupportGoal>?> fetchSupportGoalsForPupil(int pupilId) async {
    return ClientHelper.apiCall(
      call: () =>
          _client.learningSupportPlan.fetchSupportGoalsForPupil(pupilId),
      errorMessage: 'Fehler beim Laden der Förderziele',
    );
  }

  //- GOALS ------------------------------------------------------------

  //- post category goal

  Future<bool?> postNewCategoryGoal({
    required int supportCategoryId,
    required int pupilId,
    required String description,
    required String strategies,
    required String createdBy,
  }) async {
    return ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.postCategoryGoal(
        pupilId,
        supportCategoryId,
        description,
        strategies,
        createdBy,
      ),
    );
  }

  //- update category goal

  Future<bool?> updateCategoryGoal({
    required int pupilId,
    required int supportGoalId,
    String? description,
    String? strategies,
    int? supportCategoryId,
  }) async {
    return ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.updateCategoryGoal(
        pupilId,
        supportGoalId,
        description,
        strategies,
        supportCategoryId,
      ),
      errorMessage: 'Fehler beim Aktualisieren des Ziels',
    );
  }

  //- delete category goal

  Future<bool?> deleteCategoryGoal({
    required int pupilId,
    required int supportGoalId,
  }) async {
    return ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.deleteCategoryGoal(
        pupilId,
        supportGoalId,
      ),
      errorMessage: 'Fehler beim Löschen des Ziels',
    );
  }

  //- BULK IMPORT SUPPORT LEVELS ------------------------------------------

  Future<bool> bulkImportSupportLevels(
    List<SupportLevelLegacyDto> supportLevelData,
  ) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.pupil.bulkAddSupportLevels(supportLevelData),

      errorMessage: 'Fehler beim Importieren der Förderstufen',
    );
    return response ?? false;
  }

  /// Import support categories from a previously-uploaded JSON file.
  Future<List<SupportCategory>> importSupportCategoriesFromJsonFile(
    String filePath,
  ) async {
    return _client.adminCategories.importSupportCategoriesFromJsonFile(
      filePath,
    );
  }

  //- GOAL CHECKS ------------------------------------------------------------

  Future<bool?> postSupportGoalCheck({
    required int supportGoalId,
    required int score,
    required String comment,
    required String createdBy,
  }) async {
    return ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.postSupportGoalCheck(
        supportGoalId,
        score,
        comment,
        createdBy,
      ),
      errorMessage: 'Fehler beim Erstellen des Ziel-Checks',
    );
  }

  Future<bool?> updateSupportGoalCheck({
    required int supportGoalCheckId,
    int? score,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
  }) async {
    return ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.updateSupportGoalCheck(
        supportGoalCheckId,
        score,
        comment,
        createdBy,
        createdAt,
      ),
      errorMessage: 'Fehler beim Aktualisieren des Ziel-Checks',
    );
  }

  Future<bool?> deleteSupportGoalCheck({
    required int supportGoalId,
    required int supportGoalCheckId,
  }) async {
    return ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.deleteSupportGoalCheck(
        supportGoalId,
        supportGoalCheckId,
      ),
      errorMessage: 'Fehler beim Löschen des Ziel-Checks',
    );
  }

  //- GOAL CHECK DOCUMENTS ---------------------------------------------------

  Future<bool?> addFileToSupportGoalCheck({
    required int supportGoalId,
    required int supportGoalCheckId,
    required File file,
    required String createdBy,
    String? fileInfo,
  }) async {
    final path = await ClientFileUpload.uploadFile(
      file: file,
      fileInfo: fileInfo,
      storageId: StorageId.private,
      folder: ServerStorageFolder.documents,
    );
    return ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.addFileToSupportGoalCheck(
        supportGoalId,
        supportGoalCheckId,
        path.path!,
        createdBy,
      ),
      errorMessage: 'Fehler beim Hinzufügen der Datei zum Ziel-Check',
    );
  }

  Future<bool?> removeFileFromSupportGoalCheck({
    required int supportGoalId,
    required int supportGoalCheckId,
    required String documentId,
  }) async {
    return ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.removeFileFromSupportGoalCheck(
        supportGoalId,
        supportGoalCheckId,
        documentId,
      ),
      errorMessage: 'Fehler beim Entfernen der Datei vom Ziel-Check',
    );
  }
}
