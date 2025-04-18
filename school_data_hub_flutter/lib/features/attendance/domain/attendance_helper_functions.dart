// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
// import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
// import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
// import 'package:watch_it/watch_it.dart';

// class AttendanceValues {
//   final MissedType missedTypeValue;
//   final ContactedType contactedTypeValue;
//   final String? createdOrModifiedByValue;
//   final bool unexcusedValue;
//   final bool returnedValue;
//   final String? returnedTimeValue;
//   final String? commentValue;

//   AttendanceValues({
//     required this.missedTypeValue,
//     required this.contactedTypeValue,
//     required this.createdOrModifiedByValue,
//     required this.unexcusedValue,
//     this.returnedValue = false,
//     this.returnedTimeValue,
//     this.commentValue,
//   });
// }

// //- lookup functions
// class AttendanceHelper {
//   static int? getMissedClassIndex(PupilProxy pupil, DateTime date) {
//     final int? foundMissedClassIndex = pupil.missedClasses
//         ?.indexWhere((datematch) => (datematch.missedDay.isSameDate(date)));

//     if (foundMissedClassIndex == null) {
//       return null;
//     }

//     return foundMissedClassIndex;
//   }

// //- overview sums functions

// //- of all pupils

//   static int missedGlobalSum() {
//     int missedGlobalSum = 0;
//     final List<PupilProxy> allPupils = locator<PupilManager>().allPupils;
//     for (PupilProxy pupil in allPupils) {
//       if (pupil.missedClasses!.isNotEmpty) {
//         missedGlobalSum += pupil.missedClasses!
//             .where((element) =>
//                 element.missedType == 'missed' ||
//                 element.missedType == 'home' ||
//                 element.backHome == true)
//             .length;
//       }
//     }
//     return missedGlobalSum;
//   }

//   static int unexcusedGlobalSum() {
//     int unexcusedGlobalSum = 0;
//     final List<PupilProxy> allPupils = locator<PupilManager>().allPupils;
//     for (PupilProxy pupil in allPupils) {
//       if (pupil.missedClasses!.isNotEmpty) {
//         unexcusedGlobalSum += pupil.missedClasses!
//             .where((element) =>
//                 element.missedType == 'missed' && element.unexcused == true)
//             .length;
//       }
//     }
//     return unexcusedGlobalSum;
//   }

//   static int lateGlobalSum() {
//     int lateGlobalSum = 0;
//     final List<PupilProxy> allPupils = locator<PupilManager>().allPupils;
//     for (PupilProxy pupil in allPupils) {
//       if (pupil.missedClasses!.isNotEmpty) {
//         lateGlobalSum += pupil.missedClasses!
//             .where((element) => element.missedType == 'late')
//             .length;
//       }
//     }
//     return lateGlobalSum;
//   }

//   static int contactedGlobalSum() {
//     int contactedGlobalSum = 0;
//     final List<PupilProxy> allPupils = locator<PupilManager>().allPupils;
//     for (PupilProxy pupil in allPupils) {
//       if (pupil.missedClasses!.isNotEmpty) {
//         contactedGlobalSum += pupil.missedClasses!
//             .where((element) => element.contacted != '0')
//             .length;
//       }
//     }
//     return contactedGlobalSum;
//   }

//   static int pickedUpGlobalSum() {
//     int pickedUpGlobalSum = 0;
//     final List<PupilProxy> allPupils = locator<PupilManager>().allPupils;
//     for (PupilProxy pupil in allPupils) {
//       if (pupil.missedClasses!.isNotEmpty) {
//         pickedUpGlobalSum += pupil.missedClasses!
//             .where((element) => element.backHome == true)
//             .length;
//       }
//     }
//     return pickedUpGlobalSum;
//   }

// //- of a list of pupils in a schoolday

//   static int missedPupilsSum(
//       List<PupilProxy> filteredPupils, DateTime thisDate) {
//     List<PupilProxy> missedPupils = [];
//     if (filteredPupils.isNotEmpty) {
//       for (PupilProxy pupil in filteredPupils) {
//         if (pupil.missedClasses!.any((missedClass) =>
//             missedClass.missedDay == thisDate &&
//             (missedClass.missedType == 'missed' ||
//                 missedClass.missedType == 'home' ||
//                 missedClass.backHome == true))) {
//           missedPupils.add(pupil);
//         }
//       }
//       return missedPupils.length;
//     }
//     return 0;
//   }

//   static int missedAndUnexcusedPupilsSum(
//       List<PupilProxy> filteredPupils, DateTime thisDate) {
//     List<PupilProxy> unexcusedPupils = [];

//     for (PupilProxy pupil in filteredPupils) {
//       if (pupil.missedClasses!.any((missedClass) =>
//           missedClass.missedDay == thisDate &&
//           missedClass.missedType == MissedType.isMissed.value &&
//           missedClass.unexcused == true)) {
//         unexcusedPupils.add(pupil);
//       }
//     }

//     return unexcusedPupils.length;
//   }

// //- of a list of pupils

//   static int pupilListMissedclassSum(List<PupilProxy> filteredPupils) {
//     int pupilsListmissedclassSum = 0;
//     for (PupilProxy pupil in filteredPupils) {
//       pupilsListmissedclassSum += missedclassSum(pupil);
//     }
//     return pupilsListmissedclassSum;
//   }

//   static int pupilListUnexcusedSum(List<PupilProxy> filteredPupils) {
//     int pupilsListUnexcusedSum = 0;
//     for (PupilProxy pupil in filteredPupils) {
//       pupilsListUnexcusedSum += missedclassUnexcusedSum(pupil);
//     }
//     return pupilsListUnexcusedSum;
//   }

