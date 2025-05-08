import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/data/learning_support_api_service.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();

final _envManager = di<EnvManager>();

final _serverpodSessionManager = di<ServerpodSessionManager>();

final _log = Logger('LearningSupportManager');

final _learningSupportApiService = LearningSupportApiService();

final _pupilManager = di<PupilManager>();

class LearningSupportManager with ChangeNotifier {
  final _supportCategories = ValueNotifier<List<SupportCategory>>([]);
  ValueListenable<List<SupportCategory>> get supportCategories =>
      _supportCategories;

  // to avoid complicated lookups later on, we create a map
  // with references for each category to its root category
  Map<int, int> _rootCategoriesMap = {};

  LearningSupportManager();

  Future<LearningSupportManager> init() async {
    await fetchSupportCategories();
    return this;
  }

  // - Getters
  //- these functions do not call the API
  SupportCategory getSupportCategory(int categoryId) {
    final SupportCategory goalCategory = supportCategories.value
        .firstWhere((element) => element.categoryId == categoryId);
    return goalCategory;
  }

  SupportCategory getRootSupportCategory(int categoryId) {
    final rootCategoryId = _rootCategoriesMap[categoryId];
    return getSupportCategory(rootCategoryId!);
  }

  int getRootSupportCategoryId(int categoryId) {
    return _rootCategoriesMap[categoryId]!;
  }

  Color getCategoryColor(int categoryId) {
    final rootCategory = getRootSupportCategory(categoryId);
    return LearningSupportHelper.getRootSupportCategoryColor(rootCategory);
  }

  List<SupportGoal> getGoalsForSupportCategory(int categoryId) {
    List<SupportGoal> goals = [];
    // TODO: implement this function
    // final List<PupilProxy> pupils = locator<PupilManager>().allPupils;
    // for (PupilProxy pupil in pupils) {
    //   for (SupportGoal goal in pupil.supportGoals!) {
    //     if (goal.supportCategoryId == categoryId) {
    //       goals.add(goal);
    //     }
    //   }
    // }
    return goals;
  }

  void clearData() {
    _supportCategories.value = [];
  }

  // - Repository calls

  Future<void> fetchSupportCategories() async {
    final List<SupportCategory> supportCategories =
        await _learningSupportApiService.fetchSupportCategories();

    if (supportCategories.isNotEmpty) {
      // let's sort the categories by their category id to make sure they are in the right order
      supportCategories.sort((a, b) => a.categoryId.compareTo(b.categoryId));

      _supportCategories.value = supportCategories;
      _envManager.setPopulatedEnvServerData(supportCategories: true);
      _rootCategoriesMap.clear();
      _rootCategoriesMap =
          LearningSupportHelper.generateRootCategoryMap(supportCategories);
      _notificationService.showSnackBar(NotificationType.success,
          '${supportCategories.length} Förderkategorien aktualisiert!');
    }
    _log.info('Fetched ${supportCategories.length} support categories');
    return;
  }

  Future<void> postSupportCategoryStatus({
    required int pupilId,
    required int supportCategoryId,
    required int status,
    required String comment,
  }) async {
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _learningSupportApiService.postSupportCategoryStatus(
        pupilId: pupilId,
        supportCategoryId: supportCategoryId,
        status: status,
        comment: comment,
        createdBy: _serverpodSessionManager.userName!,
      ),
    );
    _pupilManager.updatePupilProxyWithPupilData(updatedPupil);
    return;
  }

  Future<void> deleteSupportCategoryStatus(int pupilId, int statusId) async {
    final updatedPupil =
        await _learningSupportApiService.deleteSupportCategoryStatus(
      pupilId,
      statusId,
    );
    _pupilManager.updatePupilProxyWithPupilData(updatedPupil);
    return;
  }
  // Future<void> updateSupportCategoryStatusProperty({
  //   required PupilProxy pupil,
  //   required String statusId,
  //   String? state,
  //   String? comment,
  //   String? createdBy,
  //   String? createdAt,
  // }) async {
  //   final PupilData responsePupil =
  //       await _learningSupportApiService.updateCategoryStatusProperty(
  //           pupil, statusId, state, comment, createdBy, createdAt);

  //   locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

  //   _notificationService.showSnackBar(
  //       NotificationType.success, 'Status aktualisiert');

  //   return;
  // }

  // Future<void> deleteSupportCategoryStatus(String statusId) async {
  //   final PupilData responsePupil =
  //       await _learningSupportApiService.deleteCategoryStatus(statusId);

  //   _notificationService.showSnackBar(
  //       NotificationType.success, 'Status gelöscht');

  //   locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);
  //   return;
  // }

  // Future postNewSupportCategoryGoal(
  //     {required int goalCategoryId,
  //     required int pupilId,
  //     required String description,
  //     required String strategies}) async {
  //   final PupilData responsePupil =
  //       await _learningSupportApiService.postNewCategoryGoal(
  //           goalCategoryId: goalCategoryId,
  //           pupilId: pupilId,
  //           description: description,
  //           strategies: strategies);

  //   locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

  //   _notificationService.showSnackBar(
  //       NotificationType.success, 'Ziel hinzugefügt');

  //   return;
  // }

  // Future deleteGoal(String goalId) async {
  //   final PupilData responsePupil =
  //       await _learningSupportApiService.deleteGoal(goalId);

  //   locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

  //   _notificationService.showSnackBar(
  //       NotificationType.success, 'Ziel gelöscht');

  //   return;
  // }
}
