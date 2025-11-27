import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:watch_it/watch_it.dart';

/// TimetableApiService provides API methods for timetable operations.
///
/// This service uses the implemented server-side endpoints for timetable management.
class TimetableApiService {
  final _client = di<Client>();
  final _log = Logger('TimetableApiService');

  // ============================================================================
  // TIMETABLE OPERATIONS
  // ============================================================================

  /// Fetch the main timetable with all related data
  Future<Timetable?> fetchTimetable() async {
    _log.info('Calling fetchTimetable...');
    final timetable = await ClientHelper.apiCall(
      call: () => _client.timetable.fetchTimetable(),
      errorMessage: 'Fehler beim Laden des Stundenplans',
    );
    _log.info(
      'fetchTimetable returned: ${timetable?.name} (ID: ${timetable?.id})',
    );
    return timetable;
  }

  /// Create a new timetable
  Future<Timetable?> createTimetable(Timetable timetable) async {
    final createdTimetable = await ClientHelper.apiCall(
      call: () => _client.timetable.createTimetable(timetable),
      errorMessage: 'Fehler beim Erstellen des Stundenplans',
    );
    return createdTimetable;
  }

  /// Update an existing timetable
  Future<Timetable?> updateTimetable(Timetable timetable) async {
    return await ClientHelper.apiCall(
      call: () => _client.timetable.updateTimetable(timetable),
      errorMessage: 'Fehler beim Aktualisieren des Stundenplans',
    );
  }

  /// Delete a timetable
  Future<bool?> deleteTimetable(int timetableId) async {
    return await ClientHelper.apiCall(
      call: () => _client.timetable.deleteTimetable(timetableId),
      errorMessage: 'Fehler beim Löschen des Stundenplans',
    );
  }

  /// Fetch complete timetable data (timetable + slots + lessons + related data)
  Future<Timetable?> fetchCompleteTimetableData() async {
    _log.info('Calling fetchCompleteTimetableData...');
    final timetable = await ClientHelper.apiCall(
      call: () => _client.timetable.fetchCompleteTimetableData(),
      errorMessage: 'Fehler beim Laden der vollständigen Stundenplandaten',
    );
    _log.info(
      'API: fetchCompleteTimetableData returned: ${timetable?.name} (ID: ${timetable?.id})',
    );
    _log.info('API: Timetable is null: ${timetable == null}');
    return timetable;
  }

  /// Fetch all timetables
  Future<List<Timetable>?> fetchTimetables() async {
    _log.info('API: Calling fetchTimetables...');
    final timetables = await ClientHelper.apiCall(
      call: () => _client.timetable.fetchTimetables(),
      errorMessage: 'Fehler beim Laden der Stundenpläne',
    );
    _log.info(
      'API: fetchTimetables returned: ${timetables?.length} timetables',
    );
    if (timetables != null) {
      for (final timetable in timetables) {
        _log.info('API: - Timetable: ${timetable.name} (ID: ${timetable.id})');
      }
    }
    return timetables;
  }

  // ============================================================================
  // TIMETABLE SLOT OPERATIONS
  // ============================================================================

  /// Fetch all timetable slots
  Future<List<TimetableSlot>?> fetchTimetableSlots() async {
    return await ClientHelper.apiCall(
      call: () => _client.timetableSlot.fetchTimetableSlots(),
      errorMessage: 'Fehler beim Laden der Zeitslots',
    );
  }

  /// Fetch timetable slots for a specific timetable
  Future<List<TimetableSlot>?> fetchTimetableSlotsByTimetableId(
    int timetableId,
  ) async {
    return await ClientHelper.apiCall(
      call: () =>
          _client.timetableSlot.fetchTimetableSlotsByTimetableId(timetableId),
      errorMessage: 'Fehler beim Laden der Zeitslots für den Stundenplan',
    );
  }

