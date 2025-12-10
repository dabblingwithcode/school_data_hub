import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_identity_extensions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_helper.dart';

void main() {
  group('PupilIdentity date handling', () {
    test('keeps date-only fields stable through CSV -> JSON -> CSV', () {
      final sourceLine = [
        '1', // id
        'Jane',
        'Doe',
        'G1',
        'Tutor',
        'E2',
        '', // specialNeeds
        '', // specialNeeds second part
        'F', // gender
        'DE', // language
        '', // family
        '2015-12-08', // birthday
        '', // migrationSupportEnds
        '2020-08-01', // pupilSince
        'OFFGANZ', // afterSchoolCare
        '', // religion
        '', // religionLessonsSince
        '', // religionLessonsCancelledAt
        '', // familyLanguageLessonsSince
        '', // leavingDate
      ].join(',');

      final identity = PupilIdentityHelper.decodePupilIdentityFromTextLine(
        sourceLine,
      );

      expect(identity.birthday.isUtc, isTrue);
      expect(identity.birthday, DateTime.utc(2015, 12, 8));
      expect(identity.pupilSince, DateTime.utc(2020, 8, 1));

      final serialized = jsonEncode(identity.toJson());
      final reloaded = PupilIdentity.fromJson(
        jsonDecode(serialized) as Map<String, dynamic>,
      );

      expect(reloaded.birthday, DateTime.utc(2015, 12, 8));
      expect(reloaded.pupilSince, DateTime.utc(2020, 8, 1));

      final lineOut = reloaded.toTextLine().split(',');
      expect(lineOut[11], '2015-12-08');
      expect(lineOut[13], '2020-08-01');
    });
  });
}
