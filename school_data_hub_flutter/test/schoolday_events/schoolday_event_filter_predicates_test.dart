import 'package:flutter_test/flutter_test.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/filters/schoolday_event_filter_predicates.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/models/schoolday_event_enums.dart';

/// Helper to create a minimal [SchooldayEvent] for filter testing.
SchooldayEvent _makeEvent({
  SchooldayEventType eventType = SchooldayEventType.admonition,
  String eventReason = '',
  String? eventTime,
  DateTime? schoolday,
  bool processed = false,
}) {
  return SchooldayEvent(
    eventId: 'test-1',
    eventType: eventType,
    eventReason: eventReason,
    eventTime: eventTime,
    createdBy: 'test',
    processed: processed,
    processedBy: null,
    processedAt: null,
    schooldayId: 1,
    schoolday: schoolday != null
        ? Schoolday(schoolday: schoolday, schoolSemesterId: 1)
        : Schoolday(schoolday: DateTime.utc(2026, 3, 13), schoolSemesterId: 1),
    pupilId: 1,
  );
}

/// Build a filter map with all filters off, then turn on the specified ones.
Map<SchooldayEventFilter, bool> _filters([
  Set<SchooldayEventFilter> active = const {},
]) {
  return {for (final f in SchooldayEventFilter.values) f: active.contains(f)};
}

