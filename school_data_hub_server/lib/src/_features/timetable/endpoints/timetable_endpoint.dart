import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class TimetableEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<Timetable> createTimetable(
      Session session, Timetable timetable) async {
    // Validate that the school semester exists if provided
    if (timetable.schoolSemesterId != null) {
      final schoolSemester = await SchoolSemester.db
          .findById(session, timetable.schoolSemesterId!);
      if (schoolSemester == null) {
        throw Exception(
            'School semester with id ${timetable.schoolSemesterId} does not exist.');
      }
    }

    final timetableInDatabase =
        await Timetable.db.insertRow(session, timetable);
    return timetableInDatabase;
  }

  //- read

  Future<List<Timetable>> fetchTimetables(Session session) async {
    final timetables = await Timetable.db.find(
      session,
      include: Timetable.include(
        schoolSemester: SchoolSemester.include(),
        scheduledLessons: ScheduledLesson.includeList(),
        timetableSlots: TimetableSlot.includeList(),
        lessonGroups: LessonGroup.includeList(),
      ),
    );
    return timetables;
  }

  Future<Timetable?> fetchTimetableById(Session session, int id) async {
    final timetable = await Timetable.db.findById(
      session,
      id,
      include: Timetable.include(
        schoolSemester: SchoolSemester.include(),
        scheduledLessons: ScheduledLesson.includeList(),
        timetableSlots: TimetableSlot.includeList(),
        lessonGroups: LessonGroup.includeList(),
      ),
    );
    return timetable;
  }

  Future<Timetable?> fetchTimetable(Session session) async {
    // Fetch the active timetable
    final timetables = await Timetable.db.find(
      session,
      where: (t) => t.active.equals(true),
      include: Timetable.include(
        schoolSemester: SchoolSemester.include(),
        scheduledLessons: ScheduledLesson.includeList(),
        timetableSlots: TimetableSlot.includeList(),
        lessonGroups: LessonGroup.includeList(),
      ),
    );
    return timetables.isNotEmpty ? timetables.first : null;
  }

  Future<Timetable?> fetchCompleteTimetableData(Session session) async {
    // Fetch the active timetable with all related data
    final timetables = await Timetable.db.find(
      session,
      where: (t) => t.active.equals(true),
      include: Timetable.include(
        schoolSemester: SchoolSemester.include(),
        scheduledLessons: ScheduledLesson.includeList(
          include: ScheduledLesson.include(
            subject: Subject.include(),
            scheduledAt: TimetableSlot.include(),
            lessonTeachers: ScheduledLessonTeacher.includeList(),
            room: Classroom.include(),
            lessonGroup: LessonGroup.include(),
          ),
        ),
        timetableSlots: TimetableSlot.includeList(),
        lessonGroups: LessonGroup.includeList(),
      ),
    );
    return timetables.isNotEmpty ? timetables.first : null;
  }

  Future<List<Timetable>> fetchActiveTimetables(Session session) async {
    final timetables = await Timetable.db.find(
      session,
      where: (t) => t.active.equals(true),
      include: Timetable.include(
        schoolSemester: SchoolSemester.include(),
        scheduledLessons: ScheduledLesson.includeList(),
        timetableSlots: TimetableSlot.includeList(),
        lessonGroups: LessonGroup.includeList(),
      ),
    );
    return timetables;
  }

  Future<List<Timetable>> fetchTimetablesBySemester(
      Session session, int schoolSemesterId) async {
    final timetables = await Timetable.db.find(
      session,
      where: (t) => t.schoolSemesterId.equals(schoolSemesterId),
      include: Timetable.include(
        schoolSemester: SchoolSemester.include(),
        scheduledLessons: ScheduledLesson.includeList(),
        timetableSlots: TimetableSlot.includeList(),
        lessonGroups: LessonGroup.includeList(),
      ),
    );
    return timetables;
  }

  //- update

  Future<Timetable> updateTimetable(
      Session session, Timetable timetable) async {
    final updatedTimetable = await Timetable.db.updateRow(session, timetable);
    return updatedTimetable;
  }

  Future<Timetable> deactivateTimetable(Session session, int id) async {
    final timetable = await Timetable.db.findById(session, id);
    if (timetable == null) {
      throw Exception('Timetable with id $id does not exist.');
    }

    timetable.active = false;
    timetable.endsAt = DateTime.now();

    final updatedTimetable = await Timetable.db.updateRow(session, timetable);
    return updatedTimetable;
  }

  //- delete

  Future<bool> deleteTimetable(Session session, int id) async {
    final timetable = await Timetable.db.findById(session, id);
    if (timetable == null) {
      throw Exception('Timetable with id $id does not exist.');
    }

    await Timetable.db.deleteRow(session, timetable);
    return true;
  }
}
