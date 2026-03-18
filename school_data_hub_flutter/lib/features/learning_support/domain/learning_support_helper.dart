import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/pupil_proxy_learning_support_ext.dart';

class LearningSupportHelper {
  static HubSessionManager get _sessionManager => di<HubSessionManager>();
  //- overview numbers functions
  static int developmentPlan1Pupils(List<PupilProxy> filteredPupils) {
    List<PupilProxy> developmentPlan1Pupils = [];
    if (filteredPupils.isNotEmpty) {
      for (PupilProxy pupil in filteredPupils) {
        if (pupil.latestSupportLevel != null) {
          if (pupil.latestSupportLevel!.level == 1) {
            developmentPlan1Pupils.add(pupil);
          }
        }
      }
      return developmentPlan1Pupils.length;
    }
    return 0;
  }

  static int developmentPlan2Pupils(List<PupilProxy> filteredPupils) {
    List<PupilProxy> developmentPlan1Pupils = [];
    if (filteredPupils.isNotEmpty) {
      for (PupilProxy pupil in filteredPupils) {
        if (pupil.latestSupportLevel != null) {
          if (pupil.latestSupportLevel!.level == 2) {
            developmentPlan1Pupils.add(pupil);
          }
        }
      }
      return developmentPlan1Pupils.length;
    }
    return 0;
  }

  static int developmentPlan3Pupils(List<PupilProxy> filteredPupils) {
    List<PupilProxy> developmentPlan1Pupils = [];
    if (filteredPupils.isNotEmpty) {
      for (PupilProxy pupil in filteredPupils) {
        if (pupil.latestSupportLevel != null) {
          if (pupil.latestSupportLevel!.level == 3) {
            developmentPlan1Pupils.add(pupil);
          }
        }
      }
      return developmentPlan1Pupils.length;
    }
    return 0;
  }

  static String preschoolRevision(PreSchoolMedicalStatus? value) {
    if (value == null) {
      return 'nicht vorhanden';
    }
    switch (value) {
      case PreSchoolMedicalStatus.notAvailable:
        return 'nicht vorhanden';
      case PreSchoolMedicalStatus.ok:
        return 'unauffällig';
      case PreSchoolMedicalStatus.supportAreas:
        return 'Förderbedarf';
      case PreSchoolMedicalStatus.checkSpecialSupport:
        return 'AO-SF überprüfen';
    }
  }

  static List<SupportGoal> getGoalsForCategory(
    PupilProxy pupil,
    int categoryId,
  ) {
    final goals = <SupportGoal>[];
    for (final goal in pupil.supportGoals) {
      if (goal.supportCategoryId == categoryId) {
        goals.add(goal);
      }
    }
    return goals;
  }

  static bool isAuthorizedToChangeStatus(SupportCategoryStatus status) {
    if (_sessionManager.isAdmin == true ||
        status.createdBy == _sessionManager.signedInUser!.userName) {
      return true;
    }
    return false;
  }

  static Map<int, int> generateRootCategoryMap(
    List<SupportCategory> categories,
  ) {
    // Map for quick lookup of categories by their ID
    final Map<int, SupportCategory> categoryMap = {
      for (SupportCategory category in categories)
        category.categoryId: category,
    };

    // Cache to store root category results for efficiency
    final Map<int, int> rootCategoryCache = {};

    int findRootCategory(int categoryId) {
      // Check if result is already cached
      if (rootCategoryCache.containsKey(categoryId)) {
        return rootCategoryCache[categoryId]!;
      }

      final category = categoryMap[categoryId];
      if (category == null || category.parentCategory == null) {
        // Base case: If there's no parent, this is the root category
        rootCategoryCache[categoryId] = categoryId;
        return categoryId;
      }

      // Recursive case: Find the root of the parent category
      final rootId = findRootCategory(category.parentCategory!);
      rootCategoryCache[categoryId] = rootId; // Cache the result
      return rootId;
    }

    // Build the final map
    final Map<int, int> result = {};
    for (var category in categories) {
      result[category.categoryId] = findRootCategory(category.categoryId);
    }

    return result;
  }

  static Color getRootSupportCategoryColor(SupportCategory goalCategory) {
    if (goalCategory.name == 'Körper, Wahrnehmung, Motorik') {
      return AppColors.koerperWahrnehmungMotorikColor;
    } else if (goalCategory.name == 'Sozialkompetenz / Emotionalität') {
      return AppColors.sozialEmotionalColor;
    } else if (goalCategory.name == 'Mathematik') {
      return AppColors.mathematikColor;
    } else if (goalCategory.name == 'Lernen und Leisten') {
      return AppColors.lernenLeistenColor;
    } else if (goalCategory.name == 'Deutsch') {
      return AppColors.deutschColor;
    } else if (goalCategory.name == 'Sprache und Sprechen') {
      return AppColors.spracheSprechenColor;
    }
    return Colors.deepPurple;
  }

  static String getRootSupportCategoryIcon(SupportCategory goalCategory) {
    if (goalCategory.name == 'Körper, Wahrnehmung, Motorik') {
      return 'assets/images/support_categories_icons/support_category_sensorik_motorik.png';
    } else if (goalCategory.name == 'Sozialkompetenz / Emotionalität') {
      return 'assets/images/support_categories_icons/support_category_emotional_sozial.png';
    } else if (goalCategory.name == 'Mathematik') {
      return 'assets/images/support_categories_icons/support_category_mathe.png';
    } else if (goalCategory.name == 'Lernen und Leisten') {
      return 'assets/images/support_categories_icons/support_category_lernen_leisten.png';
    } else if (goalCategory.name == 'Deutsch') {
      return 'assets/images/support_categories_icons/support_category_german.png';
    } else if (goalCategory.name == 'Sprache und Sprechen') {
      return 'assets/images/support_categories_icons/support_category_sprache_sprechen.png';
    }
    return 'assets/images/support_categories_icons/default.png';
  }
}
