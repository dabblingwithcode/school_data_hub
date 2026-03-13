import 'package:flutter_test/flutter_test.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_helper.dart';

void main() {
  group('preschoolRevisionPredicate', () {
    test('null returns "nicht vorhanden"', () {
      expect(PupilProxyHelper.preschoolRevisionPredicate(null),
          'nicht vorhanden');
    });

    test('each status maps to correct text', () {
      final cases = {
        PreSchoolMedicalStatus.notAvailable: 'nicht vorhanden',
        PreSchoolMedicalStatus.ok: 'unauffällig',
        PreSchoolMedicalStatus.supportAreas: 'Förderbedarf',
        PreSchoolMedicalStatus.checkSpecialSupport: 'AO-SF prüfen',
      };
      for (final entry in cases.entries) {
        final medical = PreSchoolMedical(
          preschoolMedicalStatus: entry.key,
          createdBy: 'test',
          createdAt: DateTime.utc(2026, 1, 1),
        );
        expect(
          PupilProxyHelper.preschoolRevisionPredicate(medical),
          entry.value,
          reason: '${entry.key} should map to "${entry.value}"',
        );
      }
    });
  });

  group('pickupTimePredicate', () {
    test('maps codes to times', () {
      expect(PupilProxyHelper.pickupTimePredicate(null), 'k.A.');
      expect(PupilProxyHelper.pickupTimePredicate('0'), '14:00');
      expect(PupilProxyHelper.pickupTimePredicate('1'), '14:00');
      expect(PupilProxyHelper.pickupTimePredicate('2'), '15:00');
      expect(PupilProxyHelper.pickupTimePredicate('3'), '16:00');
    });

    test('unknown code returns error text', () {
      expect(PupilProxyHelper.pickupTimePredicate('9'),
          'Falscher Wert im Server');
    });
  });

  group('communicationPredicate', () {
    test('maps codes to descriptions', () {
      expect(PupilProxyHelper.communicationPredicate(null), 'keine Angabe');
      expect(PupilProxyHelper.communicationPredicate(0), 'nicht');
      expect(
          PupilProxyHelper.communicationPredicate(1), 'einfache Anliegen');
      expect(PupilProxyHelper.communicationPredicate(2),
          'komplexere Informationen');
      expect(PupilProxyHelper.communicationPredicate(3), 'ohne Probleme');
      expect(PupilProxyHelper.communicationPredicate(4), 'unbekannt');
    });

    test('unknown code returns error text', () {
      expect(PupilProxyHelper.communicationPredicate(99),
          'Falscher Wert im Server');
    });
  });

  group('hasLanguageSupport', () {
    test('returns false for null', () {
      expect(PupilProxyHelper.hasLanguageSupport(null), isFalse);
    });

    test('returns true when end date is in the future', () {
      final future = DateTime.now().toUtc().add(const Duration(days: 365));
      expect(PupilProxyHelper.hasLanguageSupport(future), isTrue);
    });

    test('returns false when end date is in the past', () {
      final past = DateTime.now().toUtc().subtract(const Duration(days: 365));
      expect(PupilProxyHelper.hasLanguageSupport(past), isFalse);
    });
  });

  group('hadLanguageSupport', () {
    test('returns false for null', () {
      expect(PupilProxyHelper.hadLanguageSupport(null), isFalse);
    });

    test('returns true when end date is in the past', () {
      final past = DateTime.now().toUtc().subtract(const Duration(days: 365));
      expect(PupilProxyHelper.hadLanguageSupport(past), isTrue);
    });

    test('returns false when end date is in the future', () {
      final future = DateTime.now().toUtc().add(const Duration(days: 365));
      expect(PupilProxyHelper.hadLanguageSupport(future), isFalse);
    });
  });

  // Note: hasTurkishLessions, hasArabicLessions, hasAlbanianLessions,
  // calculateLernjahr, and calculateSchulbesuchsjahr require PupilProxy
  // which needs PupilData + PupilIdentity and has DI dependencies in some
  // getters. Testing these would require constructing full PupilProxy objects.
  // The static predicate methods above cover the pure logic.
}
