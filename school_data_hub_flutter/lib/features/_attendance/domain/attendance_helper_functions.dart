import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/models/attendance_values.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

final _schoolCalendarManager = di<SchoolCalendarManager>();
final _attendanceManager = di<AttendanceManager>();
final _pupilManager = di<PupilManager>();

//- lookup functions
class AttendanceHelper {
  // static int? getMissedSchooldayIndex(PupilProxy pupil, DateTime date) {
  //   final int? foundMissedSchooldayIndex = pupil.missedSchooldays?.indexWhere(
  //       (datematch) => (datematch.schoolday!.schoolday.isSameDate(date)));

  //   if (foundMissedSchooldayIndex == null) {
  //     return null;
  //   }

  //   return foundMissedSchooldayIndex;
  // }

  //- overview sums functions

  //- of all pupils

  static int missedGlobalSum() {
    int missedGlobalSum = 0;
    final List<PupilProxy> allPupils = _pupilManager.allPupils;
    for (PupilProxy pupil in allPupils) {
      final missedSchooldays =
          _attendanceManager
              .getPupilMissedSchooldaysProxy(pupil.pupilId)
              .missedSchooldays;
      if (missedSchooldays.isNotEmpty) {
        missedGlobalSum +=
            missedSchooldays
                .where(
                  (element) =>
                      element.missedType == MissedType.missed ||
                      element.missedType == MissedType.home ||
                      element.returned == true,
                )
                .length;
      }
    }
    return missedGlobalSum;
  }

  static int unexcusedGlobalSum() {
    int unexcusedGlobalSum = 0;
    final List<PupilProxy> allPupils = _pupilManager.allPupils;
    for (PupilProxy pupil in allPupils) {
      final missedSchooldays =
          _attendanceManager
              .getPupilMissedSchooldaysProxy(pupil.pupilId)
              .missedSchooldays;

      if (missedSchooldays.isNotEmpty) {
        unexcusedGlobalSum +=
            missedSchooldays
                .where(
                  (element) =>
                      element.missedType == MissedType.missed &&
                      element.unexcused == true,
                )
                .length;
      }
    }
    return unexcusedGlobalSum;
  }

  static int lateGlobalSum() {
    int lateGlobalSum = 0;
    final List<PupilProxy> allPupils = _pupilManager.allPupils;
    for (PupilProxy pupil in allPupils) {
      final missedSchooldays =
          _attendanceManager
              .getPupilMissedSchooldaysProxy(pupil.pupilId)
              .missedSchooldays;

      if (missedSchooldays.isNotEmpty) {
        lateGlobalSum +=
            missedSchooldays
                .where((element) => element.missedType == MissedType.late)
                .length;
      }
    }
    return lateGlobalSum;
  }

  static int contactedGlobalSum() {
    int contactedGlobalSum = 0;
    final List<PupilProxy> allPupils = _pupilManager.allPupils;
    for (PupilProxy pupil in allPupils) {
      final missedSchooldays =
          _attendanceManager
              .getPupilMissedSchooldaysProxy(pupil.pupilId)
              .missedSchooldays;

      if (missedSchooldays.isNotEmpty) {
        contactedGlobalSum +=
            missedSchooldays
                .where((element) => element.contacted != ContactedType.notSet)
                .length;
      }
    }
    return contactedGlobalSum;
  }

  static int pickedUpGlobalSum() {
    int pickedUpGlobalSum = 0;
    final List<PupilProxy> allPupils = _pupilManager.allPupils;
    for (PupilProxy pupil in allPupils) {
      final missedSchooldays =
          _attendanceManager
              .getPupilMissedSchooldaysProxy(pupil.pupilId)
              .missedSchooldays;
      if (missedSchooldays.isNotEmpty) {
        pickedUpGlobalSum +=
            missedSchooldays
                .where((element) => element.returned == true)
                .length;
      }
    }
    return pickedUpGlobalSum;
  }

