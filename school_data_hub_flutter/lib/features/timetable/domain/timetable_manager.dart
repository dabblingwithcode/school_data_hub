import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/managers/timetable_crud_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/managers/timetable_data_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/managers/timetable_lesson_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/managers/timetable_membership_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/managers/timetable_ui_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/models/timetable_proxy_models.dart';

/// Main timetable manager that orchestrates all sub-managers
/// This is the refactored version that breaks down the original large class
class TimetableManager extends ChangeNotifier {
  // Sub-managers
  final TimetableDataManager _dataManager;
  final TimetableCrudManager _crudManager;
  final TimetableUiManager _uiManager;
  final TimetableLessonManager _lessonManager;
  final TimetableMembershipManager _membershipManager;

  TimetableManager()
    : _dataManager = TimetableDataManager(),
      _crudManager = TimetableCrudManager(),
      _uiManager = TimetableUiManager(),
      _lessonManager = TimetableLessonManager(),
      _membershipManager = TimetableMembershipManager();

  // Expose data manager properties
  ValueListenable<Timetable?> get timetable => _dataManager.timetable;
  ValueListenable<List<TimetableSlot>> get timetableSlots =>
      _dataManager.timetableSlots;
  ValueListenable<List<Subject>> get subjects => _dataManager.subjects;
  ValueListenable<List<Classroom>> get classrooms => _dataManager.classrooms;
  ValueListenable<List<LessonGroup>> get lessonGroups =>
      _dataManager.lessonGroups;
  ValueListenable<List<ScheduledLesson>> get scheduledLessons =>
      _dataManager.scheduledLessons;
  ValueListenable<List<ScheduledLessonGroupMembership>>
  get scheduledLessonGroupMemberships =>
      _dataManager.scheduledLessonGroupMemberships;

  // Expose UI manager properties
  ValueListenable<Weekday> get selectedWeekday => _uiManager.selectedWeekday;
  ValueListenable<LessonGroup?> get selectedLessonGroup =>
      _uiManager.selectedLessonGroup;
  ValueListenable<Set<int>> get selectedLessonGroupIds =>
      _uiManager.selectedLessonGroupIds;
  ValueListenable<List<WeekdayProxy>> get weekdays => _uiManager.weekdays;

  // Expose lookup maps
  Map<int, TimetableSlot> get slotIdMap => _dataManager.slotIdMap;
  Map<int, Subject> get subjectIdMap => _dataManager.subjectIdMap;
  Map<int, Classroom> get classroomIdMap => _dataManager.classroomIdMap;
  Map<int, LessonGroup> get lessonGroupIdMap => _dataManager.lessonGroupIdMap;

  /// Initialize the timetable manager
  Future<TimetableManager> init() async {
    await _dataManager.init();
    _buildWeekdayProxies();
    return this;
  }

  /// Refresh all data from API
  Future<void> refreshData() async {
    await _dataManager.refreshData();
    _buildWeekdayProxies();
    notifyListeners();
  }

  /// Debug method to print current state
  void debugPrintState() {
    _dataManager.debugPrintState();
  }

  /// Check if there's an active timetable
  bool get hasActiveTimetable => _dataManager.timetable.value != null;

  /// Get the active timetable
  Timetable? get activeTimetable => _dataManager.timetable.value;

  /// Build weekday proxies for UI display
  void _buildWeekdayProxies() {
    _uiManager.buildWeekdayProxies(
      timetableSlots: _dataManager.timetableSlots.value,
      scheduledLessons: _dataManager.scheduledLessons.value,
      selectedGroupIds: _uiManager.selectedLessonGroupIds.value,
    );
  }

  // UI Management Methods
  void selectWeekday(Weekday weekday) {
    _uiManager.selectWeekday(weekday);
    notifyListeners();
  }

  void selectLessonGroup(LessonGroup? lessonGroup) {
    _uiManager.selectLessonGroup(lessonGroup);
    _buildWeekdayProxies();
    notifyListeners();
  }

  void addLessonGroupToSelection(LessonGroup lessonGroup) {
    _uiManager.addLessonGroupToSelection(lessonGroup);
    _buildWeekdayProxies();
    notifyListeners();
  }

  void removeLessonGroupFromSelection(LessonGroup lessonGroup) {
    _uiManager.removeLessonGroupFromSelection(lessonGroup);
    _buildWeekdayProxies();
    notifyListeners();
  }

  void clearLessonGroupSelection() {
    _uiManager.clearLessonGroupSelection();
    _buildWeekdayProxies();
    notifyListeners();
  }

  // CRUD Operations for Scheduled Lessons
  Future<void> addScheduledLesson(ScheduledLesson lesson) async {
    await _crudManager.addScheduledLesson(lesson);
    await refreshData();
  }

  Future<void> updateScheduledLesson(ScheduledLesson lesson) async {
    await _crudManager.updateScheduledLesson(lesson);
    await refreshData();
  }

  Future<void> removeScheduledLesson(int lessonId) async {
    await _crudManager.removeScheduledLesson(lessonId);
    await refreshData();
  }

