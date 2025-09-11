import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/models/timetable_proxy_models.dart';

/// Manages UI state, filtering, and weekday selection for timetable
class TimetableUiManager extends ChangeNotifier {
  // Current selected weekday
  final _selectedWeekday = ValueNotifier<Weekday>(Weekday.monday);
  ValueListenable<Weekday> get selectedWeekday => _selectedWeekday;

  // Current selected lesson group for filtering
  final _selectedLessonGroup = ValueNotifier<LessonGroup?>(null);
  ValueListenable<LessonGroup?> get selectedLessonGroup => _selectedLessonGroup;

  // Current selected lesson groups for filtering (multiple selection)
  final _selectedLessonGroupIds = ValueNotifier<Set<int>>({});
  ValueListenable<Set<int>> get selectedLessonGroupIds =>
      _selectedLessonGroupIds;

  // Weekday collections
  final _weekdays = ValueNotifier<List<WeekdayProxy>>([]);
  ValueListenable<List<WeekdayProxy>> get weekdays => _weekdays;

  TimetableUiManager();

  /// Select a weekday
  void selectWeekday(Weekday weekday) {
    if (_selectedWeekday.value != weekday) {
      _selectedWeekday.value = weekday;
      notifyListeners();
    }
  }

  /// Select a lesson group for filtering
  void selectLessonGroup(LessonGroup? lessonGroup) {
    if (_selectedLessonGroup.value != lessonGroup) {
      _selectedLessonGroup.value = lessonGroup;
      _selectedLessonGroupIds.value =
          lessonGroup != null ? {lessonGroup.id!} : {};
      notifyListeners();
    }
  }

  /// Add a lesson group to the selection
  void addLessonGroupToSelection(LessonGroup lessonGroup) {
    final updatedSelection = Set<int>.from(_selectedLessonGroupIds.value);
    updatedSelection.add(lessonGroup.id!);
    _selectedLessonGroupIds.value = updatedSelection;
    notifyListeners();
  }

  /// Remove a lesson group from the selection
  void removeLessonGroupFromSelection(LessonGroup lessonGroup) {
    final updatedSelection = Set<int>.from(_selectedLessonGroupIds.value);
    updatedSelection.remove(lessonGroup.id!);
    _selectedLessonGroupIds.value = updatedSelection;
    notifyListeners();
  }

  /// Clear all selected lesson groups
  void clearLessonGroupSelection() {
    _selectedLessonGroupIds.value = {};
    _selectedLessonGroup.value = null;
    notifyListeners();
  }

  /// Build weekday proxies for UI display
  void buildWeekdayProxies({
    required List<TimetableSlot> timetableSlots,
    required List<ScheduledLesson> scheduledLessons,
    required Set<int> selectedGroupIds,
  }) {
    final weekdayProxies = <WeekdayProxy>[];

    for (final weekday in Weekday.values) {
      // Get time slots for this weekday
      final slotsForDay =
          timetableSlots.where((slot) => slot.day == weekday).toList()
            ..sort((a, b) => a.startTime.compareTo(b.startTime));

      // Get scheduled lessons for this weekday and selected lesson groups
      final lessonsForDay = getScheduledLessonsForWeekdayAndGroups(
        weekday,
        selectedGroupIds,
        scheduledLessons,
        timetableSlots,
      );

      // Create map from slot ID to scheduled lesson
      final lessonMap = <int, ScheduledLesson>{};
      for (final lesson in lessonsForDay) {
        lessonMap[lesson.scheduledAtId] = lesson;
      }

      weekdayProxies.add(
        WeekdayProxy(
          weekday: weekday,
          timeSlots: slotsForDay,
          scheduledLessons: lessonMap,
        ),
      );
    }

    _weekdays.value = weekdayProxies;
  }

