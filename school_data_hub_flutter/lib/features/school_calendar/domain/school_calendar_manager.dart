import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/get_non_holiday_weekdays.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();

final _envManager = di<EnvManager>();

final _notificationService = di<NotificationService>();

final _log = Logger('SchooldayManager');

class SchoolCalendarManager {
  final _schooldays = ValueNotifier<List<Schoolday>>([]);
  ValueNotifier<List<Schoolday>> get schooldays => _schooldays;

  final _availableDates = ValueNotifier<List<DateTime>>([]);
  ValueListenable<List<DateTime>> get availableDates => _availableDates;

  final _schoolSemesters = ValueNotifier<List<SchoolSemester>>([]);
  ValueListenable<List<SchoolSemester>> get schoolSemesters => _schoolSemesters;

  final _currentSemester = ValueNotifier<SchoolSemester?>(null);
  ValueListenable<SchoolSemester?> get currentSemester => _currentSemester;

  final _thisDate = ValueNotifier<DateTime>(DateTime.now().toUtc());
  ValueListenable<DateTime> get thisDate => _thisDate;

  Future<SchoolCalendarManager> init() async {
    // if (_envManager.isAuthenticated.value == false) {
    //   return this;
    // }
    await fetchSchooldays();
    await fetchSchoolSemesters();
    return this;
  }

  //- DOMAIN FUNCTIONS

  void clearData() {
    _schooldays.value = [];

    _availableDates.value = [];

    _thisDate.value = DateTime.now().toUtc();

    _schoolSemesters.value = [];
  }

  Schoolday? getSchooldayByDate(DateTime date) {
    final Schoolday? schoolday = _schooldays.value.firstWhereOrNull((element) =>
        element.schoolday.year == date.year &&
        element.schoolday.month == date.month &&
        element.schoolday.day == date.day);

    return schoolday;
  }

  SchoolSemester? getCurrentSchoolSemester() {
    final SchoolSemester? currentSemester = _schoolSemesters.value
        .firstWhereOrNull((element) =>
            element.startDate.isBefore(DateTime.now().toUtc()) &&
            element.endDate.isAfter(DateTime.now().toUtc()));

    return currentSemester;
  }

  void setAvailableDates() {
    List<DateTime> processedAvailableDates = [];

    for (Schoolday day in _schooldays.value) {
      DateTime validDate = day.schoolday;
      processedAvailableDates.add(validDate);
    }

    _availableDates.value = processedAvailableDates;

    getThisDate();
  }

  void getThisDate() {
    final schooldays = _schooldays.value;

    // we look for the closest schoolday to now and set it as thisDate

    final closestSchooldayToNow = schooldays.reduce((value, element) =>
        value.schoolday.difference(DateTime.now().toUtc()).abs() <
                element.schoolday.difference(DateTime.now()).abs()
            ? value
            : element);

    _thisDate.value = closestSchooldayToNow.schoolday;

    return;
  }

  void setThisDate(DateTime date) {
    _thisDate.value = date;
  }

  //- Schoolday Repository calls

  //- create

  Future<void> postSchoolday(DateTime schoolday) async {
    final Schoolday? newSchoolday =
        await _client.schooldayAdmin.createSchoolday(schoolday);
    if (newSchoolday == null) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Schultag konnte nicht erstellt werden');
      return;
    }
    _schooldays.value = [..._schooldays.value, newSchoolday];

    _notificationService.showSnackBar(
        NotificationType.success, 'Schultag erfolgreich erstellt');

    setAvailableDates();

    return;
  }

  Future<void> postMultipleSchooldays({required List<DateTime> dates}) async {
    // we need to transform the dates to utc
    final List<DateTime> utcDates = dates.map((date) => date.toUtc()).toList();
    final List<Schoolday> newSchooldays =
        await _client.schooldayAdmin.createSchooldays(utcDates);

    _schooldays.value = [..._schooldays.value, ...newSchooldays];

    _notificationService.showSnackBar(
        NotificationType.success, 'Schultage erfolgreich erstellt');

    setAvailableDates();

    return;
  }

  //- read

  Future<void> fetchSchooldays() async {
    final List<Schoolday> responseSchooldays =
        await _client.schoolday.getSchooldays();

    if (responseSchooldays.isNotEmpty) {
      _notificationService.showSnackBar(
          NotificationType.success, 'Schultage geladen');
      _schooldays.value = responseSchooldays;

      // if the schooldays flag is not set, we set it to true
      if (_envManager.populatedEnvServerData.schooldays == false) {
        _envManager.setPopulatedEnvServerData(schooldays: true);
      }

      setAvailableDates();

      return;
    }

    _notificationService.showSnackBar(NotificationType.warning,
        '${responseSchooldays.length} Keine Schultage gefunden!');

    return;
  }

  //- delete

  Future<void> deleteSchoolday(DateTime date) async {
    final bool isDeleted = await _client.schooldayAdmin.deleteSchoolday(date);

    final Schoolday? schoolday = getSchooldayByDate(date);
    if (schoolday == null) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Schultag konnte nicht gefunden werden');
      return;
    }
    if (isDeleted) {
      _schooldays.value =
          _schooldays.value.where((day) => day != schoolday).toList();

      _notificationService.showSnackBar(
          NotificationType.success, 'Schultag erfolgreich gelöscht');
      return;
    }

    setAvailableDates();

    return;
  }

  //- SchoolSemester Repository calls

  //- create

  Future<void> postSchoolSemester(
      {required DateTime startDate,
      required DateTime endDate,
      required DateTime classConferenceDate,
      required DateTime supportConferenceDate,
      required DateTime reportSignedDate,
      required DateTime reportConferenceDate,
      required bool isFirst}) async {
    final SchoolSemester newSemester =
        await _client.schooldayAdmin.createSchoolSemester(
      startDate,
      endDate,
      isFirst,
      classConferenceDate,
      supportConferenceDate,
      reportSignedDate,
    );

    _schoolSemesters.value = [..._schoolSemesters.value, newSemester];
    final schooldaysInSemester = await getNonHolidayWeekdays(
      startDate: newSemester.startDate,
      endDate: newSemester.endDate,
    );
    await postMultipleSchooldays(dates: schooldaysInSemester);

    _notificationService.showSnackBar(
        NotificationType.success, 'Schulhalbjahr erfolgreich erstellt');

    return;
  }

  //- read

  Future<void> fetchSchoolSemesters() async {
    final List<SchoolSemester> responseSchoolSemesters =
        await _client.schoolday.getSchoolSemesters();

    _notificationService.showSnackBar(NotificationType.success,
        '${responseSchoolSemesters.length} Schulhalbjahre geladen!');

    _log.info(
      'Schulhalbjahre geladen: ${responseSchoolSemesters.length}',
    );
    _schoolSemesters.value = responseSchoolSemesters;
    if (_currentSemester.value == null) {
      _currentSemester.value = getCurrentSchoolSemester();
    }
    if (responseSchoolSemesters.isNotEmpty &&
        _envManager.populatedEnvServerData.schoolSemester == false) {
      _envManager.setPopulatedEnvServerData(schoolSemester: true);
    }
    return;
  }
}
