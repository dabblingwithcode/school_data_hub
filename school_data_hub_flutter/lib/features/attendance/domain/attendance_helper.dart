import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/models/attendance_values.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

//- lookup functions
class AttendanceHelper {
  static SchoolCalendarManager get _schoolCalendarManager =>
      di<SchoolCalendarManager>();
  static AttendanceManager get _attendanceManager => di<AttendanceManager>();

  // static int? getMissedSchooldayIndex(PupilProxy pupil, DateTime date) {
  //   final int? foundMissedSchooldayIndex = pupil.missedSchooldays?.indexWhere(
  //       (datematch) => (datematch.schoolday!.schoolday.isSameDate(date)));

  //   if (foundMissedSchooldayIndex == null) {
  //     return null;
  //   }

  //   return foundMissedSchooldayIndex;
  // }

  //- check condition functions

  static bool pupilIsMissedToday(PupilProxy pupil) {
    final missedSchooldays = _attendanceManager
        .getPupilMissedSchooldaysProxy(pupil.pupilId)
        .missedSchooldays;
    if (missedSchooldays.isEmpty) return false;
    if (missedSchooldays.any(
      (element) =>
          element.schoolday!.schoolday.isSameDate(DateTime.now()) &&
          element.missedType != MissedType.late,
    )) {
      return true;
    }
    return false;
  }

  static bool schooldayIsToday(DateTime schoolday) {
    if (schoolday.year == DateTime.now().toUtc().year &&
        schoolday.month == DateTime.now().toUtc().month &&
        schoolday.day == DateTime.now().toUtc().day) {
      return true;
    }
    return false;
  }

  // use one function instead all the set value functions
  // to avoid unnecessary lookups
  static AttendanceValues getAttendanceValues(
    MissedSchoolday? missedSchoolday,
  ) {
    MissedType missedType;

    ContactedType contactedType;

    if (missedSchoolday == null) {
      return AttendanceValues(
        missedTypeValue: MissedType.notSet,
        contactedTypeValue: ContactedType.notSet,
        createdOrModifiedByValue: null,
        unexcusedValue: false,
        returnedValue: false,
        returnedTimeValue: null,
        commentValue: null,
      );
    } else {
      missedType = missedSchoolday.missedType;
      //  missedType = MissedType.values.firstWhere((e) => e == dropdownvalue);
    }

    contactedType = missedSchoolday.contacted;

    String createdOrModifiedBy =
        missedSchoolday.modifiedBy ?? missedSchoolday.createdBy;

    final bool unexcused = missedSchoolday.unexcused;
    final bool returned = missedSchoolday.returned;
    final DateTime? returnedTime = missedSchoolday.returnedAt;
    final int? minutesLate = missedSchoolday.minutesLate;
    final String? comment = missedSchoolday.comment;

    return AttendanceValues(
      missedTypeValue: missedType,
      contactedTypeValue: contactedType,
      createdOrModifiedByValue: createdOrModifiedBy,
      unexcusedValue: unexcused,
      returnedValue: returned,
      returnedTimeValue: returnedTime,
      minutesLateValue: minutesLate,
      commentValue: comment,
    );
  }

  static bool isMissedSchooldayinSemester(
    MissedSchoolday missedSchoolday,
    SchoolSemester schoolSemester,
  ) {
    return !missedSchoolday.schoolday!.schoolday.isBefore(
          schoolSemester.startDate,
        ) &&
        !missedSchoolday.schoolday!.schoolday.isAfter(schoolSemester.endDate);
  }