void main() {
  group('excludeBySevenDays', () {
    final sevenDaysAgo = DateTime.utc(2026, 3, 6);

    test('excludes events before cutoff when filter is on', () {
      final event = _makeEvent(schoolday: DateTime.utc(2026, 3, 1));
      expect(
        SchooldayEventFilterPredicates.excludeBySevenDays(
          event: event,
          sevenDaysAgo: sevenDaysAgo,
          sevenDaysFilterOn: true,
        ),
        isTrue,
      );
    });

    test('does not exclude events after cutoff', () {
      final event = _makeEvent(schoolday: DateTime.utc(2026, 3, 10));
      expect(
        SchooldayEventFilterPredicates.excludeBySevenDays(
          event: event,
          sevenDaysAgo: sevenDaysAgo,
          sevenDaysFilterOn: true,
        ),
        isFalse,
      );
    });

    test('does not exclude when filter is off', () {
      final event = _makeEvent(schoolday: DateTime.utc(2026, 3, 1));
      expect(
        SchooldayEventFilterPredicates.excludeBySevenDays(
          event: event,
          sevenDaysAgo: sevenDaysAgo,
          sevenDaysFilterOn: false,
        ),
        isFalse,
      );
    });
  });

  group('excludeByProcessed', () {
    test('excludes processed events when filter is on', () {
      final event = _makeEvent(processed: true);
      expect(
        SchooldayEventFilterPredicates.excludeByProcessed(
          event: event,
          processedFilterOn: true,
        ),
        isTrue,
      );
    });

    test('does not exclude unprocessed events', () {
      final event = _makeEvent(processed: false);
      expect(
        SchooldayEventFilterPredicates.excludeByProcessed(
          event: event,
          processedFilterOn: true,
        ),
        isFalse,
      );
    });

    test('does not exclude when filter is off', () {
      final event = _makeEvent(processed: true);
      expect(
        SchooldayEventFilterPredicates.excludeByProcessed(
          event: event,
          processedFilterOn: false,
        ),
        isFalse,
      );
    });
  });

  group('matchesFirstComplementaryGroup', () {
    test('passes when no event-type or break filters active', () {
      final event = _makeEvent(eventType: SchooldayEventType.admonition);
      expect(
        SchooldayEventFilterPredicates.matchesFirstComplementaryGroup(
          event,
          _filters(),
        ),
        isTrue,
      );
    });

    test('passes when event type matches active filter', () {
      final event = _makeEvent(eventType: SchooldayEventType.admonition);
      expect(
        SchooldayEventFilterPredicates.matchesFirstComplementaryGroup(
          event,
          _filters({SchooldayEventFilter.admonition}),
        ),
        isTrue,
      );
    });

    test('fails when event type does not match active filter', () {
      final event = _makeEvent(eventType: SchooldayEventType.parentsMeeting);
      expect(
        SchooldayEventFilterPredicates.matchesFirstComplementaryGroup(
          event,
          _filters({SchooldayEventFilter.admonition}),
        ),
        isFalse,
      );
    });

    test('passes with break filter during break time', () {
      final event = _makeEvent(eventTime: '10:45');
      expect(
        SchooldayEventFilterPredicates.matchesFirstComplementaryGroup(
          event,
          _filters({SchooldayEventFilter.duringBreak}),
        ),
        isTrue,
      );
    });

    test('fails with break filter outside break time', () {
      final event = _makeEvent(eventTime: '08:30');
      expect(
        SchooldayEventFilterPredicates.matchesFirstComplementaryGroup(
          event,
          _filters({SchooldayEventFilter.duringBreak}),
        ),
        isFalse,
      );
    });

    test('notDuringBreak filter passes for morning event', () {
      final event = _makeEvent(eventTime: '08:30');
      expect(
        SchooldayEventFilterPredicates.matchesFirstComplementaryGroup(
          event,
          _filters({SchooldayEventFilter.notDuringBreak}),
        ),
        isTrue,
      );
    });

    test('null eventTime fails break filters', () {
      final event = _makeEvent(eventTime: null);
      expect(
        SchooldayEventFilterPredicates.matchesFirstComplementaryGroup(
          event,
          _filters({SchooldayEventFilter.duringBreak}),
        ),
        isFalse,
      );
    });

    test('break boundary: 10:29 is NOT during break', () {
      final event = _makeEvent(eventTime: '10:29');
      expect(
        SchooldayEventFilterPredicates.matchesFirstComplementaryGroup(
          event,
          _filters({SchooldayEventFilter.duringBreak}),
        ),
        isFalse,
      );
    });

    test('break boundary: 10:30 IS during break', () {
      final event = _makeEvent(eventTime: '10:30');
      expect(
        SchooldayEventFilterPredicates.matchesFirstComplementaryGroup(
          event,
          _filters({SchooldayEventFilter.duringBreak}),
        ),
        isTrue,
      );
    });

    test('break boundary: 11:19 IS during break', () {
      final event = _makeEvent(eventTime: '11:19');
      expect(
        SchooldayEventFilterPredicates.matchesFirstComplementaryGroup(
          event,
          _filters({SchooldayEventFilter.duringBreak}),
        ),
        isTrue,
      );
    });

    test('break boundary: 11:20 is NOT during break', () {
      final event = _makeEvent(eventTime: '11:20');
      expect(
        SchooldayEventFilterPredicates.matchesFirstComplementaryGroup(
          event,
          _filters({SchooldayEventFilter.duringBreak}),
        ),
        isFalse,
      );
    });
  });

  group('matchesSecondComplementaryGroup', () {
    test('passes when no reason filters active', () {
      final event = _makeEvent(eventReason: 'gm');
      expect(
        SchooldayEventFilterPredicates.matchesSecondComplementaryGroup(
          event,
          _filters(),
        ),
        isTrue,
      );
    });

    test('passes when event reason matches active filter', () {
      final event = _makeEvent(eventReason: 'gm');
      expect(
        SchooldayEventFilterPredicates.matchesSecondComplementaryGroup(
          event,
          _filters({SchooldayEventFilter.violenceAgainstPupils}),
        ),
        isTrue,
      );
    });

    test('fails when event reason does not match active filter', () {
      final event = _makeEvent(eventReason: 'us');
      expect(
        SchooldayEventFilterPredicates.matchesSecondComplementaryGroup(
          event,
          _filters({SchooldayEventFilter.violenceAgainstPupils}),
        ),
        isFalse,
      );
    });

    test('passes when reason matches one of multiple active filters', () {
      final event = _makeEvent(eventReason: 'ab');
      expect(
        SchooldayEventFilterPredicates.matchesSecondComplementaryGroup(
          event,
          _filters({
            SchooldayEventFilter.violenceAgainstPupils,
            SchooldayEventFilter.insultOthers,
          }),
        ),
        isTrue,
      );
    });

    test('eventReason containing the code also matches', () {
      // eventReason uses .contains(), so a composite reason string works
      final event = _makeEvent(eventReason: 'gm,ab');
      expect(
        SchooldayEventFilterPredicates.matchesSecondComplementaryGroup(
          event,
          _filters({SchooldayEventFilter.violenceAgainstPupils}),
        ),
        isTrue,
      );
    });
  });
}
