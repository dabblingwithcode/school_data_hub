import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_stats_helper.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/filters/attendance_pupil_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupil_selector_filters.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupil_text_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/schoolday_event_helper_functions.dart';
import 'package:school_data_hub_flutter/features/books/domain/filters/pupil_book_lending_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/filters/learning_support_filter_manager.dart';

class PupilsFilterImplementation with ChangeNotifier implements PupilsFilter {
  final _log = Logger('PupilsFilterImplementation');

  // Lazy getters to avoid accessing dependencies during construction
  PupilIdentityManager get _pupilIdentityManager => di<PupilIdentityManager>();
  LearningSupportFilterManager get _learningSupportFilterManager =>
      di<LearningSupportFilterManager>();
  SchooldayEventFilterManager get _schooldayEventFilterManager =>
      di<SchooldayEventFilterManager>();
  AttendancePupilFilterManager get _attendancePupilFilterManager =>
      di<AttendancePupilFilterManager>();
  FiltersStateManager get _filtersStateManager => di<FiltersStateManager>();

  PupilsFilterImplementation(PupilProxyManager pupilsManager)
    : _pupilsManager = pupilsManager {
    _log.info('PupilsFilterImplementation created');
    // We need to populate the group filters with the available groups
    final availableGroups = _pupilIdentityManager.groups.value;
    populateGroupFilters(availableGroups.toList());
    // Wire onToggle callback for all pupil filters
    _wireFilterToggleCallbacks();
    refresh();
    _pupilsManager.addListener(refresh);
  }

  /// Wires the onToggle callback on all filters so that toggling a filter
  /// updates the global FiltersStateManager and triggers a refresh,
  /// without the Filter base class needing to know about DI.
  void _wireFilterToggleCallbacks() {
    for (final filter in allPupilFilters) {
      filter.onToggle = _onFilterToggled;
    }
  }

  void _onFilterToggled(Filter filter, bool isActive) {
    if (isActive) {
      _filtersStateManager.setFilterState(
        filterState: FilterState.pupil,
        value: true,
      );
    } else {
      final anyStillActive =
          groupFilters.any((f) => f.isActive) ||
          schoolGradeFilters.any((f) => f.isActive) ||
          genderFilters.any((f) => f.isActive) ||
          religionCourseFilters.any((f) => f.isActive) ||
          familyLanguageFilters.any((f) => f.isActive) ||
          afterSchoolCareFilters.any((f) => f.isActive) ||
          migrationSupportFilter.isActive ||
          _textFilter.isActive;
      if (!anyStillActive) {
        _filtersStateManager.setFilterState(
          filterState: FilterState.pupil,
          value: false,
        );
      }
    }
    refresh();
  }

  // guard from trying to call a value when the filter is disposed
  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    _pupilsManager.removeListener(refresh);
    _filteredPupils.dispose();
    _filteredPupilIds.dispose();
    _sortMode.dispose();

