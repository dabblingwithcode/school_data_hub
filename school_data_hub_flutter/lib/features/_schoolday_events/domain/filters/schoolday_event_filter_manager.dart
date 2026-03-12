import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/filters/schoolday_event_filter_predicates.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/models/schoolday_event_enums.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';

typedef SchooldayEventFilterRecord = ({
  SchooldayEventFilter filter,
  bool value,
});

/// Result of applying schoolday event filters: filtered list, their pupil IDs, and whether any filter was active.
class FilteredSchooldayEventsResult {
  const FilteredSchooldayEventsResult({
    required this.events,
    required this.pupilIds,
    required this.filterActive,
  });

  final List<SchooldayEvent> events;
  final Set<int> pupilIds;
  final bool filterActive;
}

class SchooldayEventFilterManager implements Resettable {
  // Lazy getters to avoid circular dependency issues during initialization
  FiltersStateManager get _filtersStateManager => di<FiltersStateManager>();
  SchooldayEventManager get _schooldayEventManager =>
      di<SchooldayEventManager>();

  final _schooldayEventsFilterState =
      ValueNotifier<Map<SchooldayEventFilter, bool>>(
        initialSchooldayEventFilterValues,
      );

  ValueListenable<Map<SchooldayEventFilter, bool>>
  get schooldayEventsFilterState => _schooldayEventsFilterState;

  final _pupilIdsWithFilteredSchooldayEvents = ValueNotifier<Set<int>>({});
  ValueListenable<Set<int>> get pupilIdsWithFilteredSchooldayEvents =>
      _pupilIdsWithFilteredSchooldayEvents;

  bool _syncScheduled = false;

  SchooldayEventFilterManager();

  void dispose() {
    _schooldayEventsFilterState.dispose();
    _pupilIdsWithFilteredSchooldayEvents.dispose();
    return;
  }

  @override
  void resetFilters() {
    _schooldayEventsFilterState.value = {...initialSchooldayEventFilterValues};
    _filtersStateManager.setFilterState(
      filterState: FilterState.schooldayEvent,
      value: false,
    );
  }

  void setFilter({
    required List<SchooldayEventFilterRecord> schooldayEventFilters,
  }) {
    for (SchooldayEventFilterRecord record in schooldayEventFilters) {
      _schooldayEventsFilterState.value = {
        ..._schooldayEventsFilterState.value,
        record.filter: record.value,
      };
    }

    final schooldayEventFiltesStateEqualsInitialValues =
        const MapEquality<SchooldayEventFilter, bool>().equals(
          _schooldayEventsFilterState.value,
          initialSchooldayEventFilterValues,
        );

    _filtersStateManager.setFilterState(
      filterState: FilterState.schooldayEvent,
      value: !schooldayEventFiltesStateEqualsInitialValues,
    );

    // Filter the schoolday events and populate the pupil IDs set
    _applyFilterResultToNotifiers();

    // Do not call pupilsFilter.refreshs() here: the event list page uses
    // combineLatest3(filteredPupils, filterState, pupilIds) and already
    // filters by pupilIds. Calling refreshs() causes filteredPupils to notify
    // and triggers an extra list rebuild, which restarts avatar/image futures
    // and makes loading indicators appear stuck.
  }

  void _applyFilterResultToNotifiers() {
    final allEvents = _schooldayEventManager.schooldayEvents.value;
    final result = _computeFiltered(allEvents);
    // Only notify when the set actually changed, to avoid redundant list
    // rebuilds (e.g. from post-frame callback in filteredSchooldayEvents())
    if (!const SetEquality<int>().equals(
      _pupilIdsWithFilteredSchooldayEvents.value,
      result.pupilIds,
    )) {
      _pupilIdsWithFilteredSchooldayEvents.value = result.pupilIds;
    }
    if (result.filterActive) {
      _filtersStateManager.setFilterState(
        filterState: FilterState.schooldayEvent,
        value: true,
      );
    }
  }

  FilteredSchooldayEventsResult _computeFiltered(
    List<SchooldayEvent> schooldayEvents,
  ) {
    final filteredSchooldayEvents = <SchooldayEvent>[];
    final filteredPupilIds = <int>{};
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    final activeFilters = _schooldayEventsFilterState.value;
    bool filterIsActive = false;

    for (final e in schooldayEvents) {
      if (SchooldayEventFilterPredicates.excludeBySevenDays(
        event: e,
        sevenDaysAgo: sevenDaysAgo,
        sevenDaysFilterOn: activeFilters[SchooldayEventFilter.sevenDays]!,
      )) {
        continue;
      }
      if (SchooldayEventFilterPredicates.excludeByProcessed(
        event: e,
        processedFilterOn: activeFilters[SchooldayEventFilter.processed]!,
      )) {
        continue;
      }
      if (!SchooldayEventFilterPredicates.matchesFirstComplementaryGroup(
        e,
        activeFilters,
      )) {
        filterIsActive = true;
        continue;
      }
      if (!SchooldayEventFilterPredicates.matchesSecondComplementaryGroup(
        e,
        activeFilters,
      )) {
        filterIsActive = true;
        continue;
      }
      filteredSchooldayEvents.add(e);
      filteredPupilIds.add(e.pupilId);
    }

    filteredSchooldayEvents.sort(
      (a, b) => b.schoolday!.schoolday.compareTo(a.schoolday!.schoolday),
    );
    return FilteredSchooldayEventsResult(
      events: filteredSchooldayEvents,
      pupilIds: filteredPupilIds,
      filterActive: filterIsActive,
    );
  }

  List<SchooldayEvent> filteredSchooldayEvents(
    List<SchooldayEvent> schooldayEvents,
  ) {
    final result = _computeFiltered(schooldayEvents);

    final needsSync =
        result.filterActive ||
        !const SetEquality<int>().equals(
          result.pupilIds,
          _pupilIdsWithFilteredSchooldayEvents.value,
        );
    if (needsSync && !_syncScheduled) {
      _syncScheduled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _syncScheduled = false;
        _applyFilterResultToNotifiers();
      });
    }

    return result.events;
  }
}
