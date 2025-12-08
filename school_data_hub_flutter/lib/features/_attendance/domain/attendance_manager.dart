import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/data/attendance_api_service.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/models/pupil_missed_classes_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceManager with ChangeNotifier {
  // Lazy getters to avoid accessing dependencies during construction
  PupilManager get _pupilManager => di<PupilManager>();
  SchoolCalendarManager get _schoolCalendarManager =>
      di<SchoolCalendarManager>();
  NotificationService get _notificationService => di<NotificationService>();
  HubSessionManager get _sessionManager => di<HubSessionManager>();
  Client get _client => di<Client>();

  final _log = Logger('AttendanceManager');
  final _attendanceApiService = AttendanceApiService();

  StreamSubscription<MissedSchooldayDto>? _missedSchooldaySubscription;

  final ValueNotifier<List<MissedSchoolday>> _missedSchooldays = ValueNotifier(
    [],
  );

  ValueListenable<List<MissedSchoolday>> get missedSchooldays =>
      _missedSchooldays;

  // PupilMissedSchooldayesList is a list of missed classes for a pupil
  // with a change notifier
  // it is used to observe the missed classes of a pupil in the UI

  final Map<int, PupilMissedSchooldaysProxy> _pupilMissedSchooldaysMap = {};

  AttendanceManager() {
    init();
  }

  void dispose() {
    _closeStreamSubscription();

    _pupilMissedSchooldaysMap.clear();

    _missedSchooldays.dispose();

    super.dispose();
    return;
  }

  Future<void> init() async {
    // we must have a proxy object for every pupil because we need to
    // watch them in the UI unconditionally (even if there are no entries)
    final pupilIds = _pupilManager.allPupils.map((e) => e.pupilId).toList();
    for (final pupilId in pupilIds) {
      _pupilMissedSchooldaysMap[pupilId] = PupilMissedSchooldaysProxy();
    }
    // await fetchMissedSchooldayesOnASchoolday(schoolCalendarManager.thisDate.value);
    fetchAllPupilMissedSchooldayes();
    return;
  }

  //- Getters

  MissedSchoolday? getPupilMissedSchooldayOnDate(int pupilId, DateTime date) {
    // Using toUtc would make the comparison fail because the date is in the local timezone
    return _pupilMissedSchooldaysMap[pupilId]!.missedSchooldays
        .firstWhereOrNull(
          (element) => element.schoolday!.schoolday.isSameDate(date),
        );
  }

  List<MissedSchoolday> getAllPupilMissedSchooldays(int pupilId) {
    return _pupilMissedSchooldaysMap[pupilId]!.missedSchooldays;
  }

  // TODO ADVICE: This is bad - need help to review
  PupilMissedSchooldaysProxy getPupilMissedSchooldaysProxy(int pupilId) {
    if (!_pupilMissedSchooldaysMap.containsKey(pupilId)) {
      _log.warning(
        'No PupilMissedSchooldaysProxy found for pupilId: $pupilId - creating a new one',
      );
      _pupilMissedSchooldaysMap[pupilId] = PupilMissedSchooldaysProxy();
    }
    return _pupilMissedSchooldaysMap[pupilId]!;
  }

  // - Handle collections -

  void _updateMissedSchooldayesInCollections(
    List<MissedSchoolday> missedSchooldays,
  ) {
    for (final missedSchoolday in missedSchooldays) {
      updateMissedSchooldayInCollections(missedSchoolday);
    }
  }

  void updateMissedSchooldayInCollections(
    MissedSchoolday responseMissedSchoolday,
  ) {
    final date = responseMissedSchoolday.schoolday!.schoolday;

    final pupilId = responseMissedSchoolday.pupilId;

    if (!_pupilMissedSchooldaysMap.containsKey(pupilId)) {
      // If the pupil is not in the map, we need to create a new proxy for them
      _pupilMissedSchooldaysMap[pupilId] = PupilMissedSchooldaysProxy();
    }
    // 1. Update pupil map
    final pupilMissedSchooldayProxy = _pupilMissedSchooldaysMap[pupilId];

    pupilMissedSchooldayProxy!.updateMissedSchoolday(responseMissedSchoolday);

    // 2. Update the main list
    final index = _missedSchooldays.value.indexWhere(
      (element) =>
          element.schoolday!.schoolday == date && element.pupilId == pupilId,
    );

    if (index != -1) {
      final newList = List<MissedSchoolday>.from(_missedSchooldays.value);

      newList[index] = responseMissedSchoolday;

      _missedSchooldays.value = newList;
    } else {
      _missedSchooldays.value = [
        ..._missedSchooldays.value,
        responseMissedSchoolday,
      ];
    }
  }

  void removeMissedSchooldayFromCollections(int pupilId, DateTime date) {
    // 1. Remove from pupil map

    final pupilMissedSchooldayesProxy = _pupilMissedSchooldaysMap[pupilId]!;

    pupilMissedSchooldayesProxy.removeMissedSchoolday(pupilId, date);

    // 2. Remove from the main list

    final index = _missedSchooldays.value.indexWhere(
      (element) =>
          element.schoolday!.schoolday == date && element.pupilId == pupilId,
    );

    if (index != -1) {
      final updatedMissedSchooldayes = List<MissedSchoolday>.from(
        _missedSchooldays.value,
      );

      updatedMissedSchooldayes.removeAt(index);

      _missedSchooldays.value = updatedMissedSchooldayes;
    }
  }

  //- Stream function
  StreamSubscription<MissedSchooldayDto> missedSchooldayStreamSubscription() {
    _log.info('starting missedSchooldayStreamSubscription');
    _missedSchooldaySubscription?.cancel();
    _missedSchooldaySubscription = _client.missedSchoolday
        .streamMissedSchooldays()
        .listen(
          (event) {
            switch (event.operation) {
              case 'add':
                _log.fine(
                  '[STREAM]add missedSchoolday ${event.missedSchoolday}',
                );
                updateMissedSchooldayInCollections(event.missedSchoolday);
                break;
              case 'update':
                _log.fine(
                  '[STREAM] update missedSchoolday ${event.missedSchoolday}',
                );
                updateMissedSchooldayInCollections(event.missedSchoolday);
                break;
              case 'delete':
                _log.fine(
                  '[STREAM] delete missedSchoolday ${event.missedSchoolday}',
                );
                removeMissedSchooldayFromCollections(
                  event.missedSchoolday.pupilId,
                  event.missedSchoolday.schoolday!.schoolday,
                );
                break;
            }
          },
          onError: (error) async {
            final errorString = error.toString();
            ;
            _log.severe('Error in missedSchoolday stream: $error');
            if (error.toString().contains('Unauthorized')) {
              _missedSchooldaySubscription!.cancel();
              return di<HubSessionManager>().signOutDevice();
            } else if (error.toString().contains(
              'Netzwerkverbindung abgelehnt',
            )) {
              // TODO: Implement server not responding
              //- This is very buggy
              _notificationService.showInformationDialog(
                'Der Server konnte nicht gefunden werden. Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.',
              );
            } else {
              _log.severe(
                NotificationType.error,
                'Ein unbekannter Fehler ist aufgetreten: $errorString',
              );
            }
            Future.delayed(
              const Duration(seconds: 1),
              missedSchooldayStreamSubscription,
            );
          },
          onDone: () {
            _log.warning('missedSchoolday stream closed - reconnecting...');
            Future.delayed(
              const Duration(seconds: 1),
              missedSchooldayStreamSubscription,
            );
          },
        );
    return _missedSchooldaySubscription!;
  }

  void _closeStreamSubscription() {
    _log.info('Closing missedSchooldayStreamSubscription');
    _missedSchooldaySubscription?.cancel();
    _missedSchooldaySubscription = null;
  }

  //- CRUD operantions

  void fetchAllPupilMissedSchooldayes() async {
    final fetchedMissedSchooldayes = await _attendanceApiService
        .fetchAllMissedSchooldayes();
    if (fetchedMissedSchooldayes == null) return;
    _updateMissedSchooldayesInCollections(fetchedMissedSchooldayes);
  }

  Future<void> fetchMissedSchooldayesOnASchoolday(DateTime schoolday) async {
    _log.info('fetchMissedSchooldayesOnASchoolday $schoolday');
    final List<MissedSchoolday>? missedSchooldays = await _attendanceApiService
        .fetchMissedSchooldayesOnASchoolday(schoolday.toUtc());
    if (missedSchooldays == null) return;
    _updateMissedSchooldayesInCollections(missedSchooldays);

    return;
  }

  Future<void> updateUnexcusedValue(
    int pupilId,
    DateTime date,
    bool newValue,
  ) async {
    final missedSchoolday = getPupilMissedSchooldayOnDate(pupilId, date);

    if (missedSchoolday == null) {
      return;
    }
    final missedSchooldayToUpdate = missedSchoolday.copyWith(
      unexcused: newValue,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedSchoolday? responseMissedSchoolday = await _attendanceApiService
        .updateMissedSchoolday(
          missedSchooldayToUpdate: missedSchooldayToUpdate,
        );

    if (responseMissedSchoolday == null) {
      return;
    }
    updateMissedSchooldayInCollections(responseMissedSchoolday);

    return;
  }

  Future<void> deleteMissedSchoolday(int pupilId, DateTime date) async {
    final response = await _attendanceApiService.deleteMissedSchoolday(
      pupilId,
      _schoolCalendarManager.getSchooldayByDate(date)!.id!,
    );

    if (response == true) {
      removeMissedSchooldayFromCollections(pupilId, date.toUtc());
      _notificationService.showSnackBar(
        NotificationType.success,
        'Fehlzeit erfolgreich gelöscht!',
      );
    } else {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehlzeit konnte nicht gelöscht werden!',
      );
      return;
    }

    return;
  }

  Future<void> updateReturnedValue(
    int pupilId,
    bool newValue,
    DateTime date,
    DateTime? returnedDateTime,
  ) async {
    final missedSchoolday = getPupilMissedSchooldayOnDate(pupilId, date);

    // pupils gone home during class for whatever reason
    //are marked as returned with a time stamp

    //- Case create a new missed class
    // if the missed class does not exist we have to create one with the type "none"

    if (missedSchoolday == null) {
      // This missed class is new
      final MissedSchoolday? missedSchoolday = await _attendanceApiService
          .postMissedSchoolday(
            pupilId: pupilId,
            missedType: MissedType.notSet,
            date: date,
            unexcused: false,
            contactedType: ContactedType.notSet,
            returned: true,
            returnedAt: returnedDateTime?.toUtc(),
          );
      if (missedSchoolday == null) {
        return;
      }
      updateMissedSchooldayInCollections(missedSchoolday);
      _notificationService.showSnackBar(
        NotificationType.success,
        'Eintrag erfolgreich!',
      );

      return;
    }

    //- Case delete 'none' + 'returned' missed class
    // The only way to delete a missed class with 'none' and 'returned' entries
    // is if we uncheck 'return' - let's check that

    if (newValue == false && missedSchoolday.missedType == MissedType.notSet) {
      final success = await _attendanceApiService.deleteMissedSchoolday(
        pupilId,
        _schoolCalendarManager.getSchooldayByDate(date)!.id!,
      );
      if (success == true) {
        removeMissedSchooldayFromCollections(pupilId, date.toUtc());
        _notificationService.showSnackBar(
          NotificationType.success,
          'Eintrag erfolgreich gelöscht!',
        );
      } else {
        _notificationService.showSnackBar(
          NotificationType.error,
          'Eintrag konnte nicht gelöscht werden!',
        );
      }
      return;
    }

    //- Case patch an existing missed class entry

    if (newValue == true) {
      final missedSchooldayToUpdate = missedSchoolday.copyWith(
        returned: newValue,
        returnedAt: returnedDateTime?.toUtc(),
        modifiedBy: _sessionManager.signedInUser!.userName!,
      );
      final MissedSchoolday? updatedMissedSchoolday =
          await _attendanceApiService.updateMissedSchoolday(
            missedSchooldayToUpdate: missedSchooldayToUpdate,
          );
      if (updatedMissedSchoolday == null) {
        return;
      }
      updateMissedSchooldayInCollections(updatedMissedSchoolday);

      return;
    } else {
      final missedSchooldayToUpdate = missedSchoolday.copyWith(
        returned: newValue,
        returnedAt: null,
        modifiedBy: _sessionManager.signedInUser!.userName!,
      );
      final MissedSchoolday? updatedMissedSchoolday =
          await _attendanceApiService.updateMissedSchoolday(
            missedSchooldayToUpdate: missedSchooldayToUpdate,
          );
      if (updatedMissedSchoolday == null) {
        return;
      }
      updateMissedSchooldayInCollections(updatedMissedSchoolday);

      return;
    }
  }

  Future<void> updateLateTypeValue(
    int pupilId,
    MissedType dropdownValue,
    DateTime date,
    int minutesLate,
  ) async {
    // Let's look for an existing missed class - if pupil and date match, there is one
    final missedSchoolday = getPupilMissedSchooldayOnDate(pupilId, date);

    if (missedSchoolday == null) {
      // The missed class does not exist - let's create one

      final MissedSchoolday? updatedMissedSchoolday =
          await _attendanceApiService.postMissedSchoolday(
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
      if (updatedMissedSchoolday == null) {
        return;
      }
      updateMissedSchooldayInCollections(updatedMissedSchoolday);

      return;
    }

    // The missed class exists already - patching it
    final missedSchooldayToUpdate = missedSchoolday.copyWith(
      missedType: dropdownValue,
      minutesLate: minutesLate,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedSchoolday? updatedMissedSchoolday = await _attendanceApiService
        .updateMissedSchoolday(
          missedSchooldayToUpdate: missedSchooldayToUpdate,
        );
    if (updatedMissedSchoolday == null) {
      return;
    }
    updateMissedSchooldayInCollections(updatedMissedSchoolday);

    return;
  }

  Future<void> updateCommentValue(
    int pupilId,
    String? comment,
    DateTime date,
  ) async {
    final MissedSchoolday? missedSchoolday = getPupilMissedSchooldayOnDate(
      pupilId,
      date,
    );

    if (missedSchoolday == null) {
      return;
    }
    final missedSchooldayToUpdate = missedSchoolday.copyWith(
      comment: comment,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedSchoolday? updatedMissedSchoolday = await _attendanceApiService
        .updateMissedSchoolday(
          missedSchooldayToUpdate: missedSchooldayToUpdate,
        );
    if (updatedMissedSchoolday == null) {
      return;
    }
    updateMissedSchooldayInCollections(updatedMissedSchoolday);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Eintrag erfolgreich!',
    );

    return;
  }

  Future<void> postManyMissedSchooldays({
    required int id,
    required DateTime startdate,
    required DateTime enddate,
    required MissedType missedType,
    String? comment,
  }) async {
    List<MissedSchoolday> missedSchooldays = [];

    final List<DateTime> validSchooldays =
        _schoolCalendarManager.availableDates.value;

    for (DateTime validSchoolday in validSchooldays) {
      // if the date is the same as the startdate or enddate or in between

      // TODO: For now, we are not transforming the dates to UTC,
      // because this will cause it becoming a different day
      if (validSchoolday.isSameDate(startdate) ||
          validSchoolday.isSameDate(enddate) ||
          (validSchoolday.isAfterDate(startdate) &&
              validSchoolday.isBeforeDate(enddate))) {
        final schoolday = _schoolCalendarManager.getSchooldayByDate(
          validSchoolday,
        );
        missedSchooldays.add(
          MissedSchoolday(
            createdBy: _sessionManager.signedInUser!.userName!,
            pupilId: id,
            schoolday: schoolday,
            missedType: missedType,
            unexcused: false,
            contacted: ContactedType.notSet,
            returned: false,
            returnedAt: null,
            minutesLate: null,
            writtenExcuse: false,
            modifiedBy: null,
            comment: comment,
            schooldayId: schoolday!.id!,
          ),
        );
      }
    }
    final List<MissedSchoolday>? responseMissedSchooldayes =
        await _attendanceApiService.postMissedSchooldayList(
          missedSchooldays: missedSchooldays,
        );
    if (responseMissedSchooldayes == null) {
      return;
    }
    for (final MissedSchoolday responseMissedSchoolday
        in responseMissedSchooldayes) {
      updateMissedSchooldayInCollections(responseMissedSchoolday);
    }
    _notificationService.showSnackBar(
      NotificationType.success,
      'Einträge erfolgreich!',
    );

    return;
  }

  Future<void> updateMissedTypeValue(
    int pupilId,
    MissedType missedType,
    DateTime date,
  ) async {
    if (missedType == MissedType.notSet) {
      // change value to 'notSet' means there was a missed class that has to be deleted

      await deleteMissedSchoolday(pupilId, date);

      return;
    }

    // Let's look for an existing missed class - if pupil and date match, there is one

    final missedSchoolday = getPupilMissedSchooldayOnDate(pupilId, date);

    if (missedSchoolday == null) {
      // The missed class does not exist - let's create one

      _log.info('This missed class is new');

      final MissedSchoolday? updatedMissedSchoolday =
          await _attendanceApiService.postMissedSchoolday(
            pupilId: pupilId,
            missedType: missedType,
            date: date,
          );
      if (updatedMissedSchoolday == null) {
        return;
      }
      updateMissedSchooldayInCollections(updatedMissedSchoolday);

      _notificationService.showSnackBar(
        NotificationType.success,
        'Eintrag erfolgreich!',
      );

      return;
    }
    // The missed class exists already - patching it
    // we make sure that incidentally stored minutes_late values are deleted
    final missedSchooldayToUpdate = missedSchoolday.copyWith(
      missedType: missedType,
      minutesLate: null,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedSchoolday? updatedMissedSchoolday = await _attendanceApiService
        .updateMissedSchoolday(
          missedSchooldayToUpdate: missedSchooldayToUpdate,
        );
    if (updatedMissedSchoolday == null) {
      return;
    }
    updateMissedSchooldayInCollections(updatedMissedSchoolday);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Eintrag erfolgreich!',
    );

    return;
  }

  Future<void> updateContactedValue(
    int pupilId,
    ContactedType contactedType,
    DateTime date,
  ) async {
    final MissedSchoolday? missedSchoolday = getPupilMissedSchooldayOnDate(
      pupilId,
      date,
    );
    if (missedSchoolday == null) {
      return;
    }
    // The missed class exists already - patching it
    final missedSchooldayToUpdate = missedSchoolday.copyWith(
      contacted: contactedType,
      modifiedBy: _sessionManager.signedInUser!.userName!,
    );
    final MissedSchoolday? updatedMissedSchoolday = await _attendanceApiService
        .updateMissedSchoolday(
          missedSchooldayToUpdate: missedSchooldayToUpdate,
        );
    if (updatedMissedSchoolday == null) {
      return;
    }
    updateMissedSchooldayInCollections(updatedMissedSchoolday);
    _notificationService.showSnackBar(
      NotificationType.success,
      'Eintrag erfolgreich!',
    );

    return;
  }
}
