import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/models/schoolday_event_enums.dart';
import 'package:watch_it/watch_it.dart';

final _filtersStateManager = di<FiltersStateManager>();

final _pupilsFilter = di<PupilsFilter>();

typedef SchooldayEventFilterRecord = ({
  SchooldayEventFilter filter,
  bool value
});

class SchooldayEventFilterManager {
  final _schooldayEventsFilterState =
      ValueNotifier<Map<SchooldayEventFilter, bool>>(
          initialSchooldayEventFilterValues);

  ValueListenable<Map<SchooldayEventFilter, bool>>
      get schooldayEventsFilterState => _schooldayEventsFilterState;

  final _pupilIdsWithFilteredSchooldayEvents = ValueNotifier<Set<int>>({});
  ValueListenable<Set<int>> get pupilIdsWithFilteredSchooldayEvents =>
      _pupilIdsWithFilteredSchooldayEvents;

  SchooldayEventFilterManager();

  resetFilters() {
    _schooldayEventsFilterState.value = {...initialSchooldayEventFilterValues};
    _filtersStateManager.setFilterState(
        filterState: FilterState.schooldayEvent, value: false);
  }

  void setFilter(
      {required List<SchooldayEventFilterRecord> schooldayEventFilters}) {
    for (SchooldayEventFilterRecord record in schooldayEventFilters) {
      _schooldayEventsFilterState.value = {
        ..._schooldayEventsFilterState.value,
        record.filter: record.value,
      };
    }

    final schooldayEventFiltesStateEqualsInitialValues = const MapEquality()
        .equals(_schooldayEventsFilterState.value,
            initialSchooldayEventFilterValues);

    _filtersStateManager.setFilterState(
        filterState: FilterState.schooldayEvent,
        value: !schooldayEventFiltesStateEqualsInitialValues);

    _pupilsFilter.refreshs();
  }

