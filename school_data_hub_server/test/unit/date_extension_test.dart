import 'package:school_data_hub_server/src/helpers/date_extension.dart';
import 'package:test/test.dart';

void main() {
  group('isSameDay', () {
    test('same date returns true', () {
      final a = DateTime(2026, 3, 13, 10, 0);
      final b = DateTime(2026, 3, 13, 22, 0);
      expect(a.isSameDay(b), isTrue);
    });

    test('different day returns false', () {
      expect(DateTime(2026, 3, 13).isSameDay(DateTime(2026, 3, 14)), isFalse);
    });

    test('different month returns false', () {
      expect(DateTime(2026, 3, 13).isSameDay(DateTime(2026, 4, 13)), isFalse);
    });

    test('different year returns false', () {
      expect(DateTime(2026, 3, 13).isSameDay(DateTime(2027, 3, 13)), isFalse);
    });
  });

  group('isBeforeDay', () {
    test('earlier day same month', () {
      expect(DateTime(2026, 3, 10).isBeforeDay(DateTime(2026, 3, 13)), isTrue);
      expect(
          DateTime(2026, 3, 13).isBeforeDay(DateTime(2026, 3, 10)), isFalse);
    });

    test('earlier month same year', () {
      expect(DateTime(2026, 2, 28).isBeforeDay(DateTime(2026, 3, 1)), isTrue);
    });

    test('earlier year', () {
      expect(
          DateTime(2025, 12, 31).isBeforeDay(DateTime(2026, 1, 1)), isTrue);
    });

    test('same date returns false', () {
      expect(
          DateTime(2026, 3, 13).isBeforeDay(DateTime(2026, 3, 13)), isFalse);
    });

    test('later date returns false', () {
      expect(DateTime(2026, 3, 15).isBeforeDay(DateTime(2026, 3, 13)), isFalse);
    });
  });

  group('isAfterDay', () {
    test('later day same month', () {
      expect(DateTime(2026, 3, 15).isAfterDay(DateTime(2026, 3, 13)), isTrue);
      expect(DateTime(2026, 3, 13).isAfterDay(DateTime(2026, 3, 15)), isFalse);
    });

    test('later month same year', () {
      expect(DateTime(2026, 4, 1).isAfterDay(DateTime(2026, 3, 31)), isTrue);
    });

    test('later year', () {
      expect(DateTime(2027, 1, 1).isAfterDay(DateTime(2026, 12, 31)), isTrue);
    });

    test('same date returns false', () {
      expect(
          DateTime(2026, 3, 13).isAfterDay(DateTime(2026, 3, 13)), isFalse);
    });

    test('earlier date returns false', () {
      expect(DateTime(2026, 3, 10).isAfterDay(DateTime(2026, 3, 13)), isFalse);
    });
  });

  group('justDate', () {
    test('strips time component', () {
      final dt = DateTime(2026, 3, 13, 14, 30, 45, 123);
      final result = dt.justDate();
      expect(result, DateTime(2026, 3, 13));
      expect(result.hour, 0);
      expect(result.minute, 0);
      expect(result.second, 0);
      expect(result.millisecond, 0);
    });
  });

  group('formatDateForUser', () {
    test('formats as d.m.y', () {
      expect(DateTime(2026, 3, 13).formatDateForUser(), '13.3.2026');
    });

    test('single-digit day and month are not zero-padded', () {
      expect(DateTime(2026, 1, 5).formatDateForUser(), '5.1.2026');
    });
  });

  group('formatDateTimeForUser', () {
    test('formats as d.m.y h:m', () {
      final result = DateTime(2026, 3, 13, 14, 5).formatDateTimeForUser();
      expect(result, '13.3.2026 14:5');
    });
  });
}
