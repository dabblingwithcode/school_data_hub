import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:watch_it/watch_it.dart';

final _schoolListManager = di<SchoolListManager>();
final _log = Logger('SchoolListFilterManager');
final _filtersStateManager = di<FiltersStateManager>();
final _pupilFilterManager = di<PupilFilterManager>();

class SchoolListFilterManager {
  final _filteredSchoolLists = ValueNotifier<List<SchoolList>>([]);
  ValueListenable<List<SchoolList>> get filteredSchoolLists =>
      _filteredSchoolLists;

  ValueListenable<bool> get filterState => _filterState;
  final _filterState = ValueNotifier<bool>(false);

  SchoolListFilterManager init() {
    _schoolListManager.addListener(_onSchoolListsChanged);
    resetFilters();
    _log.fine('SchoolListFilterManager initialized');
    return this;
  }

  void dispose() {
    _schoolListManager.removeListener(_onSchoolListsChanged);
  }

  void _onSchoolListsChanged() {
    // If we have an active filter, reapply it to the new data
    if (_filterState.value) {
      _filteredSchoolLists.value = _schoolListManager.schoolLists
          .where((element) => element.name
              .toLowerCase()
              .contains(_filteredSchoolLists.value.first.name.toLowerCase()))
          .toList();
    } else {
      // Otherwise, just update with the new full list
      _filteredSchoolLists.value = _schoolListManager.schoolLists;
    }
  }

  void updateFilteredSchoolLists(List<SchoolList> schoolLists) {
    _filteredSchoolLists.value = schoolLists;
  }

  void resetFilters() {
    _filterState.value = false;
    _filteredSchoolLists.value = _schoolListManager.schoolLists;
    _filtersStateManager.setFilterState(
        filterState: FilterState.schoolList, value: false);
  }

  void onSearchEnter(String text) {
    if (text.isEmpty) {
      _filteredSchoolLists.value = _schoolListManager.schoolLists;
      return;
    }
    _filterState.value = true;
    _filtersStateManager.setFilterState(
        filterState: FilterState.schoolList, value: true);
    String lowerCaseText = text.toLowerCase();
    _filteredSchoolLists.value = _schoolListManager.schoolLists
        .where((element) => element.name.toLowerCase().contains(lowerCaseText))
        .toList();
  }

  List<PupilListEntry> addPupilEntryFiltersToFilteredPupils(
      List<PupilListEntry> pupilEntries) {
    List<PupilListEntry> filteredPupilEntries = [];
    bool filterIsOn = false;
    for (PupilListEntry pupilEntry in pupilEntries) {
      if (_pupilFilterManager
              .pupilFilterState.value[PupilFilter.schoolListYesResponse]! &&
          pupilEntry.status != true) {
        filterIsOn = true;
        continue;
      }
      if (_pupilFilterManager
              .pupilFilterState.value[PupilFilter.schoolListNoResponse]! &&
          pupilEntry.status != false) {
        filterIsOn = true;
        continue;
      }
      if (_pupilFilterManager
              .pupilFilterState.value[PupilFilter.schoolListNullResponse]! &&
          pupilEntry.status != null) {
        filterIsOn = true;
        continue;
      }
      if (_pupilFilterManager
              .pupilFilterState.value[PupilFilter.schoolListCommentResponse]! &&
          pupilEntry.comment == null) {
        filterIsOn = true;
        continue;
      }
      filteredPupilEntries.add(pupilEntry);
    }
    //- TODO: Implement filterState, FlutterError (setState() or markNeedsBuild() called during build.
    // if (filterIsOn) {
    //   _filterState.value = true;
    // } else {
    //   _filterState.value = false;
    // }

    return filteredPupilEntries;
  }
}
