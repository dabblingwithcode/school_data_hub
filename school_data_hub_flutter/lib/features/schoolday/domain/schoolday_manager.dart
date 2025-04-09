import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();

final _envManager = di<EnvManager>();

final _notificationService = di<NotificationService>();

final _log = Logger('SchooldayManager');

class SchooldayManager {
  final _schooldays = ValueNotifier<List<Schoolday>>([]);
  ValueNotifier<List<Schoolday>> get schooldays => _schooldays;

  final _availableDates = ValueNotifier<List<DateTime>>([]);
  ValueListenable<List<DateTime>> get availableDates => _availableDates;

  final _schoolSemesters = ValueNotifier<List<SchoolSemester>>([]);
  ValueListenable<List<SchoolSemester>> get schoolSemesters => _schoolSemesters;

  final _thisDate = ValueNotifier<DateTime>(DateTime.now());
  ValueListenable<DateTime> get thisDate => _thisDate;

  SchooldayManager();

  Future<SchooldayManager> init() async {
    if (_envManager.isAuthenticated.value == false) {
      return this;
    }
    await getSchooldays();
    await getSchoolSemesters();
    return this;
  }

  //- DOMAIN FUNCTIONS

  void clearData() {
    _schooldays.value = [];

    _availableDates.value = [];

    _thisDate.value = DateTime.now();

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
            element.startDate.isBefore(DateTime.now()) &&
            element.endDate.isAfter(DateTime.now()));

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
        value.schoolday.difference(DateTime.now()).abs() <
                element.schoolday.difference(DateTime.now()).abs()
            ? value
            : element);

    _thisDate.value = closestSchooldayToNow.schoolday;

    return;
  }

  void setThisDate(DateTime date) {
    _thisDate.value = date;
  }

  //- DATA FUNCTIONS (CRUD)

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
    final List<Schoolday> newSchooldays =
        await _client.schooldayAdmin.createSchooldays(dates);

    _schooldays.value = [..._schooldays.value, ...newSchooldays];

    _notificationService.showSnackBar(
        NotificationType.success, 'Schultage erfolgreich erstellt');

    setAvailableDates();

    return;
  }

  Future<void> getSchooldays() async {
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

  Future<void> getSchoolSemesters() async {
    final List<SchoolSemester> responseSchoolSemesters =
        await _client.schoolday.getSchoolSemesters();

    _notificationService.showSnackBar(NotificationType.success,
        '${responseSchoolSemesters.length} Schulhalbjahre geladen!');

    _log.info(
      'Schulhalbjahre geladen: ${responseSchoolSemesters.length}',
    );
    _schoolSemesters.value = responseSchoolSemesters;

    if (responseSchoolSemesters.isNotEmpty) {
      _envManager.setPopulatedEnvServerData(schoolSemester: true);
    }
    return;
  }

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

    _notificationService.showSnackBar(
        NotificationType.success, 'Schulhalbjahr erfolgreich erstellt');

    return;
  }
}
