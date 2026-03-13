import 'package:flutter_test/flutter_test.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';

void main() {
  group('computeChangedTypes', () {
    final disconnectedAt = DateTime.utc(2026, 3, 13, 10, 0, 0);

    test('returns types that changed after disconnect', () {
      final changeTimes = [
        HubTypeLastUpdate(
          objectType: HubObjectType.pupilData,
          changedAt: DateTime.utc(2026, 3, 13, 10, 5, 0), // after
        ),
        HubTypeLastUpdate(
          objectType: HubObjectType.missedSchoolday,
          changedAt: DateTime.utc(2026, 3, 13, 9, 0, 0), // before
        ),
      ];

      final result = computeChangedTypes(changeTimes, disconnectedAt);

      expect(result, {HubObjectType.pupilData});
    });

    test('returns empty set when nothing changed after disconnect', () {
      final changeTimes = [
        HubTypeLastUpdate(
          objectType: HubObjectType.pupilData,
          changedAt: DateTime.utc(2026, 3, 13, 9, 0, 0),
        ),
        HubTypeLastUpdate(
          objectType: HubObjectType.authorization,
          changedAt: DateTime.utc(2026, 3, 13, 8, 0, 0),
        ),
      ];

      final result = computeChangedTypes(changeTimes, disconnectedAt);

      expect(result, isEmpty);
    });

    test('returns empty set for empty change list', () {
      final result = computeChangedTypes([], disconnectedAt);

      expect(result, isEmpty);
    });

    test('returns all types when all changed after disconnect', () {
      final changeTimes = [
        HubTypeLastUpdate(
          objectType: HubObjectType.pupilData,
          changedAt: DateTime.utc(2026, 3, 13, 10, 1, 0),
        ),
        HubTypeLastUpdate(
          objectType: HubObjectType.missedSchoolday,
          changedAt: DateTime.utc(2026, 3, 13, 10, 2, 0),
        ),
        HubTypeLastUpdate(
          objectType: HubObjectType.schooldayEvent,
          changedAt: DateTime.utc(2026, 3, 13, 10, 3, 0),
        ),
      ];

      final result = computeChangedTypes(changeTimes, disconnectedAt);

      expect(result, {
        HubObjectType.pupilData,
        HubObjectType.missedSchoolday,
        HubObjectType.schooldayEvent,
      });
    });

    test('excludes types changed at exact disconnect moment', () {
      // isAfter is strict — equal timestamps should NOT be included
      final changeTimes = [
        HubTypeLastUpdate(
          objectType: HubObjectType.pupilData,
          changedAt: disconnectedAt, // exactly equal
        ),
      ];

      final result = computeChangedTypes(changeTimes, disconnectedAt);

      expect(result, isEmpty);
    });

    test('includes type changed one millisecond after disconnect', () {
      final changeTimes = [
        HubTypeLastUpdate(
          objectType: HubObjectType.authorization,
          changedAt: disconnectedAt.add(const Duration(milliseconds: 1)),
        ),
      ];

      final result = computeChangedTypes(changeTimes, disconnectedAt);

      expect(result, {HubObjectType.authorization});
    });
  });
}
