import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/models/attendance_values.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

final _schooldayManager = di<SchooldayManager>();
final _attendanceManager = di<AttendanceManager>();
final _pupilManager = di<PupilManager>();

//- lookup functions
class AttendanceHelper {
  // static int? getMissedClassIndex(PupilProxy pupil, DateTime date) {
  //   final int? foundMissedClassIndex = pupil.missedClasses?.indexWhere(
  //       (datematch) => (datematch.schoolday!.schoolday.isSameDate(date)));

  //   if (foundMissedClassIndex == null) {
  //     return null;
  //   }

  //   return foundMissedClassIndex;
  // }

//- overview sums functions

//- of all pupils

  static int missedGlobalSum() {
    int missedGlobalSum = 0;
    final List<PupilProxy> allPupils = _pupilManager.allPupils;
    for (PupilProxy pupil in allPupils) {
      if (pupil.missedClasses!.isNotEmpty) {
        missedGlobalSum += pupil.missedClasses!
            .where((element) =>
                element.missedType == MissedType.isMissed.value ||
                element.missedType == MissedType.goneHome.value ||
                element.returned == true)
            .length;
      }
    }
    return missedGlobalSum;
  }

  static int unexcusedGlobalSum() {
    int unexcusedGlobalSum = 0;
    final List<PupilProxy> allPupils = _pupilManager.allPupils;
    for (PupilProxy pupil in allPupils) {
      if (pupil.missedClasses!.isNotEmpty) {
        unexcusedGlobalSum += pupil.missedClasses!
            .where((element) =>
                element.missedType == 'missed' && element.unexcused == true)
            .length;
      }
    }
    return unexcusedGlobalSum;
  }

  static int lateGlobalSum() {
    int lateGlobalSum = 0;
    final List<PupilProxy> allPupils = _pupilManager.allPupils;
    for (PupilProxy pupil in allPupils) {
      if (pupil.missedClasses!.isNotEmpty) {
        lateGlobalSum += pupil.missedClasses!
            .where((element) => element.missedType == 'late')
            .length;
      }
    }
    return lateGlobalSum;
  }

  static int contactedGlobalSum() {
    int contactedGlobalSum = 0;
    final List<PupilProxy> allPupils = _pupilManager.allPupils;
    for (PupilProxy pupil in allPupils) {
      if (pupil.missedClasses!.isNotEmpty) {
        contactedGlobalSum += pupil.missedClasses!
            .where((element) => element.contacted != '0')
            .length;
      }
    }
    return contactedGlobalSum;
  }

  static int pickedUpGlobalSum() {
    int pickedUpGlobalSum = 0;
    final List<PupilProxy> allPupils = _pupilManager.allPupils;
    for (PupilProxy pupil in allPupils) {
      if (pupil.missedClasses!.isNotEmpty) {
        pickedUpGlobalSum += pupil.missedClasses!
            .where((element) => element.returned == true)
            .length;
      }
    }
    return pickedUpGlobalSum;
  }

//- of a list of pupils in a schoolday

  static int missedPupilsSum(
      List<PupilProxy> filteredPupils, DateTime thisDate) {
    List<PupilProxy> missedPupils = [];
    if (filteredPupils.isNotEmpty) {
      for (PupilProxy pupil in filteredPupils) {
        if (pupil.missedClasses!.any((missedClass) =>
            missedClass.schoolday!.schoolday == thisDate &&
            (missedClass.missedType == MissedType.isMissed.value ||
                missedClass.missedType == 'home' ||
                missedClass.returned == true))) {
          missedPupils.add(pupil);
        }
      }
      return missedPupils.length;
    }
    return 0;
  }

  static int missedAndUnexcusedPupilsSum(
      List<PupilProxy> filteredPupils, DateTime thisDate) {
    List<PupilProxy> unexcusedPupils = [];

    for (PupilProxy pupil in filteredPupils) {
      if (pupil.missedClasses!.any((missedClass) =>
          missedClass.schoolday!.schoolday == thisDate &&
          missedClass.missedType == MissedType.isMissed.value &&
          missedClass.unexcused == true)) {
        unexcusedPupils.add(pupil);
      }
    }

    return unexcusedPupils.length;
  }

//- of a list of pupils

