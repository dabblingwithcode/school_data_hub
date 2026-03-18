import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/filters/school_list_filter_enums.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/school_list_manager.dart';

class SchoolListFilterManager implements Resettable {
  SchoolListManager get _schoolListManager => di<SchoolListManager>();
  FiltersStateManager get _filtersStateManager => di<FiltersStateManager>();
  HubSessionManager get _hubSessionManager => di<HubSessionManager>();

  final _filteredSchoolLists = ValueNotifier<List<SchoolList>>([]);
  ValueListenable<List<SchoolList>> get filteredSchoolLists =>
      _filteredSchoolLists;

  ValueListenable<bool> get filterState => _filterState;
  final _filterState = ValueNotifier<bool>(false);

  String _searchText = '';

  final _schoolListFilterState = ValueNotifier<Map<SchoolListFilter, bool>>(
    initialSchoolListFilterValues,
  );
  ValueListenable<Map<SchoolListFilter, bool>> get schoolListFilterState =>
      _schoolListFilterState;

  // Entry-level response filters (migrated from PupilFilterManager)
  final _entryFilterState = ValueNotifier<Map<SchoolListEntryFilter, bool>>(
    initialSchoolListEntryFilterValues,
  );
  ValueListenable<Map<SchoolListEntryFilter, bool>> get entryFilterState =>
      _entryFilterState;

  void dispose() {
    _filteredSchoolLists.dispose();
    _filterState.dispose();
    _schoolListFilterState.dispose();
    _entryFilterState.dispose();
    _schoolListManager.removeListener(_onSchoolListsChanged);

    return;
  }

  SchoolListFilterManager init() {
    _schoolListManager.addListener(_onSchoolListsChanged);
    resetFilters();

    return this;
  }

  void _onSchoolListsChanged() {
    // Reapply active filters when school lists data changes
    _applyActiveFilters();
  }

  void updateFilteredSchoolLists(List<SchoolList> schoolLists) {
    _filteredSchoolLists.value = schoolLists;
  }

  @override
  void resetFilters() {
    _searchText = '';
    _schoolListFilterState.value = Map.from(initialSchoolListFilterValues);
    _entryFilterState.value = {...initialSchoolListEntryFilterValues};
    _filteredSchoolLists.value = _schoolListManager.schoolLists.value;
    _filterState.value = false;
    _filtersStateManager.setFilterState(
      filterState: FilterState.schoolList,
      value: false,
    );
  }

  void onSearchTextSchoolListsFilter(String text) {
    _searchText = text;
    _applyActiveFilters();
  }

  /// Toggle filter for public school lists
  void togglePublicListsFilter() {
    final currentValue =
        _schoolListFilterState.value[SchoolListFilter.publicLists] ?? false;
    _setMutuallyExclusiveFilter(SchoolListFilter.publicLists, !currentValue);
  }

  /// Toggle filter for user's own lists
  void toggleMyListsFilter() {
    final currentValue =
        _schoolListFilterState.value[SchoolListFilter.myLists] ?? false;
    _setMutuallyExclusiveFilter(SchoolListFilter.myLists, !currentValue);
  }

  /// Toggle filter for other users' lists (not public and not created by current user)
  void toggleOtherListsFilter() {
    final currentValue =
        _schoolListFilterState.value[SchoolListFilter.otherLists] ?? false;
    _setMutuallyExclusiveFilter(SchoolListFilter.otherLists, !currentValue);
  }

  /// Set a mutually exclusive filter, ensuring only one filter is active at a time
  void _setMutuallyExclusiveFilter(SchoolListFilter filter, bool value) {
    final newState = Map<SchoolListFilter, bool>.from(
      initialSchoolListFilterValues,
    );

    if (value) {
      // If turning on this filter, turn off all others
      newState[filter] = true;
    }
    // If value is false, all filters remain false (from initialValues)

    _schoolListFilterState.value = newState;
    _applyActiveFilters();
  }

  /// Apply category filters and text search compositionally.
  void _applyActiveFilters() {
    final userName = _hubSessionManager.userName;
    List<SchoolList> result = _schoolListManager.schoolLists.value;
    bool anyFilterActive = false;

    // Category filter (mutually exclusive)
    if (_schoolListFilterState.value[SchoolListFilter.publicLists] == true) {
      result = result.where((list) => list.public == true).toList();
      anyFilterActive = true;
    } else if (_schoolListFilterState.value[SchoolListFilter.myLists] == true &&
        userName != null) {
      result = result.where((list) => list.createdBy == userName).toList();
      anyFilterActive = true;
    } else if (_schoolListFilterState.value[SchoolListFilter.otherLists] ==
            true &&
        userName != null) {
      result = result
          .where((list) => list.public == false && list.createdBy != userName)
          .toList();
      anyFilterActive = true;
    }

    // Text search (composes with category filter)
    if (_searchText.isNotEmpty) {
      final lowerCaseText = _searchText.toLowerCase();
      result = result
          .where((list) => list.name.toLowerCase().contains(lowerCaseText))
          .toList();
      anyFilterActive = true;
    }

    _filteredSchoolLists.value = result;
    _filterState.value = anyFilterActive;
    _filtersStateManager.setFilterState(
      filterState: FilterState.schoolList,
      value: anyFilterActive,
    );
  }

  // Entry-level response filter methods (migrated from PupilFilterManager)

  void setEntryFilter({
    required List<SchoolListEntryFilterRecord> entryFilterRecords,
  }) {
    for (final record in entryFilterRecords) {
      _entryFilterState.value = {
        ..._entryFilterState.value,
        record.filter: record.value,
      };
    }
    final entryFilterStateEqualsInitialState =
        const MapEquality<SchoolListEntryFilter, bool>().equals(
          _entryFilterState.value,
          initialSchoolListEntryFilterValues,
        );

    _filtersStateManager.setFilterState(
      filterState: FilterState.schoolList,
      value: !entryFilterStateEqualsInitialState,
    );

    di<PupilsFilter>().refresh();
  }

  List<PupilListEntry> addPupilEntryFiltersToFilteredPupils(
    List<PupilListEntry> pupilEntries,
  ) {
    List<PupilListEntry> filteredPupilEntries = [];
    bool filterIsOn = false;
    for (PupilListEntry pupilEntry in pupilEntries) {
      if (_entryFilterState.value[SchoolListEntryFilter.yesResponse]! &&
          pupilEntry.status != true) {
        filterIsOn = true;
        continue;
      }
      if (_entryFilterState.value[SchoolListEntryFilter.noResponse]! &&
          pupilEntry.status != false) {
        filterIsOn = true;
        continue;
      }
      if (_entryFilterState.value[SchoolListEntryFilter.nullResponse]! &&
          pupilEntry.status != null) {
        filterIsOn = true;
        continue;
      }
      if (_entryFilterState.value[SchoolListEntryFilter.commentResponse]! &&
          pupilEntry.comment == null) {
        filterIsOn = true;
        continue;
      }
      filteredPupilEntries.add(pupilEntry);
    }

    if (filterIsOn) {
      _filterState.value = true;
    } else {
      _filterState.value = false;
    }

    return filteredPupilEntries;
  }
}
