import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SchooldayAdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {Scope.admin};

  Future<SchoolSemester> createSchoolSemester(
      Session session,
      DateTime startDate,
      DateTime endDate,
      bool isFirst,
      DateTime classConferenceDate,
      DateTime supportConferenceDate,
      DateTime reportSignedDate) async {
    final schoolSemester = SchoolSemester(
      startDate: startDate,
      endDate: endDate,
      isFirst: isFirst,
      classConferenceDate: classConferenceDate,
      supportConferenceDate: supportConferenceDate,
      reportConferenceDate: reportSignedDate,
    );

    await session.db.insertRow(schoolSemester);
    return schoolSemester;
  }

  Future<bool> updateSchoolSemester(
      Session session, SchoolSemester schoolSemester) async {
    await session.db.updateRow(schoolSemester);
    return true;
  }

  Future<bool> deleteSchoolSemester(
      Session session, SchoolSemester semester) async {
    await session.db.deleteRow<SchoolSemester>(semester);
    return true;
  }

  Future<Schoolday?> createSchoolday(Session session, DateTime date) async {
    final schoolSemester = await SchoolSemester.db.findFirstRow(
      session,
      where: (t) => (t.startDate < date) & (t.endDate > date),
    );

    if (schoolSemester == null) {
      return null;
    }
    final schoolday = Schoolday(
      schoolSemesterId: schoolSemester.id!,
      schoolday: date,
    );

    await session.db.insertRow(schoolday);
    return schoolday;
  }

  Future<List<Schoolday>> createSchooldays(
      Session session, List<DateTime> dates) async {
    final schooldays = <Schoolday>[];
    for (final date in dates) {
      final schoolday = await createSchoolday(session, date);
      if (schoolday != null) {
        schooldays.add(schoolday);
      }
    }
    return schooldays;
  }

  Future<bool> deleteSchoolday(Session session, DateTime date) async {
    final schoolday = await Schoolday.db.findFirstRow(
      session,
      where: (t) => t.schoolday.equals(date),
    );

    if (schoolday == null) {
      return false;
    }

    await session.db.deleteRow<Schoolday>(schoolday);
    return true;
  }

  Future<bool> updateSchoolday(Session session, Schoolday schoolday) async {
    await session.db.updateRow(schoolday);
    return true;
  }
}

class SchooldayEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<SchoolSemester>> getSchoolSemesters(Session session) async {
    final schoolSemesters = await session.db.find<SchoolSemester>();

    return schoolSemesters;
  }

  Future<List<Schoolday>> getSchooldays(Session session) async {
    final schooldays = await session.db.find<Schoolday>();

    return schooldays;
  }
}