    super.dispose();
  }

  @override
  void clearFilteredPupils() {
    if (_isDisposed) return;
    _filteredPupils.value = [];
    _filteredPupilIds.value = [];
    notifyListeners();
  }

  final PupilProxyManager _pupilsManager;

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

  late List<Filter> allPupilFilters = [
    ...schoolGradeFilters,
    ..._groupFilters,
    ...genderFilters,
    ...religionCourseFilters,
    ...familyLanguageFilters,
    ...afterSchoolCareFilters,
    migrationSupportFilter,
    _textFilter,
  ];

  // reset the filters to its initial state
  @override
  void resetFilters() {
    if (_isDisposed) return;
    // first reset all implemented filter objects

    for (final filter in allPupilFilters) {
      filter.reset();
    }

    // reset the text filter
    _textFilter.reset();

    // reset the filtered pupils to all pupils

    _filteredPupils.value = List<PupilProxy>.from(_pupilsManager.allPupils);
    _filteredPupilIds.value = _pupilsManager.allPupils
        .map((e) => e.pupilId)
        .toList();

    sortPupils();
    _filtersStateManager.setFilterState(
      filterState: FilterState.pupil,
      value: false,
    );
  }

  // updates the filtered pupils with current filters
  // and sort mode
  @override
  void refresh() {
    //if (_isDisposed) return;
    final allPupils = _pupilsManager.allPupils;

    bool filtersOn = false;

    // checks if any not yet migrated filters are active

    final bool specificFiltersOn =
        _schooldayEventFilterManager.schooldayEventsFilterState.value.values
            .any((x) => x == true) ||
        _learningSupportFilterManager.supportLevelFilterState.value.values.any(
          (x) => x == true,
        ) ||
        _learningSupportFilterManager.supportAreaFilterState.value.values.any(
          (x) => x == true,
        ) ||
        _learningSupportFilterManager.currentLearningSupportPlanFiltersActive ||
        _filtersStateManager.getFilterState(FilterState.attendance) ||
        _filtersStateManager.getFilterState(FilterState.pupilBookLending);

    // If no filters are active, just sort

    if (!allPupilFilters.any((x) => x.isActive == true) &&
        specificFiltersOn == false) {
      _filteredPupils.value = List<PupilProxy>.from(allPupils);
      _filteredPupilIds.value = allPupils.map((e) => e.pupilId).toList();

      sortPupils();
      return;
    }

    List<PupilProxy> thisFilteredPupils = [];

    bool isAnyGroupFilterActive = groupFilters.any((filter) => filter.isActive);

    bool isAnySchoolGradeFilterActive = schoolGradeFilters.any(
      (filter) => filter.isActive,
    );

    bool isAnyGenderFilterActive = genderFilters.any(
      (filter) => filter.isActive,
    );

    bool isAnyReligionCourseFilterActive = religionCourseFilters.any(
      (filter) => filter.isActive,
    );
    bool isAnyFamilyLanguageFilterActive = familyLanguageFilters.any(
      (filter) => filter.isActive,
    );

    // bool isTextFilterActive = _textFilter.isActive;

    for (final pupil in allPupils) {
      // matches if no group filter is active or if the group matches the pupil's group

      bool isMatchedByGroupFilter =
          !isAnyGroupFilterActive ||
          groupFilters.any(
            (filter) => filter.isActive && filter.matches(pupil),
          );

      // if the pupil is not matched by any group filter, skip it

      if (!isMatchedByGroupFilter) {
        if (filtersOn == false) filtersOn = true;
        continue;
      }
      // matches if no school grade filter is active or if the school grade matches the pupil's grade

      bool isMatchedBySchoolGradeFilter =
          !isAnySchoolGradeFilterActive ||
          schoolGradeFilters.any(
            (filter) => filter.isActive && filter.matches(pupil),
          );

      // if the pupil is not matched by any school grade filter, skip itl

      if (!isMatchedBySchoolGradeFilter) {
        if (filtersOn == false) filtersOn = true;
        continue;
      }

      bool isMatchedByGenderFilter =
          !isAnyGenderFilterActive ||
          genderFilters.any(
            (filter) => filter.isActive && filter.matches(pupil),
          );

      if (!isMatchedByGenderFilter) {
        if (filtersOn == false) filtersOn = true;
        continue;
      }

      bool isMatchedByReligionCourseFilter =
          !isAnyReligionCourseFilterActive ||
          religionCourseFilters.any(
            (filter) => filter.isActive && filter.matches(pupil),
          );

      if (!isMatchedByReligionCourseFilter) {
        if (filtersOn == false) filtersOn = true;
        continue;
      }
      bool isMatchedByFamilyLanguageFilter =
          !isAnyFamilyLanguageFilterActive ||
          familyLanguageFilters.any(
            (filter) => filter.isActive && filter.matches(pupil),
          );
      if (!isMatchedByFamilyLanguageFilter) {
        if (filtersOn == false) filtersOn = true;
        continue;
      }

      // if the pupil is not matched by the text filter, skip it

      if (_textFilter.isActive && !_textFilter.matches(pupil)) {
        if (filtersOn == false) filtersOn = true;
        continue;
      }

      // if attendance filters are on, pass the pupil through the attendance filters

      if (di<FiltersStateManager>().getFilterState(FilterState.attendance)) {
        if (!_attendancePupilFilterManager.isMatchedByAttendanceFilters(
          pupil,
        )) {
          if (filtersOn == false) filtersOn = true;
          continue;
        }
      }

      // schoolday event filters

      if (di<FiltersStateManager>().getFilterState(
        FilterState.schooldayEvent,
      )) {
        if (!di<SchooldayEventFilterManager>()
            .pupilIdsWithFilteredSchooldayEvents
            .value
            .contains(pupil.pupilId)) {
          if (filtersOn == false) filtersOn = true;
          continue;
        }
      }

      // Pupil book lending filters
      if (di<FiltersStateManager>().getFilterState(
        FilterState.pupilBookLending,
      )) {
        if (!di<PupilBookLendingFilterManager>()
            .pupilIdsWithFilteredPupilBookLendings
            .value
            .contains(pupil.pupilId)) {
          if (filtersOn == false) filtersOn = true;
          continue;
        }
      }

      // after school care filters

      bool isAnyAfterSchoolCareFilterActive = afterSchoolCareFilters.any(
        (filter) => filter.isActive,
      );
      if (isAnyAfterSchoolCareFilterActive &&
          !afterSchoolCareFilters.any(
            (filter) => filter.isActive && filter.matches(pupil),
          )) {
        if (filtersOn == false) filtersOn = true;
        continue;
      }

      // support level filters

      if (di<LearningSupportFilterManager>().supportLevelFiltersActive) {
        if (!di<LearningSupportFilterManager>().matchSupportLevelFilters(
          pupil,
        )) {
          if (filtersOn == false) filtersOn = true;
          continue;
        }
      }

      // support area filters

      if (di<LearningSupportFilterManager>().supportAreaFiltersActive) {
        if (!di<LearningSupportFilterManager>().matchSupportAreaFilters(
          pupil,
        )) {
          if (filtersOn == false) filtersOn = true;
          continue;
        }
      }

      // learning support plan filters
      if (di<LearningSupportFilterManager>()
              .currentLearningSupportPlanFiltersActive &&
          !di<LearningSupportFilterManager>()
              .matchCurrentLearningSupportPlanFilters(pupil)) {
        if (filtersOn == false) filtersOn = true;
        continue;
      }

      // language support filters

      if (migrationSupportFilter.isActive &&
          !migrationSupportFilter.matches(pupil)) {
        if (filtersOn == false) filtersOn = true;
        continue;
      }
      thisFilteredPupils.add(pupil);
    }

    _filteredPupils.value = thisFilteredPupils;
    _filteredPupilIds.value = thisFilteredPupils.map((e) => e.pupilId).toList();
    sortPupils();
  }

  // Set modified filter value
  @override
  void setSortMode(PupilSortMode sortMode) {
    if (sortMode == _sortMode.value) {
      return;
    }
    _sortMode.value = sortMode;
    refresh();
    notifyListeners();
  }

  @override
  void sortPupils() {
    PupilSortMode sortMode = _sortMode.value;
    List<PupilProxy> filteredPupils = List<PupilProxy>.from(
      _filteredPupils.value,
    );

    switch (sortMode) {
      case PupilSortMode.sortByName:
        filteredPupils.sort((a, b) => a.firstName.compareTo(b.firstName));

      case PupilSortMode.sortByCredit:
        filteredPupils.sort((b, a) => a.credit.compareTo(b.credit));

      case PupilSortMode.sortByCreditEarned:
        filteredPupils.sort((b, a) => a.creditEarned.compareTo(b.creditEarned));

      case PupilSortMode.sortBySchooldayEvents:
        filteredPupils.sort(
          (a, b) => SchoolDayEventHelper.schooldayEventSum(
            b,
          ).compareTo(SchoolDayEventHelper.schooldayEventSum(a)),
        );

      case PupilSortMode.sortByLastSchooldayEvent:
        filteredPupils.sort(
          (a, b) => SchoolDayEventHelper.getPupilLastSchooldayEventDate(
            b,
          ).compareTo(SchoolDayEventHelper.getPupilLastSchooldayEventDate(a)),
        );

      case PupilSortMode.sortByLastNonProcessedSchooldayEvent:
        filteredPupils.sort(
          SchoolDayEventHelper.comparePupilsByLastNonProcessedSchooldayEvent,
        );

      case PupilSortMode.sortByMissedUnexcused:
        filteredPupils.sort(
          (a, b) => AttendanceStatsHelper.missedclassUnexcusedSum(
            b,
          ).compareTo(AttendanceStatsHelper.missedclassUnexcusedSum(a)),
        );

      case PupilSortMode.sortByMissedExcused:
        filteredPupils.sort(
          (a, b) => AttendanceStatsHelper.missedclassExcusedSum(
            b,
          ).compareTo(AttendanceStatsHelper.missedclassExcusedSum(a)),
        );

      case PupilSortMode.sortByLate:
        filteredPupils.sort(
          (a, b) => AttendanceStatsHelper.lateUnexcusedSum(
            b,
          ).compareTo(AttendanceStatsHelper.lateUnexcusedSum(a)),
        );

      case PupilSortMode.sortByContacted:
        filteredPupils.sort(
          (a, b) => AttendanceStatsHelper.contactedSum(
            b,
          ).compareTo(AttendanceStatsHelper.contactedSum(a)),
        );

      case PupilSortMode.sortByGoneHome:
        filteredPupils.sort(
          (a, b) => AttendanceStatsHelper.goneHomeSum(
            b,
          ).compareTo(AttendanceStatsHelper.goneHomeSum(a)),
        );
    }

    _filteredPupils.value = filteredPupils;
    notifyListeners();
  }

  @override
  void setTextFilter(String? text, {bool shouldRefresh = true}) {
    if (text != null && text.isNotEmpty) {
      di<FiltersStateManager>().setFilterState(
        filterState: FilterState.pupil,
        value: true,
      );
    }

    _textFilter.setFilterText(text ?? '');
    notifyListeners();
    if (shouldRefresh) {
      refresh();
    }
  }

  @override
  final List<SchoolGradeFilter> schoolGradeFilters = [
    SchoolGradeFilter(SchoolGrade.E1),
    SchoolGradeFilter(SchoolGrade.E2),
    SchoolGradeFilter(SchoolGrade.E3),
    SchoolGradeFilter(SchoolGrade.K3),
    SchoolGradeFilter(SchoolGrade.K4),
  ];

  @override
  final List<GenderFilter> genderFilters = [
    GenderFilter(Gender.male),
    GenderFilter(Gender.female),
  ];

  @override
  final List<ReligionCourseFilter> religionCourseFilters = [
    ReligionCourseFilter(ReligionCourse.islam),
    ReligionCourseFilter(ReligionCourse.catholic),
    ReligionCourseFilter(ReligionCourse.none),
  ];

  @override
  final List<FamilyLanguageFilter> familyLanguageFilters = [
    FamilyLanguageFilter(FamilyLanguage.turkish),
    FamilyLanguageFilter(FamilyLanguage.arabic),
    FamilyLanguageFilter(FamilyLanguage.albanian),
    FamilyLanguageFilter(FamilyLanguage.other),
  ];

  @override
  final List<AfterSchoolCareFilter> afterSchoolCareFilters = [
    AfterSchoolCareFilter(hasAfterSchoolCare: true),
    AfterSchoolCareFilter(hasAfterSchoolCare: false),
  ];

  @override
  final MigrationSupportFilter migrationSupportFilter =
      MigrationSupportFilter();

  @override
  void populateGroupFilters(List<String> groupIds) {
    final groupFilters =
        groupIds.map((groupId) => GroupFilter(groupId)).toList()
          ..sort((a, b) => a.name.compareTo(b.name));

    _groupFilters.clear();
    _groupFilters.addAll(groupFilters);

    // Wire onToggle callback for newly created group filters
    for (final filter in _groupFilters) {
      filter.onToggle = _onFilterToggled;
    }
  }
}
