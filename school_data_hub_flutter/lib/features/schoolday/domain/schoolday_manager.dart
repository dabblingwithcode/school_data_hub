import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayManager {
  ValueNotifier<List<Schoolday>> get schooldays => _schooldays;
  ValueListenable<List<DateTime>> get availableDates => _availableDates;
  ValueListenable<DateTime> get thisDate => _thisDate;
  ValueListenable<DateTime> get startDate => _startDate;
  ValueListenable<DateTime> get endDate => _endDate;
  ValueListenable<List<SchoolSemester>> get schoolSemesters => _schoolSemesters;

  final _schooldays = ValueNotifier<List<Schoolday>>([]);
  final _availableDates = ValueNotifier<List<DateTime>>([]);
  final _thisDate = ValueNotifier<DateTime>(DateTime.now());
  final _startDate = ValueNotifier<DateTime>(DateTime.now());
  final _endDate = ValueNotifier<DateTime>(DateTime.now());
  final _schoolSemesters = ValueNotifier<List<SchoolSemester>>([]);

  SchooldayManager();

  // final session = di<SessionManager>().credentials.value;

  Future<SchooldayManager> init() async {
    await getSchooldays();
    // await getSchoolSemesters();
    return this;
  }

  //final apiSchooldayService = SchooldayApiService();

  void clearData() {
    _schooldays.value = [];
    _availableDates.value = [];
    _thisDate.value = DateTime.now();
    _startDate.value = DateTime.now();
    _endDate.value = DateTime.now();
    _schoolSemesters.value = [];
  }

  Schoolday? getSchooldayByDate(DateTime date) {
    final Schoolday? schoolday = _schooldays.value.firstWhereOrNull((element) =>
        element.schoolday.year == date.year &&
        element.schoolday.month == date.month &&
        element.schoolday.day == date.day);

    return schoolday;
  }

  Future<void> getSchooldays() async {
    final List<Schoolday> responseSchooldays =
        await di<Client>().schoolday.getSchooldays();

    if (responseSchooldays.isNotEmpty) {
      di<NotificationService>()
          .showSnackBar(NotificationType.success, 'Schultage geladen');
      _schooldays.value = responseSchooldays;
      di<EnvManager>().setPopulatedEnvServerData(schooldays: true);

      setAvailableDates();
      return;
    }

    di<NotificationService>().showSnackBar(NotificationType.warning,
        '${responseSchooldays.length} Keine Schultage gefunden!');

    return;
  }

  Future<void> postSchoolday(DateTime schoolday) async {
    final Schoolday? newSchoolday =
        await di<Client>().schooldayAdmin.createSchoolday(schoolday);
    if (newSchoolday == null) {
      di<NotificationService>().showSnackBar(
          NotificationType.error, 'Schultag konnte nicht erstellt werden');
      return;
    }
    _schooldays.value = [..._schooldays.value, newSchoolday];

    di<NotificationService>().showSnackBar(
        NotificationType.success, 'Schultag erfolgreich erstellt');

    setAvailableDates();

    return;
  }

  Future<void> postMultipleSchooldays({required List<DateTime> dates}) async {
    final List<Schoolday> newSchooldays =
        await di<Client>().schooldayAdmin.createSchooldays(dates);

    _schooldays.value = [..._schooldays.value, ...newSchooldays];

    di<NotificationService>().showSnackBar(
        NotificationType.success, 'Schultage erfolgreich erstellt');

    setAvailableDates();

    return;
  }

  Future<void> deleteSchoolday(DateTime date) async {
    final bool isDeleted =
        await di<Client>().schooldayAdmin.deleteSchoolday(date);

    final Schoolday? schoolday = getSchooldayByDate(date);
    if (schoolday == null) {
      di<NotificationService>().showSnackBar(
          NotificationType.error, 'Schultag konnte nicht gefunden werden');
      return;
    }
    if (isDeleted) {
      _schooldays.value =
          _schooldays.value.where((day) => day != schoolday).toList();

      di<NotificationService>().showSnackBar(
          NotificationType.success, 'Schultag erfolgreich gelöscht');
      return;
    }

    setAvailableDates();

    return;
  }

  // Future<void> getSchoolSemesters() async {
  //   final List<SchoolSemester> responseSchoolSemesters =
  //       await apiSchooldayService.getSchoolSemesters();

  //   di<NotificationService>().showSnackBar(NotificationType.success,
  //       '${responseSchoolSemesters.length} Schulhalbjahre geladen!');

  //   _schoolSemesters.value = responseSchoolSemesters;

  //   if (responseSchoolSemesters.isNotEmpty) {
  //     di<EnvManager>().setPopulatedEnvServerData(schoolSemester: true);
  //   }
  //   return;
  // }

  // Future<void> postSchoolSemester(
  //     {required DateTime startDate,
  //     required DateTime endDate,
  //     required bool isFirst}) async {
  //   final SchoolSemester newSemester =
  //       await apiSchooldayService.postSchoolSemester(
  //           startDate: startDate, endDate: endDate, isFirst: isFirst);

  //   _schoolSemesters.value = [..._schoolSemesters.value, newSemester];

  //   di<NotificationService>().showSnackBar(
  //       NotificationType.success, 'Schulhalbjahr erfolgreich erstellt');

  //   return;
  // }

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

  void setStartDate(DateTime date) {
    _startDate.value = date;
  }

  void setEndDate(DateTime date) {
    _endDate.value = date;
  }
}
