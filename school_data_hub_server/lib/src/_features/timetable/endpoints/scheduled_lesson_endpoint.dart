import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ScheduledLessonEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<ScheduledLesson?> createScheduledLesson(
      Session session, ScheduledLesson scheduledLesson) async {
    final scheduledLessonInDatabase =
        await ScheduledLesson.db.insertRow(session, scheduledLesson);
    return scheduledLessonInDatabase;
  }

  //- read

  Future<List<ScheduledLesson>> fetchScheduledLessons(Session session) async {
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      include: ScheduledLesson.include(
        subject: Subject.include(),
        scheduledAt: TimetableSlot.include(),
        timetable: Timetable.include(),
        lessonTeachers: ScheduledLessonTeacher.includeList(),
        room: Classroom.include(),
        lessonGroup: LessonGroup.include(),
      ),
    );
    return scheduledLessons;
  }

  Future<ScheduledLesson?> fetchScheduledLessonById(
      Session session, int id) async {
    final scheduledLesson = await ScheduledLesson.db.findById(
      session,
      id,
      include: ScheduledLesson.include(
        subject: Subject.include(),
        scheduledAt: TimetableSlot.include(),
        timetable: Timetable.include(),
        lessonTeachers: ScheduledLessonTeacher.includeList(),
        room: Classroom.include(),
        lessonGroup: LessonGroup.include(),
      ),
    );
    return scheduledLesson;
  }

  Future<List<ScheduledLesson>> fetchScheduledLessonsByTimetable(
      Session session, int timetableId) async {
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.timetableId.equals(timetableId),
      include: ScheduledLesson.include(
        subject: Subject.include(),
        scheduledAt: TimetableSlot.include(),
        timetable: Timetable.include(),
        lessonTeachers: ScheduledLessonTeacher.includeList(),
        room: Classroom.include(),
        lessonGroup: LessonGroup.include(),
      ),
    );
    return scheduledLessons;
  }

  Future<List<ScheduledLesson>> fetchScheduledLessonsBySubject(
      Session session, int subjectId) async {
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.subjectId.equals(subjectId),
      include: ScheduledLesson.include(
        subject: Subject.include(),
        scheduledAt: TimetableSlot.include(),
        timetable: Timetable.include(),
        lessonTeachers: ScheduledLessonTeacher.includeList(),
        room: Classroom.include(),
        lessonGroup: LessonGroup.include(),
      ),
    );
    return scheduledLessons;
  }

  Future<List<ScheduledLesson>> fetchScheduledLessonsByRoom(
      Session session, int roomId) async {
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.roomId.equals(roomId),
      include: ScheduledLesson.include(
        subject: Subject.include(),
        scheduledAt: TimetableSlot.include(),
        timetable: Timetable.include(),
        lessonTeachers: ScheduledLessonTeacher.includeList(),
        room: Classroom.include(),
        lessonGroup: LessonGroup.include(),
      ),
    );
    return scheduledLessons;
  }

  Future<List<ScheduledLesson>> fetchScheduledLessonsBySlotId(
      Session session, int slotId) async {
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.scheduledAtId.equals(slotId),
      include: ScheduledLesson.include(
        subject: Subject.include(),
        scheduledAt: TimetableSlot.include(),
        timetable: Timetable.include(),
        lessonTeachers: ScheduledLessonTeacher.includeList(),
        room: Classroom.include(),
        lessonGroup: LessonGroup.include(),
      ),
    );
    return scheduledLessons;
  }

  Future<List<ScheduledLesson>> fetchActiveScheduledLessons(
      Session session) async {
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.active.equals(true),
      include: ScheduledLesson.include(
        subject: Subject.include(),
        scheduledAt: TimetableSlot.include(),
        timetable: Timetable.include(),
        lessonTeachers: ScheduledLessonTeacher.includeList(),
        room: Classroom.include(),
        lessonGroup: LessonGroup.include(),
      ),
    );
    return scheduledLessons;
  }

  //- update

  Future<ScheduledLesson?> updateScheduledLesson(
      Session session, ScheduledLesson scheduledLesson) async {
    final updatedScheduledLesson =
        await ScheduledLesson.db.updateRow(session, scheduledLesson);
    return updatedScheduledLesson;
  }

  Future<ScheduledLesson?> deactivateScheduledLesson(
      Session session, int id) async {
    final scheduledLesson = await ScheduledLesson.db.findById(session, id);
    if (scheduledLesson == null) {
      throw Exception('Scheduled lesson with id $id does not exist.');
    }

    scheduledLesson.active = false;

    final updatedScheduledLesson =
        await ScheduledLesson.db.updateRow(session, scheduledLesson);
    return updatedScheduledLesson;
  }

  //- delete

  Future<bool> deleteScheduledLesson(Session session, int id) async {
    final scheduledLesson = await ScheduledLesson.db.findById(session, id);
    if (scheduledLesson == null) {
      throw Exception('Scheduled lesson with id $id does not exist.');
    }

    await ScheduledLesson.db.deleteRow(session, scheduledLesson);
    return true;
  }
}