  // CRUD Operations for Subjects
  Future<void> addSubject(Subject subject) async {
    final createdSubject = await _crudManager.addSubject(subject);
    if (createdSubject != null) {
      _dataManager.addSubject(createdSubject);
      notifyListeners();
    }
  }

  Future<void> updateSubject(Subject subject) async {
    final updatedSubject = await _crudManager.updateSubject(subject);
    if (updatedSubject != null) {
      _dataManager.updateSubject(updatedSubject);
      notifyListeners();
    }
  }

  Future<void> removeSubject(int subjectId) async {
    await _crudManager.removeSubject(subjectId);
    _dataManager.removeSubject(subjectId);
    notifyListeners();
  }

  // CRUD Operations for Classrooms
  Future<void> addClassroom(Classroom classroom) async {
    final createdClassroom = await _crudManager.addClassroom(classroom);
    if (createdClassroom != null) {
      _dataManager.addClassroom(createdClassroom);
      notifyListeners();
    }
  }

  Future<void> updateClassroom(Classroom classroom) async {
    final updatedClassroom = await _crudManager.updateClassroom(classroom);
    if (updatedClassroom != null) {
      _dataManager.updateClassroom(updatedClassroom);
      notifyListeners();
    }
  }

  Future<void> removeClassroom(int classroomId) async {
    await _crudManager.removeClassroom(classroomId);
    _dataManager.removeClassroom(classroomId);
    notifyListeners();
  }

  // CRUD Operations for Lesson Groups
  Future<void> addLessonGroup(LessonGroup lessonGroup) async {
    final createdLessonGroup = await _crudManager.addLessonGroup(lessonGroup);
    if (createdLessonGroup != null) {
      _dataManager.addLessonGroup(createdLessonGroup);
      notifyListeners();
    }
  }

  Future<void> updateLessonGroup(LessonGroup lessonGroup) async {
    final updatedLessonGroup = await _crudManager.updateLessonGroup(
      lessonGroup,
    );
    if (updatedLessonGroup != null) {
      _dataManager.updateLessonGroup(updatedLessonGroup);
      notifyListeners();
    }
  }

  Future<void> removeLessonGroup(int lessonGroupId) async {
    await _crudManager.removeLessonGroup(lessonGroupId);
    _dataManager.removeLessonGroup(lessonGroupId);
    notifyListeners();
  }

  // CRUD Operations for Timetable Slots
  Future<void> addTimetableSlot(TimetableSlot slot) async {
    await _crudManager.createTimetableSlot(slot);
    await refreshData();
  }

  Future<void> updateTimetableSlot(TimetableSlot slot) async {
    await _crudManager.updateTimetableSlot(slot);
    await refreshData();
  }

  Future<void> removeTimetableSlot(TimetableSlot slot) async {
    await _crudManager.removeTimetableSlot(slot.id!);
    await refreshData();
  }

  // Timetable Management
  Future<void> createTimetable(Timetable timetable) async {
    await _crudManager.createTimetable(timetable);
    // Generate default slots
    if (timetable.id != null) {
      await _dataManager.generateDefaultTimetableSlots(timetable.id!);
    }
    // Refresh data to get the new timetable
    await refreshData();
  }

  Future<void> updateTimetable(Timetable timetable) async {
    await _crudManager.updateTimetable(timetable);
    await refreshData();
  }

  // Lesson Management Methods
  List<ScheduledLesson> getAllLessonsForSlot(int slotId) {
    return _lessonManager.getAllLessonsForSlot(
      slotId,
      _dataManager.scheduledLessons.value,
    );
  }

  int getNextAvailableOrderForSlot(int slotId) {
    return _lessonManager.getNextAvailableOrderForSlot(
      slotId,
      _dataManager.scheduledLessons.value,
    );
  }

  void insertLessonAtPosition(
    ScheduledLesson lesson,
    int targetSlotId,
    int targetPosition,
  ) {
    _lessonManager.insertLessonAtPosition(
      lesson,
      targetSlotId,
      targetPosition,
      _dataManager.scheduledLessons.value,
      (updatedLesson) => updateScheduledLesson(updatedLesson),
    );
  }

  ScheduledLesson? getScheduledLessonForSlot(int slotId) {
    return _lessonManager.getScheduledLessonForSlot(
      slotId,
      _dataManager.scheduledLessons.value,
    );
  }

  ScheduledLesson? getScheduledLessonById(int lessonId) {
    return _lessonManager.getScheduledLessonById(
      lessonId,
      _dataManager.scheduledLessons.value,
    );
  }

  List<String> getTimeSlotPeriods() {
    return _lessonManager.getTimeSlotPeriods(_dataManager.timetableSlots.value);
  }

  List<TimetableSlot> getSlotsByTimePeriod(String period) {
    return _lessonManager.getSlotsByTimePeriod(
      period,
      _dataManager.timetableSlots.value,
    );
  }