  static int pupilListMissedclassSum(List<PupilProxy> filteredPupils) {
    int pupilsListmissedclassSum = 0;
    for (PupilProxy pupil in filteredPupils) {
      pupilsListmissedclassSum += missedclassSum(pupil);
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

  static int missedclassSum(PupilProxy pupil) {
    // count the number of missed classes - avoid null when missedClasses is empty
    int missedclassCount = 0;
    if (pupil.missedClasses != null) {
      missedclassCount = pupil.missedClasses!
          .where((element) =>
              element.missedType == 'missed' && element.unexcused == false)
          .length;
    }
    return missedclassCount;
  }

  static int missedclassUnexcusedSum(PupilProxy pupil) {
    // count the number of unexcused missed classes
    int missedclassCount = 0;
    if (pupil.missedClasses != null) {
      missedclassCount = pupil.missedClasses!
          .where((element) =>
              element.missedType == 'missed' && element.unexcused == true)
          .length;
    }
    return missedclassCount;
  }

  static int lateSum(PupilProxy pupil) {
    int lateCount = 0;
    if (pupil.missedClasses != null) {
      lateCount = pupil.missedClasses!
          .where((element) => element.missedType == 'late')
          .length;
    }
    return lateCount;
  }

  static int lateUnexcusedSum(PupilProxy pupil) {
    int missedClassUnexcusedCount = 0;
    if (pupil.missedClasses != null) {
      missedClassUnexcusedCount = pupil.missedClasses!
          .where((element) =>
              element.missedType == 'late' && element.unexcused == true)
          .length;
    }
    return missedClassUnexcusedCount;
  }

  static int contactedSum(PupilProxy pupil) {
    int contactedCount = pupil.missedClasses!
        .where((element) => element.contacted != '0')
        .length;

    return contactedCount;
  }

  static int goneHomeSum(PupilProxy pupil) {
    int goneHomeCount = pupil.missedClasses!
        .where((element) => element.returned == true)
        .length;

    return goneHomeCount;
  }

//- check condition functions

  static bool pupilIsMissedToday(PupilProxy pupil) {
    if (pupil.missedClasses!.isEmpty) return false;
    if (pupil.missedClasses!.any((element) =>
        element.schoolday!.schoolday.isSameDate(DateTime.now()) &&
        element.missedType != 'late')) {
      return true;
    }
    return false;
  }

  static bool schooldayIsToday(DateTime schoolday) {
    if (schoolday.isSameDate(DateTime.now())) {
      return true;
    }
    return false;
  }

// use one function instead all the set value functions
// to avoid unnecessary lookups
  static AttendanceValues setAttendanceValues(int pupilId, DateTime date) {
    MissedType missedType;

    ContactedType contactedType;

    final missedClass =
        _attendanceManager.getPupilMissedClassOnDate(pupilId, date);

    if (missedClass == null) {
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
      final dropdownvalue = missedClass.missedType;
      missedType =
          MissedType.values.firstWhere((e) => e.value == dropdownvalue);
    }

    final contactedValue = missedClass.contacted;
    contactedType = ContactedType.values
            .firstWhereOrNull((e) => e.value == contactedValue) ??
        ContactedType.notSet;

    String createdOrModifiedBy =
        missedClass.modifiedBy ?? missedClass.createdBy;

    final bool unexcused = missedClass.unexcused;
    final bool returned = missedClass.returned;
    final DateTime? returnedTime = missedClass.returnedAt;
    final String? comment = missedClass.comment;

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

  bool isMissedClassinSemester(
      MissedClass missedClass, SchoolSemester schoolSemester) {
    return missedClass.schoolday!.schoolday.isAfter(schoolSemester.startDate) &&
        missedClass.schoolday!.schoolday.isBefore(schoolSemester.endDate);
  }

  List<int> missedHoursforSemesterOrSchoolyear(PupilProxy pupil) {
    // The law in NRW Germany requires that absences are counted in hours
    // The function returns absence hours and unexcused hours for the current semester
    // (for grades 3 and 4)
    // in the last semester for the school year (for grades 1 and 2)

    // if no missed classes, we return 0, 0
    if (pupil.missedClasses == null || pupil.missedClasses!.isEmpty) {
      return [0, 0];
    }
    final List<MissedClass> missedClasses = pupil.missedClasses!;
    final List<SchoolSemester> schoolSemesters =
        _schooldayManager.schoolSemesters.value;
    final DateTime now = DateTime.now();

    final SchoolSemester currentSemester = schoolSemesters.firstWhereOrNull(
            (semester) =>
                semester.startDate.isBefore(now) &&
                semester.endDate.isAfter(now)) ??
        schoolSemesters.last;

    final List<MissedClass> missedClassesThisSemester = missedClasses
        .where((missedClass) =>
            isMissedClassinSemester(missedClass, currentSemester) &&
            missedClass.missedType == MissedType.isMissed.value)
        .toList();
    final List<MissedClass> unexcusedMissedClassesThisSemester =
        missedClassesThisSemester
            .where((missedClass) => missedClass.unexcused == true)
            .toList();
    if (currentSemester.isFirst) {
      switch (pupil.schoolGrade) {
        case SchoolGrade.E1:
        case SchoolGrade.E2:
        case SchoolGrade.E3:
          // for class 1 and 2 the average hours per day are 4
          final int missedHoursThisSemester =
              missedClassesThisSemester.length * 4;
          final int unExcusedMissedHoursThisSemester =
              unexcusedMissedClassesThisSemester.length * 4;
          return [missedHoursThisSemester, unExcusedMissedHoursThisSemester];

        case SchoolGrade.S3:
        case SchoolGrade.S4:
          // for class 1 and 2 the average hours per day are 5
          final int missedHoursThisSemester =
              missedClassesThisSemester.length * 5;
          final int unExcusedMissedHoursThisSemester =
              unexcusedMissedClassesThisSemester.length * 5;
          return [missedHoursThisSemester, unExcusedMissedHoursThisSemester];
      }
    } else {
      switch (pupil.schoolGrade) {
        case SchoolGrade.E1:
        case SchoolGrade.E2:
        case SchoolGrade.E3:
          // for class 1 and 2 the average hours per day are 4
          // being the last semester of the school year,
          // we need to acount for last semester, too
          final SchoolSemester lastSemester =
              schoolSemesters.firstWhere((semester) =>
                  // last semester is the one with the year of end date being the same as the year of the current semester
                  semester.endDate.year == currentSemester.endDate.year);
          final List<MissedClass> missedClassesLastSemester = missedClasses
              .where((missedClass) =>
                  isMissedClassinSemester(missedClass, lastSemester) &&
                  missedClass.missedType == MissedType.isMissed.value)
              .toList();
          final List<MissedClass> unexcusedMissedClassesLastSemester =
              missedClassesLastSemester
                  .where((missedClass) => missedClass.unexcused == true)
                  .toList();
          final int missedHoursThisSemester =
              missedClassesThisSemester.length * 4;
          final int unExcusedMissedHoursThisSemester =
              unexcusedMissedClassesThisSemester.length * 4;
          final int missedHoursLastSemester =
              missedClassesLastSemester.length * 4;
          final int unExcusedMissedHoursLastSemester =
              unexcusedMissedClassesLastSemester.length * 4;
          return [
            missedHoursThisSemester + missedHoursLastSemester,
            unExcusedMissedHoursThisSemester + unExcusedMissedHoursLastSemester
          ];
        case SchoolGrade.S3:
        case SchoolGrade.S4:
          final int missedHoursThisSemester =
              missedClassesThisSemester.length * 5;
          final int unExcusedMissedHoursThisSemester =
              unexcusedMissedClassesThisSemester.length * 5;
          return [missedHoursThisSemester, unExcusedMissedHoursThisSemester];
      }
    }
  }
//- Date functions

  static Future<void> setThisDate(
      BuildContext context, DateTime thisDate) async {
    final DateTime? newDate = await selectSchooldayDate(context, thisDate);
    if (newDate != null) {
      _schooldayManager.setThisDate(newDate);
    }
  }
}
