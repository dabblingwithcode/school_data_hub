import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/data/attendance_api_service.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/models/pupil_missed_classes_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

final _pupilManager = di<PupilManager>();

final _schoolCalendarManager = di<SchoolCalendarManager>();

final _notificationService = di<NotificationService>();

final _sessionManager = di<HubSessionManager>();

final _log = Logger('AttendanceManager');

final _attendanceApiService = AttendanceApiService();

final _client = di<Client>();

class AttendanceManager with ChangeNotifier {
  final ValueNotifier<List<MissedClass>> _missedClasses = ValueNotifier([]);

  ValueListenable<List<MissedClass>> get missedClasses => _missedClasses;

  // PupilMissedClassesList is a list of missed classes for a pupil
  // with a change notifier
  // it is used to observe the missed classes of a pupil in the UI

  final Map<int, PupilMissedClassesProxy> _pupilMissedClassesMap = {};

  AttendanceManager() {
    init();
  }

  Future<void> init() async {
    // we must have a proxy object for every pupil because we need to
    // watch them in the UI unconditionally (even if there are no entries)
    final pupilIds = _pupilManager.allPupils.map((e) => e.pupilId).toList();
    for (final pupilId in pupilIds) {
      _pupilMissedClassesMap[pupilId] = PupilMissedClassesProxy();
    }
    // await fetchMissedClassesOnASchoolday(schoolCalendarManager.thisDate.value);
    fetchAllPupilMissedClasses();
    return;
  }

  //- Getters

  MissedClass? getPupilMissedClassOnDate(int pupilId, DateTime date) {
    return _pupilMissedClassesMap[pupilId]!.missedClasses.firstWhereOrNull(
        (element) =>
            element.schoolday!.schoolday.formatForJson() ==
            date.formatForJson());
  }

  PupilMissedClassesProxy getPupilMissedClassesProxy(int pupilId) {
    return _pupilMissedClassesMap[pupilId]!;
  }

  // - Handle collections -

  void _updateMissedClassesInCollections(List<MissedClass> missedClasses) {
    for (final missedClass in missedClasses) {
      updateMissedClassInCollections(missedClass);
    }
  }

  void updateMissedClassInCollections(MissedClass responseMissedClass) {
    final date = responseMissedClass.schoolday!.schoolday;

    final pupilId = responseMissedClass.pupilId;

    // 1. Update pupil map
    final pupilMissedClassProxy = _pupilMissedClassesMap[pupilId]!;

    pupilMissedClassProxy.updateMissedClass(responseMissedClass);

    // 2. Update the main list
    final index = _missedClasses.value.indexWhere((element) =>
        element.schoolday!.schoolday == date && element.pupilId == pupilId);

    if (index != -1) {
      final newList = List<MissedClass>.from(_missedClasses.value);

      newList[index] = responseMissedClass;

      _missedClasses.value = newList;
    } else {
      _missedClasses.value = [..._missedClasses.value, responseMissedClass];
    }
  }

  void removeMissedClassFromCollections(int pupilId, DateTime date) {
    // 1. Remove from pupil map

    final pupilMissedClassesProxy = _pupilMissedClassesMap[pupilId]!;

    pupilMissedClassesProxy.removeMissedClass(pupilId, date);

    // 2. Remove from the main list

    final index = _missedClasses.value.indexWhere((element) =>
        element.schoolday!.schoolday == date && element.pupilId == pupilId);

    if (index != -1) {
      final updatedMissedClasses = List<MissedClass>.from(_missedClasses.value);

      updatedMissedClasses.removeAt(index);

      _missedClasses.value = updatedMissedClasses;
    }
  }