  static ({int missed, int unexcused}) missedHoursforSemesterOrSchoolyear(
    PupilProxy pupil,
  ) {
    // The law in NRW Germany requires that absences are counted in hours
    // The function returns absence hours and unexcused hours for the current semester
    // (for grades 3 and 4)
    // in the last semester for the school year (for grades 1 and 2)
    final missedSchooldays = _attendanceManager
        .getPupilMissedSchooldaysProxy(pupil.pupilId)
        .missedSchooldays;
    // if no missed classes, we return 0, 0
    if (missedSchooldays.isEmpty) {
      return (missed: 0, unexcused: 0);
    }

    final List<SchoolSemester> schoolSemesters =
        _schoolCalendarManager.schoolSemesters.value;
    final DateTime now = DateTime.now().toUtc();

    final SchoolSemester currentSemester =
        schoolSemesters.firstWhereOrNull(
          (semester) =>
              !semester.startDate.isAfter(now) &&
              !semester.endDate.isBefore(now),
        ) ??
        schoolSemesters.last;

    final List<MissedSchoolday> missedSchooldaysThisSemester = missedSchooldays
        .where(
          (missedSchoolday) =>
              isMissedSchooldayinSemester(missedSchoolday, currentSemester) &&
              missedSchoolday.missedType == MissedType.missed,
        )
        .toList();
    final List<MissedSchoolday> unexcusedMissedSchooldayesThisSemester =
        missedSchooldaysThisSemester
            .where((missedSchoolday) => missedSchoolday.unexcused == true)
            .toList();
    if (currentSemester.isFirst) {
      switch (pupil.schoolGrade) {
        case SchoolGrade.E1:
        case SchoolGrade.E2:
        case SchoolGrade.E3:
          // for class 1 and 2 the average hours per day are 4
          final int missedHoursThisSemester =
              missedSchooldaysThisSemester.length * 4;
          final int unExcusedMissedHoursThisSemester =
              unexcusedMissedSchooldayesThisSemester.length * 4;
          return (
            missed: missedHoursThisSemester,
            unexcused: unExcusedMissedHoursThisSemester,
          );

        case SchoolGrade.K3:
        case SchoolGrade.K4:
          // for class 1 and 2 the average hours per day are 5
          final int missedHoursThisSemester =
              missedSchooldaysThisSemester.length * 5;
          final int unExcusedMissedHoursThisSemester =
              unexcusedMissedSchooldayesThisSemester.length * 5;
          return (
            missed: missedHoursThisSemester,
            unexcused: unExcusedMissedHoursThisSemester,
          );
      }
    } else {
      switch (pupil.schoolGrade) {
        case SchoolGrade.E1:
        case SchoolGrade.E2:
        case SchoolGrade.E3:
          // for class 1 and 2 the average hours per day are 4
          // being the last semester of the school year,
          // we need to acount for last semester, too

          final SchoolSemester? lastSemester = schoolSemesters.firstWhereOrNull(
            (semester) =>
                // last semester is the one with the year of end date being the same as the year of the current semester
                semester.startDate.year != currentSemester.startDate.year &&
                semester.endDate.year == currentSemester.endDate.year,
          );
          if (lastSemester != null) {
            final List<MissedSchoolday> missedSchooldaysLastSemester =
                missedSchooldays
                    .where(
                      (missedSchoolday) =>
                          isMissedSchooldayinSemester(
                            missedSchoolday,
                            lastSemester,
                          ) &&
                          missedSchoolday.missedType == MissedType.missed,
                    )
                    .toList();
            final List<MissedSchoolday> unexcusedMissedSchooldayesLastSemester =
                missedSchooldaysLastSemester
                    .where(
                      (missedSchoolday) => missedSchoolday.unexcused == true,
                    )
                    .toList();
            final int missedHoursThisSemester =
                missedSchooldaysThisSemester.length * 4;
            final int unExcusedMissedHoursThisSemester =
                unexcusedMissedSchooldayesThisSemester.length * 4;
            final int missedHoursLastSemester =
                missedSchooldaysLastSemester.length * 4;
            final int unExcusedMissedHoursLastSemester =
                unexcusedMissedSchooldayesLastSemester.length * 4;
            return (
              missed: missedHoursThisSemester + missedHoursLastSemester,
              unexcused:
                  unExcusedMissedHoursThisSemester +
                  unExcusedMissedHoursLastSemester,
            );
          } else {
            // if no last semester found, we return only the current semester
            final int missedHoursThisSemester =
                missedSchooldaysThisSemester.length * 4;
            final int unExcusedMissedHoursThisSemester =
                unexcusedMissedSchooldayesThisSemester.length * 4;
            return (
              missed: missedHoursThisSemester,
              unexcused: unExcusedMissedHoursThisSemester,
            );
          }

        case SchoolGrade.K3:
        case SchoolGrade.K4:
          final int missedHoursThisSemester =
              missedSchooldaysThisSemester.length * 5;
          final int unExcusedMissedHoursThisSemester =
              unexcusedMissedSchooldayesThisSemester.length * 5;
          return (
            missed: missedHoursThisSemester,
            unexcused: unExcusedMissedHoursThisSemester,
          );
      }
    }
  }

  /// Returns the list of valid schooldays within [startDate]..[endDate] (inclusive).
  static List<Schoolday> schooldaysInRange({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final validDates = _schoolCalendarManager.availableDates.value;
    final schooldays = <Schoolday>[];
    for (final date in validDates) {
      if (date.isSameDate(startDate) ||
          date.isSameDate(endDate) ||
          (date.isAfterDate(startDate) && date.isBeforeDate(endDate))) {
        final schoolday = _schoolCalendarManager.getSchooldayByDate(date);
        if (schoolday != null) {
          schooldays.add(schoolday);
        }
      }
    }
    return schooldays;
  }

  //- Date functions

  static Future<void> setThisDate(
    BuildContext context,
    DateTime thisDate,
  ) async {
    final DateTime? newDate = await selectSchooldayDate(context, thisDate);

    if (newDate == null) {
      return;
    }

    _schoolCalendarManager.setThisDate(newDate);
  }
}
