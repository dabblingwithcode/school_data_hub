import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_selector_filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_text_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_helper_functions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class PupilsFilterImplementation with ChangeNotifier implements PupilsFilter {
  PupilsFilterImplementation(
    PupilManager pupilsManager,
    //   {
    //  PupilSortMode? sortMode,
    // }
  ) : _pupilsManager = pupilsManager {
    log('PupilsFilterImplementation created');
    // We need to populate the group filters with the available groups
    final availableGroups = di<PupilIdentityManager>().groups.value;
    populateGroupFilters(availableGroups.toList());
    refreshs();
    _pupilsManager.addListener(refreshs);
  }

  @override
  void dispose() {
    _pupilsManager.removeListener(refreshs);
    _filteredPupils.dispose();

    super.dispose();
  }

  @override
  void clearFilteredPupils() {
    _filteredPupils.value = [];
    _filteredPupilIds.value = [];
    notifyListeners();
  }

  final PupilManager _pupilsManager;

  @override
  ValueListenable<List<PupilProxy>> get filteredPupils => _filteredPupils;
  final ValueNotifier<List<PupilProxy>> _filteredPupils = ValueNotifier([]);

  @override
  ValueListenable<List<int>> get filteredPupilIds => _filteredPupilIds;
  final ValueNotifier<List<int>> _filteredPupilIds = ValueNotifier([]);

  @override
  List<Filter> get groupFilters => _groupFilters;
  final List<Filter> _groupFilters = [];

  @override
  ValueListenable<PupilSortMode> get sortMode => _sortMode;
  final _sortMode = ValueNotifier<PupilSortMode>(PupilSortMode.sortByName);
  @override
  PupilTextFilter get textFilter => _textFilter;
  final PupilTextFilter _textFilter = PupilTextFilter(name: 'Text Filter');

  late List<Filter> allFilters = [
    ...schoolGradeFilters,
    ..._groupFilters,
    ...genderFilters,
    _textFilter,
  ];

  // reset the filters to its initial state
  @override
  void resetFilters() {
    // first reset all implemented filter objects

    for (final filter in allFilters) {
      filter.reset();
    }

    // reset the text filter
    _textFilter.reset();

    // reset the filtered pupils to all pupils

    _filteredPupils.value = _pupilsManager.allPupils;
    _filteredPupilIds.value =
        _pupilsManager.allPupils.map((e) => e.internalId).toList();

    sortPupils();
    di<FiltersStateManager>()
        .setFilterState(filterState: FilterState.pupil, value: false);
  }

  // updates the filtered pupils with current filters
  // and sort mode
  @override
  void refreshs() {
    final allPupils = _pupilsManager.allPupils;

    bool filtersOn = false;

    // checks if any not yet migrated filters are active

    final bool specificFiltersOn = di<PupilFilterManager>()
            .pupilFilterState
            .value
            .values
            .any((x) => x == true) ||
        // TODO: Uncomment when implemented
        // di<SchooldayEventFilterManager>()
        //     .schooldayEventsFilterState
        //     .value
        //     .values
        //     .any((x) => x == true) ||
        // di<LearningSupportFilterManager>()
        //     .supportLevelFilterState
        //     .value
        //     .values
        //     .any((x) => x == true) ||
        // di<LearningSupportFilterManager>()
        //     .supportAreaFilterState
        //     .value
        //     .values
        //     .any((x) => x == true) ||
        di<FiltersStateManager>().getFilterState(FilterState.attendance);

    // If no filters are active, just sort

    if (!allFilters.any((x) => x.isActive == true) &&
        specificFiltersOn == false) {
      _filteredPupils.value = allPupils;
      _filteredPupilIds.value = allPupils.map((e) => e.internalId).toList();

      sortPupils();
      return;
    }

    List<PupilProxy> thisFilteredPupils = [];

    bool isAnyGroupFilterActive = groupFilters.any((filter) => filter.isActive);

    bool isAnySchoolGradeFilterActive =
        schoolGradeFilters.any((filter) => filter.isActive);

    bool isAnyGenderFilterActive =
        genderFilters.any((filter) => filter.isActive);

    bool isTextFilterActive = _textFilter.isActive;

    for (final pupil in allPupils) {
      // matches if no group filter is active or if the group matches the pupil's group

      bool isMatchedByGroupFilter = !isAnyGroupFilterActive ||
          groupFilters
              .any((filter) => filter.isActive && filter.matches(pupil));
      if (!isMatchedByGroupFilter) {
        filtersOn = true;
        continue;
      }
      // matches if no school grade filter is active or if the school grade matches the pupil's stufe

      bool isMatchedBySchoolGradeFilter = !isAnySchoolGradeFilterActive ||
          schoolGradeFilters
              .any((filter) => filter.isActive && filter.matches(pupil));

      // if the pupil is not matched by any group or school grade filter, skip the pupil

      if (!isMatchedBySchoolGradeFilter) {
        filtersOn = true;
        continue;
      }

      bool isMatchedByGenderFilter = !isAnyGenderFilterActive ||
          genderFilters
              .any((filter) => filter.isActive && filter.matches(pupil));

      if (!isMatchedByGenderFilter) {
        filtersOn = true;
        continue;
      }
      // if the pupil is not matched by the text filter, skip the pupil

      if (_textFilter.isActive && !_textFilter.matches(pupil)) {
        filtersOn = true;
        continue;
      }

      // if attendance filters are on, pass the pupil through the attendance filters

      if (di<FiltersStateManager>().getFilterState(FilterState.attendance)) {
        // TODO: uncomment when implemented
        // if (!di<AttendancePupilFilterManager>()
        //     .isMatchedByAttendanceFilters(pupil)) {
        //   filtersOn = true;
        //   continue;
        // }
      }

      // OGS filters

      if (di<PupilFilterManager>().pupilFilterState.value[PupilFilter.ogs]! &&
              !pupil.ogs ||
          di<PupilFilterManager>()
                  .pupilFilterState
                  .value[PupilFilter.notOgs]! &&
              pupil.ogs) {
        filtersOn = true;
        continue;
      }

      // support level filters

      //- TODO: Uncomment when implemented
      // if (di<LearningSupportFilterManager>().supportLevelFiltersActive) {
      //   if (!di<LearningSupportFilterManager>().supportLevelFilters(pupil)) {
      //     filtersOn = true;
      //     continue;
      //   }
      // }

      // if (di<LearningSupportFilterManager>().supportAreaFiltersActive) {
      //   if (!di<LearningSupportFilterManager>().supportAreaFilters(pupil)) {
      //     filtersOn = true;
      //     continue;
      //   }
      // }

      // language support filters

      if (di<PupilFilterManager>()
              .pupilFilterState
              .value[PupilFilter.migrationSupport]! &&
          !PupilHelper.hasLanguageSupport(pupil.migrationSupportEnds)) {
        filtersOn = true;
        continue;
      }
      thisFilteredPupils.add(pupil);
    }

    _filteredPupils.value = thisFilteredPupils;
    _filteredPupilIds.value =
        thisFilteredPupils.map((e) => e.internalId).toList();
    if (filtersOn) {
      //- TODO: Do we need this if we already use FiltersStateManager?
      di<FiltersStateManager>()
          .setFilterState(filterState: FilterState.pupil, value: true);
    }
    sortPupils();
  }

  // Set modified filter value
  @override
  void setSortMode(PupilSortMode sortMode) {
    _sortMode.value = sortMode;
    refreshs();
    notifyListeners();
  }

  @override
  void sortPupils() {
    PupilSortMode sortMode = _sortMode.value;
    List<PupilProxy> thisFilteredPupils = _filteredPupils.value;
    //TODO: Uncomment when implemented
    // switch (sortMode) {
    //   case PupilSortMode.sortByName:
    //     thisFilteredPupils.sort((a, b) => a.firstName.compareTo(b.firstName));

    //   case PupilSortMode.sortByCredit:
    //     thisFilteredPupils.sort((b, a) => a.credit.compareTo(b.credit));

    //   case PupilSortMode.sortByCreditEarned:
    //     thisFilteredPupils
    //         .sort((b, a) => a.creditEarned.compareTo(b.creditEarned));

    // TODO: Uncomment when implemented
    //   case PupilSortMode.sortBySchooldayEvents:
    //     thisFilteredPupils.sort((a, b) =>
    //         SchoolDayEventHelper.schooldayEventSum(b)
    //             .compareTo(SchoolDayEventHelper.schooldayEventSum(a)));

    //   case PupilSortMode.sortByLastSchooldayEvent:
    //     thisFilteredPupils.sort((a, b) =>
    //         SchoolDayEventHelper.getPupilLastSchooldayEventDate(b).compareTo(
    //             SchoolDayEventHelper.getPupilLastSchooldayEventDate(a)));

    //   case PupilSortMode.sortByLastNonProcessedSchooldayEvent:
    //     thisFilteredPupils.sort(
    //         SchoolDayEventHelper.comparePupilsByLastNonProcessedSchooldayEvent);

    //   case PupilSortMode.sortByMissedUnexcused:
    //     thisFilteredPupils.sort((a, b) =>
    //         AttendanceHelper.missedclassUnexcusedSum(b)
    //             .compareTo(AttendanceHelper.missedclassUnexcusedSum(a)));

    //   case PupilSortMode.sortByMissedExcused:
    //     thisFilteredPupils.sort((a, b) => AttendanceHelper.missedclassSum(b)
    //         .compareTo(AttendanceHelper.missedclassSum(a)));

    //   case PupilSortMode.sortByLate:
    //     thisFilteredPupils.sort((a, b) => AttendanceHelper.lateUnexcusedSum(b)
    //         .compareTo(AttendanceHelper.lateUnexcusedSum(a)));

    //   case PupilSortMode.sortByContacted:
    //     thisFilteredPupils.sort((a, b) => AttendanceHelper.contactedSum(b)
    //         .compareTo(AttendanceHelper.contactedSum(a)));

    //   case PupilSortMode.sortByGoneHome:
    //     thisFilteredPupils.sort((a, b) => AttendanceHelper.goneHomeSum(b)
    //         .compareTo(AttendanceHelper.goneHomeSum(a)));
    // }
    _filteredPupils.value = thisFilteredPupils;
    _filteredPupilIds.value =
        thisFilteredPupils.map((e) => e.internalId).toList();
    notifyListeners();
  }

  @override
  void setTextFilter(String? text, {bool refresh = true}) {
    if (text != null && text.isNotEmpty) {
      di<FiltersStateManager>()
          .setFilterState(filterState: FilterState.pupil, value: true);
    }
    notifyListeners();
    _textFilter.setFilterText(text ?? '');
    if (refresh) {
      refreshs();
    }
  }

  @override
  // List<Filter> get groupFilters => PupilProxy.groupFilters;

  @override
  List<Filter> get schoolGradeFilters => PupilProxy.schoolGradeFilters;

  @override
  List<Filter> get genderFilters => PupilProxy.genderFilters;

  @override
  void populateGroupFilters(List<String> groupIds) {
    final groupFilters = groupIds
        .map((groupId) => GroupFilter(groupId))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    _groupFilters.clear();
    _groupFilters.addAll(groupFilters);
  }
}
