import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';

/// API service for school calendar operations (schooldays & semesters).
class SchoolCalendarApiService {
  Client get _client => di<Client>();

  //-- Schoolday operations --

  /// Fetch all schooldays.
  Future<List<Schoolday>> getSchooldays() async {
    return _client.schoolday.getSchooldays();
  }

  /// Create a single schoolday.
  Future<Schoolday?> createSchoolday(DateTime date) async {
    return _client.adminSchoolDay.createSchoolday(date);
  }

  /// Create multiple schooldays in bulk.
  Future<List<Schoolday>> createSchooldays(List<DateTime> dates) async {
    return _client.adminSchoolDay.createSchooldays(dates);
  }

  // Update a schoolday's date. Returns the updated schoolday on success.
  Future<Schoolday?> updateSchoolday(Schoolday schoolday) async {
    return _client.adminSchoolDay.updateSchoolday(schoolday);
  }

  /// Delete a schoolday by date. Returns `true` on success.
  Future<bool> deleteSchoolday(DateTime date) async {
    return _client.adminSchoolDay.deleteSchoolday(date);
  }

  //-- School semester operations --

  /// Fetch all school semesters.
  Future<List<SchoolSemester>> getSchoolSemesters() async {
    return _client.schoolday.getSchoolSemesters();
  }

  /// Create a new school semester.
  Future<SchoolSemester?> createSchoolSemester({
    required String schoolYearName,
    required DateTime startDate,
    required DateTime endDate,
    required bool isFirst,
    DateTime? classConferenceDate,
    DateTime? supportConferenceDate,
    DateTime? reportConferenceDate,
    DateTime? reportSignedDate,
  }) async {
    return ClientHelper.apiCall(
      call: () => _client.adminSchoolDay.createSchoolSemester(
        schoolYearName,
        startDate,
        endDate,
        isFirst,
        classConferenceDate,
        supportConferenceDate,
        reportConferenceDate,
        reportSignedDate,
      ),
    );
  }

  Future<SchoolSemester?> updateSchoolSemester(SchoolSemester semester) async {
    return _client.adminSchoolDay.updateSchoolSemester(semester);
  }

  /// Delete a school semester by its object. Returns `true` on success.
  Future<bool> deleteSchoolSemester(SchoolSemester semester) async {
    return _client.adminSchoolDay.deleteSchoolSemester(semester);
  }
}
