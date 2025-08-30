import 'package:school_data_hub_client/school_data_hub_client.dart';

class TimetableMockData {
  static Timetable generateMockTimetable() {
    final timetableSlots = generateMockTimetableSlots();
    final subjects = generateMockSubjects();
    final classrooms = generateMockClassrooms();
    final lessonGroups = generateMockLessonGroups();

    final scheduledLessons = generateMockScheduledLessons(
      timetableSlots,
      subjects,
      classrooms,
      lessonGroups,
    );

    return Timetable(
      id: 1,
      active: true,
      startsAt: DateTime(2025, 1, 1),
      endsAt: DateTime(2025, 12, 31),
      name: 'Stundenplan 2025',
      schoolSemesterId: 1,
      timetableSlots: timetableSlots,
      scheduledLessons: scheduledLessons,
      createdBy: 'system',
      createdAt: DateTime.now(),
    );
  }

  static List<TimetableSlot> generateMockTimetableSlots() {
    final List<TimetableSlot> slots = [];
    int id = 1;

    // Time slots for each day
    final times = [
      {'start': '07:50', 'end': '08:15'},
      {'start': '08:15', 'end': '09:00'},
      {'start': '09:00', 'end': '09:45'},
      {'start': '09:45', 'end': '10:30'},
      {'start': '10:30', 'end': '10:50'},
      {'start': '10:50', 'end': '11:15'},
      {'start': '11:15', 'end': '12:00'},
      {'start': '12:00', 'end': '12:45'},
      {'start': '12:45', 'end': '13:30'},
    ];

    // Generate slots for each weekday
    for (final weekday in Weekday.values) {
      for (final time in times) {
        slots.add(
          TimetableSlot(
            id: id++,
            day: weekday,
            startTime: time['start']!,
            endTime: time['end']!,
            timetableId: 1, // Reference to our main timetable
          ),
        );
      }
    }

    return slots;
  }

  static List<Subject> generateMockSubjects() {
    return [
      Subject(
        id: 1,
        publicId: 'MATH001',
        name: 'Mathematik',
        description: 'Grundlegende Mathematik',
        color: '#FF5722',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
      ),
      Subject(
        id: 2,
        publicId: 'GER001',
        name: 'Deutsch',
        description: 'Deutsche Sprache und Literatur',
        color: '#2196F3',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
      ),
      Subject(
        id: 3,
        publicId: 'ENG001',
        name: 'Englisch',
        description: 'Englische Sprache',
        color: '#4CAF50',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
      ),
      Subject(
        id: 4,
        publicId: 'SCI001',
        name: 'Naturwissenschaften',
        description: 'Grundlegende Naturwissenschaften',
        color: '#9C27B0',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
      ),
      Subject(
        id: 5,
        publicId: 'PE001',
        name: 'Sport',
        description: 'Körperliche Erziehung',
        color: '#FF9800',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
      ),
    ];
  }

  static List<Classroom> generateMockClassrooms() {
    return [
      Classroom(id: 1, roomCode: 'A101', roomName: 'Klassenraum A101'),
      Classroom(id: 2, roomCode: 'A102', roomName: 'Klassenraum A102'),
      Classroom(id: 3, roomCode: 'A103', roomName: 'Klassenraum A103'),
      Classroom(id: 4, roomCode: 'A104', roomName: 'Klassenraum A104'),
      Classroom(id: 5, roomCode: 'A105', roomName: 'Klassenraum A105'),
      Classroom(id: 6, roomCode: 'B101', roomName: 'Klassenraum B101'),
      Classroom(id: 7, roomCode: 'B102', roomName: 'Klassenraum B102'),
      Classroom(id: 8, roomCode: 'B103', roomName: 'Klassenraum B103'),
      Classroom(id: 9, roomCode: 'C101', roomName: 'Klassenraum C101'),
      Classroom(id: 10, roomCode: 'C102', roomName: 'Klassenraum C102'),
      Classroom(id: 11, roomCode: 'GYM1', roomName: 'Turnhalle 1'),
      Classroom(id: 12, roomCode: 'GYM2', roomName: 'Turnhalle 2'),
      Classroom(id: 13, roomCode: 'LAB1', roomName: 'Labor 1'),
      Classroom(id: 14, roomCode: 'LAB2', roomName: 'Labor 2'),
      Classroom(id: 15, roomCode: 'MUS1', roomName: 'Musikraum'),
    ];
  }

