import 'package:flutter_test/flutter_test.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

void main() {
  group('DateOnlyParsing (String extension)', () {
    test('toDateOnlyUtc parses ISO date string to UTC midnight', () {
      final result = '2026-03-13'.toDateOnlyUtc();
      expect(result, DateTime.utc(2026, 3, 13));
      expect(result.isUtc, isTrue);
    });

    test('toDateOnlyUtc handles ISO datetime with time component', () {
      final result = '2026-03-13T23:30:00'.toDateOnlyUtc();
      // The 2-hour hack shifts this to 2026-03-14 01:30 — but only the date
      // portion is kept, so the result is 2026-03-14.
      expect(result, DateTime.utc(2026, 3, 14));
    });

    test('tryToDateOnlyUtc returns null on invalid string', () {
      expect('not-a-date'.tryToDateOnlyUtc(), isNull);
      expect(''.tryToDateOnlyUtc(), isNull);
    });

    test('tryToDateOnlyUtc parses valid date string', () {
      final result = '2026-01-15'.tryToDateOnlyUtc();
      expect(result, DateTime.utc(2026, 1, 15));
    });

    test('tryParseDateForUser parses dd.MM.yyyy format', () {
      final result = '13.03.2026'.tryParseDateForUser();
      expect(result, isNotNull);
      expect(result!.year, 2026);
      expect(result.month, 3);
      expect(result.day, 13);
    });

    test('tryParseDateForUser returns null on invalid input', () {
      expect('2026-03-13'.tryParseDateForUser(), isNull);
      expect('garbage'.tryParseDateForUser(), isNull);
    });
  });

  group('DateHubExtension (DateTime extension)', () {
    test('toDateOnlyUtc strips time and converts to UTC', () {
      final dt = DateTime(2026, 3, 13, 14, 30, 45);
      final result = dt.toDateOnlyUtc();
      expect(result, DateTime.utc(2026, 3, 13));
      expect(result.isUtc, isTrue);
    });

    test('toUtcSafe does not double-convert UTC dates', () {
      final utcDate = DateTime.utc(2026, 3, 13, 12, 0);
      expect(identical(utcDate.toUtcSafe(), utcDate), isTrue);
    });

    test('toUtcSafe converts local to UTC', () {
      final localDate = DateTime(2026, 3, 13, 12, 0);
      final result = localDate.toUtcSafe();
      expect(result.isUtc, isTrue);
    });

    test('toLocalSafe does not double-convert local dates', () {
      final localDate = DateTime(2026, 3, 13, 12, 0);
      expect(identical(localDate.toLocalSafe(), localDate), isTrue);
    });

    test('toLocalSafe converts UTC to local', () {
      final utcDate = DateTime.utc(2026, 3, 13, 12, 0);
      final result = utcDate.toLocalSafe();
      expect(result.isUtc, isFalse);
    });

    group('isSameDate', () {
      test('returns true for same date', () {
        final a = DateTime(2026, 3, 13, 10, 0);
        final b = DateTime(2026, 3, 13, 22, 0);
        expect(a.isSameDate(b), isTrue);
      });

      test('returns false for different day', () {
        final a = DateTime(2026, 3, 13);
        final b = DateTime(2026, 3, 14);
        expect(a.isSameDate(b), isFalse);
      });

      test('returns false for different month', () {
        final a = DateTime(2026, 3, 13);
        final b = DateTime(2026, 4, 13);
        expect(a.isSameDate(b), isFalse);
      });

      test('returns false for different year', () {
        final a = DateTime(2026, 3, 13);
        final b = DateTime(2027, 3, 13);
        expect(a.isSameDate(b), isFalse);
      });
    });

    group('isBeforeDate', () {
      test('earlier day in same month', () {
        final a = DateTime(2026, 3, 10);
        final b = DateTime(2026, 3, 13);
        expect(a.isBeforeDate(b), isTrue);
        expect(b.isBeforeDate(a), isFalse);
      });

      test('earlier month in same year', () {
        final a = DateTime(2026, 2, 28);
        final b = DateTime(2026, 3, 1);
        expect(a.isBeforeDate(b), isTrue);
      });

      test('earlier year', () {
        final a = DateTime(2025, 12, 31);
        final b = DateTime(2026, 1, 1);
        expect(a.isBeforeDate(b), isTrue);
      });

      test('same date returns false', () {
        final a = DateTime(2026, 3, 13);
        final b = DateTime(2026, 3, 13);
        expect(a.isBeforeDate(b), isFalse);
      });
    });

    group('isAfterDate', () {
      test('later day in same month', () {
        final a = DateTime(2026, 3, 15);
        final b = DateTime(2026, 3, 13);
        expect(a.isAfterDate(b), isTrue);
        expect(b.isAfterDate(a), isFalse);
      });

      test('later month in same year', () {
        final a = DateTime(2026, 4, 1);
        final b = DateTime(2026, 3, 31);
        expect(a.isAfterDate(b), isTrue);
      });

      test('later year', () {
        final a = DateTime(2027, 1, 1);
        final b = DateTime(2026, 12, 31);
        expect(a.isAfterDate(b), isTrue);
      });

      test('same date returns false', () {
        final a = DateTime(2026, 3, 13);
        final b = DateTime(2026, 3, 13);
        expect(a.isAfterDate(b), isFalse);
      });
    });

    test('formatDateForUser returns dd.MM.yyyy in local time', () {
      // Use UTC so local conversion is predictable enough to check format
      final dt = DateTime.utc(2026, 3, 13, 12, 0);
      final result = dt.formatDateForUser();
      expect(result, matches(RegExp(r'^\d{2}\.\d{2}\.\d{4}$')));
    });

    test('formatDateForJson returns yyyy-MM-dd', () {
      final dt = DateTime.utc(2026, 3, 13);
      expect(dt.formatDateForJson(), '2026-03-13');
    });

    test('formatDateForJson with normalizeUtc=false keeps original', () {
      final dt = DateTime(2026, 3, 13);
      final result = dt.formatDateForJson(normalizeUtc: false);
      expect(result, '2026-03-13');
    });

    test('formatDateAndTimeForUser contains Uhr suffix', () {
      final dt = DateTime.utc(2026, 3, 13, 14, 30);
      final result = dt.formatDateAndTimeForUser();
      expect(result, endsWith('Uhr'));
    });

    test('formatTimeForUser returns HH:mm format', () {
      final dt = DateTime(2026, 3, 13, 14, 30);
      expect(dt.formatTimeForUser(), '14:30');
    });

    test('startOfDayLocal returns midnight local', () {
      final dt = DateTime(2026, 3, 13, 14, 30, 45);
      final result = dt.startOfDayLocal();
      expect(result.hour, 0);
      expect(result.minute, 0);
      expect(result.second, 0);
      expect(result.day, 13);
    });

    test('startOfDayUtc returns midnight UTC', () {
      final dt = DateTime.utc(2026, 3, 13, 14, 30, 45);
      final result = dt.startOfDayUtc();
      expect(result, DateTime.utc(2026, 3, 13));
      expect(result.isUtc, isTrue);
    });

    test('formatToUtcForServer returns UTC datetime', () {
      final local = DateTime(2026, 3, 13, 14, 30);
      final result = local.formatToUtcForServer();
      expect(result.isUtc, isTrue);
    });
  });
}
