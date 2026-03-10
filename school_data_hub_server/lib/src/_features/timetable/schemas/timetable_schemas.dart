import 'package:school_data_hub_server/src/generated/protocol.dart';

class TimetableSchemas {
  static TimetableInclude timetableAllInclude = Timetable.include(
    schoolSemester: SchoolSemester.include(),
    scheduledLessons: ScheduledLesson.includeList(),
    timetableSlots: TimetableSlot.includeList(),
    lessonGroups: LessonGroup.includeList(),
  );

  static LessonGroupInclude lessonGroupAllInclude = LessonGroup.include(
    scheduledLessons: ScheduledLesson.includeList(),
    memberships: ScheduledLessonGroupMembership.includeList(),
  );
  static ScheduledLessonInclude scheduledLessonAllInclude =
      ScheduledLesson.include(
    subject: Subject.include(),
    scheduledAt: TimetableSlot.include(),
    timetable: Timetable.include(),
    lessonTeachers: ScheduledLessonTeacher.includeList(),
    room: Classroom.include(),
    lessonGroup: LessonGroup.include(),
  );
}
