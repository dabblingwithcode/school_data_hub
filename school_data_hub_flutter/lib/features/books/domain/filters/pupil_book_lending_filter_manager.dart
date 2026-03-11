import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_book_lending_manager.dart';

typedef PupilBookLendingFilterRecord = ({
  PupilBookLendingFilter filter,
  bool value,
});

class PupilBookLendingFilterManager {
  // Lazy getters to avoid circular dependency issues during initialization
  FiltersStateManager get _filtersStateManager => di<FiltersStateManager>();
  PupilBookLendingManager get _pupilBookLendingManager =>
      di<PupilBookLendingManager>();
  PupilsFilter get _pupilsFilter => di<PupilsFilter>();

  final _pupilBookLendingFilterState =
      ValueNotifier<Map<PupilBookLendingFilter, bool>>(
        initialPupilBookLendingFilterValues,
      );

  ValueListenable<Map<PupilBookLendingFilter, bool>>
  get pupilBookLendingFilterState => _pupilBookLendingFilterState;

  final _filteredPupilBookLendings = ValueNotifier<List<PupilBookLending>>([]);
  ValueListenable<List<PupilBookLending>> get filteredPupilBookLendings =>
      _filteredPupilBookLendings;

  final _pupilIdsWithFilteredPupilBookLendings = ValueNotifier<Set<int>>({});
  ValueListenable<Set<int>> get pupilIdsWithFilteredPupilBookLendings =>
      _pupilIdsWithFilteredPupilBookLendings;

  PupilBookLendingFilterManager();

  void dispose() {
    _pupilBookLendingFilterState.dispose();
    _filteredPupilBookLendings.dispose();
    _pupilIdsWithFilteredPupilBookLendings.dispose();
    return;
  }

  void resetFilters() {
    _pupilBookLendingFilterState.value = {
      ...initialPupilBookLendingFilterValues,
    };
    _filtersStateManager.setFilterState(
      filterState: FilterState.pupilBookLending,
      value: false,
    );
  }

  void setFilter({
    required List<PupilBookLendingFilterRecord> pupilBookLendingFilters,
  }) {
    // Check if "all" filter is being set to true
    final allFilterRecord = pupilBookLendingFilters.firstWhere(
      (record) => record.filter == PupilBookLendingFilter.all,
      orElse: () => (filter: PupilBookLendingFilter.all, value: false),
    );

    if (allFilterRecord.value == true) {
      // If "all" is being activated, reset all filters to initial values
      _pupilBookLendingFilterState.value = {
        ...initialPupilBookLendingFilterValues,
        PupilBookLendingFilter.all: true,
      };
    } else {
      // Normal filter update
      for (PupilBookLendingFilterRecord record in pupilBookLendingFilters) {
        _pupilBookLendingFilterState.value = {
          ..._pupilBookLendingFilterState.value,
          record.filter: record.value,
        };
      }

      // If any other filter is being activated, turn off "all"
      final anyOtherFilterActive = _pupilBookLendingFilterState.value.entries
          .where((e) => e.key != PupilBookLendingFilter.all)
          .any((e) => e.value == true);

      if (anyOtherFilterActive) {
        _pupilBookLendingFilterState.value = {
          ..._pupilBookLendingFilterState.value,
          PupilBookLendingFilter.all: false,
        };
      }
    }

    final pupilBookLendingFilterStateEqualsInitialValues =
        const MapEquality<PupilBookLendingFilter, bool>().equals(
          _pupilBookLendingFilterState.value,
          initialPupilBookLendingFilterValues,
        );

    _filtersStateManager.setFilterState(
      filterState: FilterState.pupilBookLending,
      value: !pupilBookLendingFilterStateEqualsInitialValues,
    );

    // Filter the pupil book lendings
    final allLendings = _pupilBookLendingManager.allPupilBookLendings;
    final filtered = _applyFilters(allLendings);
    _filteredPupilBookLendings.value = filtered;

    _pupilsFilter.refreshs();
  }

  List<PupilBookLending> _applyFilters(
    List<PupilBookLending> pupilBookLendings,
  ) {
    List<PupilBookLending> filteredLendings = [];
    Set<int> filteredPupilIds = {};

    final activeFilters = _pupilBookLendingFilterState.value;

    // If "all" filter is active, return all lendings without filtering
    if (activeFilters[PupilBookLendingFilter.all]!) {
      filteredLendings = pupilBookLendings;
      filteredPupilIds = pupilBookLendings.map((e) => e.pupilId).toSet();
      // Sort pupil book lendings, latest first
      filteredLendings.sort((a, b) => b.lentAt.compareTo(a.lentAt));
      _pupilIdsWithFilteredPupilBookLendings.value = filteredPupilIds;
      return filteredLendings;
    }

    DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    DateTime thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

    bool filterIsActive = false;

    for (PupilBookLending lending in pupilBookLendings) {
      bool isMatched = true;

      bool complementaryFilter = false;

      //- Hard filters - these exclude items completely
      //- we use continue for hard filters

      // Filter by last seven days
      if (activeFilters[PupilBookLendingFilter.lastSevenDays]! &&
          lending.lentAt.isBefore(sevenDaysAgo)) {
        continue;
      }

      // Filter by last thirty days
      if (activeFilters[PupilBookLendingFilter.lastThirtyDays]! &&
          lending.lentAt.isBefore(thirtyDaysAgo)) {
        continue;
      }

      // Filter by currently borrowed (not returned)
      if (activeFilters[PupilBookLendingFilter.currentlyBorrowed]! &&
          lending.returnedAt != null) {
        continue;
      }

      // Filter by returned
      if (activeFilters[PupilBookLendingFilter.returned]! &&
          lending.returnedAt == null) {
        continue;
      }

      //- Complementary filters - these are OR logic
      //- at least one must match if any are active

      // High score filter (score >= 3)
      if (activeFilters[PupilBookLendingFilter.highScore]!) {
        if (lending.score >= 3) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }

      // Low score filter (score > 0 and < 3)
      if (activeFilters[PupilBookLendingFilter.lowScore]!) {
        if (lending.score > 0 && lending.score < 3) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }

      // No score filter (score == 0)
      if (activeFilters[PupilBookLendingFilter.noScore]!) {
        if (lending.score == 0) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }

      if (!isMatched) {
        filterIsActive = true;
        continue;
      }

      filteredLendings.add(lending);
      filteredPupilIds.add(lending.pupilId);
    }

    if (filterIsActive) {
      _filtersStateManager.setFilterState(
        filterState: FilterState.pupilBookLending,
        value: true,
      );
    }

    // Sort pupil book lendings, latest first
    filteredLendings.sort((a, b) => b.lentAt.compareTo(a.lentAt));
    _pupilIdsWithFilteredPupilBookLendings.value = filteredPupilIds;

    return filteredLendings;
  }

  bool filterByCurrentlyBorrowed(PupilBookLending lending) {
    return lending.returnedAt == null;
  }

  bool filterByReturned(PupilBookLending lending) {
    return lending.returnedAt != null;
  }

  bool filterByLastSevenDays(PupilBookLending lending) {
    DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return lending.lentAt.isAfter(sevenDaysAgo);
  }

  bool filterByLastThirtyDays(PupilBookLending lending) {
    DateTime thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return lending.lentAt.isAfter(thirtyDaysAgo);
  }

  bool filterByHighScore(PupilBookLending lending) {
    return lending.score >= 3;
  }

  bool filterByLowScore(PupilBookLending lending) {
    return lending.score > 0 && lending.score < 3;
  }

  bool filterByNoScore(PupilBookLending lending) {
    return lending.score == 0;
  }
}
