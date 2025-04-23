import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/data/attendance_api_service.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

final _pupilManager = di<PupilManager>();

final _schooldayManager = di<SchooldayManager>();

final _notificationService = di<NotificationService>();

final _sessionManager = di<ServerpodSessionManager>();

final _log = Logger('AttendanceManager');

final _attendanceApiService = AttendanceApiService();

class AttendanceManager {
  ValueListenable<List<MissedClass>> get missedClasses => _missedClasses;
  final ValueNotifier<List<MissedClass>> _missedClasses = ValueNotifier([]);

  final Map<int, List<MissedClass>> _pupilMissedClassesMap = {};

  final Map<DateTime, List<MissedClass>> _schooldayMissedClassesMap = {};

  AttendanceManager() {
    init();
  }

  Future init() async {
    // await fetchMissedClassesOnASchoolday(schooldayManager.thisDate.value);
    fetchAllPupilMissedClasses();
    return;
  }

  //- Getters

  MissedClass? getPupilMissedClassOnDate(int pupilId, DateTime date) {
    return _schooldayMissedClassesMap[date]
        ?.firstWhereOrNull((element) => element.pupilId == pupilId);
  }

  List<MissedClass> getPupilMissedClasses(int pupilId) {
    return _pupilMissedClassesMap[pupilId] ?? [];
  }

  List<MissedClass> getSchooldayMissedClasses(DateTime date) {
    return _schooldayMissedClassesMap[date] ?? [];
  }

  // List<MissedClass> getMissedClassesOnADay(DateTime date) {
  //   return _missedClasses.value
  //       .where(
  //           (missedClass) => missedClass.schoolday!.schoolday.isSameDate(date))
  //       .toList();
  // }
  // - Handle collections -

  void _updateMissedClassesInCollections(List<MissedClass> missedClasses) {
    for (final missedClass in missedClasses) {
      updateMissedClassInCollections(missedClass);
    }
  }

  void updateMissedClassInCollections(MissedClass responseMissedClass) {
    final date = responseMissedClass.schoolday!.schoolday;

    final pupilId = responseMissedClass.pupilId;

    // 1. Update the main list
    final index = _missedClasses.value.indexWhere((element) =>
        element.schoolday!.schoolday == date && element.pupilId == pupilId);

    if (index != -1) {
      final newList = List<MissedClass>.from(_missedClasses.value);
      newList[index] = responseMissedClass;
      _missedClasses.value = newList;
    } else {
      _missedClasses.value = [..._missedClasses.value, responseMissedClass];
    }

    // 2. Update pupil map
    if (_pupilMissedClassesMap.containsKey(pupilId)) {
      final missedClassList = _pupilMissedClassesMap[pupilId]!;
      final missedClassIndex = missedClassList
          .indexWhere((element) => element.schoolday!.schoolday == date);

      if (missedClassIndex != -1) {
        missedClassList.removeAt(missedClassIndex);
        missedClassList.add(responseMissedClass);
        _pupilMissedClassesMap[pupilId] = missedClassList;
      }
    } else {
      _pupilMissedClassesMap[pupilId] = [responseMissedClass];
    }

    // 3. Update schoolday map
    final schooldayMissedClassList = _schooldayMissedClassesMap[date];
    if (schooldayMissedClassList == null) {
      _schooldayMissedClassesMap[date] = [responseMissedClass];
    } else {
      final schooldayMissedClassIndex = schooldayMissedClassList
          .indexWhere((element) => element.pupilId == pupilId);

      if (schooldayMissedClassIndex != -1) {
        schooldayMissedClassList.removeAt(schooldayMissedClassIndex);
        schooldayMissedClassList.add(responseMissedClass);
        _schooldayMissedClassesMap[date] = schooldayMissedClassList;
      } else {
        schooldayMissedClassList.add(responseMissedClass);
      }
    }
  }

  void removeMissedClassFromCollections(int pupilId, DateTime date) {
    // 1. Remove from the main list
    final index = _missedClasses.value.indexWhere((element) =>
        element.schoolday!.schoolday == date && element.pupilId == pupilId);

    if (index != -1) {
      final updatedMissedClasses = List<MissedClass>.from(_missedClasses.value);

      updatedMissedClasses.removeAt(index);

      _missedClasses.value = updatedMissedClasses;
    }
    // 2. Remove from pupil map
    if (_pupilMissedClassesMap.containsKey(pupilId)) {
      final missedClassList = _pupilMissedClassesMap[pupilId]!;
      final missedClassIndex = missedClassList
          .indexWhere((element) => element.schoolday!.schoolday == date);

      if (missedClassIndex != -1) {
        missedClassList.removeAt(missedClassIndex);
        _pupilMissedClassesMap[pupilId] = missedClassList;
      }
    }
    // 3. Remove from schoolday map
    final schooldayMissedClassList = _schooldayMissedClassesMap[date];
    if (schooldayMissedClassList != null) {
      final schooldayMissedClassIndex = schooldayMissedClassList
          .indexWhere((element) => element.pupilId == pupilId);

      if (schooldayMissedClassIndex != -1) {
        schooldayMissedClassList.removeAt(schooldayMissedClassIndex);
        _schooldayMissedClassesMap[date] = schooldayMissedClassList;
      }
    }
  }