  //- of a list of pupils in a schoolday

  static int missedPupilsSum(
    List<PupilProxy> filteredPupils,
    DateTime thisDate,
  ) {
    List<PupilProxy> missedPupils = [];
    if (filteredPupils.isNotEmpty) {
      for (PupilProxy pupil in filteredPupils) {
        final missedSchooldays =
            _attendanceManager
                .getPupilMissedSchooldaysProxy(pupil.pupilId)
                .missedSchooldays;
        if (missedSchooldays.any(
          (missedSchoolday) =>
              missedSchoolday.schoolday!.schoolday.isSameDate(thisDate) &&
              (missedSchoolday.missedType == MissedType.missed ||
                  missedSchoolday.missedType == MissedType.home ||
                  missedSchoolday.returned == true),
        )) {
          missedPupils.add(pupil);
        }
      }
      return missedPupils.length;
    }
    return 0;
  }

  static int missedAndUnexcusedPupilsSum(
    List<PupilProxy> filteredPupils,
    DateTime thisDate,
  ) {
    List<PupilProxy> unexcusedPupils = [];

    for (PupilProxy pupil in filteredPupils) {
      final missedSchooldays =
          _attendanceManager
              .getPupilMissedSchooldaysProxy(pupil.pupilId)
              .missedSchooldays;
      if (missedSchooldays.any(
        (missedSchoolday) =>
            missedSchoolday.schoolday!.schoolday.isSameDate(thisDate) &&
            missedSchoolday.missedType == MissedType.missed &&
            missedSchoolday.unexcused == true,
      )) {
        unexcusedPupils.add(pupil);
      }
    }

    return unexcusedPupils.length;
  }

  //- of a list of pupils

  static int pupilListMissedclassSum(List<PupilProxy> filteredPupils) {
    int pupilsListmissedclassSum = 0;
    for (PupilProxy pupil in filteredPupils) {
      pupilsListmissedclassSum += missedclassExcusedSum(pupil);
    }
    return pupilsListmissedclassSum;
  }

  static int pupilListUnexcusedSum(List<PupilProxy> filteredPupils) {
    int pupilsListUnexcusedSum = 0;
    for (PupilProxy pupil in filteredPupils) {
      pupilsListUnexcusedSum += missedclassUnexcusedSum(pupil);
    }
    return pupilsListUnexcusedSum;
  }

  static int pupilListLateSum(List<PupilProxy> filteredPupils) {
    int pupilsListLateSum = 0;
    for (PupilProxy pupil in filteredPupils) {
      pupilsListLateSum += lateSum(pupil);
    }
    return pupilsListLateSum;
  }

  static int pupilListContactedSum(List<PupilProxy> filteredPupils) {
    int pupilsListContactedSum = 0;
    for (PupilProxy pupil in filteredPupils) {
      pupilsListContactedSum += contactedSum(pupil);
    }
    return pupilsListContactedSum;
  }

  static int pupilListPickedUpSum(List<PupilProxy> filteredPupils) {
    int pupilsListPickedUpSum = 0;
    for (PupilProxy pupil in filteredPupils) {
      pupilsListPickedUpSum += goneHomeSum(pupil);
    }
    return pupilsListPickedUpSum;
  }
  //- of a single pupil

  static int missedclassExcusedSum(PupilProxy pupil) {
    // count the number of missed classes - avoid null when missedSchooldays is empty
    int missedclassCount = 0;
    final missedSchooldays =
        _attendanceManager
            .getPupilMissedSchooldaysProxy(pupil.pupilId)
            .missedSchooldays;
    if (missedSchooldays.isNotEmpty) {
      missedclassCount =
          missedSchooldays
              .where(
                (element) =>
                    element.missedType == MissedType.missed &&
                    element.unexcused == false,
              )
              .length;
    }
    return missedclassCount;
  }

