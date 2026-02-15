import 'dart:io';

import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:flutter_it/flutter_it.dart';

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

  //- STATUSES ---------------------------------------------------------

  Future<PupilData?> postSupportCategoryStatus({
    required int pupilId,
    required int supportCategoryId,
    required int learningSupportPlanId,
    required int status,
    required String comment,
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

  //- GOALS ------------------------------------------------------------

  //- post category goal

  Future<PupilData?> postNewCategoryGoal({
    required int supportCategoryId,
    required int pupilId,
    required String description,
    required String strategies,
    required String createdBy,
  }) async {
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.postCategoryGoal(
        pupilId,
        supportCategoryId,
        description,
        strategies,
        createdBy,
      ),
    );

    return updatedPupil;
  }

  //- delete category goal

  Future<PupilData?> deleteCategoryGoal({
    required int pupilId,
    required int supportGoalId,
  }) async {
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.deleteCategoryGoal(
        pupilId,
        supportGoalId,
      ),
      errorMessage: 'Fehler beim Löschen des Ziels',
    );
    return updatedPupil;
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
    return _client.adminCategories.importSupportCategoriesFromJsonFile(filePath);
  }

  //- GOAL CHECKS ------------------------------------------------------------

  Future<SupportGoal?> postSupportGoalCheck({
    required int supportGoalId,
    required int score,
    required String comment,
    required String createdBy,
  }) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.postSupportGoalCheck(
        supportGoalId,
        score,
        comment,
        createdBy,
      ),
      errorMessage: 'Fehler beim Erstellen des Ziel-Checks',
    );
    return response;
  }

  Future<SupportGoalCheck?> updateSupportGoalCheck({
    required int supportGoalCheckId,
    int? score,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
  }) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.updateSupportGoalCheck(
        supportGoalCheckId,
        score,
        comment,
        createdBy,
        createdAt,
      ),
      errorMessage: 'Fehler beim Aktualisieren des Ziel-Checks',
    );
    return response;
  }

  Future<SupportGoal?> deleteSupportGoalCheck({
    required int supportGoalId,
    required int supportGoalCheckId,
  }) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.deleteSupportGoalCheck(
        supportGoalId,
        supportGoalCheckId,
      ),
      errorMessage: 'Fehler beim Löschen des Ziel-Checks',
    );
    return response;
  }

  //- GOAL CHECK DOCUMENTS ---------------------------------------------------

  Future<SupportGoal?> addFileToSupportGoalCheck({
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
    final result = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.addFileToSupportGoalCheck(
        supportGoalId,
        supportGoalCheckId,
        path.path!,
        createdBy,
      ),
      errorMessage: 'Fehler beim Hinzufügen der Datei zum Ziel-Check',
    );
    return result;
  }

  Future<SupportGoal?> removeFileFromSupportGoalCheck({
    required int supportGoalId,
    required int supportGoalCheckId,
    required String documentId,
  }) async {
    final result = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.removeFileFromSupportGoalCheck(
        supportGoalId,
        supportGoalCheckId,
        documentId,
      ),
      errorMessage: 'Fehler beim Entfernen der Datei vom Ziel-Check',
    );
    return result;
  }
}
