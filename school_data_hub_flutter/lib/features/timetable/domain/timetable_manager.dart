import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/managers/timetable_crud_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/managers/timetable_data_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/managers/timetable_lesson_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/managers/timetable_membership_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/managers/timetable_ui_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/models/timetable_proxy_models.dart';

final _log = Logger('TimetableManager');

/// Main timetable manager that orchestrates all sub-managers
/// This is the refactored version that breaks down the original large class
class TimetableManager {
  final TimetableDataManager data;
  final TimetableUiManager ui;
  final TimetableCrudManager _crudManager;
  final TimetableLessonManager _lessonManager;
  final TimetableMembershipManager _membershipManager;
  StreamSubscription<dynamic>? _hubSubscription;

  TimetableManager()
    : data = TimetableDataManager(),
      ui = TimetableUiManager(),
      _crudManager = TimetableCrudManager(),
      _lessonManager = TimetableLessonManager(),
      _membershipManager = TimetableMembershipManager();

  void dispose() {
    _hubSubscription?.cancel();
    _hubSubscription = null;
    data.dispose();
    ui.dispose();
  }

  /// Initialize the timetable manager
  Future<TimetableManager> init() async {
    await data.init();
    _buildWeekdayProxies();
    _hubSubscription = di<HubStreamService>().events.listen(_onHubEvent);
    return this;
  }

  void _onHubEvent(dynamic event) {
    if (event is HubDeleteEvent &&
        event.objectType == HubObjectType.timetableData) {
      _log.fine('[STREAM] timetable delete event ${event.id}');
      refreshData();
    } else if (event is ScheduledLesson ||
        event is Timetable ||
        event is TimetableSlot ||
        event is Subject ||
        event is Classroom ||
        event is LessonGroup ||
        event is ScheduledLessonGroupMembership) {
      _log.fine('[STREAM] timetable upsert ${event.runtimeType}');
      refreshData();
    } else if (event is HubReconnected) {
      refreshData();
    } else if (event is HubSelectiveReconnect) {
      if (event.changedTypes.contains(HubObjectType.timetableData)) {
        refreshData();
      }
    }
  }

  /// Refresh all data from API
  Future<void> refreshData() async {
    await data.refreshData();
    _buildWeekdayProxies();
  }

  /// Build weekday proxies for UI display
  void _buildWeekdayProxies() {
    ui.buildWeekdayProxies(
      timetableSlots: data.timetableSlots.value,
      scheduledLessons: data.scheduledLessons.value,
      selectedGroupIds: ui.selectedLessonGroupIds.value,
    );
  }

  // UI Management Methods

  void selectLessonGroup(LessonGroup? lessonGroup) {
    ui.selectLessonGroup(lessonGroup);
    _buildWeekdayProxies();
  }

  void addLessonGroupToSelection(LessonGroup lessonGroup) {
    ui.addLessonGroupToSelection(lessonGroup);
    _buildWeekdayProxies();
  }

  void removeLessonGroupFromSelection(LessonGroup lessonGroup) {
    ui.removeLessonGroupFromSelection(lessonGroup);
    _buildWeekdayProxies();
  }