  /// Get scheduled lessons for a specific weekday and selected lesson groups
  List<ScheduledLesson> getScheduledLessonsForWeekdayAndGroups(
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

  /// Get current weekday proxy
  WeekdayProxy? getCurrentWeekdayProxy() {
    return _weekdays.value.firstWhereOrNull(
      (wd) => wd.weekday == _selectedWeekday.value,
    );
  }

  /// Get unique time periods for vertical scrolling
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

  /// Get time slots by time period (same start/end times across weekdays)
  List<TimetableSlot> getSlotsByTimePeriod(
    String period,
    List<TimetableSlot> timetableSlots,
  ) {
    final parts = period.split(' - ');
    if (parts.length != 2) return [];

    final startTime = parts[0];
    final endTime = parts[1];

    return timetableSlots
        .where((slot) => slot.startTime == startTime && slot.endTime == endTime)
        .toList();
  }

  /// Get lesson groups that have lessons on a specific weekday
  List<LessonGroup> getLessonGroupsForWeekday(
    Weekday weekday,
    List<TimetableSlot> timetableSlots,
    List<ScheduledLesson> scheduledLessons,
    List<LessonGroup> lessonGroups,
    Set<int> selectedGroupIds,
  ) {
    // If specific lesson groups are selected, return those groups (even if they don't have lessons yet)
    if (selectedGroupIds.isNotEmpty) {
      final selectedGroups =
          lessonGroups
              .where((group) => selectedGroupIds.contains(group.id))
              .toList();
      return selectedGroups;
    }

    // If there are no scheduled lessons at all, return all lesson groups
    // so users can see available groups to create lessons for
    if (scheduledLessons.isEmpty) {
      return lessonGroups;
    }

    final lessonGroupIds = <int>{};

    // Get all slots for this weekday
    final slotsForWeekday =
        timetableSlots.where((slot) => slot.day == weekday).toList();

    // Get all lessons in these slots
    for (final slot in slotsForWeekday) {
      final lessonsInSlot =
          scheduledLessons
              .where((lesson) => lesson.scheduledAtId == slot.id)
              .toList();
      for (final lesson in lessonsInSlot) {
        lessonGroupIds.add(lesson.lessonGroupId);
      }
    }

    // Return all lesson groups that have lessons on this weekday
    return lessonGroups
        .where((group) => lessonGroupIds.contains(group.id))
        .toList();
  }

  /// Get users that are teaching in a specific time slot
  Set<int> getBusyUserIdsForTimeSlot(
    Weekday weekday,
    String period,
    List<TimetableSlot> timetableSlots,
    List<ScheduledLesson> scheduledLessons,
  ) {
    final busyUserIds = <int>{};

    // Get all slots for this time period
    final slotsForPeriod = getSlotsByTimePeriod(period, timetableSlots);
    final slotForWeekday =
        slotsForPeriod.where((slot) => slot.day == weekday).firstOrNull;

    if (slotForWeekday != null) {
      // Get all lessons in this time slot
      final lessonsInSlot =
          scheduledLessons
              .where((lesson) => lesson.scheduledAtId == slotForWeekday.id)
              .toList();

      // Add main teachers to busy list
      for (final lesson in lessonsInSlot) {
        busyUserIds.add(lesson.mainTeacherId);

        // Add additional teachers if they exist
        if (lesson.lessonTeachers != null) {
          for (final teacherAssignment in lesson.lessonTeachers!) {
            busyUserIds.add(teacherAssignment.userId);
          }
        }
      }
    }

    return busyUserIds;
  }

  /// Get the count of scheduled lessons for a specific user (as main teacher or additional teacher)
  int getScheduledLessonsCountForUser(
    int userId,
    List<ScheduledLesson> scheduledLessons,
  ) {
    return scheduledLessons.where((lesson) {
      // Count if user is main teacher
      if (lesson.mainTeacherId == userId) return true;

      // Count if user is additional teacher
      if (lesson.lessonTeachers != null) {
        return lesson.lessonTeachers!.any(
          (teacher) => teacher.userId == userId,
        );
      }

      return false;
    }).length;
  }

  /// Get remaining time units for a user based on their timeUnits and scheduled lessons
  int getRemainingTimeUnitsForUser(
    int userId,
    int userTimeUnits,
    List<ScheduledLesson> scheduledLessons,
  ) {
    final scheduledCount = getScheduledLessonsCountForUser(
      userId,
      scheduledLessons,
    );
    return userTimeUnits - scheduledCount;
  }
}
