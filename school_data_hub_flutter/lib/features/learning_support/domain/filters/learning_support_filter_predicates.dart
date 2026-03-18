import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/models/learning_support_enums.dart';

/// Pure predicate functions for learning support filtering.
/// No dependency on get_it or manager; easy to unit test.
class LearningSupportFilterPredicates {
  LearningSupportFilterPredicates._();

  static const _levelFilters = [
    SupportLevelType.supportLevel1,
    SupportLevelType.supportLevel2,
    SupportLevelType.supportLevel3,
    SupportLevelType.supportLevel4,
  ];

  static const _levelByFilter = {
    SupportLevelType.supportLevel1: 1,
    SupportLevelType.supportLevel2: 2,
    SupportLevelType.supportLevel3: 3,
    SupportLevelType.supportLevel4: 4,
  };

  /// Complementary group: if any level filter is active, pupil must match
  /// at least one. If none active, all pass.
  static bool matchesSupportLevelGroup(
    int? supportLevel,
    Map<SupportLevelType, bool> activeFilters,
  ) {
    bool anyActive = false;
    bool anyMatched = false;
    for (final filter in _levelFilters) {
      if (activeFilters[filter]!) {
        anyActive = true;
        if (supportLevel == _levelByFilter[filter]) {
          anyMatched = true;
        }
      }
    }
    return !anyActive || anyMatched;
  }

  /// Exclusion: if specialNeeds filter is on AND pupil has no special needs,
  /// exclude.
  static bool matchesSpecialNeeds(
    List<String>? specialNeeds,
    bool filterOn,
  ) {
    if (!filterOn) return true;
    return specialNeeds != null;
  }

  /// Exclusion: if migrationSupport filter is on AND pupil has no active
  /// language support, exclude.
  static bool matchesMigrationSupport(
    DateTime? migrationSupportEnds,
    bool filterOn,
  ) {
    if (!filterOn) return true;
    return PupilProxyHelper.hasLanguageSupport(migrationSupportEnds) == true;
  }

  /// Complementary group: if any area filter is active, pupil must have a
  /// support category status in at least one matching root category.
  /// [getRootCategoryId] resolves a category ID to its root category ID.
  static bool matchesSupportAreaGroup(
    List<SupportCategoryStatus>? statuses,
    Map<SupportArea, bool> activeFilters,
    int Function(int categoryId) getRootCategoryId,
  ) {
    if (statuses == null) return false;
    bool anyActive = false;
    bool anyMatched = false;
    for (final area in SupportArea.values) {
      if (activeFilters[area] != true) continue;
      anyActive = true;
      if (statuses.any(
        (s) => getRootCategoryId(s.supportCategoryId) == area.value,
      )) {
        anyMatched = true;
      }
    }
    return !anyActive || anyMatched;
  }

  /// Complementary group: if any plan availability filter is active, pupil
  /// must match at least one.
  static bool matchesCurrentPlanGroup({
    required bool needsPlan,
    required bool hasPlan,
    required Map<CurrentLearningSupportPlan, bool> activeFilters,
  }) {
    bool anyActive = false;
    bool anyMatched = false;
    if (activeFilters[CurrentLearningSupportPlan.available]!) {
      anyActive = true;
      if (hasPlan) anyMatched = true;
    }
    if (activeFilters[CurrentLearningSupportPlan.notAvailable]!) {
      anyActive = true;
      if (!hasPlan && needsPlan) anyMatched = true;
    }
    return !anyActive || anyMatched;
  }
}
