import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

/// Manages business logic for lesson operations
class TimetableLessonManager extends ChangeNotifier {
  TimetableLessonManager();

  /// Get all lessons for a specific time slot regardless of group
  List<ScheduledLesson> getAllLessonsForSlot(int slotId, List<ScheduledLesson> scheduledLessons) {
    return scheduledLessons.where((lesson) => lesson.scheduledAtId == slotId).toList();
  }

  /// Get the next available timetableSlotOrder for a specific time slot
  /// This method finds the first gap in the sequence or returns the next number after the highest order
  int getNextAvailableOrderForSlot(int slotId, List<ScheduledLesson> scheduledLessons) {
    final lessonsInSlot = getAllLessonsForSlot(slotId, scheduledLessons);

    // If no lessons in slot, start with order 1
    if (lessonsInSlot.isEmpty) {
      return 1;
    }

    final existingOrders = lessonsInSlot.map((l) => l.timetableSlotOrder).toSet().toList()..sort();

    // Find the first gap in the sequence
    for (int i = 0; i < existingOrders.length; i++) {
      if (existingOrders[i] != i + 1) {
        return i + 1;
      }
    }

    // If no gaps found, use next number after the highest
    return existingOrders.last + 1;
  }

  /// Insert a lesson at a specific position within a time slot, shifting other lessons accordingly
  void insertLessonAtPosition(
    ScheduledLesson lesson,
    int targetSlotId,
    int targetPosition,
    List<ScheduledLesson> scheduledLessons,
    Function(ScheduledLesson) updateLessonCallback,
  ) {
    final lessonsInSlot = getAllLessonsForSlot(targetSlotId, scheduledLessons);
    final isSameSlot = lesson.scheduledAtId == targetSlotId;

    if (isSameSlot) {
      // Same slot reordering: Use a more careful approach
      final otherLessonsInSlot = lessonsInSlot.where((l) => l.id != lesson.id).toList()
        ..sort((a, b) => a.timetableSlotOrder.compareTo(b.timetableSlotOrder));

      // If the target position is the same as current position, do nothing
      if (lesson.timetableSlotOrder == targetPosition) {
        return;
      }

      // Store the original order before updating
      final originalOrder = lesson.timetableSlotOrder;

      // Update the dragged lesson to the target position
      final updatedLesson = lesson.copyWith(timetableSlotOrder: targetPosition);
      updateLessonCallback(updatedLesson);

      // Shift other lessons appropriately
      if (originalOrder < targetPosition) {
        // Moving down: shift lessons between old and new position up
        for (final otherLesson in otherLessonsInSlot) {
          if (otherLesson.timetableSlotOrder > originalOrder && otherLesson.timetableSlotOrder <= targetPosition) {
            final shiftedLesson = otherLesson.copyWith(timetableSlotOrder: otherLesson.timetableSlotOrder - 1);
            updateLessonCallback(shiftedLesson);
          }
        }
      } else {
        // Moving up: shift lessons between new and old position down
        for (final otherLesson in otherLessonsInSlot) {
          if (otherLesson.timetableSlotOrder >= targetPosition && otherLesson.timetableSlotOrder < originalOrder) {
            final shiftedLesson = otherLesson.copyWith(timetableSlotOrder: otherLesson.timetableSlotOrder + 1);
            updateLessonCallback(shiftedLesson);
          }
        }
      }
    } else {
      // Different slot: Use the original logic
      final otherLessonsInSlot = lessonsInSlot.where((l) => l.id != lesson.id).toList()
        ..sort((a, b) => a.timetableSlotOrder.compareTo(b.timetableSlotOrder));

      // Update the dragged lesson to new slot and position
      final updatedLesson = lesson.copyWith(
        scheduledAtId: targetSlotId,
        timetableSlotOrder: targetPosition,
      );
      updateLessonCallback(updatedLesson);

      // Shift all lessons at or after the target position to the right
      for (int i = 0; i < otherLessonsInSlot.length; i++) {
        final otherLesson = otherLessonsInSlot[i];
        if (otherLesson.timetableSlotOrder >= targetPosition) {
          final shiftedLesson = otherLesson.copyWith(timetableSlotOrder: otherLesson.timetableSlotOrder + 1);
          updateLessonCallback(shiftedLesson);
        }
      }

      // Compact the orders in the original slot
      compactOrdersInSlot(lesson.scheduledAtId, scheduledLessons, updateLessonCallback);
    }
  }