  /// Create a new timetable slot
  Future<TimetableSlot?> createTimetableSlot(TimetableSlot slot) async {
    return await ClientHelper.apiCall(
      call: () => _client.timetableSlot.createTimetableSlot(slot),
      errorMessage: 'Fehler beim Erstellen des Zeitslots',
    );
  }

  /// Update an existing timetable slot
  Future<TimetableSlot?> updateTimetableSlot(TimetableSlot slot) async {
    return await ClientHelper.apiCall(
      call: () => _client.timetableSlot.updateTimetableSlot(slot),
      errorMessage: 'Fehler beim Aktualisieren des Zeitslots',
    );
  }

  /// Delete a timetable slot
  Future<bool?> deleteTimetableSlot(int slotId) async {
    return await ClientHelper.apiCall(
      call: () => _client.timetableSlot.deleteTimetableSlot(slotId),
      errorMessage: 'Fehler beim Löschen des Zeitslots',
    );
  }

  // ============================================================================
  // SCHEDULED LESSON OPERATIONS
  // ============================================================================

  /// Fetch all scheduled lessons
  Future<List<ScheduledLesson>?> fetchScheduledLessons() async {
    return await ClientHelper.apiCall(
      call: () => _client.scheduledLesson.fetchScheduledLessons(),
      errorMessage: 'Fehler beim Laden der geplanten Stunden',
    );
  }

  /// Fetch scheduled lessons for a specific timetable
  Future<List<ScheduledLesson>?> fetchScheduledLessonsByTimetableId(
    int timetableId,
  ) async {
    return await ClientHelper.apiCall(
      call: () =>
          _client.scheduledLesson.fetchScheduledLessonsByTimetable(timetableId),
      errorMessage:
          'Fehler beim Laden der geplanten Stunden für den Stundenplan',
    );
  }

  /// Fetch scheduled lessons for a specific time slot
  Future<List<ScheduledLesson>?> fetchScheduledLessonsBySlotId(
    int slotId,
  ) async {
    return await ClientHelper.apiCall(
      call: () => _client.scheduledLesson.fetchScheduledLessonsBySlotId(slotId),
      errorMessage: 'Fehler beim Laden der geplanten Stunden für den Zeitslot',
    );
  }

  /// Create a new scheduled lesson
  Future<ScheduledLesson?> createScheduledLesson(ScheduledLesson lesson) async {
    final scheduledLesson = await ClientHelper.apiCall(
      call: () => _client.scheduledLesson.createScheduledLesson(lesson),
      errorMessage: 'Fehler beim Erstellen der geplanten Stunde',
    );
    return scheduledLesson;
  }

  /// Update an existing scheduled lesson
  Future<ScheduledLesson?> updateScheduledLesson(ScheduledLesson lesson) async {
    final scheduledLesson = await ClientHelper.apiCall(
      call: () => _client.scheduledLesson.updateScheduledLesson(lesson),
      errorMessage: 'Fehler beim Aktualisieren der geplanten Stunde',
    );
    return scheduledLesson;
  }

  /// Delete a scheduled lesson
  Future<bool?> deleteScheduledLesson(int lessonId) async {
    return await ClientHelper.apiCall(
      call: () => _client.scheduledLesson.deleteScheduledLesson(lessonId),
      errorMessage: 'Fehler beim Löschen der geplanten Stunde',
    );
  }

  // ============================================================================
  // LESSON GROUP OPERATIONS
  // ============================================================================

  /// Fetch all lesson groups
  Future<List<LessonGroup>?> fetchLessonGroups() async {
    return await ClientHelper.apiCall(
      call: () => _client.learningGroup.fetchLessonGroups(),
      errorMessage: 'Fehler beim Laden der Klassen',
    );
  }

  /// Fetch lesson groups for a specific timetable
  Future<List<LessonGroup>?> fetchLessonGroupsByTimetable(
    int timetableId,
  ) async {
    return await ClientHelper.apiCall(
      call: () =>
          _client.learningGroup.fetchLessonGroupsByTimetable(timetableId),
      errorMessage: 'Fehler beim Laden der Klassen für den Stundenplan',
    );
  }

