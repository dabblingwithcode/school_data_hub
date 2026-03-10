import 'package:school_data_hub_client/school_data_hub_client.dart';

/// Result of validating a drag-snap position for a lesson in the room grid.
sealed class RoomDragSnapResult {
  const RoomDragSnapResult();

  /// Whether the requested position is allowed (no group/teacher conflict).
  bool get isValid;

  /// Start slot index to use (requested if valid, otherwise next valid in that room).
  int get suggestedStartSlotIndex;
}

/// The requested snap position is allowed.
final class RoomDragSnapValid extends RoomDragSnapResult {
  const RoomDragSnapValid({required this.suggestedStartSlotIndex});

  @override
  bool get isValid => true;

  @override
  final int suggestedStartSlotIndex;
}

/// The requested position would put group or teacher in two places at once.
/// [conflictEntityLabel] is the display name for the message
/// "$entity kann nicht gleichzeitig in 2 Orten sein".
final class RoomDragSnapConflict extends RoomDragSnapResult {
  const RoomDragSnapConflict({
    required this.conflictEntityLabel,
    required this.suggestedStartSlotIndex,
  });

  @override
  bool get isValid => false;

  /// Display name of the group or teacher that would be double-booked.
  final String conflictEntityLabel;

  @override
  final int suggestedStartSlotIndex;
}

/// The requested position would overlap another lesson in the same room.
final class RoomDragSnapRoomOccupied extends RoomDragSnapResult {
  const RoomDragSnapRoomOccupied({required this.suggestedStartSlotIndex});

  @override
  bool get isValid => false;

  @override
  final int suggestedStartSlotIndex;
}

/// Validates drag-snap positions so that neither the lesson group nor any
/// teacher is scheduled in two rooms at the same time. Provides the next
/// valid slot in the same room when the requested position is invalid.
class RoomDragSnapValidator {
  RoomDragSnapValidator({
    required this.dayStartMinutes,
    required this.dayEndMinutes,
    required this.slotMinutes,
  });

  final int dayStartMinutes;
  final int dayEndMinutes;
  final int slotMinutes;

  int get slotsPerDay =>
      ((dayEndMinutes - dayStartMinutes) / slotMinutes).round();

  /// Parses "HH:MM" to minutes since midnight.
  static int _hhmmToMinutes(String hhmm) {
    final parts = hhmm.split(':');
    if (parts.length != 2) return 0;
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return hour * 60 + minute;
  }

  /// Converts slot index to start minutes (since midnight).
  int slotIndexToStartMinutes(int slotIndex) {
    return dayStartMinutes + slotIndex * slotMinutes;
  }

  /// Converts slot index + duration in slots to end minutes (exclusive).
  int slotRangeToEndMinutes(int startSlotIndex, int durationSlots) {
    return slotIndexToStartMinutes(startSlotIndex) +
        durationSlots * slotMinutes;
  }

  /// Returns slot indices [start, end) for a lesson from its timetable slot.
  (int start, int end)? _lessonSlotRange(
    ScheduledLesson lesson,
    Map<int, TimetableSlot> slotIdMap,
  ) {
    final slot = slotIdMap[lesson.scheduledAtId];
    if (slot == null) return null;
    final startMin = _hhmmToMinutes(slot.startTime);
    final endMin = _hhmmToMinutes(slot.endTime);
    final startIndex = ((startMin - dayStartMinutes) / slotMinutes).floor();
    final endIndex = ((endMin - dayStartMinutes) / slotMinutes).ceil();
    return (startIndex.clamp(0, slotsPerDay), endIndex.clamp(0, slotsPerDay));
  }

  /// Checks if [startSlotIndex, startSlotIndex + durationSlots) overlaps [otherStart, otherEnd) in slot index space.
  static bool _rangesOverlap(
    int startSlotIndex,
    int durationSlots,
    int otherStart,
    int otherEnd,
  ) {
    final dragEnd = startSlotIndex + durationSlots;
    return dragEnd > otherStart && otherEnd > startSlotIndex;
  }

  /// Gets teacher userIds for a lesson (mainTeacher + lessonTeachers).
  static Iterable<int> _teacherIds(ScheduledLesson lesson) sync* {
    yield lesson.mainTeacherId;
    final list = lesson.lessonTeachers;
    if (list != null) {
      for (final t in list) {
        yield t.userId;
      }
    }
  }

  /// Builds a display label for the conflicting entity (group or teacher).
  static String _conflictEntityLabel(ScheduledLesson other, bool isGroup) {
    if (isGroup) {
      return other.lessonGroup?.name ?? 'Gruppe';
    }
    for (final t in other.lessonTeachers ?? <ScheduledLessonTeacher>[]) {
      if (t.userId == other.mainTeacherId && t.user?.userInfo != null) {
        final name = t.user!.userInfo!.userName;
        if (name != null && name.isNotEmpty) return name;
        break;
      }
    }
    return 'Lehrkraft';
  }

