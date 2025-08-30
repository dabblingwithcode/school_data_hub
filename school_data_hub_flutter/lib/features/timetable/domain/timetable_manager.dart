import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/data/timetable_api_service.dart';
import 'package:school_data_hub_flutter/features/timetable/data/timetable_mock_data.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/models/timetable_proxy_models.dart';
import 'package:watch_it/watch_it.dart';

class TimetableManager extends ChangeNotifier {
  final _apiService = di<TimetableApiService>();

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

  // Current selected lesson groups for filtering (multiple selection)
  final _selectedLessonGroupIds = ValueNotifier<Set<int>>({});
  ValueListenable<Set<int>> get selectedLessonGroupIds =>
      _selectedLessonGroupIds;

  // Scheduled lesson group memberships
  final _scheduledLessonGroupMemberships =
      ValueNotifier<List<ScheduledLessonGroupMembership>>([]);
  ValueListenable<List<ScheduledLessonGroupMembership>>
  get scheduledLessonGroupMemberships => _scheduledLessonGroupMemberships;

  // Maps for quick lookups
  Map<int, TimetableSlot> _slotIdMap = {};
  Map<int, Subject> _subjectIdMap = {};
  Map<int, Classroom> _classroomIdMap = {};
  Map<int, LessonGroup> _lessonGroupIdMap = {};

  TimetableManager();

  Future<TimetableManager> init() async {
    await _loadData();
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
    _selectedLessonGroupIds.value = {};

    _slotIdMap.clear();
    _subjectIdMap.clear();
    _classroomIdMap.clear();
    _lessonGroupIdMap.clear();
  }

  // Load data from API with fallback to mock data
  Future<void> _loadData() async {
    try {
      // Try to load from API first
      await _loadFromApi();
    } catch (e) {
      // Fallback to mock data if API fails
      await _loadMockData();
    }
  }

  // Load data from API
  Future<void> _loadFromApi() async {
    // Load complete timetable data
    final timetable = await _apiService.fetchCompleteTimetableData();
    if (timetable != null) {
      _timetable.value = timetable;
      _timetableSlots.value = timetable.timetableSlots ?? [];
      _scheduledLessons.value = timetable.scheduledLessons ?? [];
    }

    // Load additional data if not included in timetable
    await _loadAdditionalDataFromApi();

    // Extract related data from lessons and slots
    _extractRelatedDataFromLessons();
  }

  // Load additional data from API
  Future<void> _loadAdditionalDataFromApi() async {
    // Load subjects if not already loaded
    if (_subjects.value.isEmpty) {
      final subjects = await _apiService.fetchSubjects();
      if (subjects != null) {
        _subjects.value = subjects;
      }
    }

    // Load classrooms if not already loaded
    if (_classrooms.value.isEmpty) {
      final classrooms = await _apiService.fetchClassrooms();
      if (classrooms != null) {
        _classrooms.value = classrooms;
      }
    }

    // Load lesson groups if not already loaded
    if (_lessonGroups.value.isEmpty) {
      final lessonGroups = await _apiService.fetchLessonGroups();
      if (lessonGroups != null) {
        _lessonGroups.value = lessonGroups;
      }
    }

    // Load scheduled lesson group memberships
    final memberships =
        await _apiService.fetchScheduledLessonGroupMemberships();
    if (memberships != null) {
      _scheduledLessonGroupMemberships.value = memberships;
    }
  }