  /// Fetch a specific lesson group by ID
  Future<LessonGroup?> fetchLessonGroupById(int lessonGroupId) async {
    final lessonGroup = await ClientHelper.apiCall(
      call: () => _client.learningGroup.fetchLessonGroupById(lessonGroupId),
      errorMessage: 'Fehler beim Laden der Klasse',
    );
    return lessonGroup;
  }

  /// Create a new lesson group
  Future<LessonGroup?> createLessonGroup(LessonGroup lessonGroup) async {
    return await ClientHelper.apiCall(
      call: () => _client.learningGroup.createLessonGroup(lessonGroup),
      errorMessage: 'Fehler beim Erstellen der Klasse',
    );
  }

  /// Update an existing lesson group
  Future<LessonGroup?> updateLessonGroup(LessonGroup lessonGroup) async {
    return await ClientHelper.apiCall(
      call: () => _client.learningGroup.updateLessonGroup(lessonGroup),
      errorMessage: 'Fehler beim Aktualisieren der Klasse',
    );
  }

  /// Delete a lesson group
  Future<bool?> deleteLessonGroup(int lessonGroupId) async {
    return await ClientHelper.apiCall(
      call: () => _client.learningGroup.deleteLessonGroup(lessonGroupId),
      errorMessage: 'Fehler beim Löschen der Klasse',
    );
  }

  // ============================================================================
  // CLASSROOM OPERATIONS
  // ============================================================================

  /// Fetch all classrooms
  Future<List<Classroom>?> fetchClassrooms() async {
    return await ClientHelper.apiCall(
      call: () => _client.classroom.fetchClassrooms(),
      errorMessage: 'Fehler beim Laden der Räume',
    );
  }

  /// Fetch a specific classroom by ID
  Future<Classroom?> fetchClassroomById(int classroomId) async {
    final classroom = await ClientHelper.apiCall(
      call: () => _client.classroom.fetchClassroomById(classroomId),
      errorMessage: 'Fehler beim Laden des Raums',
    );
    return classroom;
  }

  /// Create a new classroom
  Future<Classroom?> createClassroom(Classroom classroom) async {
    return await ClientHelper.apiCall(
      call: () => _client.classroom.createClassroom(classroom),
      errorMessage: 'Fehler beim Erstellen des Raums',
    );
  }

  /// Update an existing classroom
  Future<Classroom?> updateClassroom(Classroom classroom) async {
    return await ClientHelper.apiCall(
      call: () => _client.classroom.updateClassroom(classroom),
      errorMessage: 'Fehler beim Aktualisieren des Raums',
    );
  }

  /// Delete a classroom
  Future<bool?> deleteClassroom(int classroomId) async {
    return await ClientHelper.apiCall(
      call: () => _client.classroom.deleteClassroom(classroomId),
      errorMessage: 'Fehler beim Löschen des Raums',
    );
  }

  // ============================================================================
  // SUBJECT OPERATIONS
  // ============================================================================

  /// Fetch all subjects
  Future<List<Subject>?> fetchSubjects() async {
    return await ClientHelper.apiCall(
      call: () => _client.subject.fetchSubjects(),
      errorMessage: 'Fehler beim Laden der Fächer',
    );
  }

  /// Fetch a specific subject by ID
  Future<Subject?> fetchSubjectById(int subjectId) async {
    final subject = await ClientHelper.apiCall(
      call: () => _client.subject.fetchSubjectById(subjectId),
      errorMessage: 'Fehler beim Laden des Fachs',
    );
    return subject;
  }

  /// Create a new subject
  Future<Subject?> createSubject(Subject subject) async {
    return await ClientHelper.apiCall(
      call: () => _client.subject.createSubject(subject),
      errorMessage: 'Fehler beim Erstellen des Fachs',
    );
  }

