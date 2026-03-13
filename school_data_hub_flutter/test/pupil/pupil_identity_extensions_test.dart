import 'package:flutter_test/flutter_test.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_identity_extensions.dart';

/// Create a test [PupilIdentity] with sensible defaults.
PupilIdentity _makeIdentity({
  int id = 42,
  String firstName = 'Max',
  String lastName = 'Mustermann',
  String group = 'A1',
  String groupTutor = 'Herr Lehrer',
  String? deputyGroupTutor,
  SchoolGrade schoolGrade = SchoolGrade.E1,
  List<String>? specialNeeds,
  String gender = 'm',
  String language = 'Deutsch',
  bool migrationBackground = false,
  String? nationality,
  String? family,
  DateTime? birthday,
  DateTime? migrationSupportEnds,
  DateTime? pupilSince,
  bool afterSchoolCare = false,
  String? religion,
  DateTime? religionLessonsSince,
  DateTime? religionLessonsCancelledAt,
  DateTime? familyLanguageLessonsSince,
  DateTime? leavingDate,
  String? schoolTransitionRecommendation,
}) {
  return PupilIdentity(
    id: id,
    firstName: firstName,
    lastName: lastName,
    group: group,
    groupTutor: groupTutor,
    deputyGroupTutor: deputyGroupTutor,
    schoolGrade: schoolGrade,
    specialNeeds: specialNeeds,
    gender: gender,
    language: language,
    migrationBackground: migrationBackground,
    nationality: nationality,
    family: family,
    birthday: birthday ?? DateTime.utc(2018, 5, 1),
    migrationSupportEnds: migrationSupportEnds,
    pupilSince: pupilSince ?? DateTime.utc(2024, 8, 1),
    afterSchoolCare: afterSchoolCare,
    religion: religion,
    religionLessonsSince: religionLessonsSince,
    religionLessonsCancelledAt: religionLessonsCancelledAt,
    familyLanguageLessonsSince: familyLanguageLessonsSince,
    leavingDate: leavingDate,
    schoolTransitionRecommendation: schoolTransitionRecommendation,
  );
}

void main() {
  group('toTextLine', () {
    test('produces correct CSV for basic identity', () {
      final identity = _makeIdentity();
      final line = identity.toTextLine();
      final parts = line.split(',');

      expect(parts[0], '42'); // id
      expect(parts[1], 'Max'); // firstName
      expect(parts[2], 'Mustermann'); // lastName
      expect(parts[3], 'A1'); // group
      expect(parts[4], 'Herr Lehrer'); // groupTutor
      expect(parts[5], 'E1'); // schoolGrade enum .name
      expect(parts[8], 'm'); // gender
      expect(parts[9], 'Deutsch'); // language
      expect(parts[10], 'false'); // migrationBackground
    });

    test('serializes specialNeeds into two columns', () {
      final identity = _makeIdentity(specialNeeds: ['LE', 'SQ']);
      final parts = identity.toTextLine().split(',');
      expect(parts[6], 'LE');
      expect(parts[7], 'SQ');
    });

    test('empty specialNeeds columns when null', () {
      final identity = _makeIdentity(specialNeeds: null);
      final parts = identity.toTextLine().split(',');
      expect(parts[6], '');
      expect(parts[7], '');
    });

    test('single specialNeed in first column only', () {
      final identity = _makeIdentity(specialNeeds: ['LE']);
      final parts = identity.toTextLine().split(',');
      expect(parts[6], 'LE');
      expect(parts[7], '');
    });

    test('afterSchoolCare true produces OFFGANZ', () {
      final identity = _makeIdentity(afterSchoolCare: true);
      final parts = identity.toTextLine().split(',');
      expect(parts[15], 'OFFGANZ');
    });

    test('afterSchoolCare false produces empty string', () {
      final identity = _makeIdentity(afterSchoolCare: false);
      final parts = identity.toTextLine().split(',');
      expect(parts[15], '');
    });

    test('optional fields are empty strings when null', () {
      final identity = _makeIdentity();
      final parts = identity.toTextLine().split(',');
      expect(parts[11], ''); // family
      expect(parts[13], ''); // migrationSupportEnds
      expect(parts[16], ''); // religion
      expect(parts[21], ''); // deputyGroupTutor
      expect(parts[22], ''); // nationality
      expect(parts[23], ''); // schoolTransitionRecommendation
    });

    test('optional fields serialize when present', () {
      final identity = _makeIdentity(
        family: 'FAM01',
        migrationSupportEnds: DateTime.utc(2027, 6, 30),
        religion: 'ev',
        deputyGroupTutor: 'Frau V',
        nationality: 'DE',
        schoolTransitionRecommendation: 'Gymnasium',
      );
      final parts = identity.toTextLine().split(',');
      expect(parts[11], 'FAM01');
      expect(parts[13], '2027-06-30');
      expect(parts[16], 'ev');
      expect(parts[21], 'Frau V');
      expect(parts[22], 'DE');
      expect(parts[23], 'Gymnasium');
    });

    test('produces exactly 24 columns', () {
      final identity = _makeIdentity();
      final parts = identity.toTextLine().split(',');
      expect(parts.length, 24);
    });
  });

  group('isEqual', () {
    test('identical objects are equal', () {
      final a = _makeIdentity();
      expect(a.isEqual(a), isTrue);
    });

    test('equal values are equal', () {
      final a = _makeIdentity();
      final b = _makeIdentity();
      expect(a.isEqual(b), isTrue);
    });

    test('different id is not equal', () {
      final a = _makeIdentity(id: 1);
      final b = _makeIdentity(id: 2);
      expect(a.isEqual(b), isFalse);
    });

    test('different firstName is not equal', () {
      final a = _makeIdentity(firstName: 'Max');
      final b = _makeIdentity(firstName: 'Moritz');
      expect(a.isEqual(b), isFalse);
    });

    test('different specialNeeds is not equal', () {
      final a = _makeIdentity(specialNeeds: ['LE']);
      final b = _makeIdentity(specialNeeds: ['SQ']);
      expect(a.isEqual(b), isFalse);
    });

    test('null vs non-null specialNeeds is not equal', () {
      final a = _makeIdentity(specialNeeds: null);
      final b = _makeIdentity(specialNeeds: ['LE']);
      expect(a.isEqual(b), isFalse);
    });

    test('both null specialNeeds is equal', () {
      final a = _makeIdentity(specialNeeds: null);
      final b = _makeIdentity(specialNeeds: null);
      expect(a.isEqual(b), isTrue);
    });

    test('different migrationBackground is not equal', () {
      final a = _makeIdentity(migrationBackground: true);
      final b = _makeIdentity(migrationBackground: false);
      expect(a.isEqual(b), isFalse);
    });

    test('different optional date is not equal', () {
      final a = _makeIdentity(
        migrationSupportEnds: DateTime.utc(2027, 6, 30),
      );
      final b = _makeIdentity(
        migrationSupportEnds: DateTime.utc(2028, 6, 30),
      );
      expect(a.isEqual(b), isFalse);
    });
  });
}
