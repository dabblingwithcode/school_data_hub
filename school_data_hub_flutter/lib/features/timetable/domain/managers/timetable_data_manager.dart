import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/data/timetable_api_service.dart';
import 'package:school_data_hub_flutter/features/timetable/data/timetable_mock_data.dart';
import 'package:watch_it/watch_it.dart';

/// Manages timetable data loading, API calls, and state management
class TimetableDataManager extends ChangeNotifier {
  final _apiService = di<TimetableApiService>();
  final _log = Logger('TimetableDataManager');

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

  TimetableDataManager();

  /// Initialize the data manager
  Future<TimetableDataManager> init() async {
    await _loadData();
    return this;
  }

  /// Refresh all data from API
  Future<void> refreshData() async {
    _log.info('Refreshing timetable data...');
    await _loadData();
    _log.info(
      'Data refresh completed. Lesson groups: ${_lessonGroups.value.length}',
    );
    notifyListeners();
  }

  /// Debug method to print current state
  void debugPrintState() {
    _log.info(
      '''Timetable: ${_timetable.value?.name} (ID: ${_timetable.value?.id})
      TimetableSlots: ${_timetableSlots.value.length}
      ScheduledLessons: ${_scheduledLessons.value.length}
      Subjects: ${_subjects.value.length}
      Classrooms: ${_classrooms.value.length}
      LessonGroups: ${_lessonGroups.value.length}
      ''',
    );
  }

  void clearData() {
    _timetableSlots.value = [];
    _subjects.value = [];
    _classrooms.value = [];
    _lessonGroups.value = [];
    _scheduledLessons.value = [];
    _scheduledLessonGroupMemberships.value = [];

    _slotIdMap.clear();
    _subjectIdMap.clear();
    _classroomIdMap.clear();
    _lessonGroupIdMap.clear();
  }

  // Load data from API with fallback to mock data
  Future<void> _loadData() async {
    try {
      _log.info('Loading data from API...');
      // Try to load from API first
      await _loadFromApi();
      _log.info('Data loaded from API successfully');
      debugPrintState();
    } catch (e) {
      _log.info('API failed, loading mock data: $e');
      // Fallback to mock data if API fails
      await _loadMockData();
      debugPrintState();
    }
  }

  // Load data from API
  Future<void> _loadFromApi() async {
    _log.info('Loading complete timetable data from API...');
    // Load complete timetable data
    final timetable = await _apiService.fetchCompleteTimetableData();
    _log.info(
      'API returned timetable: ${timetable?.name} (ID: ${timetable?.id})',
    );

    if (timetable != null) {
      _timetable.value = timetable;
      _timetableSlots.value = timetable.timetableSlots ?? [];
      _scheduledLessons.value = timetable.scheduledLessons ?? [];
      _log.info(
        'Set timetable data - slots: ${timetable.timetableSlots?.length ?? 0}, lessons: ${timetable.scheduledLessons?.length ?? 0}',
      );
    } else {
      _log.info(
        'No timetable data returned from fetchCompleteTimetableData, trying fetchTimetables...',
      );
      // Try to fetch all timetables and use the first one
      final timetables = await _apiService.fetchTimetables();
      if (timetables != null && timetables.isNotEmpty) {
        final firstTimetable = timetables.first;
        _log.info(
          'Using first timetable from fetchTimetables: ${firstTimetable.name} (ID: ${firstTimetable.id})',
        );
        _timetable.value = firstTimetable;
        _timetableSlots.value = firstTimetable.timetableSlots ?? [];
        _scheduledLessons.value = firstTimetable.scheduledLessons ?? [];
        _log.info(
          'Set timetable data from fetchTimetables - slots: ${firstTimetable.timetableSlots?.length ?? 0}, lessons: ${firstTimetable.scheduledLessons?.length ?? 0}',
        );
      } else {
        _log.info('No timetables found in database');
      }
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
        // Sort classrooms alphabetically by room code
        final sortedClassrooms = [...classrooms];
        sortedClassrooms.sort((a, b) => a.roomCode.compareTo(b.roomCode));
        _classrooms.value = sortedClassrooms;
      }
    }