  /// Update an existing subject
  Future<Subject?> updateSubject(Subject subject) async {
    return await ClientHelper.apiCall(
      call: () => _client.subject.updateSubject(subject),
      errorMessage: 'Fehler beim Aktualisieren des Fachs',
    );
  }

  /// Delete a subject
  Future<bool?> deleteSubject(int subjectId) async {
    return await ClientHelper.apiCall(
      call: () => _client.subject.deleteSubject(subjectId),
      errorMessage: 'Fehler beim Löschen des Fachs',
    );
  }

  // ============================================================================
  // SCHEDULED LESSON GROUP MEMBERSHIP OPERATIONS
  // ============================================================================

  /// Fetch all scheduled lesson group memberships
  Future<List<ScheduledLessonGroupMembership>?>
  fetchScheduledLessonGroupMemberships() async {
    return await ClientHelper.apiCall(
      call: () => _client.scheduledLessonGroupMembership
          .fetchScheduledLessonGroupMemberships(),
      errorMessage: 'Fehler beim Laden der Klassenmitgliedschaften',
    );
  }

  /// Fetch memberships for a specific lesson group
  Future<List<ScheduledLessonGroupMembership>?> fetchMembershipsByLessonGroupId(
    int lessonGroupId,
  ) async {
    return await ClientHelper.apiCall(
      call: () => _client.scheduledLessonGroupMembership
          .fetchMembershipsByLessonGroupId(lessonGroupId),
      errorMessage: 'Fehler beim Laden der Klassenmitgliedschaften',
    );
  }

  /// Create a new scheduled lesson group membership
  Future<ScheduledLessonGroupMembership?> createScheduledLessonGroupMembership(
    ScheduledLessonGroupMembership membership,
  ) async {
    return await ClientHelper.apiCall(
      call: () => _client.scheduledLessonGroupMembership
          .createScheduledLessonGroupMembership(membership),
      errorMessage: 'Fehler beim Erstellen der Klassenmitgliedschaft',
    );
  }

  /// Update an existing scheduled lesson group membership
  Future<ScheduledLessonGroupMembership?> updateScheduledLessonGroupMembership(
    ScheduledLessonGroupMembership membership,
  ) async {
    return await ClientHelper.apiCall(
      call: () => _client.scheduledLessonGroupMembership
          .updateScheduledLessonGroupMembership(membership),
      errorMessage: 'Fehler beim Aktualisieren der Klassenmitgliedschaft',
    );
  }

  /// Delete a scheduled lesson group membership
  Future<bool?> deleteScheduledLessonGroupMembership(int membershipId) async {
    return await ClientHelper.apiCall(
      call: () => _client.scheduledLessonGroupMembership
          .deleteScheduledLessonGroupMembership(membershipId),
      errorMessage: 'Fehler beim Löschen der Klassenmitgliedschaft',
    );
  }

  /// Delete a pupil from a lesson group
  Future<bool?> deletePupilFromLessonGroup(
    int lessonGroupId,
    int pupilDataId,
  ) async {
    return await ClientHelper.apiCall(
      call: () => _client.scheduledLessonGroupMembership
          .deletePupilFromLessonGroup(lessonGroupId, pupilDataId),
      errorMessage: 'Fehler beim Entfernen des Schülers aus der Klasse',
    );
  }

  // ============================================================================
  // BULK OPERATIONS
  // ============================================================================

  /// Update multiple pupil memberships for a lesson group
  Future<bool?> updatePupilMembershipsForLessonGroup(
    int lessonGroupId,
    List<int> pupilDataIds,
  ) async {
    return await ClientHelper.apiCall(
      call: () => _client.scheduledLessonGroupMembership
          .updatePupilMembershipsForLessonGroup(lessonGroupId, pupilDataIds),
      errorMessage: 'Fehler beim Aktualisieren der Klassenmitgliedschaften',
    );
  }
}