  void clearLessonGroupSelection() {
    ui.clearLessonGroupSelection();
    _buildWeekdayProxies();
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
      data.addSubject(createdSubject);
    }
  }

  Future<void> updateSubject(Subject subject) async {
    final updatedSubject = await _crudManager.updateSubject(subject);
    if (updatedSubject != null) {
      data.updateSubject(updatedSubject);
    }
  }

  Future<void> removeSubject(int subjectId) async {
    await _crudManager.removeSubject(subjectId);
    data.removeSubject(subjectId);
  }

  // CRUD Operations for Classrooms
  Future<void> addClassroom(Classroom classroom) async {
    final createdClassroom = await _crudManager.addClassroom(classroom);
    if (createdClassroom != null) {
      data.addClassroom(createdClassroom);
    }
  }

  Future<void> updateClassroom(Classroom classroom) async {
    final updatedClassroom = await _crudManager.updateClassroom(classroom);
    if (updatedClassroom != null) {
      data.updateClassroom(updatedClassroom);
    }
  }

  Future<void> removeClassroom(int classroomId) async {
    await _crudManager.removeClassroom(classroomId);
    data.removeClassroom(classroomId);
  }

  // CRUD Operations for Lesson Groups
  Future<LessonGroup?> addLessonGroup(LessonGroup lessonGroup) async {
    final createdLessonGroup = await _crudManager.addLessonGroup(lessonGroup);
    if (createdLessonGroup != null) {
      data.addLessonGroup(createdLessonGroup);
    }
    return createdLessonGroup;
  }

  Future<void> updateLessonGroup(LessonGroup lessonGroup) async {
    final updatedLessonGroup = await _crudManager.updateLessonGroup(
      lessonGroup,
    );
    if (updatedLessonGroup != null) {
      data.updateLessonGroup(updatedLessonGroup);
    }
  }

  Future<void> removeLessonGroup(int lessonGroupId) async {
    await _crudManager.removeLessonGroup(lessonGroupId);
    data.removeLessonGroup(lessonGroupId);
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

  /// Find an existing timetable slot for the given day, start time and duration,
  /// or create and add one. Same logic as used when dropping a lesson in the
  /// room timetable grid. Returns the slot (existing or newly created with id).
  Future<TimetableSlot> findOrCreateSlotFor(
    Weekday day,
    String startTime,
    int durationMinutes,
  ) async {
    final timetable = data.timetable.value;
    final timetableId = timetable?.id;
    if (timetableId == null) {
      throw StateError('No timetable selected');
    }
    final parts = startTime.split(':');
    final startHour = int.parse(parts[0]);
    final startMinute = int.parse(parts[1]);
    final startTotal = startHour * 60 + startMinute;
    final endTotal = startTotal + durationMinutes;
    final endHour = endTotal ~/ 60;
    final endMinute = endTotal % 60;
    final endTime =
        '${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}';

    final existing = data.timetableSlots.value.where(
      (s) =>
          s.day == day &&
          s.startTime == startTime &&
          s.endTime == endTime &&
          s.timetableId == timetableId,
    );
    if (existing.isNotEmpty) {
      return existing.first;
    }

    final slot = TimetableSlot(
      day: day,
      startTime: startTime,
      endTime: endTime,
      timetableId: timetableId,
    );
    await addTimetableSlot(slot);

    final refreshed = data.timetableSlots.value.where(
      (s) =>
          s.day == day &&
          s.startTime == startTime &&
          s.endTime == endTime &&
          s.timetableId == timetableId,
    );
    return refreshed.isNotEmpty ? refreshed.first : slot;
  }

  // Timetable Management
  Future<void> createTimetable(Timetable timetable) async {
    await _crudManager.createTimetable(timetable);
    // Generate default slots
    if (timetable.id != null) {
      await data.generateDefaultTimetableSlots(timetable.id!);
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
      data.scheduledLessons.value,
    );
  }

  int getNextAvailableOrderForSlot(int slotId) {
    return _lessonManager.getNextAvailableOrderForSlot(
      slotId,
      data.scheduledLessons.value,
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
      data.scheduledLessons.value,
      (updatedLesson) => updateScheduledLesson(updatedLesson),
    );
  }

  ScheduledLesson? getScheduledLessonForSlot(int slotId) {
    return _lessonManager.getScheduledLessonForSlot(
      slotId,
      data.scheduledLessons.value,
    );
  }

  ScheduledLesson? getScheduledLessonById(int lessonId) {
    return _lessonManager.getScheduledLessonById(
      lessonId,
      data.scheduledLessons.value,
    );
  }

  List<String> getTimeSlotPeriods() {
    return _lessonManager.getTimeSlotPeriods(data.timetableSlots.value);
  }

  List<TimetableSlot> getSlotsByTimePeriod(String period) {
    return _lessonManager.getSlotsByTimePeriod(
      period,
      data.timetableSlots.value,
    );
  }

  List<LessonGroup> getLessonGroupsForWeekday(Weekday weekday) {
    return ui.getLessonGroupsForWeekday(
      weekday,
      data.timetableSlots.value,
      data.scheduledLessons.value,
      data.lessonGroups.value,
      ui.selectedLessonGroupIds.value,
    );
  }

  // Membership Management Methods
  List<ScheduledLessonGroupMembership> getMembershipsForLessonGroup(
    int lessonGroupId,
  ) {
    return _membershipManager.getMembershipsForLessonGroup(
      lessonGroupId,
      data.scheduledLessonGroupMemberships.value,
    );
  }

  List<int> getPupilIdsForLessonGroup(int lessonGroupId) {
    return _membershipManager.getPupilIdsForLessonGroup(
      lessonGroupId,
      data.scheduledLessonGroupMemberships.value,
    );
  }

  void addPupilToLessonGroup(int lessonGroupId, int pupilDataId) {
    _membershipManager.addPupilToLessonGroup(
      lessonGroupId,
      pupilDataId,
      data.scheduledLessonGroupMemberships.value,
      (updatedMemberships) {
        data.updateScheduledLessonGroupMemberships(updatedMemberships);
      },
    );
  }

  void removePupilFromLessonGroup(int lessonGroupId, int pupilDataId) {
    _membershipManager.removePupilFromLessonGroup(
      lessonGroupId,
      pupilDataId,
      data.scheduledLessonGroupMemberships.value,
      (updatedMemberships) {
        data.updateScheduledLessonGroupMemberships(updatedMemberships);
      },
    );
  }

  Future<void> updatePupilMembershipsForLessonGroup(
    int lessonGroupId,
    List<int> pupilDataIds,
  ) async {
    _membershipManager.updatePupilMembershipsForLessonGroup(
      lessonGroupId,
      pupilDataIds,
      data.scheduledLessonGroupMemberships.value,
      (updatedMemberships) {
        data.updateScheduledLessonGroupMemberships(updatedMemberships);
      },
    );
    await _crudManager.updatePupilMembershipsForLessonGroup(
      lessonGroupId,
      pupilDataIds,
    );
  }

  bool isPupilMemberOfLessonGroup(int lessonGroupId, int pupilDataId) {
    return _membershipManager.isPupilMemberOfLessonGroup(
      lessonGroupId,
      pupilDataId,
      data.scheduledLessonGroupMemberships.value,
    );
  }

  Set<int> getBusyUserIdsForTimeSlot(Weekday weekday, String period) {
    return ui.getBusyUserIdsForTimeSlot(
      weekday,
      period,
      data.timetableSlots.value,
      data.scheduledLessons.value,
    );
  }

  int getScheduledLessonsCountForUser(int userId) {
    return ui.getScheduledLessonsCountForUser(
      userId,
      data.scheduledLessons.value,
    );
  }

  int getRemainingTimeUnitsForUser(int userId, int userTimeUnits) {
    return ui.getRemainingTimeUnitsForUser(
      userId,
      userTimeUnits,
      data.scheduledLessons.value,
    );
  }

  List<ScheduledLesson> getScheduledLessonsForWeekday(Weekday weekday) {
    return ui.getScheduledLessonsForWeekdayAndGroups(
      weekday,
      ui.selectedLessonGroupIds.value,
      data.scheduledLessons.value,
      data.timetableSlots.value,
    );
  }

  /// All scheduled lessons on [weekday] (no lesson-group filter). Use for
  /// conflict checks e.g. in room grid drag-snap validation.
  List<ScheduledLesson> getAllScheduledLessonsForWeekday(Weekday weekday) {
    return ui.getScheduledLessonsForWeekdayAndGroups(
      weekday,
      <int>{},
      data.scheduledLessons.value,
      data.timetableSlots.value,
    );
  }

  void clearData() {
    data.clearData();
    ui.clearLessonGroupSelection();
    _buildWeekdayProxies();
  }
}
