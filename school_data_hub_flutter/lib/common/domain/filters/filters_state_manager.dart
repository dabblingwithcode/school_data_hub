import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

enum FilterState {
  pupil,
  pupilLegacy,
  attendance,
  schooldayEvent,
  schoolList,
  authorization,
  matrixUser,
  matrixRoom,
  user,
  pupilBookLending,
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
  FilterState.user: false,
  FilterState.pupilBookLending: false,
};

/// Interface for filter managers that can be reset.
/// Implemented by all feature-specific filter managers so they can
/// register themselves with FiltersStateManager.
abstract class Resettable {
  void resetFilters();
}

abstract class FiltersStateManager {
  void dispose();
  bool getFilterState(FilterState filterState);

  ValueListenable<bool> get filtersActive;

  ValueListenable<Map<FilterState, bool>> get filterStates;

  void setFilterState({required FilterState filterState, required bool value});

  void markFiltersActive(bool filtersOn);

  void registerFilterManager(Resettable manager);

  void resetFilters();
}

class FiltersStateManagerImplementation implements FiltersStateManager {
  FiltersStateManagerImplementation();

  final List<Resettable> _registeredFilterManagers = [];

  @override
  void dispose() {
    _filterStates.dispose();
    _filtersActive.dispose();
    _registeredFilterManagers.clear();
  }

  void init() {
    _filterStates.value = {..._initialFilterGlobalValues};
    _filtersActive.value = false;
  }

  final _filterStates = ValueNotifier<Map<FilterState, bool>>(
    _initialFilterGlobalValues,
  );

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

    final filterStatesAreEqualInitialValues =
        const MapEquality<FilterState, bool>().equals(
          _filterStates.value,
          _initialFilterGlobalValues,
        );
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
  void registerFilterManager(Resettable manager) {
    _registeredFilterManagers.add(manager);
  }

  @override
  void resetFilters() {
    for (final manager in _registeredFilterManagers) {
      manager.resetFilters();
    }

    _filterStates.value = {..._initialFilterGlobalValues};
    _filtersActive.value = false;
  }
}
