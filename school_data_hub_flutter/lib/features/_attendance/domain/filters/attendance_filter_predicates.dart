import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/models/enums.dart';

/// Pure predicate functions for attendance pupil filtering.
/// No dependency on get_it or manager; easy to unit test.
class AttendanceFilterPredicates {
  AttendanceFilterPredicates._();

  /// Pupil is "present" if they have no missed schoolday today, or only a
  /// late entry (late counts as present).
  static bool isPresent(MissedSchoolday? event) {
    return event == null || event.missedType == MissedType.late;
  }

  /// Pupil is "not present" if they have a missed schoolday today that is
  /// not late (i.e. fully absent or gone home).
  static bool isNotPresent(MissedSchoolday? event) {
    return event != null && event.missedType != MissedType.late;
  }

  /// Pupil is "unexcused" if they have a missed schoolday today that is
  /// of type missed AND marked unexcused.
  static bool isUnexcused(MissedSchoolday? event) {
    return event != null &&
        event.unexcused == true &&
        event.missedType == MissedType.missed;
  }

  /// Returns true if the pupil matches all active attendance filters.
  /// Uses complementary group logic: if any filter is active, pupil must
  /// match at least one.
  static bool matchesAttendanceGroup(
    MissedSchoolday? event,
    Map<AttendancePupilFilter, bool> activeFilters,
  ) {
    bool anyActive = false;
    bool anyMatched = false;

    if (activeFilters[AttendancePupilFilter.present]!) {
      anyActive = true;
      if (isPresent(event)) anyMatched = true;
    }
    if (activeFilters[AttendancePupilFilter.notPresent]!) {
      anyActive = true;
      if (isNotPresent(event)) anyMatched = true;
    }
    if (activeFilters[AttendancePupilFilter.unexcused]!) {
      anyActive = true;
      if (isUnexcused(event)) anyMatched = true;
    }

    return !anyActive || anyMatched;
  }
}
