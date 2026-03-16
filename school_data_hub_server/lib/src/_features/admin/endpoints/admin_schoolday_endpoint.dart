import 'package:collection/collection.dart';
import 'package:school_data_hub_server/src/_features/hub/services/hub_updates_tracker.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/date_extension.dart';
import 'package:serverpod/serverpod.dart';

class AdminSchoolDayEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;
  @override
  Set<Scope> get requiredScopes => {Scope('serverpod.admin')};

  //- School Semester Endpoints

  Future<SchoolSemester> createSchoolSemester(
      Session session,
      String schoolYearName,
      DateTime startDate,
      DateTime endDate,
      bool isFirst,
      DateTime? classConferenceDate,
      DateTime? supportConferenceDate,
      DateTime? reportConferenceDate,
      DateTime? reportSignedDate) async {
    final schoolSemester = SchoolSemester(
      schoolYear: schoolYearName,
      startDate: startDate,
      endDate: endDate,
      isFirst: isFirst,
      classConferenceDate: classConferenceDate,
      supportConferenceDate: supportConferenceDate,
      reportConferenceDate: reportConferenceDate,
      reportSignedDate: reportSignedDate,
    );

    await session.db.insertRow(schoolSemester);
    session.messages.postMessage('hub_events_stream', schoolSemester);
    HubUpdatesTracker.instance.touch(HubObjectType.schoolSemester);
    return schoolSemester;
  }

  Future<SchoolSemester?> updateSchoolSemester(
      Session session, SchoolSemester schoolSemester) async {
    await session.db.updateRow(schoolSemester);

    final updatedSchoolSemester = await SchoolSemester.db.findFirstRow(
      session,
      where: (t) => t.id.equals(schoolSemester.id!),
    );
    if (updatedSchoolSemester != null) {
      session.messages.postMessage('hub_events_stream', updatedSchoolSemester);
      HubUpdatesTracker.instance.touch(HubObjectType.schoolSemester);
    }
    return updatedSchoolSemester;
  }

  Future<bool> deleteSchoolSemester(
      Session session, SchoolSemester semester) async {
    await session.db.transaction((transaction) async {
      // Find all schooldays for this semester
      final schooldays = await Schoolday.db.find(
        session,
        where: (t) => t.schoolSemesterId.equals(semester.id!),
        transaction: transaction,
      );

      // Delete all SchooldayEvents related to these schooldays
      for (final schoolday in schooldays) {
        await SchooldayEvent.db.deleteWhere(
          session,
          where: (t) => t.schooldayId.equals(schoolday.id!),
          transaction: transaction,
        );
      }

      // Delete all schooldays (this will auto-cascade MissedSchoolday deletions)
      await Schoolday.db.deleteWhere(
        session,
        where: (t) => t.schoolSemesterId.equals(semester.id!),
        transaction: transaction,
      );

      // Finally delete the semester itself
      await SchoolSemester.db.deleteRow(
        session,
        semester,
        transaction: transaction,
      );
    });

    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(objectType: HubObjectType.schoolSemester, id: semester.id!),
    );

    return true;
  }

  //- Schoolday Endpoints

  Future<Schoolday?> createSchoolday(Session session, DateTime date) async {
    final newDate = date.justDate();
    final schoolSemester = await SchoolSemester.db.findFirstRow(
      session,
      where: (t) => (t.startDate <= newDate) & (t.endDate >= newDate),
    );

    if (schoolSemester == null) {
      return null;
    }
    final schoolday = Schoolday(
      schoolSemesterId: schoolSemester.id!,
      schoolday: newDate,
    );

    await session.db.insertRow(schoolday);
    session.messages.postMessage('hub_events_stream', schoolday);
    HubUpdatesTracker.instance.touch(HubObjectType.schoolday);
    return schoolday;
  }

  Future<List<Schoolday>> createSchooldays(
      Session session, List<DateTime> dates) async {
    final schooldays = <Schoolday>[];
    final allSemesters = await SchoolSemester.db.find(session);
    if (allSemesters.isEmpty) {
      throw Exception('No school semesters found in the database.');
    }

    for (final date in dates) {
      final schoolSemester = allSemesters.firstWhereOrNull((t) =>
          (t.startDate.isBeforeDay(date) || t.startDate.isSameDay(date)) &&
          (t.endDate.isAfterDay(date) || t.endDate.isSameDay(date)));

      if (schoolSemester == null) {
        throw Exception('No school semester found for date: $date');
      }

      final schoolday = Schoolday(
        schoolSemesterId: schoolSemester.id!,
        schoolday: date.justDate(),
      );
      schooldays.add(schoolday);
    }

    final newSchooldays = await session.db.insert(schooldays);

    for (final sd in newSchooldays) {
      session.messages.postMessage('hub_events_stream', sd);
    }
    HubUpdatesTracker.instance.touch(HubObjectType.schoolday);

    return newSchooldays;
  }

  Future<Schoolday> updateSchoolday(
      Session session, Schoolday schoolday) async {
    await session.db.updateRow(schoolday);

    final updatedSchoolday = await Schoolday.db
        .findFirstRow(session, where: (t) => t.id.equals(schoolday.id!));

    session.messages.postMessage('hub_events_stream', updatedSchoolday!);
    HubUpdatesTracker.instance.touch(HubObjectType.schoolday);

    return updatedSchoolday;
  }

  Future<bool> deleteSchoolday(Session session, DateTime date) async {
    final schoolday = await Schoolday.db.findFirstRow(
      session,
      where: (t) => t.schoolday.equals(date),
    );

    if (schoolday == null) {
      return false;
    }

    final schooldayId = schoolday.id!;
    await session.db.deleteRow<Schoolday>(schoolday);

    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(objectType: HubObjectType.schoolday, id: schooldayId),
    );

    return true;
  }
}