  //- CRUD operantions

  void fetchAllPupilMissedClasses() async {
    final fetchedMissedClasses =
        await _attendanceApiService.fetchAllMissedClasses();

    _missedClasses.value = fetchedMissedClasses;
  }

  Future<void> fetchMissedClassesOnASchoolday(DateTime schoolday) async {
    final List<MissedClass> missedClasses =
        await _attendanceApiService.fetchMissedClassesOnASchoolday(schoolday);
    _missedClasses.value = [..._missedClasses.value, ...missedClasses];
    _updateMissedClassesInCollections(missedClasses);

    return;
  }

  Future<void> updateExcusedValue(
      int pupilId, DateTime date, bool newValue) async {
    final missedClass = getPupilMissedClassOnDate(pupilId, date);

    if (missedClass == null) {
      return;
    }

    final MissedClass responseMissedClass =
        await _attendanceApiService.updateMissedClass(
            missedClassId: missedClass.id!,
            pupilId: pupilId,
            date: date,
            excused: newValue);

    updateMissedClassInCollections(responseMissedClass);

    return;
  }

  Future<void> deleteMissedClass(int pupilId, DateTime date) async {
    final response = await _attendanceApiService.deleteMissedClass(
      pupilId,
      date,
    );

    if (response == true) {
      removeMissedClassFromCollections(pupilId, date);
      _notificationService.showSnackBar(
          NotificationType.success, 'Fehlzeit erfolgreich gelöscht!');
    } else {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehlzeit konnte nicht gelöscht werden!');
      return;
    }

    return;
  }

  Future<void> updateReturnedValue(
      int pupilId, bool newValue, DateTime date, String? time) async {
    final missedClass = getPupilMissedClassOnDate(pupilId, date);

    // pupils gone home during class for whatever reason
    //are marked as returned with a time stamp

    //- Case create a new missed class
    // if the missed class does not exist we have to create one with the type "none"

    if (missedClass == null) {
      // This missed class is new
      final MissedClass missedClass =
          await _attendanceApiService.postMissedClass(
        pupilId: pupilId,
        missedType: MissedType.notSet,
        date: date,
        unexcused: false,
        contactedType: ContactedType.notSet,
        returned: true,
        returnedAt: time,
      );
      updateMissedClassInCollections(missedClass);
      _notificationService.showSnackBar(
          NotificationType.success, 'Eintrag erfolgreich!');

      return;
    }

    //- Case delete 'none' + 'returned' missed class
    // The only way to delete a missed class with 'none' and 'returned' entries
    // is if we uncheck 'return' - let's check that

    if (newValue == false &&
        missedClass.missedType == MissedType.notSet.value) {
      final success = await _attendanceApiService.deleteMissedClass(
        pupilId,
        date,
      );
      if (success == true) {
        removeMissedClassFromCollections(pupilId, date);
        _notificationService.showSnackBar(
            NotificationType.success, 'Eintrag erfolgreich gelöscht!');
      } else {
        _notificationService.showSnackBar(
            NotificationType.error, 'Eintrag konnte nicht gelöscht werden!');
      }
      return;
    }

    //- Case patch an existing missed class entry

    if (newValue == true) {
      final MissedClass updatedMissedClass =
          await _attendanceApiService.updateMissedClass(
        missedClassId: missedClass.id!,
        pupilId: pupilId,
        returned: newValue,
        date: date,
        returnedAt: time,
      );

      updateMissedClassInCollections(updatedMissedClass);

      return;
    } else {
      final MissedClass updatedMissedClass =
          await _attendanceApiService.updateMissedClass(
        missedClassId: missedClass.id!,
        pupilId: pupilId,
        returned: newValue,
        date: date,
        returnedAt: null,
      );
      updateMissedClassInCollections(updatedMissedClass);

      return;
    }
  }