  // Extract related data from lessons
  void _extractRelatedDataFromLessons() {
    final subjects = <Subject>[];
    final classrooms = <Classroom>[];
    final lessonGroups = <LessonGroup>[];

    for (final lesson in _scheduledLessons.value) {
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

    // Update collections if we found additional data
    if (subjects.isNotEmpty) {
      _subjects.value = subjects;
    }
    if (classrooms.isNotEmpty) {
      _classrooms.value = classrooms;
    }
    if (lessonGroups.isNotEmpty) {
      _lessonGroups.value = lessonGroups;
    }

    // Set default selected lesson group
    if (_lessonGroups.value.isNotEmpty && _selectedLessonGroup.value == null) {
      _selectedLessonGroup.value = _lessonGroups.value.first;
      _selectedLessonGroupIds.value = {_lessonGroups.value.first.id!};
    }

    // Build lookup maps
    _buildLookupMaps();
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
      _selectedLessonGroupIds.value = {lessonGroups.first.id!};
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

      // Get scheduled lessons for this weekday and selected lesson groups
      final lessonsForDay = _getScheduledLessonsForWeekdayAndGroups(
        weekday,
        _selectedLessonGroupIds.value,
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

  /// Get scheduled lessons for a specific weekday and selected lesson groups
  List<ScheduledLesson> _getScheduledLessonsForWeekdayAndGroups(
    Weekday weekday,
    Set<int> selectedGroupIds,
  ) {
    return _scheduledLessons.value.where((lesson) {
      final lessonWeekday = _slotIdMap[lesson.scheduledAtId]?.day;
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
    return _getScheduledLessonsForWeekdayAndGroups(
      weekday,
      _selectedLessonGroupIds.value,
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
      _selectedLessonGroupIds.value =
          lessonGroup != null ? {lessonGroup.id!} : {};
      _buildWeekdayProxies(); // Rebuild with new filter
      notifyListeners();
    }
  }

  /// Add a lesson group to the selection
  void addLessonGroupToSelection(LessonGroup lessonGroup) {
    final updatedSelection = Set<int>.from(_selectedLessonGroupIds.value);
    updatedSelection.add(lessonGroup.id!);
    _selectedLessonGroupIds.value = updatedSelection;
    _buildWeekdayProxies(); // Rebuild with new filter
    notifyListeners();
  }

  /// Remove a lesson group from the selection
  void removeLessonGroupFromSelection(LessonGroup lessonGroup) {
    final updatedSelection = Set<int>.from(_selectedLessonGroupIds.value);
    updatedSelection.remove(lessonGroup.id!);
    _selectedLessonGroupIds.value = updatedSelection;
    _buildWeekdayProxies(); // Rebuild with new filter
    notifyListeners();
  }

  /// Clear all selected lesson groups
  void clearLessonGroupSelection() {
    _selectedLessonGroupIds.value = {};
    _selectedLessonGroup.value = null;
    _buildWeekdayProxies(); // Rebuild with new filter
    notifyListeners();
  }

  // CRUD operations for scheduled lessons
  Future<void> addScheduledLesson(ScheduledLesson lesson) async {
    try {
      final createdLesson = await _apiService.createScheduledLesson(lesson);
      if (createdLesson != null) {
        final lessons = List<ScheduledLesson>.from(_scheduledLessons.value);
        lessons.add(createdLesson);
        _scheduledLessons.value = lessons;
        _buildWeekdayProxies();
        notifyListeners();
      }
    } catch (e) {
      // Fallback to local operation if API fails
      final lessons = List<ScheduledLesson>.from(_scheduledLessons.value);
      final lessonWithId =
          lesson.id == null ? lesson.copyWith(id: _getNextLessonId()) : lesson;
      lessons.add(lessonWithId);
      _scheduledLessons.value = lessons;
      _buildWeekdayProxies();
      notifyListeners();
    }
  }

  int _getNextLessonId() {
    if (_scheduledLessons.value.isEmpty) return 1;
    return _scheduledLessons.value
            .map((l) => l.id ?? 0)
            .reduce((a, b) => a > b ? a : b) +
        1;
  }

  Future<void> updateScheduledLesson(ScheduledLesson updatedLesson) async {
    try {
      final updatedLessonFromApi = await _apiService.updateScheduledLesson(
        updatedLesson,
      );
      if (updatedLessonFromApi != null) {
        final lessons = List<ScheduledLesson>.from(_scheduledLessons.value);
        final index = lessons.indexWhere(
          (lesson) => lesson.id == updatedLesson.id,
        );
        if (index != -1) {
          lessons[index] = updatedLessonFromApi;
          _scheduledLessons.value = lessons;
          _buildWeekdayProxies();
          notifyListeners();
        }
      }
    } catch (e) {
      // Fallback to local operation if API fails
      final lessons = List<ScheduledLesson>.from(_scheduledLessons.value);
      final index = lessons.indexWhere(
        (lesson) => lesson.id == updatedLesson.id,
      );
      if (index != -1) {
        lessons[index] = updatedLesson;
        _scheduledLessons.value = lessons;
        _buildWeekdayProxies();
        notifyListeners();
      }
    }
  }

  Future<void> removeScheduledLesson(int lessonId) async {
    try {
      final success = await _apiService.deleteScheduledLesson(lessonId);
      if (success == true) {
        final lessons = List<ScheduledLesson>.from(_scheduledLessons.value);
        lessons.removeWhere((lesson) => lesson.id == lessonId);
        _scheduledLessons.value = lessons;
        _buildWeekdayProxies();
        notifyListeners();
      }
    } catch (e) {
      // Fallback to local operation if API fails
      final lessons = List<ScheduledLesson>.from(_scheduledLessons.value);
      lessons.removeWhere((lesson) => lesson.id == lessonId);
      _scheduledLessons.value = lessons;
      _buildWeekdayProxies();
      notifyListeners();
    }
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
    final isSameSlot = lesson.scheduledAtId == targetSlotId;

    if (isSameSlot) {
      // Same slot reordering: Use a more careful approach
      final otherLessonsInSlot =
          lessonsInSlot.where((l) => l.id != lesson.id).toList()..sort(
            (a, b) => a.timetableSlotOrder.compareTo(b.timetableSlotOrder),
          );

      // If the target position is the same as current position, do nothing
      if (lesson.timetableSlotOrder == targetPosition) {
        return;
      }

      // Store the original order before updating
      final originalOrder = lesson.timetableSlotOrder;

      // Update the dragged lesson to the target position
      final updatedLesson = lesson.copyWith(timetableSlotOrder: targetPosition);
      updateScheduledLesson(updatedLesson);

      // Shift other lessons appropriately
      if (originalOrder < targetPosition) {
        // Moving down: shift lessons between old and new position up
        for (final otherLesson in otherLessonsInSlot) {
          if (otherLesson.timetableSlotOrder > originalOrder &&
              otherLesson.timetableSlotOrder <= targetPosition) {
            final shiftedLesson = otherLesson.copyWith(
              timetableSlotOrder: otherLesson.timetableSlotOrder - 1,
            );
            updateScheduledLesson(shiftedLesson);
          }
        }
      } else {
        // Moving up: shift lessons between new and old position down
        for (final otherLesson in otherLessonsInSlot) {
          if (otherLesson.timetableSlotOrder >= targetPosition &&
              otherLesson.timetableSlotOrder < originalOrder) {
            final shiftedLesson = otherLesson.copyWith(
              timetableSlotOrder: otherLesson.timetableSlotOrder + 1,
            );
            updateScheduledLesson(shiftedLesson);
          }
        }
      }
    } else {
      // Different slot: Use the original logic
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

      // Compact the orders in the original slot
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

    // If specific lesson groups are selected, return those groups (even if they don't have lessons yet)
    if (_selectedLessonGroupIds.value.isNotEmpty) {
      final selectedGroups =
          _lessonGroups.value
              .where(
                (group) => _selectedLessonGroupIds.value.contains(group.id),
              )
              .toList();
      return selectedGroups;
    }

    // Return all lesson groups that have lessons on this weekday
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

  /// Get the count of scheduled lessons for a specific user (as main teacher or additional teacher)
  int getScheduledLessonsCountForUser(int userId) {
    return _scheduledLessons.value.where((lesson) {
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
  int getRemainingTimeUnitsForUser(int userId, int userTimeUnits) {
    final scheduledCount = getScheduledLessonsCountForUser(userId);
    return userTimeUnits - scheduledCount;
  }

  // Lesson Group Management Methods

  /// Add a new lesson group
  Future<void> addLessonGroup(LessonGroup lessonGroup) async {
    try {
      final createdLessonGroup = await _apiService.createLessonGroup(
        lessonGroup,
      );
      if (createdLessonGroup != null) {
        final updatedGroups = List<LessonGroup>.from(_lessonGroups.value)
          ..add(createdLessonGroup);

        _lessonGroups.value = updatedGroups;
        _lessonGroupIdMap[createdLessonGroup.id!] = createdLessonGroup;
        notifyListeners();
      }
    } catch (e) {
      // Fallback to local operation if API fails
      final newId =
          _lessonGroups.value.isEmpty
              ? 1
              : _lessonGroups.value
                      .map((g) => g.id ?? 0)
                      .reduce((a, b) => a > b ? a : b) +
                  1;

      final newLessonGroup = lessonGroup.copyWith(id: newId);
      final updatedGroups = List<LessonGroup>.from(_lessonGroups.value)
        ..add(newLessonGroup);

      _lessonGroups.value = updatedGroups;
      _lessonGroupIdMap[newId] = newLessonGroup;
      notifyListeners();
    }
  }

  /// Update an existing lesson group
  Future<void> updateLessonGroup(LessonGroup lessonGroup) async {
    try {
      final updatedLessonGroup = await _apiService.updateLessonGroup(
        lessonGroup,
      );
      if (updatedLessonGroup != null) {
        final index = _lessonGroups.value.indexWhere(
          (g) => g.id == lessonGroup.id,
        );
        if (index != -1) {
          final updatedGroups = List<LessonGroup>.from(_lessonGroups.value);
          updatedGroups[index] = updatedLessonGroup;

          _lessonGroups.value = updatedGroups;
          _lessonGroupIdMap[lessonGroup.id!] = updatedLessonGroup;
          notifyListeners();
        }
      }
    } catch (e) {
      // Fallback to local operation if API fails
      final index = _lessonGroups.value.indexWhere(
        (g) => g.id == lessonGroup.id,
      );
      if (index != -1) {
        final updatedGroups = List<LessonGroup>.from(_lessonGroups.value);
        updatedGroups[index] = lessonGroup;

        _lessonGroups.value = updatedGroups;
        _lessonGroupIdMap[lessonGroup.id!] = lessonGroup;
        notifyListeners();
      }
    }
  }

  /// Remove a lesson group
  Future<void> removeLessonGroup(int lessonGroupId) async {
    try {
      final success = await _apiService.deleteLessonGroup(lessonGroupId);
      if (success == true) {
        final updatedGroups =
            _lessonGroups.value.where((g) => g.id != lessonGroupId).toList();
        _lessonGroups.value = updatedGroups;
        _lessonGroupIdMap.remove(lessonGroupId);
        notifyListeners();
      }
    } catch (e) {
      // Fallback to local operation if API fails
      final updatedGroups =
          _lessonGroups.value.where((g) => g.id != lessonGroupId).toList();
      _lessonGroups.value = updatedGroups;
      _lessonGroupIdMap.remove(lessonGroupId);
      notifyListeners();
    }
  }

  // Scheduled Lesson Group Membership Management

  /// Get all memberships for a specific lesson group
  List<ScheduledLessonGroupMembership> getMembershipsForLessonGroup(
    int lessonGroupId,
  ) {
    return _scheduledLessonGroupMemberships.value
        .where((membership) => membership.lessonGroupId == lessonGroupId)
        .toList();
  }

  /// Get all pupil IDs for a specific lesson group
  List<int> getPupilIdsForLessonGroup(int lessonGroupId) {
    return getMembershipsForLessonGroup(
      lessonGroupId,
    ).map((membership) => membership.pupilDataId).toList();
  }

  /// Add a pupil to a lesson group
  void addPupilToLessonGroup(int lessonGroupId, int pupilDataId) {
    // Check if membership already exists
    final existingMembership =
        _scheduledLessonGroupMemberships.value
            .where(
              (membership) =>
                  membership.lessonGroupId == lessonGroupId &&
                  membership.pupilDataId == pupilDataId,
            )
            .firstOrNull;

    if (existingMembership != null) {
      return; // Already exists
    }

    final newId =
        _scheduledLessonGroupMemberships.value.isEmpty
            ? 1
            : _scheduledLessonGroupMemberships.value
                    .map((m) => m.id ?? 0)
                    .reduce((a, b) => a > b ? a : b) +
                1;

    final newMembership = ScheduledLessonGroupMembership(
      id: newId,
      lessonGroupId: lessonGroupId,
      pupilDataId: pupilDataId,
    );

    final updatedMemberships = List<ScheduledLessonGroupMembership>.from(
      _scheduledLessonGroupMemberships.value,
    )..add(newMembership);

    _scheduledLessonGroupMemberships.value = updatedMemberships;
    notifyListeners();
  }

  /// Remove a pupil from a lesson group
  void removePupilFromLessonGroup(int lessonGroupId, int pupilDataId) {
    final updatedMemberships =
        _scheduledLessonGroupMemberships.value
            .where(
              (membership) =>
                  !(membership.lessonGroupId == lessonGroupId &&
                      membership.pupilDataId == pupilDataId),
            )
            .toList();

    _scheduledLessonGroupMemberships.value = updatedMemberships;
    notifyListeners();
  }

  /// Update pupil memberships for a lesson group
  void updatePupilMembershipsForLessonGroup(
    int lessonGroupId,
    List<int> pupilDataIds,
  ) {
    // Remove existing memberships for this lesson group
    final otherMemberships =
        _scheduledLessonGroupMemberships.value
            .where((membership) => membership.lessonGroupId != lessonGroupId)
            .toList();

    // Create new memberships for the provided pupil IDs
    final newMemberships = <ScheduledLessonGroupMembership>[];
    int nextId =
        _scheduledLessonGroupMemberships.value.isEmpty
            ? 1
            : _scheduledLessonGroupMemberships.value
                    .map((m) => m.id ?? 0)
                    .reduce((a, b) => a > b ? a : b) +
                1;

    for (final pupilDataId in pupilDataIds) {
      newMemberships.add(
        ScheduledLessonGroupMembership(
          id: nextId++,
          lessonGroupId: lessonGroupId,
          pupilDataId: pupilDataId,
        ),
      );
    }

    _scheduledLessonGroupMemberships.value = [
      ...otherMemberships,
      ...newMemberships,
    ];
    notifyListeners();
  }

  /// Check if a pupil is a member of a lesson group
  bool isPupilMemberOfLessonGroup(int lessonGroupId, int pupilDataId) {
    return _scheduledLessonGroupMemberships.value.any(
      (membership) =>
          membership.lessonGroupId == lessonGroupId &&
          membership.pupilDataId == pupilDataId,
    );
  }

  // Classroom management methods

  /// Add a new classroom
  Future<void> addClassroom(Classroom classroom) async {
    try {
      final createdClassroom = await _apiService.createClassroom(classroom);
      if (createdClassroom != null) {
        final updatedClassrooms = List<Classroom>.from(_classrooms.value)
          ..add(createdClassroom);

        _classrooms.value = updatedClassrooms;
        _classroomIdMap[createdClassroom.id!] = createdClassroom;
        notifyListeners();
      }
    } catch (e) {
      // Fallback to local operation if API fails
      final newId =
          _classrooms.value.isEmpty
              ? 1
              : _classrooms.value
                      .map((c) => c.id ?? 0)
                      .reduce((a, b) => a > b ? a : b) +
                  1;

      final newClassroom = classroom.copyWith(id: newId);
      final updatedClassrooms = List<Classroom>.from(_classrooms.value)
        ..add(newClassroom);

      _classrooms.value = updatedClassrooms;
      _classroomIdMap[newId] = newClassroom;
      notifyListeners();
    }
  }

  /// Update an existing classroom
  Future<void> updateClassroom(Classroom classroom) async {
    try {
      final updatedClassroom = await _apiService.updateClassroom(classroom);
      if (updatedClassroom != null) {
        final index = _classrooms.value.indexWhere((c) => c.id == classroom.id);
        if (index != -1) {
          final updatedClassrooms = List<Classroom>.from(_classrooms.value);
          updatedClassrooms[index] = updatedClassroom;
          _classrooms.value = updatedClassrooms;
          _classroomIdMap[classroom.id!] = updatedClassroom;
          notifyListeners();
        }
      }
    } catch (e) {
      // Fallback to local operation if API fails
      final index = _classrooms.value.indexWhere((c) => c.id == classroom.id);
      if (index != -1) {
        final updatedClassrooms = List<Classroom>.from(_classrooms.value);
        updatedClassrooms[index] = classroom;
        _classrooms.value = updatedClassrooms;
        _classroomIdMap[classroom.id!] = classroom;
        notifyListeners();
      }
    }
  }

  /// Remove a classroom
  Future<void> removeClassroom(int classroomId) async {
    try {
      final success = await _apiService.deleteClassroom(classroomId);
      if (success == true) {
        final updatedClassrooms =
            _classrooms.value.where((c) => c.id != classroomId).toList();
        _classrooms.value = updatedClassrooms;
        _classroomIdMap.remove(classroomId);
        notifyListeners();
      }
    } catch (e) {
      // Fallback to local operation if API fails
      final updatedClassrooms =
          _classrooms.value.where((c) => c.id != classroomId).toList();
      _classrooms.value = updatedClassrooms;
      _classroomIdMap.remove(classroomId);
      notifyListeners();
    }
  }

  /// Get next available classroom ID
  int _getNextClassroomId() {
    return _classrooms.value.isEmpty
        ? 1
        : _classrooms.value
                .map((c) => c.id ?? 0)
                .reduce((a, b) => a > b ? a : b) +
            1;
  }

  // Timetable management methods

  /// Create a new timetable
  Future<void> createTimetable(Timetable timetable) async {
    try {
      final createdTimetable = await _apiService.createTimetable(timetable);
      if (createdTimetable != null) {
        _timetable.value = createdTimetable;
        notifyListeners();
      }
    } catch (e) {
      // Fallback to local operation if API fails
      final newId = _timetable.value?.id ?? 1;
      final newTimetable = timetable.copyWith(id: newId);
      _timetable.value = newTimetable;
      notifyListeners();
    }
  }

  /// Update an existing timetable
  Future<void> updateTimetable(Timetable timetable) async {
    try {
      final updatedTimetable = await _apiService.updateTimetable(timetable);
      if (updatedTimetable != null) {
        _timetable.value = updatedTimetable;
        notifyListeners();
      }
    } catch (e) {
      // Fallback to local operation if API fails
      _timetable.value = timetable;
      notifyListeners();
    }
  }
}
