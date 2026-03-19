import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/books/domain/filters/pupil_book_lending_filter_predicates.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_book_lending_manager.dart';

typedef PupilBookLendingFilterRecord = ({
  PupilBookLendingFilter filter,
  bool value,
});

class PupilBookLendingFilterManager implements Resettable {
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

  @override
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

    _pupilsFilter.refresh();
  }

  List<PupilBookLending> _applyFilters(
    List<PupilBookLending> pupilBookLendings,
  ) {
    final activeFilters = _pupilBookLendingFilterState.value;

    // If "all" filter is active, return all lendings without filtering
    if (activeFilters[PupilBookLendingFilter.all]!) {
      final sorted = List<PupilBookLending>.from(pupilBookLendings)
        ..sort((a, b) => b.lentAt.compareTo(a.lentAt));
      _pupilIdsWithFilteredPupilBookLendings.value =
          pupilBookLendings.map((e) => e.pupilId).toSet();
      return sorted;
    }

    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

    final filteredLendings = <PupilBookLending>[];
    final filteredPupilIds = <int>{};
    bool filterIsActive = false;

    for (final lending in pupilBookLendings) {
      // Exclusion filters
      if (PupilBookLendingFilterPredicates.excludeBySevenDays(
        lending: lending,
        sevenDaysAgo: sevenDaysAgo,
        filterOn: activeFilters[PupilBookLendingFilter.lastSevenDays]!,
      )) {
        continue;
      }

      if (PupilBookLendingFilterPredicates.excludeByThirtyDays(
        lending: lending,
        thirtyDaysAgo: thirtyDaysAgo,
        filterOn: activeFilters[PupilBookLendingFilter.lastThirtyDays]!,
      )) {
        continue;
      }

      if (PupilBookLendingFilterPredicates.excludeByCurrentlyBorrowed(
        lending: lending,
        filterOn: activeFilters[PupilBookLendingFilter.currentlyBorrowed]!,
      )) {
        continue;
      }

      if (PupilBookLendingFilterPredicates.excludeByReturned(
        lending: lending,
        filterOn: activeFilters[PupilBookLendingFilter.returned]!,
      )) {
        continue;
      }

      // Complementary group: score filters
      if (!PupilBookLendingFilterPredicates.matchesScoreGroup(
        lending,
        activeFilters,
      )) {
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

    filteredLendings.sort((a, b) => b.lentAt.compareTo(a.lentAt));
    _pupilIdsWithFilteredPupilBookLendings.value = filteredPupilIds;
    return filteredLendings;
  }
}
