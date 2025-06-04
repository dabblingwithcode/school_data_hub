import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();

class LearningSupportApiService {
  //- SUPPORT CATEGORIES --------------------------------------------------

  //- fetch goal categories

  Future<List<SupportCategory>?> fetchSupportCategories() async {
    final response = await ClientHelper.apiCall(
      call: () => _client.supportCategory.fetchSupportCategories(),
      errorMessage: 'Fehler beim Laden der Kategorien',
    );
    return response;
  }

  //- STATUSES ---------------------------------------------------------

  Future<PupilData?> postSupportCategoryStatus(
      {required int pupilId,
      required int supportCategoryId,
      required int learningSupportPlanId,
      required int status,
      required String comment,
      required String createdBy}) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.postSupportCategoryStatus(pupilId,
          supportCategoryId, learningSupportPlanId, status, comment, createdBy),
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
      DateTime? createdAt) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.updateCategoryStatus(
          pupilId, statusId, status, comment, createdBy, createdAt),
      errorMessage: 'Fehler beim Aktualisieren des Status',
    );
    return response;
  }

  Future<PupilData?> deleteSupportCategoryStatus(
      int pupilId, int statusId) async {
    final pupil = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan
          .deleteSupportCategoryStatus(pupilId, statusId),
      errorMessage: 'Fehler beim Löschen des Status',
    );

    return pupil;
  }

  //- GOALS ------------------------------------------------------------

  //- post category goal

  Future<PupilData?> postNewCategoryGoal(
      {required int supportCategoryId,
      required int pupilId,
      required String description,
      required String strategies,
      required String createdBy}) async {
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _client.learningSupportPlan.postCategoryGoal(
          pupilId, supportCategoryId, description, strategies, createdBy),
    );

    return updatedPupil;
  }

  //- delete category goal

  // String _deleteGoalUrl(String goalId) {
  //   return '/support_goals/$goalId/delete';
  // }

  // Future deleteGoal(String goalId) async {
  //   _notificationService.apiRunning(true);

  //   final Response response = await _client.delete(
  //     '${_baseUrl()}${_deleteGoalUrl(goalId)}',
  //     options: _client.hubOptions,
  //   );

  //   if (response.statusCode != 200) {
  //     _notificationService.showSnackBar(
  //         NotificationType.error, 'Fehler beim Löschen des Ziels');

  //     _notificationService.apiRunning(false);

  //     throw ApiException('Failed to delete category goal', response.statusCode);
  //   }

  //   final PupilData pupil = PupilData.fromJson(response.data);

  //   _notificationService.apiRunning(false);

  //   return pupil;
  // }

  //- NOT IMPLEMENTED ------------------------------------------------------

  // Future<SupportGoalCheck> postGoalCheck(int goalId) async {
  //   _notificationService.apiRunning(true);

  //   final Response response = await _client.post(
  //     '${_baseUrl()}${_postGoalCheck(goalId)}',
  //     data: data,
  //     options: _client.hubOptions,
  //   );
  // }
}
