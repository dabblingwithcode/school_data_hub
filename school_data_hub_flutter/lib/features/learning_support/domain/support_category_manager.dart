import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/data/learning_support_api_service.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();

final _envManager = di<EnvManager>();

final _log = Logger('LearningSupportManager');

final _learningSupportApiService = LearningSupportApiService();

final _pupilManager = di<PupilManager>();

class SupportCategoryManager with ChangeNotifier {
  final _supportCategories = ValueNotifier<List<SupportCategory>>([]);
  ValueListenable<List<SupportCategory>> get supportCategories =>
      _supportCategories;

  // to avoid complicated lookups later on, we create a map
  // with references for each category to its root category
  Map<int, int> _rootCategoriesMap = {};

  SupportCategoryManager();

  Future<SupportCategoryManager> init() async {
    await fetchSupportCategories();
    return this;
  }

  // - Getters

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

    final List<PupilProxy> pupils = _pupilManager.allPupils;
    for (PupilProxy pupil in pupils) {
      for (SupportGoal goal in pupil.supportGoals!) {
        if (goal.supportCategoryId == categoryId) {
          goals.add(goal);
        }
      }
    }
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

      _supportCategories.notifyListeners();

      _notificationService.showSnackBar(NotificationType.success,
          '${supportCategories.length} Förderkategorien aktualisiert!');
    }
    _log.info('Fetched ${supportCategories.length} support categories');
    return;
  }
}
