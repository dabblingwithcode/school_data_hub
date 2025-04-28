import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/filters/attendance_pupil_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

enum FilterState {
  pupil,
  pupilLegacy,
  attendance,
  schooldayEvent,
  schoolList,
  authorization,
  matrixUser,
  matrixRoom,
}

const Map<FilterState, bool> _initialFilterGlobalValues = {
  FilterState.pupil: false,
  FilterState.pupilLegacy: false,
  FilterState.attendance: false,
  FilterState.schooldayEvent: false,
  FilterState.schoolList: false,
  FilterState.authorization: false,
  FilterState.matrixUser: false,
  FilterState.matrixRoom: false,
};

abstract class FiltersStateManager {
  bool getFilterState(FilterState filterState);

  ValueListenable<bool> get filtersActive;

  ValueListenable<Map<FilterState, bool>> get filterStates;

  void setFilterState({required FilterState filterState, required bool value});

  void markFiltersActive(bool filtersOn);

  void resetFilters();
}

class FiltersStateManagerImplementation implements FiltersStateManager {
  final _filterStates =
      ValueNotifier<Map<FilterState, bool>>(_initialFilterGlobalValues);

  @override
  ValueListenable<Map<FilterState, bool>> get filterStates => _filterStates;

  final _filtersActive = ValueNotifier<bool>(false);

  @override
  ValueListenable<bool> get filtersActive => _filtersActive;

  @override
  bool getFilterState(FilterState filterState) {
    return _filterStates.value[filterState]!;
  }

  @override
  void setFilterState({required FilterState filterState, required bool value}) {
    final newFilterState = Map<FilterState, bool>.from(_filterStates.value);
    newFilterState[filterState] = value;
    _filterStates.value = newFilterState;

    final filterStatesAreEqualInitialValues = const MapEquality()
        .equals(_filterStates.value, _initialFilterGlobalValues);
    if (filterStatesAreEqualInitialValues) {
      _filtersActive.value = false;
    } else {
      _filtersActive.value = true;
    }
  }

  @override
  void markFiltersActive(bool filtersOn) {
    _filtersActive.value = filtersOn;
  }

  @override
  void resetFilters() {
    di<AttendancePupilFilterManager>().resetFilters();
    di<PupilsFilter>().resetFilters();
    di<PupilFilterManager>().resetFilters();
    di<SchooldayEventFilterManager>().resetFilters();
    // di<SchoolListFilterManager>().resetFilters();
    // di<AuthorizationFilterManager>().resetFilters();
    // di<PupilAuthorizationFilterManager>().resetFilters();
    // di<LearningSupportFilterManager>().resetFilters();

    _filterStates.value = {..._initialFilterGlobalValues};
    _filtersActive.value = false;
  }
}
