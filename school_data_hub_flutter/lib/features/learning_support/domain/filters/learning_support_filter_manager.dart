import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/filters/learning_support_filter_predicates.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/models/learning_support_enums.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

typedef SupportLevelFilterRecord = ({SupportLevelType filter, bool value});
typedef SupportAreaFilterRecord = ({SupportArea filter, bool value});
typedef CurrentLearningSupportPlanFilterRecord = ({
  CurrentLearningSupportPlan filter,
  bool value,
});

class LearningSupportFilterManager implements Resettable {
  FiltersStateManager get _filtersStateManager => di<FiltersStateManager>();
  PupilsFilter get _pupilsFilter => di<PupilsFilter>();
  SupportCategoryManager get _learningSupportManager =>
      di<SupportCategoryManager>();
  final _supportLevelFilterState = ValueNotifier<Map<SupportLevelType, bool>>(
    initialSupportLevelFilterValues,
  );
  ValueListenable<Map<SupportLevelType, bool>> get supportLevelFilterState =>
      _supportLevelFilterState;

  final _supportAreaFiltersState = ValueNotifier<Map<SupportArea, bool>>(
    initialSupportAreaFilterValues,
  );

  ValueListenable<Map<CurrentLearningSupportPlan, bool>>
  get currentLearningSupportFilterState =>
      _currentLearningSupportPlanFilterState;

  final _currentLearningSupportPlanFilterState =
      ValueNotifier<Map<CurrentLearningSupportPlan, bool>>(
        initialCurrentLearningSupportPlanFilterValues,
      );
  bool get currentLearningSupportPlanFiltersActive =>
      _currentLearningSupportPlanFilterState.value.containsValue(true);

  ValueListenable<Map<SupportArea, bool>> get supportAreaFilterState =>
      _supportAreaFiltersState;
  bool get supportLevelFiltersActive =>
      _supportLevelFilterState.value.containsValue(true);

  bool get supportAreaFiltersActive =>
      _supportAreaFiltersState.value.containsValue(true);
  LearningSupportFilterManager();

  void dispose() {
    _supportLevelFilterState.dispose();
    _supportAreaFiltersState.dispose();
    _currentLearningSupportPlanFilterState.dispose();
    return;
  }

  void setSupportLevelFilter({
    required List<SupportLevelFilterRecord> supportLevelFilterRecords,
  }) {
    for (final record in supportLevelFilterRecords) {
      _supportLevelFilterState.value = {
        ..._supportLevelFilterState.value,
        record.filter: record.value,
      };
    }
    final bool supportLevelFilterStateEqualsInitialState =
        const MapEquality<SupportLevelType, bool>().equals(
          supportLevelFilterState.value,
          initialSupportLevelFilterValues,
        );

    if (supportLevelFilterStateEqualsInitialState) {
      _filtersStateManager.setFilterState(
        filterState: FilterState.learningSupport,
        value: false,
      );
    } else {
      _filtersStateManager.setFilterState(
        filterState: FilterState.learningSupport,
        value: true,
      );
    }
    _pupilsFilter.refresh();
  }

  /// We pass a list of [SupportAreaFilterRecord] to this function
  /// because we want to be able to set multiple filters at once
  /// in the case of filters that are mutually exclusive
  void setSupportAreaFilter({
    required List<SupportAreaFilterRecord> supportAreaFilterRecords,
  }) {
    for (final record in supportAreaFilterRecords) {
      _supportAreaFiltersState.value = {
        ..._supportAreaFiltersState.value,
        record.filter: record.value,
      };
    }
    final bool supportAreaFilterStateEqualsInitialState =
        const MapEquality<SupportArea, bool>().equals(
          _supportAreaFiltersState.value,
          initialSupportAreaFilterValues,
        );

    if (supportAreaFilterStateEqualsInitialState) {
      _filtersStateManager.setFilterState(
        filterState: FilterState.learningSupport,
        value: false,
      );
    } else {
      _filtersStateManager.setFilterState(
        filterState: FilterState.learningSupport,
        value: true,
      );
    }

    _pupilsFilter.refresh();
  }

  void setCurrentLearningSupportPlanFilter({
    required List<CurrentLearningSupportPlanFilterRecord>
    currentLearningSupportPlanFilterRecords,
  }) {
    for (final record in currentLearningSupportPlanFilterRecords) {
      _currentLearningSupportPlanFilterState.value = {
        ..._currentLearningSupportPlanFilterState.value,
        record.filter: record.value,
      };
    }
    final bool currentLearningSupportPlanFilterStateEqualsInitialState =
        const MapEquality<CurrentLearningSupportPlan, bool>().equals(
          _currentLearningSupportPlanFilterState.value,
          initialCurrentLearningSupportPlanFilterValues,
        );

    if (currentLearningSupportPlanFilterStateEqualsInitialState) {
      _filtersStateManager.setFilterState(
        filterState: FilterState.learningSupport,
        value: false,
      );
    } else {
      _filtersStateManager.setFilterState(
        filterState: FilterState.learningSupport,
        value: true,
      );
    }

    _pupilsFilter.refresh();
  }

  @override
  void resetFilters() {
    _supportLevelFilterState.value = {...initialSupportLevelFilterValues};
    _supportAreaFiltersState.value = {...initialSupportAreaFilterValues};
    _currentLearningSupportPlanFilterState.value = {
      ...initialCurrentLearningSupportPlanFilterValues,
    };
  }

  bool matchSupportLevelFilters(PupilProxy pupil) {
    final activeFilters = _supportLevelFilterState.value;
    final supportLevel = pupil.latestSupportLevel?.level;

    // Complementary group: levels 1-4
    if (!LearningSupportFilterPredicates.matchesSupportLevelGroup(
      supportLevel,
      activeFilters,
    )) {
      return false;
    }

    // Exclusion filters: specialNeeds, migrationSupport
    if (!LearningSupportFilterPredicates.matchesSpecialNeeds(
      pupil.specialNeeds,
      activeFilters[SupportLevelType.specialNeeds]!,
    )) {
      return false;
    }
    if (!LearningSupportFilterPredicates.matchesMigrationSupport(
      pupil.migrationSupportEnds,
      activeFilters[SupportLevelType.migrationSupport]!,
    )) {
      return false;
    }

    return true;
  }

  bool matchSupportAreaFilters(PupilProxy pupil) {
    return LearningSupportFilterPredicates.matchesSupportAreaGroup(
      pupil.supportCategoryStatuses,
      _supportAreaFiltersState.value,
      (categoryId) =>
          _learningSupportManager
              .getRootSupportCategory(categoryId)
              .categoryId,
    );
  }

  bool matchCurrentLearningSupportPlanFilters(PupilProxy pupil) {
    final needsPlan = pupil.latestSupportLevel != null;
    final hasPlan = needsPlan &&
        pupil.learningSupportPlans != null &&
        pupil.learningSupportPlans!.any(
          (p) =>
              p.schoolSemester != null &&
              p.schoolSemester!.id ==
                  di<SchoolCalendarManager>().currentSemester.value!.id,
        );

    return LearningSupportFilterPredicates.matchesCurrentPlanGroup(
      needsPlan: needsPlan,
      hasPlan: hasPlan,
      activeFilters: _currentLearningSupportPlanFilterState.value,
    );
  }
}