  List<SchooldayEvent> filteredSchooldayEvents(
      List<SchooldayEvent> schooldayEvents) {
    List<SchooldayEvent> filteredSchooldayEvents = [];
    Set<int> filteredPupilIds = {};

    DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

    final activeFilters = _schooldayEventsFilterState.value;

    bool filterIsActive = false;

    for (SchooldayEvent schooldayEvent in schooldayEvents) {
      bool isMatched = true;

      bool complementaryFilter = false;

      //- we keep the last seven days
      //- because this is a hard filter we use continue

      if (activeFilters[SchooldayEventFilter.sevenDays]! &&
          schooldayEvent.schoolday!.schoolday.isBefore(sevenDaysAgo)) {
        continue;
      }

      //- we keep the not processed ones
      //- because this is a hard filter we use continue

      if (activeFilters[SchooldayEventFilter.processed]! &&
          schooldayEvent.processed == true) {
        continue;
      }

      //- these are complementary filters
      //- and should persist if one of them is active

      if (activeFilters[SchooldayEventFilter.admonition]!) {
        if (schooldayEvent.eventType == SchooldayEventType.admonition) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }

      if (activeFilters[SchooldayEventFilter.afternoonCareAdmonition]!) {
        if (schooldayEvent.eventType ==
            SchooldayEventType.afternoonCareAdmonition) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }

      if (activeFilters[SchooldayEventFilter.admonitionAndBanned]!) {
        if (schooldayEvent.eventType ==
            SchooldayEventType.admonitionAndBanned) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }

      if (activeFilters[SchooldayEventFilter.parentsMeeting]!) {
        if (schooldayEvent.eventType == SchooldayEventType.parentsMeeting) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }

      if (activeFilters[SchooldayEventFilter.otherEvent]!) {
        if (schooldayEvent.eventType == SchooldayEventType.otherEvent) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }

      //- The behavior of this first filter group should be
      //- excluding for the next filter group
      //- let's tidy up the list

      if (!isMatched) {
        filterIsActive = true;
        continue;
      }

      //- these filters are also complementary
      //- we reset the complementary value to process them

      complementaryFilter = false;

      if (activeFilters[SchooldayEventFilter.violenceAgainstPupils]!) {
        if (schooldayEvent.eventReason
            .contains(SchooldayEventReason.violenceAgainstPupils.value)) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }

      if (activeFilters[SchooldayEventFilter.violenceAgainstAdults]!) {
        if (schooldayEvent.eventReason
            .contains(SchooldayEventReason.violenceAgainstTeachers.value)) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }
      if (activeFilters[SchooldayEventFilter.violenceAgainstThings]!) {
        if (schooldayEvent.eventReason
            .contains(SchooldayEventReason.violenceAgainstThings.value)) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }
      if (activeFilters[SchooldayEventFilter.insultOthers]!) {
        if (schooldayEvent.eventReason
            .contains(SchooldayEventReason.insultOthers.value)) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }
      if (activeFilters[SchooldayEventFilter.annoy]!) {
        if (schooldayEvent.eventReason
            .contains(SchooldayEventReason.annoyOthers.value)) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }
      if (activeFilters[SchooldayEventFilter.dangerousBehaviour]!) {
        if (schooldayEvent.eventReason
            .contains(SchooldayEventReason.dangerousBehaviour.value)) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }
      if (activeFilters[SchooldayEventFilter.disturbLesson]!) {
        if (schooldayEvent.eventReason
            .contains(SchooldayEventReason.disturbLesson.value)) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }
      if (activeFilters[SchooldayEventFilter.ignoreInstructions]!) {
        if (schooldayEvent.eventReason
            .contains(SchooldayEventReason.ignoreInstructions.value)) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }
      if (activeFilters[SchooldayEventFilter.learningDevelopmentInfo]!) {
        if (schooldayEvent.eventReason
            .contains(SchooldayEventReason.learningDevelopmentInfo.value)) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }
      if (activeFilters[SchooldayEventFilter.learningSupportInfo]!) {
        if (schooldayEvent.eventReason
            .contains(SchooldayEventReason.learningSupportInfo.value)) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }
      if (activeFilters[SchooldayEventFilter.admonitionInfo]!) {
        if (schooldayEvent.eventReason
            .contains(SchooldayEventReason.admonitionInfo.value)) {
          isMatched = true;
          complementaryFilter = true;
        } else if (!complementaryFilter) {
          isMatched = false;
        }
      }
      if (activeFilters[SchooldayEventFilter.other]!) {
        if (schooldayEvent.eventReason
            .contains(SchooldayEventReason.other.value)) {
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
      filteredSchooldayEvents.add(schooldayEvent);
      filteredPupilIds.add(schooldayEvent.pupilId);
    }

    if (filterIsActive) {
      _filtersStateManager.setFilterState(
          filterState: FilterState.schooldayEvent, value: true);
    }
    // sort schooldayEvents, latest first
    filteredSchooldayEvents.sort(
        (a, b) => b.schoolday!.schoolday.compareTo(a.schoolday!.schoolday));
    _pupilIdsWithFilteredSchooldayEvents.value = filteredPupilIds;
    return filteredSchooldayEvents;
  }

  bool filterBySevenDays(SchooldayEvent schooldayEvent) {
    DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return schooldayEvent.schoolday!.schoolday.isAfter(sevenDaysAgo);
  }

  bool filterByProcessed(SchooldayEvent schooldayEvent) {
    return schooldayEvent.processed == true;
  }

  bool filterByAdmonition(SchooldayEvent schooldayEvent) {
    return schooldayEvent.eventType == SchooldayEventType.admonition;
  }

  bool filterByAfternoonCareAdmonition(SchooldayEvent schooldayEvent) {
    return schooldayEvent.eventType ==
        SchooldayEventType.afternoonCareAdmonition;
  }

  bool filterByAdmonitionAndBanned(SchooldayEvent schooldayEvent) {
    return schooldayEvent.eventType == SchooldayEventType.admonitionAndBanned;
  }

  bool filterByOtherEvent(SchooldayEvent schooldayEvent) {
    return schooldayEvent.eventType == SchooldayEventType.otherEvent;
  }

  bool filterByParentsMeeting(SchooldayEvent schooldayEvent) {
    return schooldayEvent.eventType == SchooldayEventType.parentsMeeting;
  }
}
