import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/models/learning_support_enums.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_helper.dart';
import 'package:watch_it/watch_it.dart';

typedef SupportLevelFilterRecord = ({SupportLevelType filter, bool value});
typedef SupportAreaFilterRecord = ({SupportArea filter, bool value});

class LearningSupportFilterManager {
  FiltersStateManager get _filtersStateManager => di<FiltersStateManager>();
  PupilFilterManager get _pupilFilterManager => di<PupilFilterManager>();
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
    final bool supportLevelFilterStateEqualsInitialState = const MapEquality()
        .equals(supportLevelFilterState.value, initialSupportLevelFilterValues);

    if (supportLevelFilterStateEqualsInitialState) {
      _filtersStateManager.setFilterState(
        filterState: FilterState.pupilLegacy,
        value: false,
      );
    } else {
      _filtersStateManager.setFilterState(
        filterState: FilterState.pupilLegacy,
        value: true,
      );
    }
    _pupilsFilter.refreshs();
  }

  // We pass a list of [SupportAreaFilterRecord] to this function
  // because we want to be able to set multiple filters at once
  // in the case of filters that are mutually exclusive
  void setSupportAreaFilter({
    required List<SupportAreaFilterRecord> supportAreaFilterRecords,
  }) {
    for (final record in supportAreaFilterRecords) {
      _supportAreaFiltersState.value = {
        ..._supportAreaFiltersState.value,
        record.filter: record.value,
      };
    }
    final bool pupilFilterStateEqualsInitialState = const MapEquality().equals(
      _pupilFilterManager.pupilFilterState.value,
      initialPupilFilterValues,
    );

    if (pupilFilterStateEqualsInitialState) {
      _filtersStateManager.setFilterState(
        filterState: FilterState.pupilLegacy,
        value: false,
      );
    } else {
      _filtersStateManager.setFilterState(
        filterState: FilterState.pupilLegacy,
        value: true,
      );
    }

    _pupilsFilter.refreshs();
  }

  void resetFilters() {
    _supportLevelFilterState.value = {...initialSupportLevelFilterValues};
    _supportAreaFiltersState.value = {...initialSupportAreaFilterValues};
  }

  bool matchSupportLevelFilters(PupilProxy pupil) {
    final activeFilters = _supportLevelFilterState.value;

    final latestSupportLevel = pupil.latestSupportLevel;

    final supportLevel = latestSupportLevel?.level;

    bool isMatched = true;

    bool complementaryFilter = false;

    //- these are complementary filters
    //- they should persist if one of them is active

    // Filter support level 1

    if (activeFilters[SupportLevelType.supportLevel1]! && supportLevel != 1) {
      isMatched = false;
    } else if (activeFilters[SupportLevelType.supportLevel1]! &&
        supportLevel == 1) {
      complementaryFilter = true;
    }

    // Filter support level 2

    if (!complementaryFilter &&
        activeFilters[SupportLevelType.supportLevel2]! &&
        supportLevel != 2) {
      isMatched = false;
    } else if (!complementaryFilter &&
        activeFilters[SupportLevelType.supportLevel2]! &&
        supportLevel == 2) {
      isMatched = true;
      complementaryFilter = true;
    }

    // Filter support level 3

    if (!complementaryFilter &&
        activeFilters[SupportLevelType.supportLevel3]! &&
        supportLevel != 3) {
      isMatched = false;
    } else if (!complementaryFilter &&
        activeFilters[SupportLevelType.supportLevel3]! &&
        supportLevel == 3) {
      isMatched = true;
      complementaryFilter = true;
    }
    // Filter support level 4
    if (!complementaryFilter &&
        activeFilters[SupportLevelType.supportLevel4]! &&
        supportLevel != 4) {
      isMatched = false;
    } else if (!complementaryFilter &&
        activeFilters[SupportLevelType.supportLevel4]! &&
        supportLevel == 4) {
      isMatched = true;
      complementaryFilter = true;
    }

    //- These filters exclude pupil that not match
    //- regardless of the other filters

    if (isMatched == true) {
      if (activeFilters[SupportLevelType.specialNeeds]! &&
          pupil.specialNeeds == null) {
        isMatched = false;
      } else if (activeFilters[SupportLevelType.specialNeeds]! &&
          pupil.specialNeeds != null) {
        isMatched = true;
      }

      if (activeFilters[SupportLevelType.migrationSupport]! &&
          PupilProxyHelper.hasLanguageSupport(pupil.migrationSupportEnds) !=
              true) {
        isMatched = false;
      } else if (activeFilters[SupportLevelType.migrationSupport]! &&
          PupilProxyHelper.hasLanguageSupport(pupil.migrationSupportEnds) ==
              true) {
        isMatched = true;
        complementaryFilter = true;
      }
    }

    return isMatched;
  }

  bool matchSupportAreaFilters(PupilProxy pupil) {
    final Map<SupportArea, bool> activeFilters = _supportAreaFiltersState.value;

    // motorics filter

    if (pupil.supportCategoryStatuses != null) {
      if (activeFilters[SupportArea.motorics]! &&
          pupil.supportCategoryStatuses!.any(
            (element) =>
                _learningSupportManager
                    .getRootSupportCategory(element.supportCategoryId)
                    .categoryId ==
                SupportArea.motorics.value,
          )) {
        return true;
      }

      // emotions filter

      if (activeFilters[SupportArea.emotions]! &&
          pupil.supportCategoryStatuses!.any(
            (element) =>
                _learningSupportManager
                    .getRootSupportCategory(element.supportCategoryId)
                    .categoryId ==
                SupportArea.emotions.value,
          )) {
        return true;
      }

      // math filter

      if (activeFilters[SupportArea.math] == true &&
          pupil.supportCategoryStatuses!.any(
            (element) =>
                _learningSupportManager
                    .getRootSupportCategory(element.supportCategoryId)
                    .categoryId ==
                SupportArea.math.value,
          )) {
        return true;
      }

      // learning filter

      if (activeFilters[SupportArea.learning] == true &&
          pupil.supportCategoryStatuses!.any(
            (element) =>
                _learningSupportManager
                    .getRootSupportCategory(element.supportCategoryId)
                    .categoryId ==
                SupportArea.learning.value,
          )) {
        return true;
      }

      // German language filter

      if (activeFilters[SupportArea.german] == true &&
          pupil.supportCategoryStatuses!.any(
            (element) =>
                _learningSupportManager
                    .getRootSupportCategory(element.supportCategoryId)
                    .categoryId ==
                SupportArea.german.value,
          )) {
        return true;
      }

      // Language filter

      if (activeFilters[SupportArea.language] == true &&
          pupil.supportCategoryStatuses!.any(
            (element) =>
                _learningSupportManager
                    .getRootSupportCategory(element.supportCategoryId)
                    .categoryId ==
                SupportArea.language.value,
          )) {
        return true;
      }
    }
    return false;
  }
}
