import 'package:school_data_hub_server/src/_features/timetable/schemas/timetable_schemas.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ScheduledLessonEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<ScheduledLesson?> createScheduledLesson(
      Session session, ScheduledLesson scheduledLesson) async {
    // Validate that the timetable exists
    final timetable =
        await Timetable.db.findById(session, scheduledLesson.timetableId);
    if (timetable == null) {
      throw Exception(
          'Timetable with id ${scheduledLesson.timetableId} does not exist.');
    }

    // Validate that the subject exists
    final subject =
        await Subject.db.findById(session, scheduledLesson.subjectId);
    if (subject == null) {
      throw Exception(
          'Subject with id ${scheduledLesson.subjectId} does not exist.');
    }

    // Validate that the room exists
    final room = await Classroom.db.findById(session, scheduledLesson.roomId);
    if (room == null) {
      throw Exception(
          'Classroom with id ${scheduledLesson.roomId} does not exist.');
    }

    // Validate that the lesson group exists
    final lessonGroup =
        await LessonGroup.db.findById(session, scheduledLesson.lessonGroupId);
    if (lessonGroup == null) {
      throw Exception(
          'Lesson group with id ${scheduledLesson.lessonGroupId} does not exist.');
    }

    // Validate that the timetable slot exists
    final slot =
        await TimetableSlot.db.findById(session, scheduledLesson.scheduledAtId);
    if (slot == null) {
      throw Exception(
          'Timetable slot with id ${scheduledLesson.scheduledAtId} does not exist.');
    }

    final scheduledLessonInDatabase =
        await ScheduledLesson.db.insertRow(session, scheduledLesson);
    final scheduledLessonWithIncludes = await ScheduledLesson.db.findById(
        session, scheduledLessonInDatabase.id!,
        include: TimetableSchemas.scheduledLessonAllInclude);
    if (scheduledLessonWithIncludes == null) {
      throw Exception('Failed to find scheduled lesson with includes.');
    }
    return scheduledLessonWithIncludes;
  }

  //- read

  Future<List<ScheduledLesson>> fetchScheduledLessons(Session session) async {
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      include: TimetableSchemas.scheduledLessonAllInclude,
    );
    return scheduledLessons;
  }

  Future<ScheduledLesson?> fetchScheduledLessonById(
      Session session, int id) async {
    final scheduledLesson = await ScheduledLesson.db.findById(
      session,
      id,
      include: TimetableSchemas.scheduledLessonAllInclude,
    );
    return scheduledLesson;
  }

  Future<List<ScheduledLesson>> fetchScheduledLessonsByTimetable(
      Session session, int timetableId) async {
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.timetableId.equals(timetableId),
      include: TimetableSchemas.scheduledLessonAllInclude,
    );
    return scheduledLessons;
  }

  Future<List<ScheduledLesson>> fetchScheduledLessonsBySubject(
      Session session, int subjectId) async {
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.subjectId.equals(subjectId),
      include: TimetableSchemas.scheduledLessonAllInclude,
    );
    return scheduledLessons;
  }

  Future<List<ScheduledLesson>> fetchScheduledLessonsByRoom(
      Session session, int roomId) async {
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.roomId.equals(roomId),
      include: TimetableSchemas.scheduledLessonAllInclude,
    );
    return scheduledLessons;
  }

  Future<List<ScheduledLesson>> fetchScheduledLessonsBySlotId(
      Session session, int slotId) async {
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.scheduledAtId.equals(slotId),
      include: TimetableSchemas.scheduledLessonAllInclude,
    );
    return scheduledLessons;
  }

  Future<List<ScheduledLesson>> fetchActiveScheduledLessons(
      Session session) async {
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.active.equals(true),
      include: TimetableSchemas.scheduledLessonAllInclude,
    );
    return scheduledLessons;
  }

  //- update

  Future<ScheduledLesson?> updateScheduledLesson(
      Session session, ScheduledLesson scheduledLesson) async {
    final existing =
        await ScheduledLesson.db.findById(session, scheduledLesson.id!);
    if (existing == null) {
      throw Exception(
          'Scheduled lesson with id ${scheduledLesson.id} does not exist.');
    }

    final oldSlotId = existing.scheduledAtId;
    final newSlotId = scheduledLesson.scheduledAtId;

    final updatedScheduledLesson =
        await ScheduledLesson.db.updateRow(session, scheduledLesson);

    if (oldSlotId != newSlotId) {
      final lessonsStillUsingOldSlot = await ScheduledLesson.db.find(
        session,
        where: (t) => t.scheduledAtId.equals(oldSlotId),
      );
      if (lessonsStillUsingOldSlot.isEmpty) {
        final slotToDelete =
            await TimetableSlot.db.findById(session, oldSlotId);
        if (slotToDelete != null) {
          await TimetableSlot.db.deleteRow(session, slotToDelete);
        }
      }
    }

    final updatedScheduledLessonWithIncludes = await ScheduledLesson.db
        .findById(session, updatedScheduledLesson.id!,
            include: TimetableSchemas.scheduledLessonAllInclude);
    if (updatedScheduledLessonWithIncludes == null) {
      throw Exception('Failed to find scheduled lesson with includes.');
    }
    return updatedScheduledLessonWithIncludes;
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

    final slotId = scheduledLesson.scheduledAtId;
    await ScheduledLesson.db.deleteRow(session, scheduledLesson);

    final lessonsStillUsingSlot = await ScheduledLesson.db.find(
      session,
      where: (t) => t.scheduledAtId.equals(slotId),
    );
    if (lessonsStillUsingSlot.isEmpty) {
      final slot = await TimetableSlot.db.findById(session, slotId);
      if (slot != null) {
        await TimetableSlot.db.deleteRow(session, slot);
      }
    }

    return true;
  }
}