  /// Validates placing [draggedLesson] at [targetRoomId], [startSlotIndex], with [durationSlots].
  /// [weekdayLessons] = all scheduled lessons on the same weekday (including [draggedLesson]).
  /// [slotIdMap] = map slot id -> TimetableSlot for that weekday (or all slots).
  /// Returns a result with suggested snap (same or next valid slot) and conflict info if invalid.
  RoomDragSnapResult validate({
    required ScheduledLesson draggedLesson,
    required int targetRoomId,
    required int startSlotIndex,
    required int durationSlots,
    required Weekday weekday,
    required List<ScheduledLesson> weekdayLessons,
    required Map<int, TimetableSlot> slotIdMap,
  }) {
    final otherLessons = weekdayLessons
        .where((l) => l.id != draggedLesson.id && l.roomId != targetRoomId)
        .toList();
    final sameRoomLessons = weekdayLessons
        .where((l) => l.id != draggedLesson.id && l.roomId == targetRoomId)
        .toList();

    final dragGroupId = draggedLesson.lessonGroupId;
    final dragTeacherIds = _teacherIds(draggedLesson).toSet();

    // Check if requested position overlaps another lesson in the same room.
    for (final other in sameRoomLessons) {
      final range = _lessonSlotRange(other, slotIdMap);
      if (range == null) continue;
      final (otherStart, otherEnd) = range;
      final overlaps =
          _rangesOverlap(startSlotIndex, durationSlots, otherStart, otherEnd);
      if (overlaps) {
        return RoomDragSnapRoomOccupied(
          suggestedStartSlotIndex: _nextValidStartSlotInRoom(
            draggedLesson: draggedLesson,
            targetRoomId: targetRoomId,
            fromStartSlotIndex: startSlotIndex,
            durationSlots: durationSlots,
            weekday: weekday,
            weekdayLessons: weekdayLessons,
            slotIdMap: slotIdMap,
            dragGroupId: dragGroupId,
            dragTeacherIds: dragTeacherIds,
            sameRoomLessons: sameRoomLessons,
            otherLessons: otherLessons,
          ),
        );
      }
    }

    // Check if requested position conflicts (group or teacher elsewhere at same time).
    for (final other in otherLessons) {
      final range = _lessonSlotRange(other, slotIdMap);
      if (range == null) continue;
      final (otherStart, otherEnd) = range;
      final overlaps =
          _rangesOverlap(startSlotIndex, durationSlots, otherStart, otherEnd);
      if (!overlaps) continue;

      if (other.lessonGroupId == dragGroupId) {
        return RoomDragSnapConflict(
          conflictEntityLabel: _conflictEntityLabel(other, true),
          suggestedStartSlotIndex: _nextValidStartSlotInRoom(
            draggedLesson: draggedLesson,
            targetRoomId: targetRoomId,
            fromStartSlotIndex: startSlotIndex,
            durationSlots: durationSlots,
            weekday: weekday,
            weekdayLessons: weekdayLessons,
            slotIdMap: slotIdMap,
            dragGroupId: dragGroupId,
            dragTeacherIds: dragTeacherIds,
            sameRoomLessons: sameRoomLessons,
            otherLessons: otherLessons,
          ),
        );
      }

      for (final uid in _teacherIds(other)) {
        if (dragTeacherIds.contains(uid)) {
          return RoomDragSnapConflict(
            conflictEntityLabel: _conflictEntityLabel(other, false),
            suggestedStartSlotIndex: _nextValidStartSlotInRoom(
              draggedLesson: draggedLesson,
              targetRoomId: targetRoomId,
              fromStartSlotIndex: startSlotIndex,
              durationSlots: durationSlots,
              weekday: weekday,
              weekdayLessons: weekdayLessons,
              slotIdMap: slotIdMap,
              dragGroupId: dragGroupId,
              dragTeacherIds: dragTeacherIds,
              sameRoomLessons: sameRoomLessons,
              otherLessons: otherLessons,
            ),
          );
        }
      }
    }

    // Requested position is valid.
    return RoomDragSnapValid(suggestedStartSlotIndex: startSlotIndex);
  }

  /// Finds the next start slot index in the same room that has no group/teacher conflict.
  int _nextValidStartSlotInRoom({
    required ScheduledLesson draggedLesson,
    required int targetRoomId,
    required int fromStartSlotIndex,
    required int durationSlots,
    required Weekday weekday,
    required List<ScheduledLesson> weekdayLessons,
    required Map<int, TimetableSlot> slotIdMap,
    required int dragGroupId,
    required Set<int> dragTeacherIds,
    required List<ScheduledLesson> sameRoomLessons,
    required List<ScheduledLesson> otherLessons,
  }) {
    final maxStart = (slotsPerDay - durationSlots).clamp(0, slotsPerDay);

    for (var tryStart = fromStartSlotIndex; tryStart <= maxStart; tryStart++) {
      var hasConflict = false;

      // Same room: no time overlap with another lesson.
      for (final other in sameRoomLessons) {
        final range = _lessonSlotRange(other, slotIdMap);
        if (range == null) continue;
        final (otherStart, otherEnd) = range;
        if (_rangesOverlap(tryStart, durationSlots, otherStart, otherEnd)) {
          hasConflict = true;
          break;
        }
      }
      if (hasConflict) continue;

      // Other rooms: no group/teacher double-book.
      for (final other in otherLessons) {
        final range = _lessonSlotRange(other, slotIdMap);
        if (range == null) continue;
        final (otherStart, otherEnd) = range;
        final overlaps =
            _rangesOverlap(tryStart, durationSlots, otherStart, otherEnd);
        if (!overlaps) continue;

        if (other.lessonGroupId == dragGroupId) {
          hasConflict = true;
          break;
        }
        for (final uid in _teacherIds(other)) {
          if (dragTeacherIds.contains(uid)) {
            hasConflict = true;
            break;
          }
        }
        if (hasConflict) break;
      }

      if (!hasConflict) return tryStart;
    }

    return fromStartSlotIndex;
  }
}