    // Load lesson groups for the current timetable
    if (_timetable.value?.id != null) {
      final lessonGroups = await _apiService.fetchLessonGroupsByTimetable(
        _timetable.value!.id!,
      );
      if (lessonGroups != null) {
        _log.info(
          'Loaded ${lessonGroups.length} lesson groups from API for timetable ${_timetable.value!.id}',
        );
        // Sort lesson groups alphabetically by name
        final sortedLessonGroups = [...lessonGroups];
        sortedLessonGroups.sort((a, b) => a.name.compareTo(b.name));
        _lessonGroups.value = sortedLessonGroups;
        // Update the lesson group ID map
        _lessonGroupIdMap.clear();
        for (final group in sortedLessonGroups) {
          if (group.id != null) {
            _lessonGroupIdMap[group.id!] = group;
          }
        }
      }
    } else {
      _log.info('No timetable loaded, skipping lesson groups fetch');
      _lessonGroups.value = [];
      _lessonGroupIdMap.clear();
    }

    // Load scheduled lesson group memberships
    final memberships = await _apiService
        .fetchScheduledLessonGroupMemberships();
    if (memberships != null) {
      _scheduledLessonGroupMemberships.value = memberships;
    }
  }

  // Extract related data from lessons
  void _extractRelatedDataFromLessons() {
    final subjects = <Subject>[];
    final classroomsFromLessons = <Classroom>[];
    final lessonGroupsFromLessons = <LessonGroup>[];

    for (final lesson in _scheduledLessons.value) {
      if (lesson.subject != null &&
          !subjects.any((s) => s.id == lesson.subject!.id)) {
        subjects.add(lesson.subject!);
      }
      if (lesson.room != null &&
          !classroomsFromLessons.any((c) => c.id == lesson.room!.id)) {
        classroomsFromLessons.add(lesson.room!);
      }
      if (lesson.lessonGroup != null &&
          !lessonGroupsFromLessons.any(
            (lg) => lg.id == lesson.lessonGroup!.id,
          )) {
        lessonGroupsFromLessons.add(lesson.lessonGroup!);
      }
    }

    // Update collections if we found additional data
    if (subjects.isNotEmpty) {
      _subjects.value = subjects;
    }

    // Merge classrooms from lessons with existing classrooms instead of overwriting
    if (classroomsFromLessons.isNotEmpty) {
      final existingClassrooms = _classrooms.value;
      final mergedClassrooms = <Classroom>[];

      // Add all existing classrooms
      mergedClassrooms.addAll(existingClassrooms);

      // Add classrooms from lessons that aren't already in the list
      for (final classroom in classroomsFromLessons) {
        if (!mergedClassrooms.any((c) => c.id == classroom.id)) {
          mergedClassrooms.add(classroom);
        }
      }

      // Sort classrooms alphabetically by room code
      mergedClassrooms.sort((a, b) => a.roomCode.compareTo(b.roomCode));
      _classrooms.value = mergedClassrooms;
    }

    // Merge lesson groups from lessons with existing lesson groups instead of overwriting
    if (lessonGroupsFromLessons.isNotEmpty) {
      final existingGroups = _lessonGroups.value;
      final mergedGroups = <LessonGroup>[];

      // Add all existing lesson groups
      mergedGroups.addAll(existingGroups);

      // Add lesson groups from lessons that aren't already in the list
      // Only add lesson groups that belong to the current timetable
      for (final lessonGroup in lessonGroupsFromLessons) {
        if (!mergedGroups.any((lg) => lg.id == lessonGroup.id) &&
            lessonGroup.timetableId == _timetable.value?.id) {
          mergedGroups.add(lessonGroup);
        }
      }

      // Sort lesson groups alphabetically by name
      mergedGroups.sort((a, b) => a.name.compareTo(b.name));
      _lessonGroups.value = mergedGroups;
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

  // Getters for lookup maps
  Map<int, TimetableSlot> get slotIdMap => _slotIdMap;
  Map<int, Subject> get subjectIdMap => _subjectIdMap;
  Map<int, Classroom> get classroomIdMap => _classroomIdMap;
  Map<int, LessonGroup> get lessonGroupIdMap => _lessonGroupIdMap;

  // Timetable management methods
  Future<void> createTimetable(Timetable timetable) async {
    try {
      _log.info('Creating timetable: ${timetable.name}');
      final createdTimetable = await _apiService.createTimetable(timetable);
      if (createdTimetable != null) {
        _log.info(
          'Timetable created successfully: ${createdTimetable.name} (ID: ${createdTimetable.id})',
        );

        // Set the newly created timetable as the active one
        _timetable.value = createdTimetable;

        // Initialize empty collections for the new timetable
        _timetableSlots.value = [];
        _scheduledLessons.value = [];
        _lessonGroups.value = [];
        _scheduledLessonGroupMemberships.value = [];

        // Clear lookup maps
        _slotIdMap.clear();
        _lessonGroupIdMap.clear();

        // Generate default timetable slots for the new timetable
        await generateDefaultTimetableSlots(createdTimetable.id!);

        // Load additional data for the new timetable
        await _loadAdditionalDataFromApi();

        notifyListeners();
        _log.info(
          'Timetable set as active. Current timetable: ${_timetable.value?.name} (ID: ${_timetable.value?.id})',
        );
      }
    } catch (e) {
      _log.info('Error creating timetable: $e');
      // Fallback to local operation if API fails
      final newId = _timetable.value?.id ?? 1;
      final newTimetable = timetable.copyWith(id: newId);
      _timetable.value = newTimetable;
      notifyListeners();
    }
  }

  Future<void> updateTimetable(Timetable timetable) async {
    try {
      final updatedTimetable = await _apiService.updateTimetable(timetable);
      if (updatedTimetable != null) {
        // Reload complete data to ensure UI is updated with all timetable information
        await _loadData();
        notifyListeners();
      }
    } catch (e) {
      // Fallback to local operation if API fails
      _timetable.value = timetable;
      notifyListeners();
    }
  }

  /// Generate default timetable slots for a new timetable
  Future<void> generateDefaultTimetableSlots(int timetableId) async {
    try {
      // Default time slots (same as mock data)
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
          final slot = TimetableSlot(
            day: weekday,
            startTime: time['start']!,
            endTime: time['end']!,
            timetableId: timetableId,
          );

          try {
            final createdSlot = await _apiService.createTimetableSlot(slot);
            if (createdSlot != null) {
              _log.info(
                'Created slot: ${createdSlot.day} ${createdSlot.startTime}-${createdSlot.endTime}',
              );
            }
          } catch (e) {
            _log.info(
              'Error creating slot for ${weekday} ${time['start']}-${time['end']}: $e',
            );
          }
        }
      }

      _log.info('Default timetable slots generation completed');
    } catch (e) {
      _log.info('Error generating default timetable slots: $e');
    }
  }

  /// Update scheduled lesson group memberships
  void updateScheduledLessonGroupMemberships(
    List<ScheduledLessonGroupMembership> memberships,
  ) {
    _scheduledLessonGroupMemberships.value = memberships;
  }

  /// Add a new classroom to the local data
  void addClassroom(Classroom classroom) {
    final currentClassrooms = _classrooms.value;
    if (!currentClassrooms.any((c) => c.id == classroom.id)) {
      final updatedClassrooms = [...currentClassrooms, classroom];
      // Sort classrooms alphabetically by room code
      updatedClassrooms.sort((a, b) => a.roomCode.compareTo(b.roomCode));
      _classrooms.value = updatedClassrooms;
      _buildLookupMaps();
      notifyListeners();
      _log.info(
        'Added classroom to local data: ${classroom.roomName} (ID: ${classroom.id})',
      );
    }
  }

  /// Update an existing classroom in the local data
  void updateClassroom(Classroom classroom) {
    final currentClassrooms = _classrooms.value;
    final index = currentClassrooms.indexWhere((c) => c.id == classroom.id);
    if (index != -1) {
      final updatedClassrooms = [...currentClassrooms];
      updatedClassrooms[index] = classroom;
      // Sort classrooms alphabetically by room code
      updatedClassrooms.sort((a, b) => a.roomCode.compareTo(b.roomCode));
      _classrooms.value = updatedClassrooms;
      _buildLookupMaps();
      notifyListeners();
      _log.info(
        'Updated classroom in local data: ${classroom.roomName} (ID: ${classroom.id})',
      );
    }
  }

  /// Remove a classroom from the local data
  void removeClassroom(int classroomId) {
    final currentClassrooms = _classrooms.value;
    final updatedClassrooms = currentClassrooms
        .where((c) => c.id != classroomId)
        .toList();
    if (updatedClassrooms.length != currentClassrooms.length) {
      _classrooms.value = updatedClassrooms;
      _buildLookupMaps();
      notifyListeners();
      _log.info('Removed classroom from local data: $classroomId');
    }
  }

  /// Add a new lesson group to the local data
  void addLessonGroup(LessonGroup lessonGroup) {
    _log.info(
      'DEBUG: addLessonGroup called - timetableId: ${lessonGroup.timetableId}, current timetable: ${_timetable.value?.id}',
    );

    // Only add lesson groups that belong to the current timetable
    if (lessonGroup.timetableId != _timetable.value?.id) {
      _log.info(
        'Skipping lesson group ${lessonGroup.name} - belongs to different timetable (${lessonGroup.timetableId} vs ${_timetable.value?.id})',
      );
      return;
    }

    final currentLessonGroups = _lessonGroups.value;
    if (!currentLessonGroups.any((lg) => lg.id == lessonGroup.id)) {
      final updatedLessonGroups = [...currentLessonGroups, lessonGroup];
      // Sort lesson groups alphabetically by name
      updatedLessonGroups.sort((a, b) => a.name.compareTo(b.name));
      _lessonGroups.value = updatedLessonGroups;
      _buildLookupMaps();
      notifyListeners();
      _log.info(
        'Added lesson group to local data: ${lessonGroup.name} (ID: ${lessonGroup.id})',
      );
    }
  }

  /// Update an existing lesson group in the local data
  void updateLessonGroup(LessonGroup lessonGroup) {
    // Only update lesson groups that belong to the current timetable
    if (lessonGroup.timetableId != _timetable.value?.id) {
      _log.info(
        'Skipping lesson group update ${lessonGroup.name} - belongs to different timetable (${lessonGroup.timetableId} vs ${_timetable.value?.id})',
      );
      return;
    }

    final currentLessonGroups = _lessonGroups.value;
    final index = currentLessonGroups.indexWhere(
      (lg) => lg.id == lessonGroup.id,
    );
    if (index != -1) {
      final updatedLessonGroups = [...currentLessonGroups];
      updatedLessonGroups[index] = lessonGroup;
      // Sort lesson groups alphabetically by name
      updatedLessonGroups.sort((a, b) => a.name.compareTo(b.name));
      _lessonGroups.value = updatedLessonGroups;
      _buildLookupMaps();
      notifyListeners();
      _log.info(
        'Updated lesson group in local data: ${lessonGroup.name} (ID: ${lessonGroup.id})',
      );
    }
  }

  /// Remove a lesson group from the local data
  void removeLessonGroup(int lessonGroupId) {
    final currentLessonGroups = _lessonGroups.value;
    final updatedLessonGroups = currentLessonGroups
        .where((lg) => lg.id != lessonGroupId)
        .toList();
    if (updatedLessonGroups.length != currentLessonGroups.length) {
      _lessonGroups.value = updatedLessonGroups;
      _buildLookupMaps();
      notifyListeners();
      _log.info('Removed lesson group from local data: $lessonGroupId');
    }
  }

  /// Add a new subject to the local data
  void addSubject(Subject subject) {
    final currentSubjects = _subjects.value;
    if (!currentSubjects.any((s) => s.id == subject.id)) {
      final updatedSubjects = [...currentSubjects, subject];
      // Sort subjects alphabetically by name
      updatedSubjects.sort((a, b) => a.name.compareTo(b.name));
      _subjects.value = updatedSubjects;
      _buildLookupMaps();
      notifyListeners();
      _log.info(
        'Added subject to local data: ${subject.name} (ID: ${subject.id})',
      );
    }
  }

  /// Update an existing subject in the local data
  void updateSubject(Subject subject) {
    final currentSubjects = _subjects.value;
    final index = currentSubjects.indexWhere((s) => s.id == subject.id);
    if (index != -1) {
      final updatedSubjects = [...currentSubjects];
      updatedSubjects[index] = subject;
      // Sort subjects alphabetically by name
      updatedSubjects.sort((a, b) => a.name.compareTo(b.name));
      _subjects.value = updatedSubjects;
      _buildLookupMaps();
      notifyListeners();
      _log.info(
        'Updated subject in local data: ${subject.name} (ID: ${subject.id})',
      );
    }
  }

  /// Remove a subject from the local data
  void removeSubject(int subjectId) {
    final currentSubjects = _subjects.value;
    final updatedSubjects = currentSubjects
        .where((s) => s.id != subjectId)
        .toList();
    if (updatedSubjects.length != currentSubjects.length) {
      _subjects.value = updatedSubjects;
      _buildLookupMaps();
      notifyListeners();
      _log.info('Removed subject from local data: $subjectId');
    }
  }
}
