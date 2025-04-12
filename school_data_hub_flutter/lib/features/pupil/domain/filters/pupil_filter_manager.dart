import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

// TODO: this is an old class and the rests being used should be migrated to PupilsFilterImplementation

typedef PupilFilterRecord = ({PupilFilter filter, bool value});

class PupilFilterManager {
  final _searchText = ValueNotifier<String>('');
  ValueListenable<String> get searchText => _searchText;

  final _pupilFilterState =
      ValueNotifier<Map<PupilFilter, bool>>(initialPupilFilterValues);
  ValueListenable<Map<PupilFilter, bool>> get pupilFilterState =>
      _pupilFilterState;

  final _sortMode =
      ValueNotifier<Map<PupilSortMode, bool>>(initialSortModeValues);
  ValueListenable<Map<PupilSortMode, bool>> get sortMode => _sortMode;

  final _filteredPupils =
      ValueNotifier<List<PupilProxy>>(di<PupilManager>().allPupils);
  ValueListenable<List<PupilProxy>> get filteredPupils => _filteredPupils;

  PupilFilterManager();

  resetFilters() {
    _pupilFilterState.value = {...initialPupilFilterValues};

    //TODO: fix this
    //  di<SchooldayEventFilterManager>().resetFilters();

    _searchText.value = '';

    _sortMode.value = {...initialSortModeValues};

    di<FiltersStateManager>()
        .setFilterState(filterState: FilterState.pupilLegacy, value: false);

    di<PupilsFilter>().refreshs();
  }

  // Set modified filter value
  void setPupilFilter({required List<PupilFilterRecord> pupilFilterRecords}) {
    for (final record in pupilFilterRecords) {
      _pupilFilterState.value = {
        ..._pupilFilterState.value,
        record.filter: record.value,
      };
    }
    final bool pupilFilterStateEqualsInitialState = const MapEquality()
        .equals(_pupilFilterState.value, initialPupilFilterValues);

    if (pupilFilterStateEqualsInitialState) {
      di<FiltersStateManager>()
          .setFilterState(filterState: FilterState.pupilLegacy, value: false);
    } else {
      di<FiltersStateManager>()
          .setFilterState(filterState: FilterState.pupilLegacy, value: true);
    }

    di<PupilsFilter>().refreshs();
  }

  int comparePupilsByAdmonishedDate(PupilProxy a, PupilProxy b) {
    // Handle potential null cases with null-aware operators
    return (a.schooldayEvents?.isEmpty ?? true) ==
            (b.schooldayEvents?.isEmpty ?? true)
        ? compareLastSchooldayEventDates(a, b) // Handle empty or both empty
        : (a.schooldayEvents?.isEmpty ?? true)
            ? 1
            : -1; // Place empty after non-empty
  }

  int comparePupilsByLastNonProcessedSchooldayEvent(
      PupilProxy a, PupilProxy b) {
    // Handle potential null cases with null-aware operators
    return (a.schooldayEvents?.isEmpty ?? true) ==
            (b.schooldayEvents?.isEmpty ?? true)
        ? compareLastSchooldayEventDates(a, b) // Handle empty or both empty
        : (a.schooldayEvents?.isEmpty ?? true)
            ? 1
            : -1; // Place empty after non-empty
  }

  int compareLastSchooldayEventDates(PupilProxy a, PupilProxy b) {
    // Ensure non-empty lists before accessing elements
    if (a.schooldayEvents!.isNotEmpty && b.schooldayEvents!.isNotEmpty) {
      final admonishedDateA = a.schooldayEvents!.last.schoolday!.schoolday;
      final admonishedDateB = b.schooldayEvents!.last.schoolday!.schoolday;
      return admonishedDateB
          .compareTo(admonishedDateA); // Reversed for descending order
    } else {
      // Handle cases where one or both lists are empty
      return 0; // Consider them equal, or apply other logic
    }
  }
}
