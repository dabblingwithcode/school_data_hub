import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/data/timetable_mock_data.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/models/timetable_proxy_models.dart';

class TimetableManager extends ChangeNotifier {
  // Main timetable container
  final _timetable = ValueNotifier<Timetable?>(null);
  ValueListenable<Timetable?> get timetable => _timetable;

  // Core collections - derived from timetable
  final _timetableSlots = ValueNotifier<List<TimetableSlot>>([]);
  ValueListenable<List<TimetableSlot>> get timetableSlots => _timetableSlots;

  final _subjects = ValueNotifier<List<Subject>>([]);
  ValueListenable<List<Subject>> get subjects => _subjects;

  final _classrooms = ValueNotifier<List<Classroom>>([]);
  ValueListenable<List<Classroom>> get classrooms => _classrooms;

  final _lessonGroups = ValueNotifier<List<LessonGroup>>([]);
  ValueListenable<List<LessonGroup>> get lessonGroups => _lessonGroups;

  final _scheduledLessons = ValueNotifier<List<ScheduledLesson>>([]);
  ValueListenable<List<ScheduledLesson>> get scheduledLessons =>
      _scheduledLessons;

  // Weekday collections
  final _weekdays = ValueNotifier<List<WeekdayProxy>>([]);
  ValueListenable<List<WeekdayProxy>> get weekdays => _weekdays;

  // Current selected weekday
  final _selectedWeekday = ValueNotifier<Weekday>(Weekday.monday);
  ValueListenable<Weekday> get selectedWeekday => _selectedWeekday;

  // Current selected lesson group for filtering
  final _selectedLessonGroup = ValueNotifier<LessonGroup?>(null);
  ValueListenable<LessonGroup?> get selectedLessonGroup => _selectedLessonGroup;

  // Maps for quick lookups
  Map<int, TimetableSlot> _slotIdMap = {};
  Map<int, Subject> _subjectIdMap = {};
  Map<int, Classroom> _classroomIdMap = {};
  Map<int, LessonGroup> _lessonGroupIdMap = {};

  TimetableManager();

  Future<TimetableManager> init() async {
    await _loadMockData();
    _buildWeekdayProxies();
    return this;
  }

  void clearData() {
    _timetableSlots.value = [];
    _subjects.value = [];
    _classrooms.value = [];
    _lessonGroups.value = [];
    _scheduledLessons.value = [];
    _weekdays.value = [];
    _selectedWeekday.value = Weekday.monday;
    _selectedLessonGroup.value = null;

    _slotIdMap.clear();
    _subjectIdMap.clear();
    _classroomIdMap.clear();
    _lessonGroupIdMap.clear();
  }

  // Load mock data
  Future<void> _loadMockData() async {
    // Generate mock timetable with all data
    final mockTimetable = TimetableMockData.generateMockTimetable();

    // Set the main timetable
    _timetable.value = mockTimetable;

    // Extract and update individual collections from timetable
    _timetableSlots.value = mockTimetable.timetableSlots ?? [];
    _scheduledLessons.value = mockTimetable.scheduledLessons ?? [];

    // Extract related data from lessons and slots
    final subjects = <Subject>[];
    final classrooms = <Classroom>[];
    final lessonGroups = <LessonGroup>[];

    for (final lesson in mockTimetable.scheduledLessons ?? []) {
      if (lesson.subject != null &&
          !subjects.any((s) => s.id == lesson.subject!.id)) {
        subjects.add(lesson.subject!);
      }
      if (lesson.room != null &&
          !classrooms.any((c) => c.id == lesson.room!.id)) {
        classrooms.add(lesson.room!);
      }
      if (lesson.lessonGroup != null &&
          !lessonGroups.any((lg) => lg.id == lesson.lessonGroup!.id)) {
        lessonGroups.add(lesson.lessonGroup!);
      }
    }

    _subjects.value = subjects;
    _classrooms.value = classrooms;
    _lessonGroups.value = lessonGroups;

    // Set default selected lesson group
    if (lessonGroups.isNotEmpty) {
      _selectedLessonGroup.value = lessonGroups.first;
    }

    // Build lookup maps
    _buildLookupMaps();
  }

  void _buildLookupMaps() {
    _slotIdMap = {for (var slot in _timetableSlots.value) slot.id!: slot};
    _subjectIdMap = {for (var subject in _subjects.value) subject.id!: subject};
    _classroomIdMap = {
      for (var classroom in _classrooms.value) classroom.id!: classroom,
    };
    _lessonGroupIdMap = {
      for (var group in _lessonGroups.value) group.id!: group,
    };
  }

