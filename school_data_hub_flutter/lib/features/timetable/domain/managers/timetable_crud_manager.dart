import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/data/timetable_api_service.dart';
import 'package:watch_it/watch_it.dart';

/// Manages CRUD operations for timetable entities
class TimetableCrudManager extends ChangeNotifier {
  final _apiService = di<TimetableApiService>();

  TimetableCrudManager();

  // Scheduled Lesson CRUD operations
  Future<void> addScheduledLesson(ScheduledLesson lesson) async {
    try {
      print(
        'Creating scheduled lesson with timetableId: ${lesson.timetableId}',
      );
      final createdLesson = await _apiService.createScheduledLesson(lesson);
      if (createdLesson != null) {
        print(
          'Scheduled lesson created successfully: ${createdLesson.lessonId}',
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error creating scheduled lesson: $e');
      rethrow;
    }
  }

  Future<void> updateScheduledLesson(ScheduledLesson lesson) async {
    try {
      final updatedLesson = await _apiService.updateScheduledLesson(lesson);
      if (updatedLesson != null) {
        print(
          'Scheduled lesson updated successfully: ${updatedLesson.lessonId}',
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error updating scheduled lesson: $e');
      rethrow;
    }
  }

  Future<void> removeScheduledLesson(int lessonId) async {
    try {
      final success = await _apiService.deleteScheduledLesson(lessonId);
      if (success == true) {
        print('Scheduled lesson deleted successfully: $lessonId');
        notifyListeners();
      }
    } catch (e) {
      print('Error deleting scheduled lesson: $e');
      rethrow;
    }
  }

  // Subject CRUD operations
  Future<Subject?> addSubject(Subject subject) async {
    try {
      final createdSubject = await _apiService.createSubject(subject);
      if (createdSubject != null) {
        print('Subject created successfully: ${createdSubject.name}');
        notifyListeners();
      }
      return createdSubject;
    } catch (e) {
      print('Error creating subject: $e');
      rethrow;
    }
  }

  Future<Subject?> updateSubject(Subject subject) async {
    try {
      final updatedSubject = await _apiService.updateSubject(subject);
      if (updatedSubject != null) {
        print('Subject updated successfully: ${updatedSubject.name}');
        notifyListeners();
      }
      return updatedSubject;
    } catch (e) {
      print('Error updating subject: $e');
      rethrow;
    }
  }

  Future<void> removeSubject(int subjectId) async {
    try {
      final success = await _apiService.deleteSubject(subjectId);
      if (success == true) {
        print('Subject deleted successfully: $subjectId');
        notifyListeners();
      }
    } catch (e) {
      print('Error deleting subject: $e');
      rethrow;
    }
  }

  // Classroom CRUD operations
  Future<Classroom?> addClassroom(Classroom classroom) async {
    try {
      final createdClassroom = await _apiService.createClassroom(classroom);
      if (createdClassroom != null) {
        print('Classroom created successfully: ${createdClassroom.roomName}');
        notifyListeners();
      }
      return createdClassroom;
    } catch (e) {
      print('Error creating classroom: $e');
      rethrow;
    }
  }

  Future<Classroom?> updateClassroom(Classroom classroom) async {
    try {
      final updatedClassroom = await _apiService.updateClassroom(classroom);
      if (updatedClassroom != null) {
        print('Classroom updated successfully: ${updatedClassroom.roomName}');
        notifyListeners();
      }
      return updatedClassroom;
    } catch (e) {
      print('Error updating classroom: $e');
      rethrow;
    }
  }

  Future<void> removeClassroom(int classroomId) async {
    try {
      final success = await _apiService.deleteClassroom(classroomId);
      if (success == true) {
        print('Classroom deleted successfully: $classroomId');
        notifyListeners();
      }
    } catch (e) {
      print('Error deleting classroom: $e');
      rethrow;
    }
  }

  // Lesson Group CRUD operations
  Future<LessonGroup?> addLessonGroup(LessonGroup lessonGroup) async {
    try {
      print('Creating lesson group: ${lessonGroup.name}');
      final createdLessonGroup = await _apiService.createLessonGroup(
        lessonGroup,
      );
      if (createdLessonGroup != null) {
        print(
          'Lesson group created successfully: ${createdLessonGroup.name} (ID: ${createdLessonGroup.id})',
        );
        notifyListeners();
      }
      return createdLessonGroup;
    } catch (e) {
      print('Error creating lesson group: $e');
      rethrow;
    }
  }

  Future<LessonGroup?> updateLessonGroup(LessonGroup lessonGroup) async {
    try {
      final updatedLessonGroup = await _apiService.updateLessonGroup(
        lessonGroup,
      );
      if (updatedLessonGroup != null) {
        print('Lesson group updated successfully: ${updatedLessonGroup.name}');
        notifyListeners();
      }
      return updatedLessonGroup;
    } catch (e) {
      print('Error updating lesson group: $e');
      rethrow;
    }
  }

  Future<void> removeLessonGroup(int lessonGroupId) async {
    try {
      final success = await _apiService.deleteLessonGroup(lessonGroupId);
      if (success == true) {
        print('Lesson group deleted successfully: $lessonGroupId');
        notifyListeners();
      }
    } catch (e) {
      print('Error deleting lesson group: $e');
      rethrow;
    }
  }

  // Timetable CRUD operations
  Future<void> createTimetable(Timetable timetable) async {
    try {
      print('Creating timetable: ${timetable.name}');
      final createdTimetable = await _apiService.createTimetable(timetable);
      if (createdTimetable != null) {
        print(
          'Timetable created successfully: ${createdTimetable.name} (ID: ${createdTimetable.id})',
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error creating timetable: $e');
      rethrow;
    }
  }

  Future<void> updateTimetable(Timetable timetable) async {
    try {
      final updatedTimetable = await _apiService.updateTimetable(timetable);
      if (updatedTimetable != null) {
        print('Timetable updated successfully: ${updatedTimetable.name}');
        notifyListeners();
      }
    } catch (e) {
      print('Error updating timetable: $e');
      rethrow;
    }
  }

  Future<void> removeTimetable(int timetableId) async {
    try {
      final success = await _apiService.deleteTimetable(timetableId);
      if (success == true) {
        print('Timetable deleted successfully: $timetableId');
        notifyListeners();
      }
    } catch (e) {
      print('Error deleting timetable: $e');
      rethrow;
    }
  }

  // Timetable Slot CRUD operations
  Future<void> createTimetableSlot(TimetableSlot slot) async {
    try {
      final createdSlot = await _apiService.createTimetableSlot(slot);
      if (createdSlot != null) {
        print(
          'Timetable slot created successfully: ${createdSlot.day} ${createdSlot.startTime}-${createdSlot.endTime}',
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error creating timetable slot: $e');
      rethrow;
    }
  }

  Future<void> updateTimetableSlot(TimetableSlot slot) async {
    try {
      final updatedSlot = await _apiService.updateTimetableSlot(slot);
      if (updatedSlot != null) {
        print(
          'Timetable slot updated successfully: ${updatedSlot.day} ${updatedSlot.startTime}-${updatedSlot.endTime}',
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error updating timetable slot: $e');
      rethrow;
    }
  }

  Future<void> removeTimetableSlot(int slotId) async {
    try {
      final success = await _apiService.deleteTimetableSlot(slotId);
      if (success == true) {
        print('Timetable slot deleted successfully: $slotId');
        notifyListeners();
      }
    } catch (e) {
      print('Error deleting timetable slot: $e');
      rethrow;
    }
  }
}
