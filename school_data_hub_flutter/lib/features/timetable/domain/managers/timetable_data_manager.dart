import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/data/timetable_api_service.dart';
import 'package:school_data_hub_flutter/features/timetable/data/timetable_mock_data.dart';
import 'package:watch_it/watch_it.dart';

/// Manages timetable data loading, API calls, and state management
class TimetableDataManager extends ChangeNotifier {
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
    print('Refreshing timetable data...');
    await _loadData();
    print(
      'Data refresh completed. Lesson groups: ${_lessonGroups.value.length}',
    );
    notifyListeners();
  }

  /// Debug method to print current state
  void debugPrintState() {
    print('=== TimetableDataManager Debug State ===');
    print('Timetable: ${_timetable.value?.name} (ID: ${_timetable.value?.id})');
    print('TimetableSlots: ${_timetableSlots.value.length}');
    print('ScheduledLessons: ${_scheduledLessons.value.length}');
    print('Subjects: ${_subjects.value.length}');
    print('Classrooms: ${_classrooms.value.length}');
    print('LessonGroups: ${_lessonGroups.value.length}');
    print('====================================');
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
      print('Loading data from API...');
      // Try to load from API first
      await _loadFromApi();
      print('Data loaded from API successfully');
      debugPrintState();
    } catch (e) {
      print('API failed, loading mock data: $e');
      // Fallback to mock data if API fails
      await _loadMockData();
      debugPrintState();
    }
  }

  // Load data from API
  Future<void> _loadFromApi() async {
    print('Loading complete timetable data from API...');
    // Load complete timetable data
    final timetable = await _apiService.fetchCompleteTimetableData();
    print('API returned timetable: ${timetable?.name} (ID: ${timetable?.id})');
    if (timetable != null) {
      _timetable.value = timetable;
      _timetableSlots.value = timetable.timetableSlots ?? [];
      _scheduledLessons.value = timetable.scheduledLessons ?? [];
      print(
        'Set timetable data - slots: ${timetable.timetableSlots?.length ?? 0}, lessons: ${timetable.scheduledLessons?.length ?? 0}',
      );
    } else {
      print('No timetable data returned from API');
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

    // Load lesson groups
    final lessonGroups = await _apiService.fetchLessonGroups();
    if (lessonGroups != null) {
      print('Loaded ${lessonGroups.length} lesson groups from API');
      _lessonGroups.value = lessonGroups;
      // Update the lesson group ID map
      _lessonGroupIdMap.clear();
      for (final group in lessonGroups) {
        if (group.id != null) {
          _lessonGroupIdMap[group.id!] = group;
        }
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
      print('Creating timetable: ${timetable.name}');
      final createdTimetable = await _apiService.createTimetable(timetable);
      if (createdTimetable != null) {
        print(
          'Timetable created successfully: ${createdTimetable.name} (ID: ${createdTimetable.id})',
        );
        // Reload complete data to ensure UI is updated with all timetable information
        await _loadData();
        notifyListeners();
        print(
          'Timetable data reloaded. Current timetable: ${_timetable.value?.name}',
        );
      }
    } catch (e) {
      print('Error creating timetable: $e');
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
              print(
                'Created slot: ${createdSlot.day} ${createdSlot.startTime}-${createdSlot.endTime}',
              );
            }
          } catch (e) {
            print(
              'Error creating slot for ${weekday} ${time['start']}-${time['end']}: $e',
            );
          }
        }
      }

      print('Default timetable slots generation completed');
    } catch (e) {
      print('Error generating default timetable slots: $e');
    }
  }
}