  static List<LessonGroup> generateMockLessonGroups() {
    return [
      LessonGroup(
        id: 1,
        publicId: 'GROUP_5A',
        name: 'Klasse 5A',
        color: '#E3F2FD',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 2,
        publicId: 'GROUP_5B',
        name: 'Klasse 5B',
        color: '#F3E5F5',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 3,
        publicId: 'GROUP_6A',
        name: 'Klasse 6A',
        color: '#E8F5E8',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 4,
        publicId: 'GROUP_6B',
        name: 'Klasse 6B',
        color: '#FFF3E0',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 5,
        publicId: 'GROUP_7A',
        name: 'Klasse 7A',
        color: '#FCE4EC',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 6,
        publicId: 'GROUP_7B',
        name: 'Klasse 7B',
        color: '#E0F2F1',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 7,
        publicId: 'GROUP_8A',
        name: 'Klasse 8A',
        color: '#F1F8E9',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 8,
        publicId: 'GROUP_8B',
        name: 'Klasse 8B',
        color: '#FFF8E1',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 9,
        publicId: 'GROUP_9A',
        name: 'Klasse 9A',
        color: '#E8EAF6',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 10,
        publicId: 'GROUP_9B',
        name: 'Klasse 9B',
        color: '#E1F5FE',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 11,
        publicId: 'GROUP_10A',
        name: 'Klasse 10A',
        color: '#F9FBE7',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 12,
        publicId: 'GROUP_10B',
        name: 'Klasse 10B',
        color: '#FFF3E0',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 13,
        publicId: 'GROUP_11A',
        name: 'Klasse 11A',
        color: '#F3E5F5',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 14,
        publicId: 'GROUP_11B',
        name: 'Klasse 11B',
        color: '#E0F7FA',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
      LessonGroup(
        id: 15,
        publicId: 'GROUP_12A',
        name: 'Klasse 12A',
        color: '#EFEBE9',
        createdBy: 'system',
        createdAt: DateTime.now(),
        modifiedBy: 'system',
        modifiedAt: DateTime.now(),
      ),
    ];
  }

  static List<ScheduledLesson> generateMockScheduledLessons(
    List<TimetableSlot> slots,
    List<Subject> subjects,
    List<Classroom> classrooms,
    List<LessonGroup> lessonGroups,
  ) {
    final List<ScheduledLesson> lessons = [];
    int lessonId = 1;

    // First, create 15 simultaneous lessons for Monday 8:15-9:00
    final mondaySlot815 = slots.firstWhere(
      (s) => s.day == Weekday.monday && s.startTime == '08:15',
    );

    // Add 3 lessons for all groups at Monday 8:15-9:00
    for (int i = 0; i < 3; i++) {
      final subject = subjects[i % subjects.length]; // Cycle through subjects
      final room = classrooms[i]; // Use different room for each
      final lessonGroup = lessonGroups[i]; // One lesson per group

      lessons.add(
        ScheduledLesson(
          id: lessonId++,
          active: true,
          publicId: 'LESSON_${lessonId}_${mondaySlot815.id}',
          subjectId: subject.id!,
          subject: subject,
          scheduledAtId: mondaySlot815.id!,
          scheduledAt: mondaySlot815,
          timetableId: 1, // Reference to our main timetable
          lessonId: 'L${lessonId}_MONDAY_815',
          roomId: room.id!,
          room: room,
          lessonGroupId: lessonGroup.id!,
          lessonGroup: lessonGroup,
          timetableSlotOrder:
              i + 1, // Unique order within the time slot (1, 2, 3)
          mainTeacherId:
              1, // Default teacher ID - will be managed by UserManager
          createdBy: 'system',
          createdAt: DateTime.now(),
          modifiedBy: 'system',
          modifiedAt: DateTime.now(),
        ),
      );
    }

    // Create some additional sample lessons for other time slots
    final sampleLessons = [
      {
        'day': Weekday.monday,
        'startTime': '09:00',
        'subjectId': 2, // German
        'roomId': 1,
        'lessonGroupId': 1,
      },
      {
        'day': Weekday.tuesday,
        'startTime': '08:15',
        'subjectId': 3, // English
        'roomId': 2,
        'lessonGroupId': 1,
      },
      {
        'day': Weekday.tuesday,
        'startTime': '11:15',
        'subjectId': 5, // PE
        'roomId': 11,
        'lessonGroupId': 1,
      },
      {
        'day': Weekday.wednesday,
        'startTime': '09:00',
        'subjectId': 4, // Science
        'roomId': 13,
        'lessonGroupId': 1,
      },
      {
        'day': Weekday.thursday,
        'startTime': '08:15',
        'subjectId': 1, // Math
        'roomId': 1,
        'lessonGroupId': 2,
      },
      {
        'day': Weekday.friday,
        'startTime': '10:50',
        'subjectId': 2, // German
        'roomId': 1,
        'lessonGroupId': 3,
      },
    ];

    for (final lessonData in sampleLessons) {
      // Find the corresponding slot
      final slot = slots.firstWhere(
        (s) =>
            s.day == lessonData['day'] &&
            s.startTime == lessonData['startTime'],
      );

      final subject = subjects.firstWhere(
        (s) => s.id == lessonData['subjectId'],
      );
      final room = classrooms.firstWhere((r) => r.id == lessonData['roomId']);
      final lessonGroup = lessonGroups.firstWhere(
        (lg) => lg.id == lessonData['lessonGroupId'],
      );

      lessons.add(
        ScheduledLesson(
          id: lessonId++,
          active: true,
          publicId: 'LESSON_${lessonId}_${slot.id}',
          subjectId: subject.id!,
          subject: subject,
          scheduledAtId: slot.id!,
          scheduledAt: slot,
          timetableId: 1, // Reference to our main timetable
          lessonId:
              'L${lessonId}_${lessonData['day']!.toString().split('.').last.toUpperCase()}',
          roomId: room.id!,
          room: room,
          lessonGroupId: lessonGroup.id!,
          lessonGroup: lessonGroup,
          timetableSlotOrder:
              1, // First (and only) lesson in each of these time slots
          mainTeacherId:
              1, // Default teacher ID - will be managed by UserManager
          createdBy: 'system',
          createdAt: DateTime.now(),
          modifiedBy: 'system',
          modifiedAt: DateTime.now(),
        ),
      );
    }

    return lessons;
  }
}
