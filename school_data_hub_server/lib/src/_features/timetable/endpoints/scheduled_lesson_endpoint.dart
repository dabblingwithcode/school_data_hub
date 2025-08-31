import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ScheduledLessonEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<ScheduledLesson?> createScheduledLesson(
      Session session, ScheduledLesson scheduledLesson) async {
    // Validate that the timetable exists
    if (scheduledLesson.timetableId != null) {
      final timetable =
          await Timetable.db.findById(session, scheduledLesson.timetableId!);
      if (timetable == null) {
        throw Exception(
            'Timetable with id ${scheduledLesson.timetableId} does not exist.');
      }
    }

    // Validate that the subject exists
    if (scheduledLesson.subjectId != null) {
      final subject =
          await Subject.db.findById(session, scheduledLesson.subjectId!);
      if (subject == null) {
        throw Exception(
            'Subject with id ${scheduledLesson.subjectId} does not exist.');
      }
    }

    // Validate that the room exists
    if (scheduledLesson.roomId != null) {
      final room =
          await Classroom.db.findById(session, scheduledLesson.roomId!);
      if (room == null) {
        throw Exception(
            'Classroom with id ${scheduledLesson.roomId} does not exist.');
      }
    }

    // Validate that the lesson group exists
    if (scheduledLesson.lessonGroupId != null) {
      final lessonGroup = await LessonGroup.db
          .findById(session, scheduledLesson.lessonGroupId!);
      if (lessonGroup == null) {
        throw Exception(
            'Lesson group with id ${scheduledLesson.lessonGroupId} does not exist.');
      }
    }

    // Validate that the timetable slot exists
    if (scheduledLesson.scheduledAtId != null) {
      final slot = await TimetableSlot.db
          .findById(session, scheduledLesson.scheduledAtId!);
      if (slot == null) {
        throw Exception(
            'Timetable slot with id ${scheduledLesson.scheduledAtId} does not exist.');
      }
    }

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