  /// Compact the order numbers in a slot to remove gaps
  void compactOrdersInSlot(
    int slotId,
    List<ScheduledLesson> scheduledLessons,
    Function(ScheduledLesson) updateLessonCallback,
  ) {
    final lessonsInSlot = getAllLessonsForSlot(slotId, scheduledLessons)
      ..sort((a, b) => a.timetableSlotOrder.compareTo(b.timetableSlotOrder));

    for (int i = 0; i < lessonsInSlot.length; i++) {
      final lesson = lessonsInSlot[i];
      final expectedOrder = i + 1;

      if (lesson.timetableSlotOrder != expectedOrder) {
        final compactedLesson = lesson.copyWith(timetableSlotOrder: expectedOrder);
        updateLessonCallback(compactedLesson);
      }
    }
  }

  /// Get all lessons for a specific weekday and time period regardless of group
  List<ScheduledLesson> getAllLessonsForWeekdayAndTimePeriod(
    Weekday weekday,
    String period,
    List<TimetableSlot> timetableSlots,
    List<ScheduledLesson> scheduledLessons,
  ) {
    final slotsForPeriod = getSlotsByTimePeriod(period, timetableSlots);
    final slotForWeekday = slotsForPeriod.where((slot) => slot.day == weekday).firstOrNull;

    if (slotForWeekday == null) return [];

    return getAllLessonsForSlot(slotForWeekday.id!, scheduledLessons);
  }

  /// Get time slots by time period (same start/end times across weekdays)
  List<TimetableSlot> getSlotsByTimePeriod(String period, List<TimetableSlot> timetableSlots) {
    final parts = period.split(' - ');
    if (parts.length != 2) return [];

    final startTime = parts[0];
    final endTime = parts[1];

    return timetableSlots.where((slot) => slot.startTime == startTime && slot.endTime == endTime).toList();
  }

  /// Check if a time slot has a lesson for the selected lesson group
  bool hasLessonForSlot(int slotId, List<ScheduledLesson> scheduledLessons) {
    return getScheduledLessonForSlot(slotId, scheduledLessons) != null;
  }

  /// Get scheduled lesson for a specific slot
  ScheduledLesson? getScheduledLessonForSlot(int slotId, List<ScheduledLesson> scheduledLessons) {
    return scheduledLessons.firstWhereOrNull((lesson) => lesson.scheduledAtId == slotId);
  }

  /// Get scheduled lesson by ID
  ScheduledLesson? getScheduledLessonById(int lessonId, List<ScheduledLesson> scheduledLessons) {
    return scheduledLessons.firstWhereOrNull((lesson) => lesson.id == lessonId);
  }

  /// Get unique time slots for UI display
  List<String> getUniqueTimeSlots(List<TimetableSlot> timetableSlots) {
    final timeSlots = <String>{};
    for (final slot in timetableSlots) {
      timeSlots.add('${slot.startTime} - ${slot.endTime}');
    }
    return timeSlots.toList()..sort();
  }

  /// Get all unique time periods for vertical scrolling
  List<String> getTimeSlotPeriods(List<TimetableSlot> timetableSlots) {
    final periods = <String>{};
    for (final slot in timetableSlots) {
      periods.add('${slot.startTime} - ${slot.endTime}');
    }
    final sortedPeriods = periods.toList();
    // Sort by start time
    sortedPeriods.sort((a, b) {
      final aStart = a.split(' - ')[0];
      final bStart = b.split(' - ')[0];
      return aStart.compareTo(bStart);
    });
    return sortedPeriods;
  }

  /// Get time slots for a specific weekday
  List<TimetableSlot> getTimeSlotsForWeekday(Weekday weekday, List<TimetableSlot> timetableSlots) {
    return timetableSlots.where((slot) => slot.day == weekday).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  /// Get scheduled lessons for a specific weekday
  List<ScheduledLesson> getScheduledLessonsForWeekday(
    Weekday weekday,
    Set<int> selectedGroupIds,
    List<ScheduledLesson> scheduledLessons,
    List<TimetableSlot> timetableSlots,
  ) {
    // Create a map for quick slot lookup
    final slotIdMap = {for (var slot in timetableSlots) slot.id!: slot};

    return scheduledLessons.where((lesson) {
      final lessonWeekday = slotIdMap[lesson.scheduledAtId]?.day;
      final matchesWeekday = lessonWeekday == weekday;

      // If no groups selected, show all lessons
      if (selectedGroupIds.isEmpty) {
        return matchesWeekday;
      }

      // Show lessons that match any of the selected groups
      final matchesGroup = selectedGroupIds.contains(lesson.lessonGroupId);
      return matchesWeekday && matchesGroup;
    }).toList();
  }
}
