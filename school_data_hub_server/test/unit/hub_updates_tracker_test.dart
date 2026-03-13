import 'package:school_data_hub_server/src/_features/hub/services/hub_updates_tracker.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  final tracker = HubUpdatesTracker.instance;

  setUp(() => tracker.reset());

  group('HubUpdatesTracker', () {
    test('changeTimes is empty after reset', () {
      expect(tracker.changeTimes, isEmpty);
    });

    test('touch() records a timestamp for the given type', () {
      final before = DateTime.now().toUtc();
      tracker.touch(HubObjectType.pupilData);
      final times = tracker.changeTimes;

      expect(times, hasLength(1));
      expect(times.first.objectType, HubObjectType.pupilData);
      expect(
        times.first.changedAt.isAfter(before) ||
            times.first.changedAt.isAtSameMomentAs(before),
        isTrue,
      );
    });

    test('touch() updates timestamp on repeated calls', () {
      tracker.touch(HubObjectType.missedSchoolday);
      final first = tracker.changeTimes.first.changedAt;

      tracker.touch(HubObjectType.missedSchoolday);
      final second = tracker.changeTimes.first.changedAt;

      expect(
        second.isAfter(first) || second.isAtSameMomentAs(first),
        isTrue,
      );
      expect(tracker.changeTimes, hasLength(1));
    });

    test('only touched types appear in changeTimes', () {
      tracker.touch(HubObjectType.pupilData);
      tracker.touch(HubObjectType.authorization);

      final types = tracker.changeTimes.map((t) => t.objectType).toSet();
      expect(types, {HubObjectType.pupilData, HubObjectType.authorization});
      expect(types, isNot(contains(HubObjectType.missedSchoolday)));
    });

    test('touching multiple types tracks each independently', () {
      tracker.touch(HubObjectType.pupilData);
      final afterPupil = DateTime.now().toUtc();

      // Small busy-wait to ensure different timestamp
      while (DateTime.now().toUtc().difference(afterPupil).inMicroseconds <
          10) {}

      tracker.touch(HubObjectType.schooldayEvent);

      final times = tracker.changeTimes;
      expect(times, hasLength(2));

      final pupilTime = times
          .firstWhere((t) => t.objectType == HubObjectType.pupilData)
          .changedAt;
      final eventTime = times
          .firstWhere((t) => t.objectType == HubObjectType.schooldayEvent)
          .changedAt;

      expect(
        eventTime.isAfter(pupilTime) ||
            eventTime.isAtSameMomentAs(pupilTime),
        isTrue,
      );
    });
  });
}
