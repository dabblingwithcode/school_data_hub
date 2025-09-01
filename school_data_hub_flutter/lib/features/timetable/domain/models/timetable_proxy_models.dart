import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

/// Proxy model for easier handling of weekday timetables
class WeekdayProxy with ChangeNotifier {
  final Weekday weekday;
  final List<TimetableSlot> timeSlots;
  final Map<int, ScheduledLesson>
  scheduledLessons; // Map from timetable slot ID to scheduled lesson

  WeekdayProxy({
    required this.weekday,
    required this.timeSlots,
    Map<int, ScheduledLesson>? scheduledLessons,
  }) : scheduledLessons = scheduledLessons ?? {};

  String get displayName {
    switch (weekday) {
      case Weekday.monday:
        return 'Montag';
      case Weekday.tuesday:
        return 'Dienstag';
      case Weekday.wednesday:
        return 'Mittwoch';
      case Weekday.thursday:
        return 'Donnerstag';
      case Weekday.friday:
        return 'Freitag';
    }
  }

  /// Get scheduled lesson for a specific time slot
  ScheduledLesson? getLessonForSlot(int slotId) {
    return scheduledLessons[slotId];
  }

  /// Add or update a scheduled lesson for a time slot
  void setLessonForSlot(int slotId, ScheduledLesson lesson) {
    scheduledLessons[slotId] = lesson;
    notifyListeners();
  }

  /// Remove a scheduled lesson from a time slot
  void removeLessonFromSlot(int slotId) {
    scheduledLessons.remove(slotId);
    notifyListeners();
  }

  /// Get all time slots that have lessons scheduled
  List<TimetableSlot> get slotsWithLessons {
    return timeSlots
        .where((slot) => scheduledLessons.containsKey(slot.id))
        .toList();
  }

  /// Get all time slots that are free
  List<TimetableSlot> get freeslots {
    return timeSlots
        .where((slot) => !scheduledLessons.containsKey(slot.id))
        .toList();
  }

  WeekdayProxy copyWith({
    Weekday? weekday,
    List<TimetableSlot>? timeSlots,
    Map<int, ScheduledLesson>? scheduledLessons,
  }) {
    return WeekdayProxy(
      weekday: weekday ?? this.weekday,
      timeSlots: timeSlots ?? this.timeSlots,
      scheduledLessons:
          scheduledLessons ??
          Map<int, ScheduledLesson>.from(this.scheduledLessons),
    );
  }
}

/// Proxy model for easier handling of subjects with color information
class SubjectProxy {
  final Subject subject;

  SubjectProxy({required this.subject});

  int? get id => subject.id;
  String get publicId => subject.publicId;
  String get name => subject.name;
  String? get description => subject.description;
  String? get color => subject.color;
  String get createdBy => subject.createdBy;
  DateTime get createdAt => subject.createdAt;
  String get modifiedBy => subject.modifiedBy;

  /// Get color as a hex string with # prefix
  String get colorHex {
    final subjectColor = color ?? '#757575';
    return subjectColor.startsWith('#') ? subjectColor : '#$subjectColor';
  }

  SubjectProxy copyWith({Subject? subject}) {
    return SubjectProxy(subject: subject ?? this.subject);
  }
}

/// Proxy model for easier handling of classrooms
class ClassroomProxy {
  final Classroom classroom;

  ClassroomProxy({required this.classroom});

  int? get id => classroom.id;
  String get roomCode => classroom.roomCode;
  String get roomName => classroom.roomName;

  /// Get display name combining code and name
  String get displayName => '$roomCode - $roomName';

  ClassroomProxy copyWith({Classroom? classroom}) {
    return ClassroomProxy(classroom: classroom ?? this.classroom);
  }
}

/// Proxy model for easier handling of lesson groups
class LessonGroupProxy {
  final LessonGroup lessonGroup;

  LessonGroupProxy({required this.lessonGroup});

  int? get id => lessonGroup.id;
  String get publicId => lessonGroup.publicId;
  String get name => lessonGroup.name;
  String? get color => lessonGroup.color;
  String get createdBy => lessonGroup.createdBy;
  DateTime get createdAt => lessonGroup.createdAt;
  String? get modifiedBy => lessonGroup.modifiedBy;
  DateTime? get modifiedAt => lessonGroup.modifiedAt;

  /// Get color as a hex string with # prefix (if color exists)
  String? get colorHex =>
      color != null ? (color!.startsWith('#') ? color : '#$color') : null;

  LessonGroupProxy copyWith({LessonGroup? lessonGroup}) {
    return LessonGroupProxy(lessonGroup: lessonGroup ?? this.lessonGroup);
  }
}

/// Proxy model for easier handling of scheduled lessons
class ScheduledLessonProxy {
  final ScheduledLesson scheduledLesson;

  ScheduledLessonProxy({required this.scheduledLesson});

  int? get id => scheduledLesson.id;
  bool get active => scheduledLesson.active;

  int get subjectId => scheduledLesson.subjectId;
  Subject? get subject => scheduledLesson.subject;
  int get scheduledAtId => scheduledLesson.scheduledAtId;
  TimetableSlot? get scheduledAt => scheduledLesson.scheduledAt;
  String get lessonId => scheduledLesson.lessonId;
  int get roomId => scheduledLesson.roomId;
  Classroom? get room => scheduledLesson.room;
  int get lessonGroupId => scheduledLesson.lessonGroupId;
  LessonGroup? get lessonGroup => scheduledLesson.lessonGroup;
  String get createdBy => scheduledLesson.createdBy;
  DateTime get createdAt => scheduledLesson.createdAt;
  String? get modifiedBy => scheduledLesson.modifiedBy;
  DateTime? get modifiedAt => scheduledLesson.modifiedAt;

  /// Get subject name
  String get subjectName => subject?.name ?? 'Unbekanntes Fach';

  /// Get subject color
  String get subjectColor => subject?.color ?? '#757575';

  /// Get subject color as hex string with # prefix
  String get subjectColorHex =>
      subjectColor.startsWith('#') ? subjectColor : '#$subjectColor';

  /// Get room display name
  String get roomDisplayName => room?.roomCode ?? 'Unbekannter Raum';

  /// Get lesson group name
  String get lessonGroupName => lessonGroup?.name ?? 'Unbekannte Gruppe';

  /// Get time slot display
  String get timeSlotDisplay {
    if (scheduledAt == null) return 'Unbekannte Zeit';
    return '${scheduledAt!.startTime} - ${scheduledAt!.endTime}';
  }

  /// Get weekday of the lesson
  Weekday? get weekday => scheduledAt?.day;

  /// Get weekday display name
  String get weekdayDisplayName {
    if (weekday == null) return 'Unbekannter Tag';
    switch (weekday!) {
      case Weekday.monday:
        return 'Montag';
      case Weekday.tuesday:
        return 'Dienstag';
      case Weekday.wednesday:
        return 'Mittwoch';
      case Weekday.thursday:
        return 'Donnerstag';
      case Weekday.friday:
        return 'Freitag';
    }
  }

  ScheduledLessonProxy copyWith({ScheduledLesson? scheduledLesson}) {
    return ScheduledLessonProxy(
      scheduledLesson: scheduledLesson ?? this.scheduledLesson,
    );
  }
}
