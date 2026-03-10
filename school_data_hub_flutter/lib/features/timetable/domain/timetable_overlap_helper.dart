import 'package:school_data_hub_client/school_data_hub_client.dart';

/// Domain helper for timetable slot overlap checks.
/// All methods are static and operate on time ranges (weekday + start/end "HH:MM").
class TimetableOverlapHelper {
  TimetableOverlapHelper._();

  /// Parses "HH:MM" to minutes since midnight. Returns null on invalid input.
  static int? _timeToMinutes(String time) {
    final parts = time.split(':');
    if (parts.length != 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null || h < 0 || h > 23 || m < 0 || m > 59) {
      return null;
    }
    return h * 60 + m;
  }

  /// Returns end time as "HH:MM" for [startTime] + [durationMinutes].
  static String addMinutesToTime(String startTime, int durationMinutes) {
    final start = _timeToMinutes(startTime);
    if (start == null) return startTime;
    final total = start + durationMinutes;
    final h = (total ~/ 60) % 24;
    final m = total % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }

  /// True if the two time ranges overlap on the same day.
  static bool timeRangesOverlapOnSameDay(
    Weekday dayA,
    String startA,
    String endA,
    Weekday dayB,
    String startB,
    String endB,
  ) {
    if (dayA != dayB) return false;
    final sa = _timeToMinutes(startA);
    final ea = _timeToMinutes(endA);
    final sb = _timeToMinutes(startB);
    final eb = _timeToMinutes(endB);
    if (sa == null || ea == null || sb == null || eb == null) return false;
    return sa < eb && sb < ea;
  }

  /// True if any lesson in [lessons] (excluding [excludeLessonId]) for
  /// [roomId] overlaps with [weekday] [startTime]-[endTime].
  static bool classroomHasOverlappingLesson(
    List<ScheduledLesson> lessons, {
    int? excludeLessonId,
    required Weekday weekday,
    required String startTime,
    required String endTime,
    required int roomId,
  }) {
    for (final lesson in lessons) {
      if (lesson.roomId != roomId) continue;
      if (excludeLessonId != null && lesson.id == excludeLessonId) continue;
      final slot = lesson.scheduledAt;
      if (slot == null) continue;
      if (timeRangesOverlapOnSameDay(
        weekday,
        startTime,
        endTime,
        slot.day,
        slot.startTime,
        slot.endTime,
      )) {
        return true;
      }
    }
    return false;
  }

  /// True if any lesson in [lessons] (excluding [excludeLessonId]) for
  /// [lessonGroupId] overlaps with [weekday] [startTime]-[endTime].
  static bool lessonGroupHasOverlappingLesson(
    List<ScheduledLesson> lessons, {
    int? excludeLessonId,
    required Weekday weekday,
    required String startTime,
    required String endTime,
    required int lessonGroupId,
  }) {
    for (final lesson in lessons) {
      if (lesson.lessonGroupId != lessonGroupId) continue;
      if (excludeLessonId != null && lesson.id == excludeLessonId) continue;
      final slot = lesson.scheduledAt;
      if (slot == null) continue;
      if (timeRangesOverlapOnSameDay(
        weekday,
        startTime,
        endTime,
        slot.day,
        slot.startTime,
        slot.endTime,
      )) {
        return true;
      }
    }
    return false;
  }

  /// True if any lesson in [lessons] (excluding [excludeLessonId]) where
  /// [userId] is main teacher or in lessonTeachers overlaps with
  /// [weekday] [startTime]-[endTime].
  static bool teacherHasOverlappingLesson(
    List<ScheduledLesson> lessons, {
    int? excludeLessonId,
    required Weekday weekday,
    required String startTime,
    required String endTime,
    required int userId,
  }) {
    for (final lesson in lessons) {
      if (excludeLessonId != null && lesson.id == excludeLessonId) continue;
      final isMain = lesson.mainTeacherId == userId;
      final isAdditional =
          lesson.lessonTeachers?.any((t) => t.userId == userId) ?? false;
      if (!isMain && !isAdditional) continue;
      final slot = lesson.scheduledAt;
      if (slot == null) continue;
      if (timeRangesOverlapOnSameDay(
        weekday,
        startTime,
        endTime,
        slot.day,
        slot.startTime,
        slot.endTime,
      )) {
        return true;
      }
    }
    return false;
  }
}