  //- Stream function
  StreamSubscription<MissedClassDto> missedClassStreamSubscription() {
    _log.info('starting missedClassStreamSubscription');
    return _client.missedClass.streamMyModels().listen(
      (event) {
        switch (event.operation) {
          case 'add':
            _log.fine('add missedClass ${event.missedClass}');
            updateMissedClassInCollections(event.missedClass);
            break;
          case 'update':
            _log.fine('update missedClass ${event.missedClass}');
            updateMissedClassInCollections(event.missedClass);
            break;
          case 'delete':
            _log.fine('delete missedClass ${event.missedClass}');
            removeMissedClassFromCollections(event.missedClass.pupilId,
                event.missedClass.schoolday!.schoolday);
            break;
        }
      },
      onError: (error) {
        _log.severe('Error in missedClass stream: $error');
        Future.delayed(
            const Duration(seconds: 1), missedClassStreamSubscription);
      },
      onDone: () {
        _log.warning('missedClass stream closed - reconnecting...');
        Future.delayed(
            const Duration(seconds: 1), missedClassStreamSubscription);
      },
    );
  }
  //- CRUD operantions

  void fetchAllPupilMissedClasses() async {
    final fetchedMissedClasses =
        await _attendanceApiService.fetchAllMissedClasses();
    if (fetchedMissedClasses == null) return;
    _updateMissedClassesInCollections(fetchedMissedClasses);
  }

  Future<void> fetchMissedClassesOnASchoolday(DateTime schoolday) async {
    _log.info('fetchMissedClassesOnASchoolday $schoolday');
    final List<MissedClass>? missedClasses =
        await _attendanceApiService.fetchMissedClassesOnASchoolday(schoolday);
    if (missedClasses == null) return;
    _updateMissedClassesInCollections(missedClasses);

    return;
  }

