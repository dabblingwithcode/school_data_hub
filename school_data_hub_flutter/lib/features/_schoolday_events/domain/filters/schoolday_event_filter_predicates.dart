import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/models/schoolday_event_enums.dart';

/// Pure predicate functions for schoolday event filtering.
/// No dependency on get_it or manager; easy to unit test.
class SchooldayEventFilterPredicates {
  SchooldayEventFilterPredicates._();

  // Break window: after 10:29 and before 11:20 (same as original manager).
  static const _breakStart = TimeOfDay(hour: 10, minute: 29);
  static const _breakEnd = TimeOfDay(hour: 11, minute: 20);

  static const _firstGroupEventTypeFilters = [
    SchooldayEventFilter.admonition,
    SchooldayEventFilter.afternoonCareAdmonition,
    SchooldayEventFilter.admonitionAndBanned,
    SchooldayEventFilter.parentsMeeting,
    SchooldayEventFilter.otherEvent,
  ];

  static const _eventTypeByFilter = {
    SchooldayEventFilter.admonition: SchooldayEventType.admonition,
    SchooldayEventFilter.afternoonCareAdmonition:
        SchooldayEventType.afternoonCareAdmonition,
    SchooldayEventFilter.admonitionAndBanned:
        SchooldayEventType.admonitionAndBanned,
    SchooldayEventFilter.parentsMeeting: SchooldayEventType.parentsMeeting,
    SchooldayEventFilter.otherEvent: SchooldayEventType.otherEvent,
  };

  static const _secondGroupReasonFilters = [
    SchooldayEventFilter.violenceAgainstPupils,
    SchooldayEventFilter.violenceAgainstAdults,
    SchooldayEventFilter.violenceAgainstThings,
    SchooldayEventFilter.insultOthers,
    SchooldayEventFilter.annoy,
    SchooldayEventFilter.dangerousBehaviour,
    SchooldayEventFilter.disturbLesson,
    SchooldayEventFilter.ignoreInstructions,
    SchooldayEventFilter.learningDevelopmentInfo,
    SchooldayEventFilter.learningSupportInfo,
    SchooldayEventFilter.admonitionInfo,
    SchooldayEventFilter.other,
  ];

  static const _reasonByFilter = {
    SchooldayEventFilter.violenceAgainstPupils:
        SchooldayEventReason.violenceAgainstPupils,
    SchooldayEventFilter.violenceAgainstAdults:
        SchooldayEventReason.violenceAgainstTeachers,
    SchooldayEventFilter.violenceAgainstThings:
        SchooldayEventReason.violenceAgainstThings,
    SchooldayEventFilter.insultOthers: SchooldayEventReason.insultOthers,
    SchooldayEventFilter.annoy: SchooldayEventReason.annoyOthers,
    SchooldayEventFilter.dangerousBehaviour:
        SchooldayEventReason.dangerousBehaviour,
    SchooldayEventFilter.disturbLesson: SchooldayEventReason.disturbLesson,
    SchooldayEventFilter.ignoreInstructions:
        SchooldayEventReason.ignoreInstructions,
    SchooldayEventFilter.learningDevelopmentInfo:
        SchooldayEventReason.learningDevelopmentInfo,
    SchooldayEventFilter.learningSupportInfo:
        SchooldayEventReason.learningSupportInfo,
    SchooldayEventFilter.admonitionInfo: SchooldayEventReason.admonitionInfo,
    SchooldayEventFilter.other: SchooldayEventReason.other,
  };

  /// True when the event should be excluded (filter on and event before cutoff).
  static bool excludeBySevenDays({
    required SchooldayEvent event,
    required DateTime sevenDaysAgo,
    required bool sevenDaysFilterOn,
  }) {
    return sevenDaysFilterOn &&
        event.schoolday!.schoolday.isBefore(sevenDaysAgo);
  }

  /// True when the event should be excluded (filter on and event is processed).
  static bool excludeByProcessed({
    required SchooldayEvent event,
    required bool processedFilterOn,
  }) {
    return processedFilterOn && event.processed == true;
  }

  /// Event passes if (event-type part) AND (break part).
  /// Event-type part: no event-type filter on, or event matches at least one.
  /// Break part: no break filter on, or event matches at least one break predicate.
  static bool matchesFirstComplementaryGroup(
    SchooldayEvent e,
    Map<SchooldayEventFilter, bool> activeFilters,
  ) {
    return _matchesEventTypePart(e, activeFilters) &&
        _matchesBreakPart(e, activeFilters);
  }

  static bool _matchesEventTypePart(
    SchooldayEvent e,
    Map<SchooldayEventFilter, bool> activeFilters,
  ) {
    bool anyActive = false;
    bool anyMatched = false;
    for (final filter in _firstGroupEventTypeFilters) {
      if (activeFilters[filter]!) {
        anyActive = true;
        if (_eventTypeByFilter[filter] == e.eventType) {
          anyMatched = true;
        }
      }
    }
    return !anyActive || anyMatched;
  }

  static bool _matchesBreakPart(
    SchooldayEvent e,
    Map<SchooldayEventFilter, bool> activeFilters,
  ) {
    bool anyActive = false;
    bool anyMatched = false;
    if (activeFilters[SchooldayEventFilter.duringBreak]!) {
      anyActive = true;
      if (_isDuringBreak(e.eventTime)) anyMatched = true;
    }
    if (activeFilters[SchooldayEventFilter.notDuringBreak]!) {
      anyActive = true;
      if (_isNotDuringBreak(e.eventTime)) anyMatched = true;
    }
    return !anyActive || anyMatched;
  }

  static bool _isDuringBreak(String? eventTime) {
    if (eventTime == null) return false;
    final t = _parseTimeOfDay(eventTime);
    if (t == null) return false;
    return t.isAfter(_breakStart) && t.isBefore(_breakEnd);
  }

  static bool _isNotDuringBreak(String? eventTime) {
    if (eventTime == null) return false;
    final t = _parseTimeOfDay(eventTime);
    if (t == null) return false;
    return t.isBefore(_breakStart) || t.isAfter(_breakEnd);
  }

  static TimeOfDay? _parseTimeOfDay(String eventTime) {
    final parts = eventTime.split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return TimeOfDay(hour: hour, minute: minute);
  }

  /// True if no filter in the second group is on, or the event matches at least one.
  static bool matchesSecondComplementaryGroup(
    SchooldayEvent e,
    Map<SchooldayEventFilter, bool> activeFilters,
  ) {
    bool anyActive = false;
    bool anyMatched = false;
    for (final filter in _secondGroupReasonFilters) {
      if (activeFilters[filter]!) {
        anyActive = true;
        final reason = _reasonByFilter[filter]!;
        if (e.eventReason.contains(reason.value)) {
          anyMatched = true;
        }
      }
    }
    return !anyActive || anyMatched;
  }
}