  void _buildWeekdayProxies() {
    final weekdayProxies = <WeekdayProxy>[];

    for (final weekday in Weekday.values) {
      // Get time slots for this weekday
      final slotsForDay =
          _timetableSlots.value.where((slot) => slot.day == weekday).toList()
            ..sort((a, b) => a.startTime.compareTo(b.startTime));

      // Get scheduled lessons for this weekday and selected lesson group
      final lessonsForDay = _getScheduledLessonsForWeekdayAndGroup(
        weekday,
        _selectedLessonGroup.value,
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

  List<ScheduledLesson> _getScheduledLessonsForWeekdayAndGroup(
    Weekday weekday,
    LessonGroup? lessonGroup,
  ) {
    return _scheduledLessons.value.where((lesson) {
      final lessonWeekday = _slotIdMap[lesson.scheduledAtId]?.day;
      final matchesWeekday = lessonWeekday == weekday;
      final matchesGroup =
          lessonGroup == null || lesson.lessonGroupId == lessonGroup.id;
      return matchesWeekday && matchesGroup;
    }).toList();
  }

  // Getters
  WeekdayProxy? getCurrentWeekdayProxy() {
    return _weekdays.value.firstWhereOrNull(
      (wd) => wd.weekday == _selectedWeekday.value,
    );
  }

  List<TimetableSlot> getTimeSlotsForWeekday(Weekday weekday) {
    return _timetableSlots.value.where((slot) => slot.day == weekday).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  List<ScheduledLesson> getScheduledLessonsForWeekday(Weekday weekday) {
    return _getScheduledLessonsForWeekdayAndGroup(
      weekday,
      _selectedLessonGroup.value,
    );
  }

  ScheduledLesson? getScheduledLessonForSlot(int slotId) {
    return _scheduledLessons.value.firstWhereOrNull(
      (lesson) => lesson.scheduledAtId == slotId,
    );
  }

  ScheduledLesson? getScheduledLessonById(int lessonId) {
    return _scheduledLessons.value.firstWhereOrNull(
      (lesson) => lesson.id == lessonId,
    );
  }

  Subject? getSubjectById(int subjectId) {
    return _subjectIdMap[subjectId];
  }

  Classroom? getClassroomById(int classroomId) {
    return _classroomIdMap[classroomId];
  }

  LessonGroup? getLessonGroupById(int lessonGroupId) {
    return _lessonGroupIdMap[lessonGroupId];
  }

  TimetableSlot? getTimetableSlotById(int slotId) {
    return _slotIdMap[slotId];
  }

  // Actions
  void selectWeekday(Weekday weekday) {
    if (_selectedWeekday.value != weekday) {
      _selectedWeekday.value = weekday;
      notifyListeners();
    }
  }

  void selectLessonGroup(LessonGroup? lessonGroup) {
    if (_selectedLessonGroup.value != lessonGroup) {
      _selectedLessonGroup.value = lessonGroup;
      _buildWeekdayProxies(); // Rebuild with new filter
      notifyListeners();
    }
  }

  // CRUD operations for scheduled lessons
  void addScheduledLesson(ScheduledLesson lesson) {
    final lessons = List<ScheduledLesson>.from(_scheduledLessons.value);
    lessons.add(lesson);
    _scheduledLessons.value = lessons;
    _buildWeekdayProxies();
    notifyListeners();
  }

  void updateScheduledLesson(ScheduledLesson updatedLesson) {
    final lessons = List<ScheduledLesson>.from(_scheduledLessons.value);
    final index = lessons.indexWhere((lesson) => lesson.id == updatedLesson.id);
    if (index != -1) {
      lessons[index] = updatedLesson;
      _scheduledLessons.value = lessons;
      _buildWeekdayProxies();
      notifyListeners();
    }
  }

  void removeScheduledLesson(int lessonId) {
    final lessons = List<ScheduledLesson>.from(_scheduledLessons.value);
    lessons.removeWhere((lesson) => lesson.id == lessonId);
    _scheduledLessons.value = lessons;
    _buildWeekdayProxies();
    notifyListeners();
  }

  // Helper methods for UI
  List<String> getUniqueTimeSlots() {
    final timeSlots = <String>{};
    for (final slot in _timetableSlots.value) {
      timeSlots.add('${slot.startTime} - ${slot.endTime}');
    }
    return timeSlots.toList()..sort();
  }

  /// Get all unique time periods for vertical scrolling
  List<String> getTimeSlotPeriods() {
    final periods = <String>{};
    for (final slot in _timetableSlots.value) {
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
  List<TimetableSlot> getSlotsByTimePeriod(String period) {
    final parts = period.split(' - ');
    if (parts.length != 2) return [];

    final startTime = parts[0];
    final endTime = parts[1];

    return _timetableSlots.value
        .where((slot) => slot.startTime == startTime && slot.endTime == endTime)
        .toList();
  }

  /// Check if a time slot has a lesson for the selected lesson group
  bool hasLessonForSlot(int slotId) {
    return getScheduledLessonForSlot(slotId) != null;
  }

  /// Get all lessons for a specific time slot regardless of group
  List<ScheduledLesson> getAllLessonsForSlot(int slotId) {
    return _scheduledLessons.value
        .where((lesson) => lesson.scheduledAtId == slotId)
        .toList();
  }

  /// Get the next available timetableSlotOrder for a specific time slot
  /// This method finds the first gap in the sequence or returns the next number after the highest order
  int getNextAvailableOrderForSlot(int slotId) {
    final lessonsInSlot = getAllLessonsForSlot(slotId);

    // If no lessons in slot, start with order 1
    if (lessonsInSlot.isEmpty) {
      return 1;
    }

    final existingOrders =
        lessonsInSlot.map((l) => l.timetableSlotOrder).toSet().toList()..sort();

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
  ) {
    final lessonsInSlot = getAllLessonsForSlot(targetSlotId);

    // If lesson is moving from the same slot, temporarily remove it from consideration
    final otherLessonsInSlot =
        lessonsInSlot.where((l) => l.id != lesson.id).toList()..sort(
          (a, b) => a.timetableSlotOrder.compareTo(b.timetableSlotOrder),
        );

    // Update the dragged lesson to new slot and position
    final updatedLesson = lesson.copyWith(
      scheduledAtId: targetSlotId,
      scheduledAt: getTimetableSlotById(targetSlotId),
      timetableSlotOrder: targetPosition,
    );
    updateScheduledLesson(updatedLesson);

    // Shift all lessons at or after the target position to the right
    for (int i = 0; i < otherLessonsInSlot.length; i++) {
      final otherLesson = otherLessonsInSlot[i];
      if (otherLesson.timetableSlotOrder >= targetPosition) {
        final shiftedLesson = otherLesson.copyWith(
          timetableSlotOrder: otherLesson.timetableSlotOrder + 1,
        );
        updateScheduledLesson(shiftedLesson);
      }
    }

    // Compact the orders in the original slot if the lesson moved from a different slot
    if (lesson.scheduledAtId != targetSlotId) {
      _compactOrdersInSlot(lesson.scheduledAtId);
    }
  }

  /// Compact the order numbers in a slot to remove gaps
  void _compactOrdersInSlot(int slotId) {
    final lessonsInSlot = getAllLessonsForSlot(slotId)
      ..sort((a, b) => a.timetableSlotOrder.compareTo(b.timetableSlotOrder));

    for (int i = 0; i < lessonsInSlot.length; i++) {
      final lesson = lessonsInSlot[i];
      final expectedOrder = i + 1;

      if (lesson.timetableSlotOrder != expectedOrder) {
        final compactedLesson = lesson.copyWith(
          timetableSlotOrder: expectedOrder,
        );
        updateScheduledLesson(compactedLesson);
      }
    }
  }

  /// Get all lessons for a specific weekday and time period regardless of group
  List<ScheduledLesson> getAllLessonsForWeekdayAndTimePeriod(
    Weekday weekday,
    String period,
  ) {
    final slotsForPeriod = getSlotsByTimePeriod(period);
    final slotForWeekday =
        slotsForPeriod.where((slot) => slot.day == weekday).firstOrNull;

    if (slotForWeekday == null) return [];

    return getAllLessonsForSlot(slotForWeekday.id!);
  }

  /// Create a proxy for easy UI handling
  ScheduledLessonProxy? getScheduledLessonProxyForSlot(int slotId) {
    final lesson = getScheduledLessonForSlot(slotId);
    return lesson != null
        ? ScheduledLessonProxy(scheduledLesson: lesson)
        : null;
  }

  /// Get lesson groups that have lessons on a specific weekday
  List<LessonGroup> getLessonGroupsForWeekday(Weekday weekday) {
    final lessonGroupIds = <int>{};

    // Get all slots for this weekday
    final slotsForWeekday =
        _timetableSlots.value.where((slot) => slot.day == weekday).toList();

    // Get all lessons in these slots
    for (final slot in slotsForWeekday) {
      final lessonsInSlot = getAllLessonsForSlot(slot.id!);
      for (final lesson in lessonsInSlot) {
        lessonGroupIds.add(lesson.lessonGroupId);
      }
    }

    // Return the lesson groups that have lessons on this weekday
    return _lessonGroups.value
        .where((group) => lessonGroupIds.contains(group.id))
        .toList();
  }

  /// Get users that are teaching in a specific time slot
  Set<int> getBusyUserIdsForTimeSlot(Weekday weekday, String period) {
    final busyUserIds = <int>{};

    // Get all slots for this time period
    final slotsForPeriod = getSlotsByTimePeriod(period);
    final slotForWeekday =
        slotsForPeriod.where((slot) => slot.day == weekday).firstOrNull;

    if (slotForWeekday != null) {
      // Get all lessons in this time slot
      final lessonsInSlot = getAllLessonsForSlot(slotForWeekday.id!);

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

  /// Get the count of scheduled lessons for a specific user as main teacher
  int getScheduledLessonsCountForUser(int userId) {
    // Count how many lessons this user is assigned to as main teacher
    return _scheduledLessons.value
        .where((lesson) => lesson.mainTeacherId == userId)
        .length;
  }

  /// Get remaining time units for a user based on their timeUnits and scheduled lessons
  int getRemainingTimeUnitsForUser(int userId, int userTimeUnits) {
    final scheduledCount = getScheduledLessonsCountForUser(userId);
    return userTimeUnits - scheduledCount;
  }
}