  List<LessonGroup> getLessonGroupsForWeekday(Weekday weekday) {
    return _uiManager.getLessonGroupsForWeekday(
      weekday,
      _dataManager.timetableSlots.value,
      _dataManager.scheduledLessons.value,
      _dataManager.lessonGroups.value,
      _uiManager.selectedLessonGroupIds.value,
    );
  }

  // Membership Management Methods
  List<ScheduledLessonGroupMembership> getMembershipsForLessonGroup(
    int lessonGroupId,
  ) {
    return _membershipManager.getMembershipsForLessonGroup(
      lessonGroupId,
      _dataManager.scheduledLessonGroupMemberships.value,
    );
  }

  List<int> getPupilIdsForLessonGroup(int lessonGroupId) {
    return _membershipManager.getPupilIdsForLessonGroup(
      lessonGroupId,
      _dataManager.scheduledLessonGroupMemberships.value,
    );
  }

  void addPupilToLessonGroup(int lessonGroupId, int pupilDataId) {
    _membershipManager.addPupilToLessonGroup(
      lessonGroupId,
      pupilDataId,
      _dataManager.scheduledLessonGroupMemberships.value,
      (updatedMemberships) {
        _dataManager.updateScheduledLessonGroupMemberships(updatedMemberships);
        notifyListeners();
      },
    );
  }

  void removePupilFromLessonGroup(int lessonGroupId, int pupilDataId) {
    _membershipManager.removePupilFromLessonGroup(
      lessonGroupId,
      pupilDataId,
      _dataManager.scheduledLessonGroupMemberships.value,
      (updatedMemberships) {
        _dataManager.updateScheduledLessonGroupMemberships(updatedMemberships);
        notifyListeners();
      },
    );
  }

  void updatePupilMembershipsForLessonGroup(
    int lessonGroupId,
    List<int> pupilDataIds,
  ) {
    _membershipManager.updatePupilMembershipsForLessonGroup(
      lessonGroupId,
      pupilDataIds,
      _dataManager.scheduledLessonGroupMemberships.value,
      (updatedMemberships) {
        _dataManager.updateScheduledLessonGroupMemberships(updatedMemberships);
        notifyListeners();
      },
    );
  }

  bool isPupilMemberOfLessonGroup(int lessonGroupId, int pupilDataId) {
    return _membershipManager.isPupilMemberOfLessonGroup(
      lessonGroupId,
      pupilDataId,
      _dataManager.scheduledLessonGroupMemberships.value,
    );
  }

  // Utility Methods
  Subject? getSubjectById(int subjectId) {
    return _dataManager.subjectIdMap[subjectId];
  }

  Classroom? getClassroomById(int classroomId) {
    return _dataManager.classroomIdMap[classroomId];
  }

  LessonGroup? getLessonGroupById(int lessonGroupId) {
    return _dataManager.lessonGroupIdMap[lessonGroupId];
  }

  TimetableSlot? getTimetableSlotById(int slotId) {
    return _dataManager.slotIdMap[slotId];
  }

  WeekdayProxy? getCurrentWeekdayProxy() {
    return _uiManager.getCurrentWeekdayProxy();
  }

  Set<int> getBusyUserIdsForTimeSlot(Weekday weekday, String period) {
    return _uiManager.getBusyUserIdsForTimeSlot(
      weekday,
      period,
      _dataManager.timetableSlots.value,
      _dataManager.scheduledLessons.value,
    );
  }

  int getScheduledLessonsCountForUser(int userId) {
    return _uiManager.getScheduledLessonsCountForUser(
      userId,
      _dataManager.scheduledLessons.value,
    );
  }

  int getRemainingTimeUnitsForUser(int userId, int userTimeUnits) {
    return _uiManager.getRemainingTimeUnitsForUser(
      userId,
      userTimeUnits,
      _dataManager.scheduledLessons.value,
    );
  }

  // Helper methods for UI
  List<String> getUniqueTimeSlots() {
    final timeSlots = <String>{};
    for (final slot in _dataManager.timetableSlots.value) {
      timeSlots.add('${slot.startTime} - ${slot.endTime}');
    }
    return timeSlots.toList()..sort();
  }

  /// Check if a time slot has a lesson for the selected lesson group
  bool hasLessonForSlot(int slotId) {
    return getScheduledLessonForSlot(slotId) != null;
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

  // Getters for backward compatibility
  List<TimetableSlot> getTimeSlotsForWeekday(Weekday weekday) {
    return _dataManager.timetableSlots.value
        .where((slot) => slot.day == weekday)
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  List<ScheduledLesson> getScheduledLessonsForWeekday(Weekday weekday) {
    return _uiManager.getScheduledLessonsForWeekdayAndGroups(
      weekday,
      _uiManager.selectedLessonGroupIds.value,
      _dataManager.scheduledLessons.value,
      _dataManager.timetableSlots.value,
    );
  }

  void clearData() {
    _dataManager.clearData();
    _uiManager.clearLessonGroupSelection();
    _buildWeekdayProxies();
    notifyListeners();
  }
}
