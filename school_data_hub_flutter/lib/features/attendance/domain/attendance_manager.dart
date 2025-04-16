import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/data/attendance_api_service.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_helper_functions.dart';
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
    getAllPupilMissedClasses();
    return;
  }

  //- Helper functions

  void _updateMissedClassesListAndMaps(List<MissedClass> missedClasses) {
    for (final missedClass in missedClasses) {
      // first update the pupil reference map
      if (_pupilMissedClassesMap[missedClass.pupilId] == null) {
        _pupilMissedClassesMap[missedClass.pupilId] = [missedClass];
      } else {
        final existingClass = _pupilMissedClassesMap[missedClass.pupilId]!
            .firstWhereOrNull((MissedClass t) =>
                t.schoolday!.schoolday == missedClass.schoolday!.schoolday);
        if (existingClass != null) {
          _pupilMissedClassesMap[missedClass.pupilId]!.remove(existingClass);
          _pupilMissedClassesMap[missedClass.pupilId]!.add(missedClass);
        } else {
          _pupilMissedClassesMap[missedClass.pupilId]!.add(missedClass);
        }
      }
      // now update the schoolday reference map
      if (_schooldayMissedClassesMap[missedClass.schoolday!.schoolday] ==
          null) {
        _schooldayMissedClassesMap[missedClass.schoolday!.schoolday] = [
          missedClass
        ];
      } else {
        final existingClass =
            _schooldayMissedClassesMap[missedClass.schoolday!.schoolday]!
                .firstWhereOrNull((MissedClass t) =>
                    t.pupilId == missedClass.pupilId &&
                    t.missedType == missedClass.missedType);
        if (existingClass != null) {
          _schooldayMissedClassesMap[missedClass.schoolday!.schoolday]!
              .remove(existingClass);
          _schooldayMissedClassesMap[missedClass.schoolday!.schoolday]!
              .add(missedClass);
        } else {
          _schooldayMissedClassesMap[missedClass.schoolday!.schoolday]!
              .add(missedClass);
        }
      }
    }
    _missedClasses.value =
        _schooldayMissedClassesMap.values.expand((element) => element).toList();
  }

  /// Update the missed class in all collections at once
  /// TODO: This is quick and dirty and needs to be reviewed
  void _updateMissedClassInCollections(MissedClass responseMissedClass) {
    final date = responseMissedClass.schoolday!.schoolday;

    final pupilId = responseMissedClass.pupil!.internalId;

    // 1. Update the main list
    final index = _missedClasses.value.indexWhere((element) =>
        element.schoolday!.schoolday == date &&
        element.pupil!.internalId == pupilId);

    if (index != -1) {
      final newList = List<MissedClass>.from(_missedClasses.value);
      newList[index] = responseMissedClass;
      _missedClasses.value = newList;
    } else {
      _missedClasses.value.add(responseMissedClass);
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
          .indexWhere((element) => element.pupil!.internalId == pupilId);

      if (schooldayMissedClassIndex != -1) {
        schooldayMissedClassList.removeAt(schooldayMissedClassIndex);
        schooldayMissedClassList.add(responseMissedClass);
        _schooldayMissedClassesMap[date] = schooldayMissedClassList;
      } else {
        schooldayMissedClassList.add(responseMissedClass);
      }
    }
  }

  void _removeMissedClassFromCollections(int pupilId, DateTime date) {
    // 1. Remove from the main list
    final index = _missedClasses.value.indexWhere((element) =>
        element.schoolday!.schoolday == date &&
        element.pupil!.internalId == pupilId);

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
          .indexWhere((element) => element.pupil!.internalId == pupilId);

      if (schooldayMissedClassIndex != -1) {
        schooldayMissedClassList.removeAt(schooldayMissedClassIndex);
        _schooldayMissedClassesMap[date] = schooldayMissedClassList;
      }
    }
  }
  //- CRUD operantions

  void getAllPupilMissedClasses() async {
    final fetchedMissedClasses =
        await _attendanceApiService.fetchAllMissedClasses();

    _missedClasses.value = fetchedMissedClasses;
  }

  List<MissedClass> getMissedClassesOnADay(DateTime date) {
    return _missedClasses.value
        .where(
            (missedClass) => missedClass.schoolday!.schoolday.isSameDate(date))
        .toList();
  }

  Future<void> fetchMissedClassesOnASchoolday(DateTime schoolday) async {
    final List<MissedClass> missedClasses =
        await _attendanceApiService.fetchMissedClassesOnASchoolday(schoolday);
    _missedClasses.value = [..._missedClasses.value, ...missedClasses];
    _pupilManager.updatePupilsFromMissedClassesOnASchoolday(missedClasses);

    // notificationService.showSnackBar(
    //     NotificationType.success, 'Fehlzeiten erfolgreich geladen!');

    return;
  }

  Future<void> changeExcusedValue(
      int pupilId, DateTime date, bool newValue) async {
    final PupilProxy pupil = _pupilManager.getPupilByInternalId(pupilId)!;
    final int? missedClass = AttendanceHelper.getMissedClassIndex(pupil, date);
    if (missedClass == null || missedClass == -1) {
      return;
    }

    final MissedClass responseMissedClass = await _attendanceApiService
        .updateMissedClass(pupilId: pupilId, date: date, excused: newValue);

    _updateMissedClassInCollections(responseMissedClass);
    // first update the modified missed class in the list
    final index = pupil.missedClasses!.indexWhere((element) =>
        element.schoolday!.schoolday == date &&
        element.pupil!.internalId == pupilId);
    final newList = List<MissedClass>.from(_missedClasses.value);
    newList[index] = responseMissedClass;
    _missedClasses.value = newList;

    // Now we need to update the maps
    // First we find the element in the list of the map value
    // Then we remove it from the list and add the new one
    // Finally we update the map with the new list
    final missedClassList = _pupilMissedClassesMap[pupilId]!;
    final missedClassIndex = missedClassList
        .indexWhere((element) => element.schoolday!.schoolday == date);
    missedClassList.removeAt(missedClassIndex);
    missedClassList.add(responseMissedClass);
    _pupilMissedClassesMap[pupilId] = missedClassList;
    // Now we need to update the schoolday map

    final schooldayMissedClassList = _schooldayMissedClassesMap[date];
    if (schooldayMissedClassList == null) {
      _schooldayMissedClassesMap[date] = [responseMissedClass];
      return;
    }
    final schooldayMissedClassIndex = schooldayMissedClassList
        .indexWhere((element) => element.pupil!.internalId == pupilId);
    schooldayMissedClassList.removeAt(schooldayMissedClassIndex);
    schooldayMissedClassList.add(responseMissedClass);
    _schooldayMissedClassesMap[date] = schooldayMissedClassList;

    _notificationService.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich!');

    return;
  }

  Future<void> deleteMissedClass(int pupilId, DateTime date) async {
    final response = await _attendanceApiService.deleteMissedClass(
      pupilId,
      date,
    );

    if (response == true) {
      _removeMissedClassFromCollections(pupilId, date);
      _notificationService.showSnackBar(
          NotificationType.success, 'Fehlzeit erfolgreich gelöscht!');
    } else {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehlzeit konnte nicht gelöscht werden!');
      return;
    }

    return;
  }

  Future<void> changeReturnedValue(
      int pupilId, bool newValue, DateTime date, String? time) async {
    final PupilProxy pupil = _pupilManager.getPupilByInternalId(pupilId)!;
    final int? missedClass = AttendanceHelper.getMissedClassIndex(pupil, date);

    // pupils gone home during class for whatever reason
    //are marked as returned with a time stamp

    //- Case create a new missed class
    // if the missed class does not exist we have to create one with the type "none"

    if (missedClass == -1) {
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
      _updateMissedClassInCollections(missedClass);
      _notificationService.showSnackBar(
          NotificationType.success, 'Eintrag erfolgreich!');

      return;
    }

    //- Case delete 'none' + 'returned' missed class
    // The only way to delete a missed class with 'none' and 'returned' entries
    // is if we uncheck 'return' - let's check that

    if (newValue == false &&
        pupil.missedClasses![missedClass!].missedType ==
            MissedType.notSet.value) {
      final success = await _attendanceApiService.deleteMissedClass(
        pupilId,
        date,
      );
      if (success == true) {
        _removeMissedClassFromCollections(pupilId, date);
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
        pupilId: pupilId,
        returned: newValue,
        date: date,
        returnedAt: time,
      );

      _updateMissedClassInCollections(updatedMissedClass);

      return;
    } else {
      final MissedClass updatedMissedClass =
          await _attendanceApiService.updateMissedClass(
        pupilId: pupilId,
        returned: newValue,
        date: date,
        returnedAt: null,
      );
      _updateMissedClassInCollections(updatedMissedClass);

      return;
    }
  }

  Future<void> changeLateTypeValue(int pupilId, MissedType dropdownValue,
      DateTime date, int minutesLate) async {
    // Let's look for an existing missed class - if pupil and date match, there is one

    final PupilProxy pupil = _pupilManager.getPupilByInternalId(pupilId)!;
    final int? missedClass = AttendanceHelper.getMissedClassIndex(pupil, date);
    if (missedClass == -1) {
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
      _updateMissedClassInCollections(updatedMissedClass);

      return;
    }

    // The missed class exists already - patching it

    final MissedClass updatedMissedClass =
        await _attendanceApiService.updateMissedClass(
      pupilId: pupilId,
      missedType: dropdownValue,
      date: date,
      minutesLate: minutesLate,
    );

    _updateMissedClassInCollections(updatedMissedClass);
    return;
  }

  Future<void> changeCommentValue(
      int pupilId, String? comment, DateTime date) async {
    final PupilProxy pupil = _pupilManager.getPupilByInternalId(pupilId)!;
    final int? missedClass = AttendanceHelper.getMissedClassIndex(pupil, date);
    if (missedClass == null || missedClass == -1) {
      return;
    }

    final MissedClass updatedMissedClass = await _attendanceApiService
        .updateMissedClass(pupilId: pupilId, date: date, comment: comment);
    _updateMissedClassInCollections(updatedMissedClass);

    _notificationService.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich!');

    return;
  }

  Future<void> createManyMissedClasses(
      id, startdate, enddate, missedType) async {
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
      _updateMissedClassInCollections(responseMissedClass);
    }
    _notificationService.showSnackBar(
        NotificationType.success, 'Einträge erfolgreich!');

    return;
  }

  Future<void> changeMissedTypeValue(
      int pupilId, MissedType missedType, DateTime date) async {
    if (missedType == MissedType.notSet) {
      // change value to 'notSet' means there was a missed class that has to be deleted

      await deleteMissedClass(pupilId, date);

      _notificationService.apiRunning(false);

      return;
    }

    // Let's look for an existing missed class - if pupil and date match, there is one

    final PupilProxy pupil = _pupilManager.getPupilByInternalId(pupilId)!;
    final int? missedClass = AttendanceHelper.getMissedClassIndex(pupil, date);
    if (missedClass == -1) {
      // The missed class does not exist - let's create one

      _log.info('This missed class is new');

      final MissedClass updatedMissedClass =
          await _attendanceApiService.postMissedClass(
        pupilId: pupilId,
        missedType: missedType,
        date: date,
      );
      _updateMissedClassInCollections(updatedMissedClass);

      _notificationService.showSnackBar(
          NotificationType.success, 'Eintrag erfolgreich!');

      return;
    }
    // The missed class exists already - patching it
    // we make sure that incidentally stored minutes_late values are deleted
    final MissedClass updatedMissedClass =
        await _attendanceApiService.updateMissedClass(
      pupilId: pupilId,
      missedType: missedType,
      date: date,
      minutesLate: null,
    );
    _updateMissedClassInCollections(updatedMissedClass);

    _notificationService.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich!');

    return;
  }

  Future<void> changeContactedValue(
      int pupilId, ContactedType contactedType, DateTime date) async {
    // The missed class exists already - patching it
    final MissedClass updatedMissedClass =
        await _attendanceApiService.updateMissedClass(
      pupilId: pupilId,
      contactedType: contactedType,
      date: date,
    );

    _updateMissedClassInCollections(updatedMissedClass);
    _notificationService.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich!');

    return;
  }
}
