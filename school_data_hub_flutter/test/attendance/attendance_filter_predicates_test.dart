import 'package:flutter_test/flutter_test.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/filters/attendance_filter_predicates.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/models/enums.dart';

MissedSchoolday _make({
  MissedType missedType = MissedType.missed,
  bool unexcused = false,
}) {
  return MissedSchoolday(
    missedType: missedType,
    unexcused: unexcused,
    contacted: ContactedType.notSet,
    returned: false,
    writtenExcuse: false,
    createdBy: 'test',
    schooldayId: 1,
    pupilId: 1,
  );
}

Map<AttendancePupilFilter, bool> _filters([
  Set<AttendancePupilFilter> active = const {},
]) {
  return {for (final f in AttendancePupilFilter.values) f: active.contains(f)};
}

void main() {
  group('isPresent', () {
    test('null event means present', () {
      expect(AttendanceFilterPredicates.isPresent(null), isTrue);
    });

    test('late counts as present', () {
      expect(
        AttendanceFilterPredicates.isPresent(
          _make(missedType: MissedType.late),
        ),
        isTrue,
      );
    });

    test('missed is not present', () {
      expect(
        AttendanceFilterPredicates.isPresent(
          _make(missedType: MissedType.missed),
        ),
        isFalse,
      );
    });

    test('home (sent home) is not present', () {
      expect(
        AttendanceFilterPredicates.isPresent(
          _make(missedType: MissedType.home),
        ),
        isFalse,
      );
    });
  });

  group('isNotPresent', () {
    test('null event means not "not present"', () {
      expect(AttendanceFilterPredicates.isNotPresent(null), isFalse);
    });

    test('missed is not present', () {
      expect(
        AttendanceFilterPredicates.isNotPresent(
          _make(missedType: MissedType.missed),
        ),
        isTrue,
      );
    });

    test('late is not "not present"', () {
      expect(
        AttendanceFilterPredicates.isNotPresent(
          _make(missedType: MissedType.late),
        ),
        isFalse,
      );
    });
  });

  group('isUnexcused', () {
    test('null event is not unexcused', () {
      expect(AttendanceFilterPredicates.isUnexcused(null), isFalse);
    });

    test('missed + unexcused is unexcused', () {
      expect(
        AttendanceFilterPredicates.isUnexcused(
          _make(missedType: MissedType.missed, unexcused: true),
        ),
        isTrue,
      );
    });

    test('missed but excused is not unexcused', () {
      expect(
        AttendanceFilterPredicates.isUnexcused(
          _make(missedType: MissedType.missed, unexcused: false),
        ),
        isFalse,
      );
    });

    test('late + unexcused is not unexcused (must be missed type)', () {
      expect(
        AttendanceFilterPredicates.isUnexcused(
          _make(missedType: MissedType.late, unexcused: true),
        ),
        isFalse,
      );
    });
  });

  group('matchesAttendanceGroup', () {
    test('passes when no filters active', () {
      expect(
        AttendanceFilterPredicates.matchesAttendanceGroup(null, _filters()),
        isTrue,
      );
    });

    test('present filter matches null event', () {
      expect(
        AttendanceFilterPredicates.matchesAttendanceGroup(
          null,
          _filters({AttendancePupilFilter.present}),
        ),
        isTrue,
      );
    });

    test('present filter rejects missed pupil', () {
      expect(
        AttendanceFilterPredicates.matchesAttendanceGroup(
          _make(missedType: MissedType.missed),
          _filters({AttendancePupilFilter.present}),
        ),
        isFalse,
      );
    });

    test('notPresent filter matches missed pupil', () {
      expect(
        AttendanceFilterPredicates.matchesAttendanceGroup(
          _make(missedType: MissedType.missed),
          _filters({AttendancePupilFilter.notPresent}),
        ),
        isTrue,
      );
    });

    test('both present + notPresent active matches any pupil (OR logic)', () {
      expect(
        AttendanceFilterPredicates.matchesAttendanceGroup(
          null,
          _filters({
            AttendancePupilFilter.present,
            AttendancePupilFilter.notPresent,
          }),
        ),
        isTrue,
      );
      expect(
        AttendanceFilterPredicates.matchesAttendanceGroup(
          _make(missedType: MissedType.missed),
          _filters({
            AttendancePupilFilter.present,
            AttendancePupilFilter.notPresent,
          }),
        ),
        isTrue,
      );
    });

    test('unexcused filter rejects excused absence', () {
      expect(
        AttendanceFilterPredicates.matchesAttendanceGroup(
          _make(missedType: MissedType.missed, unexcused: false),
          _filters({AttendancePupilFilter.unexcused}),
        ),
        isFalse,
      );
    });
  });
}