  Future<void> updateLateTypeValue(int pupilId, MissedType dropdownValue,
      DateTime date, int minutesLate) async {
    // Let's look for an existing missed class - if pupil and date match, there is one
    final missedClass = getPupilMissedClassOnDate(pupilId, date);

    if (missedClass == null) {
      // The missed class does not exist - let's create one

      final MissedClass updatedMissedClass =
          await _attendanceApiService.postMissedClass(
        pupilId: pupilId,
        missedType: dropdownValue,
        date: date,
        minutesLate: minutesLate,
        unexcused: false,
        contactedType: ContactedType.notSet,
        returned: false,
        returnedAt: null,
        writtenExcuse: null,
      );
      updateMissedClassInCollections(updatedMissedClass);

      return;
    }

    // The missed class exists already - patching it

    final MissedClass updatedMissedClass =
        await _attendanceApiService.updateMissedClass(
      missedClassId: missedClass.id!,
      pupilId: pupilId,
      missedType: dropdownValue,
      date: date,
      minutesLate: minutesLate,
    );

    updateMissedClassInCollections(updatedMissedClass);

    return;
  }

  Future<void> updateCommentValue(
      int pupilId, String? comment, DateTime date) async {
    final MissedClass? missedClass = getPupilMissedClassOnDate(pupilId, date);

    if (missedClass == null) {
      return;
    }

    final MissedClass updatedMissedClass =
        await _attendanceApiService.updateMissedClass(
      missedClassId: missedClass.id!,
      pupilId: pupilId,
      date: date,
      comment: comment,
    );
    updateMissedClassInCollections(updatedMissedClass);

    _notificationService.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich!');

    return;
  }

  Future<void> postManyMissedClasses(id, startdate, enddate, missedType) async {
    List<MissedClass> missedClasses = [];

    final PupilProxy pupil =
        _pupilManager.allPupils.firstWhere((pupil) => pupil.internalId == id);

    final List<DateTime> validSchooldays =
        _schooldayManager.availableDates.value;

    for (DateTime validSchoolday in validSchooldays) {
      // if the date is the same as the startdate or enddate or in between
      if (validSchoolday.isSameDate(startdate) ||
          validSchoolday.isSameDate(enddate) ||
          (validSchoolday.isAfterDate(startdate) &&
              validSchoolday.isBeforeDate(enddate))) {
        final schoolday = _schooldayManager.getSchooldayByDate(validSchoolday);
        missedClasses.add(MissedClass(
          createdBy: _sessionManager.signedInUser!.userName!,
          pupilId: pupil.pupilId,
          schoolday: schoolday,
          missedType: missedType,
          unexcused: false,
          contacted: '0',
          returned: false,
          returnedAt: null,
          minutesLate: null,
          writtenExcuse: false,
          modifiedBy: null,
          comment: null,
          schooldayId: schoolday!.id!,
        ));
      }
    }
    final List<MissedClass> responseMissedClasses = await _attendanceApiService
        .postMissedClassList(missedClasses: missedClasses);
    for (final MissedClass responseMissedClass in responseMissedClasses) {
      updateMissedClassInCollections(responseMissedClass);
    }
    _notificationService.showSnackBar(
        NotificationType.success, 'Einträge erfolgreich!');

    return;
  }

  Future<void> updateMissedTypeValue(
      int pupilId, MissedType missedType, DateTime date) async {
    if (missedType == MissedType.notSet) {
      // change value to 'notSet' means there was a missed class that has to be deleted

      await deleteMissedClass(pupilId, date);

      return;
    }

    // Let's look for an existing missed class - if pupil and date match, there is one

    final missedClass = getPupilMissedClassOnDate(pupilId, date);

    if (missedClass == null) {
      // The missed class does not exist - let's create one

      _log.info('This missed class is new');

      final MissedClass updatedMissedClass =
          await _attendanceApiService.postMissedClass(
        pupilId: pupilId,
        missedType: missedType,
        date: date,
      );
      updateMissedClassInCollections(updatedMissedClass);

      _notificationService.showSnackBar(
          NotificationType.success, 'Eintrag erfolgreich!');

      return;
    }
    // The missed class exists already - patching it
    // we make sure that incidentally stored minutes_late values are deleted
    final MissedClass updatedMissedClass =
        await _attendanceApiService.updateMissedClass(
      missedClassId: missedClass.id!,
      pupilId: pupilId,
      missedType: missedType,
      date: date,
      minutesLate: null,
    );
    updateMissedClassInCollections(updatedMissedClass);

    _notificationService.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich!');

    return;
  }

  Future<void> updateContactedValue(
      int pupilId, ContactedType contactedType, DateTime date) async {
    final MissedClass? missedClass = getPupilMissedClassOnDate(pupilId, date);
    if (missedClass == null) {
      return;
    }
    // The missed class exists already - patching it
    final MissedClass updatedMissedClass =
        await _attendanceApiService.updateMissedClass(
      missedClassId: missedClass.id!,
      pupilId: pupilId,
      contactedType: contactedType,
      date: date,
    );

    updateMissedClassInCollections(updatedMissedClass);
    _notificationService.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich!');

    return;
  }
}