//   static int pupilListLateSum(List<PupilProxy> filteredPupils) {
//     int pupilsListLateSum = 0;
//     for (PupilProxy pupil in filteredPupils) {
//       pupilsListLateSum += lateSum(pupil);
//     }
//     return pupilsListLateSum;
//   }

//   static int pupilListContactedSum(List<PupilProxy> filteredPupils) {
//     int pupilsListContactedSum = 0;
//     for (PupilProxy pupil in filteredPupils) {
//       pupilsListContactedSum += contactedSum(pupil);
//     }
//     return pupilsListContactedSum;
//   }

//   static int pupilListPickedUpSum(List<PupilProxy> filteredPupils) {
//     int pupilsListPickedUpSum = 0;
//     for (PupilProxy pupil in filteredPupils) {
//       pupilsListPickedUpSum += goneHomeSum(pupil);
//     }
//     return pupilsListPickedUpSum;
//   }
// //- of a single pupil

//   static int missedclassSum(PupilProxy pupil) {
//     // count the number of missed classes - avoid null when missedClasses is empty
//     int missedclassCount = 0;
//     if (pupil.missedClasses != null) {
//       missedclassCount = pupil.missedClasses!
//           .where((element) =>
//               element.missedType == 'missed' && element.unexcused == false)
//           .length;
//     }
//     return missedclassCount;
//   }

//   static int missedclassUnexcusedSum(PupilProxy pupil) {
//     // count the number of unexcused missed classes
//     int missedclassCount = 0;
//     if (pupil.missedClasses != null) {
//       missedclassCount = pupil.missedClasses!
//           .where((element) =>
//               element.missedType == 'missed' && element.unexcused == true)
//           .length;
//     }
//     return missedclassCount;
//   }

//   static int lateSum(PupilProxy pupil) {
//     int lateCount = 0;
//     if (pupil.missedClasses != null) {
//       lateCount = pupil.missedClasses!
//           .where((element) => element.missedType == 'late')
//           .length;
//     }
//     return lateCount;
//   }

//   static int lateUnexcusedSum(PupilProxy pupil) {
//     int missedClassUnexcusedCount = 0;
//     if (pupil.missedClasses != null) {
//       missedClassUnexcusedCount = pupil.missedClasses!
//           .where((element) =>
//               element.missedType == 'late' && element.unexcused == true)
//           .length;
//     }
//     return missedClassUnexcusedCount;
//   }

//   static int contactedSum(PupilProxy pupil) {
//     int contactedCount = pupil.missedClasses!
//         .where((element) => element.contacted != '0')
//         .length;

//     return contactedCount;
//   }

//   static int goneHomeSum(PupilProxy pupil) {
//     int goneHomeCount = pupil.missedClasses!
//         .where((element) => element.backHome == true)
//         .length;

//     return goneHomeCount;
//   }

// //- check condition functions

//   static bool pupilIsMissedToday(PupilProxy pupil) {
//     if (pupil.missedClasses!.isEmpty) return false;
//     if (pupil.missedClasses!.any((element) =>
//         element.missedDay.isSameDate(DateTime.now()) &&
//         element.missedType != 'late')) {
//       return true;
//     }
//     return false;
//   }

//   static bool schooldayIsToday(DateTime schoolday) {
//     if (schoolday.isSameDate(DateTime.now())) {
//       return true;
//     }
//     return false;
//   }

// // use one function instead all the set value functions
// // to avoid unnecessary lookups
//   static AttendanceValues setAttendanceValues(int pupilId, DateTime date) {
//     MissedType missedType;

//     ContactedType contactedType;

//     final PupilProxy pupil = locator<PupilManager>().getPupilById(pupilId)!;

//     final int? missedClass = getMissedClassIndex(pupil, date);

//     if (missedClass == -1 || missedClass == null) {
//       return AttendanceValues(
//         missedTypeValue: MissedType.notSet,
//         contactedTypeValue: ContactedType.notSet,
//         createdOrModifiedByValue: null,
//         unexcusedValue: false,
//         returnedValue: false,
//         returnedTimeValue: null,
//         commentValue: null,
//       );
//     } else {
//       final dropdownvalue = pupil.missedClasses![missedClass].missedType;
//       missedType =
//           MissedType.values.firstWhere((e) => e.value == dropdownvalue);
//     }

//     final contactedValue = pupil.missedClasses![missedClass].contacted;
//     contactedType = ContactedType.values
//             .firstWhereOrNull((e) => e.value == contactedValue) ??
//         ContactedType.notSet;

//     String createdOrModifiedBy = pupil.missedClasses![missedClass].modifiedBy ??
//         pupil.missedClasses![missedClass].createdBy;

//     final bool excused = pupil.missedClasses![missedClass].unexcused;
//     final bool returned = pupil.missedClasses![missedClass].backHome!;
//     final String? returnedTime = pupil.missedClasses![missedClass].backHomeAt;
//     final String? comment = pupil.missedClasses![missedClass].comment;

//     return AttendanceValues(
//       missedTypeValue: missedType,
//       contactedTypeValue: contactedType,
//       createdOrModifiedByValue: createdOrModifiedBy,
//       unexcusedValue: excused,
//       returnedValue: returned,
//       returnedTimeValue: returnedTime,
//       commentValue: comment,
//     );
//   }

// //- Date functions

//   static Future<void> setThisDate(
//       BuildContext context, DateTime thisDate) async {
//     final DateTime? newDate = await selectSchooldayDate(context, thisDate);
//     if (newDate != null) {
//       di<SchooldayManager>().setThisDate(newDate);
//     }
//   }

//   static String thisDateAsString(BuildContext context, DateTime thisDate) {
//     return '${DateFormat('EEEE', Localizations.localeOf(context).toString()).format(thisDate)}, ${thisDate.formatForUser()}';
//   }
// }
