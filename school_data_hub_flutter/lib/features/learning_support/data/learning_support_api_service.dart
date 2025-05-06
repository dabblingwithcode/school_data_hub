import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();

final _notificationService = di<NotificationService>();

class LearningSupportApiService {
  //- SUPPORT CATEGORIES --------------------------------------------------

  //- fetch goal categories

  Future<List<SupportCategory>> fetchSupportCategories() async {
    final response = await ClientHelper.apiCall(
      call: () => _client.supportCategory.fetchSupportCategories(),
      errorMessage: 'Fehler beim Laden der Kategorien',
    );
    return response;
  }

  //- STATUSES ---------------------------------------------------------

  Future<SupportCategoryStatus> postSupportCategoryStatus(
      {required int pupilId,
      required int supportCategoryId,
      required int status,
      required String comment,
      required createdBy}) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.supportCategory.postCategoryStatus(
          pupilId, supportCategoryId, status, comment, createdBy),
      errorMessage: 'Fehler beim Posten des Status',
    );

    return response;
  }

  //- update category status

  Future<SupportCategoryStatus> updateCategoryStatus(
      int pupilId,
      int statusId,
      int? status,
      String? comment,
      String? createdBy,
      DateTime? createdAt) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.supportCategory.updateCategoryStatus(
          pupilId, statusId, status, comment, createdBy, createdAt),
      errorMessage: 'Fehler beim Aktualisieren des Status',
    );
    return response;
  }

  // Future deleteCategoryStatus(String statusId) async {
  //   _notificationService.apiRunning(true);

  //   final response = await _client.delete(
  //     '${_baseUrl()}${_deleteCategoryStatusUrl(statusId)}',
  //     options: _client.hubOptions,
  //   );

  //   if (response.statusCode != 200) {
  //     _notificationService.showSnackBar(
  //         NotificationType.error, 'Fehler beim Löschen des Status');

  //     _notificationService.apiRunning(false);

  //     throw ApiException(
  //         'Failed to delete category status', response.statusCode);
  //   }

  //   final PupilData pupil = PupilData.fromJson(response.data);

  //   _notificationService.apiRunning(false);

  //   return pupil;
  // }

  //- GOALS ------------------------------------------------------------

  //- post category goal

  // String _postGoalUrl(int pupilId) {
  //   return '/support_goals/$pupilId/new';
  // }

  // Future<PupilData> postNewCategoryGoal(
  //     {required int goalCategoryId,
  //     required int pupilId,
  //     required String description,
  //     required String strategies}) async {
  //   _notificationService.apiRunning(true);

  //   final data = jsonEncode({
  //     "support_category_id": goalCategoryId,
  //     "created_at": DateTime.now().formatForJson(),
  //     "achieved": 0,
  //     "achieved_at": null,
  //     "description": description,
  //     "strategies": strategies
  //   });

  //   final Response response = await _client.post(
  //     '${_baseUrl()}${_postGoalUrl(pupilId)}',
  //     data: data,
  //     options: _client.hubOptions,
  //   );

  //   if (response.statusCode != 200) {
  //     _notificationService.showSnackBar(
  //         NotificationType.error, 'Fehler beim Hinzufügen des Ziels');

  //     _notificationService.apiRunning(false);

  //     throw ApiException('Failed to post category goal', response.statusCode);
  //   }

  //   final PupilData pupil = PupilData.fromJson(response.data);

  //   _notificationService.apiRunning(false);

  //   return pupil;
  // }

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