  static int missedclassUnexcusedSum(PupilProxy pupil) {
    // count the number of unexcused missed classes
    int missedclassCount = 0;
    final missedSchooldays =
        _attendanceManager
            .getPupilMissedSchooldaysProxy(pupil.pupilId)
            .missedSchooldays;
    if (missedSchooldays.isNotEmpty) {
      missedclassCount =
          missedSchooldays
              .where(
                (element) =>
                    element.missedType == MissedType.missed &&
                    element.unexcused == true,
              )
              .length;
    }
    return missedclassCount;
  }

  static int lateSum(PupilProxy pupil) {
    int lateCount = 0;
    final missedSchooldays =
        _attendanceManager
            .getPupilMissedSchooldaysProxy(pupil.pupilId)
            .missedSchooldays;
    if (missedSchooldays.isNotEmpty) {
      lateCount =
          missedSchooldays
              .where((element) => element.missedType == MissedType.late)
              .length;
    }
    return lateCount;
  }

  static int lateUnexcusedSum(PupilProxy pupil) {
    int missedSchooldayUnexcusedCount = 0;
    final missedSchooldays =
        _attendanceManager
            .getPupilMissedSchooldaysProxy(pupil.pupilId)
            .missedSchooldays;
    if (missedSchooldays.isNotEmpty) {
      missedSchooldayUnexcusedCount =
          missedSchooldays
              .where(
                (element) =>
                    element.missedType == MissedType.late &&
                    element.unexcused == true,
              )
              .length;
    }
    return missedSchooldayUnexcusedCount;
  }

  static int contactedSum(PupilProxy pupil) {
    final missedSchooldays =
        _attendanceManager
            .getPupilMissedSchooldaysProxy(pupil.pupilId)
            .missedSchooldays;
    int contactedCount =
        missedSchooldays
            .where((element) => element.contacted != ContactedType.notSet)
            .length;

    return contactedCount;
  }

  static int goneHomeSum(PupilProxy pupil) {
    final missedSchooldays =
        _attendanceManager
            .getPupilMissedSchooldaysProxy(pupil.pupilId)
            .missedSchooldays;
    int goneHomeCount =
        missedSchooldays.where((element) => element.returned == true).length;

    return goneHomeCount;
  }

  //- check condition functions

  static bool pupilIsMissedToday(PupilProxy pupil) {
    final missedSchooldays =
        _attendanceManager
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
    if (schoolday.isSameDate(DateTime.now().toUtc())) {
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
    final String? comment = missedSchoolday.comment;

    return AttendanceValues(
      missedTypeValue: missedType,
      contactedTypeValue: contactedType,
      createdOrModifiedByValue: createdOrModifiedBy,
      unexcusedValue: unexcused,
      returnedValue: returned,
      returnedTimeValue: returnedTime,
      commentValue: comment,
    );
  }

  static bool isMissedSchooldayinSemester(
    MissedSchoolday missedSchoolday,
    SchoolSemester schoolSemester,
  ) {
    return missedSchoolday.schoolday!.schoolday.isAfter(
          schoolSemester.startDate,
        ) &&
        missedSchoolday.schoolday!.schoolday.isBefore(schoolSemester.endDate);
  }

  static ({int missed, int unexcused}) missedHoursforSemesterOrSchoolyear(
    PupilProxy pupil,
  ) {
    // TODO: This is somehow broken, check again!
    // The law in NRW Germany requires that absences are counted in hours
    // The function returns absence hours and unexcused hours for the current semester
    // (for grades 3 and 4)
    // in the last semester for the school year (for grades 1 and 2)
    final missedSchooldays =
        _attendanceManager
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
              semester.startDate.isBefore(now) && semester.endDate.isAfter(now),
        ) ??
        schoolSemesters.last;

    final List<MissedSchoolday> missedSchooldaysThisSemester =
        missedSchooldays
            .where(
              (missedSchoolday) =>
                  isMissedSchooldayinSemester(
                    missedSchoolday,
                    currentSemester,
                  ) &&
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