  Future<void> updateUnexcusedValue(
      int pupilId, DateTime date, bool newValue) async {
    final missedClass = getPupilMissedClassOnDate(pupilId, date);

    if (missedClass == null) {
      return;
    }
    final missedClassToUpdate = missedClass.copyWith(
      unexcused: newValue,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedClass? responseMissedClass = await _attendanceApiService
        .updateMissedClass(missedClassToUpdate: missedClassToUpdate);

    if (responseMissedClass == null) {
      return;
    }
    updateMissedClassInCollections(responseMissedClass);

    return;
  }

  Future<void> deleteMissedClass(int pupilId, DateTime date) async {
    final response = await _attendanceApiService.deleteMissedClass(
      pupilId,
      _schoolCalendarManager.getSchooldayByDate(date)!.id!,
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

  Future<void> updateReturnedValue(int pupilId, bool newValue, DateTime date,
      DateTime? returnedDateTime) async {
    final missedClass = getPupilMissedClassOnDate(pupilId, date);

    // pupils gone home during class for whatever reason
    //are marked as returned with a time stamp

    //- Case create a new missed class
    // if the missed class does not exist we have to create one with the type "none"

    if (missedClass == null) {
      // This missed class is new
      final MissedClass? missedClass =
          await _attendanceApiService.postMissedClass(
        pupilId: pupilId,
        missedType: MissedType.notSet,
        date: date,
        unexcused: false,
        contactedType: ContactedType.notSet,
        returned: true,
        returnedAt: returnedDateTime,
      );
      if (missedClass == null) {
        return;
      }
      updateMissedClassInCollections(missedClass);
      _notificationService.showSnackBar(
          NotificationType.success, 'Eintrag erfolgreich!');

      return;
    }

    //- Case delete 'none' + 'returned' missed class
    // The only way to delete a missed class with 'none' and 'returned' entries
    // is if we uncheck 'return' - let's check that

    if (newValue == false && missedClass.missedType == MissedType.notSet) {
      final success = await _attendanceApiService.deleteMissedClass(
        pupilId,
        _schoolCalendarManager.getSchooldayByDate(date)!.id!,
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
      final missedClassToUpdate = missedClass.copyWith(
        returned: newValue,
        returnedAt: returnedDateTime,
        modifiedBy: _sessionManager.signedInUser!.userName!,
      );
      final MissedClass? updatedMissedClass = await _attendanceApiService
          .updateMissedClass(missedClassToUpdate: missedClassToUpdate);
      if (updatedMissedClass == null) {
        return;
      }
      updateMissedClassInCollections(updatedMissedClass);

      return;
    } else {
      final missedClassToUpdate = missedClass.copyWith(
        returned: newValue,
        returnedAt: null,
        modifiedBy: _sessionManager.signedInUser!.userName!,
      );
      final MissedClass? updatedMissedClass = await _attendanceApiService
          .updateMissedClass(missedClassToUpdate: missedClassToUpdate);
      if (updatedMissedClass == null) {
        return;
      }
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

      final MissedClass? updatedMissedClass =
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
      if (updatedMissedClass == null) {
        return;
      }
      updateMissedClassInCollections(updatedMissedClass);

      return;
    }

    // The missed class exists already - patching it
    final missedClassToUpdate = missedClass.copyWith(
      missedType: dropdownValue,
      minutesLate: minutesLate,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedClass? updatedMissedClass = await _attendanceApiService
        .updateMissedClass(missedClassToUpdate: missedClassToUpdate);
    if (updatedMissedClass == null) {
      return;
    }
    updateMissedClassInCollections(updatedMissedClass);

    return;
  }

  Future<void> updateCommentValue(
      int pupilId, String? comment, DateTime date) async {
    final MissedClass? missedClass = getPupilMissedClassOnDate(pupilId, date);

    if (missedClass == null) {
      return;
    }
    final missedClassToUpdate = missedClass.copyWith(
      comment: comment,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedClass? updatedMissedClass = await _attendanceApiService
        .updateMissedClass(missedClassToUpdate: missedClassToUpdate);
    if (updatedMissedClass == null) {
      return;
    }
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
        _schoolCalendarManager.availableDates.value;

    for (DateTime validSchoolday in validSchooldays) {
      // if the date is the same as the startdate or enddate or in between
      if (validSchoolday.isSameDate(startdate) ||
          validSchoolday.isSameDate(enddate) ||
          (validSchoolday.isAfterDate(startdate) &&
              validSchoolday.isBeforeDate(enddate))) {
        final schoolday =
            _schoolCalendarManager.getSchooldayByDate(validSchoolday);
        missedClasses.add(MissedClass(
          createdBy: _sessionManager.signedInUser!.userName!,
          pupilId: pupil.pupilId,
          schoolday: schoolday,
          missedType: missedType,
          unexcused: false,
          contacted: ContactedType.notSet,
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
    final List<MissedClass>? responseMissedClasses = await _attendanceApiService
        .postMissedClassList(missedClasses: missedClasses);
    if (responseMissedClasses == null) {
      return;
    }
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

      final MissedClass? updatedMissedClass =
          await _attendanceApiService.postMissedClass(
        pupilId: pupilId,
        missedType: missedType,
        date: date,
      );
      if (updatedMissedClass == null) {
        return;
      }
      updateMissedClassInCollections(updatedMissedClass);

      _notificationService.showSnackBar(
          NotificationType.success, 'Eintrag erfolgreich!');

      return;
    }
    // The missed class exists already - patching it
    // we make sure that incidentally stored minutes_late values are deleted
    final missedClassToUpdate = missedClass.copyWith(
      missedType: missedType,
      minutesLate: null,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedClass? updatedMissedClass =
        await _attendanceApiService.updateMissedClass(
      missedClassToUpdate: missedClassToUpdate,
    );
    if (updatedMissedClass == null) {
      return;
    }
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
    final missedClassToUpdate = missedClass.copyWith(
      contacted: contactedType,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedClass? updatedMissedClass =
        await _attendanceApiService.updateMissedClass(
      missedClassToUpdate: missedClassToUpdate,
    );
    if (updatedMissedClass == null) {
      return;
    }
    updateMissedClassInCollections(updatedMissedClass);
    _notificationService.showSnackBar(
        NotificationType.success, 'Eintrag erfolgreich!');

    return;
  }
}
