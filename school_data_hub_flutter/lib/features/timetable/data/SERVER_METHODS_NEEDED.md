# Server-Side Methods Needed for Timetable Feature

This document lists all the server-side methods that need to be implemented to support the timetable feature in the Flutter app.

## Overview

The timetable feature requires comprehensive CRUD operations for the following entities:
- **Timetable** - Main timetable container
- **TimetableSlot** - Time slots (day + start/end time)
- **ScheduledLesson** - Lessons scheduled in time slots
- **LessonGroup** - Classes or groups of students
- **Classroom** - Physical rooms/locations
- **Subject** - School subjects with color coding
- **ScheduledLessonGroupMembership** - Junction table for pupil memberships

## Required Server-Side Methods

### 1. Timetable Operations

```dart
// In server-side timetable endpoint
Future<Timetable?> fetchTimetable()
Future<Timetable?> createTimetable(Timetable timetable)
Future<Timetable?> updateTimetable(Timetable timetable)
Future<bool?> deleteTimetable(int timetableId)
Future<Timetable?> fetchCompleteTimetableData() // Includes all related data
```

### 2. TimetableSlot Operations

```dart
// In server-side timetableSlot endpoint
Future<List<TimetableSlot>?> fetchTimetableSlots()
Future<List<TimetableSlot>?> fetchTimetableSlotsByTimetableId(int timetableId)
Future<TimetableSlot?> createTimetableSlot(TimetableSlot slot)
Future<TimetableSlot?> updateTimetableSlot(TimetableSlot slot)
Future<bool?> deleteTimetableSlot(int slotId)
```

### 3. ScheduledLesson Operations

```dart
// In server-side scheduledLesson endpoint
Future<List<ScheduledLesson>?> fetchScheduledLessons()
Future<List<ScheduledLesson>?> fetchScheduledLessonsByTimetableId(int timetableId)
Future<List<ScheduledLesson>?> fetchScheduledLessonsBySlotId(int slotId)
Future<ScheduledLesson?> createScheduledLesson(ScheduledLesson lesson)
Future<ScheduledLesson?> updateScheduledLesson(ScheduledLesson lesson)
Future<bool?> deleteScheduledLesson(int lessonId)
```

### 4. LessonGroup Operations

```dart
// In server-side lessonGroup endpoint
Future<List<LessonGroup>?> fetchLessonGroups()
Future<LessonGroup?> fetchLessonGroupById(int lessonGroupId)
Future<LessonGroup?> createLessonGroup(LessonGroup lessonGroup)
Future<LessonGroup?> updateLessonGroup(LessonGroup lessonGroup)
Future<bool?> deleteLessonGroup(int lessonGroupId)
```

### 5. Classroom Operations

```dart
// In server-side classroom endpoint
Future<List<Classroom>?> fetchClassrooms()
Future<Classroom?> fetchClassroomById(int classroomId)
Future<Classroom?> createClassroom(Classroom classroom)
Future<Classroom?> updateClassroom(Classroom classroom)
Future<bool?> deleteClassroom(int classroomId)
```

### 6. Subject Operations

```dart
// In server-side subject endpoint
Future<List<Subject>?> fetchSubjects()
Future<Subject?> fetchSubjectById(int subjectId)
Future<Subject?> createSubject(Subject subject)
Future<Subject?> updateSubject(Subject subject)
Future<bool?> deleteSubject(int subjectId)
```

### 7. ScheduledLessonGroupMembership Operations

```dart
// In server-side scheduledLessonGroupMembership endpoint
Future<List<ScheduledLessonGroupMembership>?> fetchScheduledLessonGroupMemberships()
Future<List<ScheduledLessonGroupMembership>?> fetchMembershipsByLessonGroupId(int lessonGroupId)
Future<ScheduledLessonGroupMembership?> createScheduledLessonGroupMembership(ScheduledLessonGroupMembership membership)
Future<ScheduledLessonGroupMembership?> updateScheduledLessonGroupMembership(ScheduledLessonGroupMembership membership)
Future<bool?> deleteScheduledLessonGroupMembership(int membershipId)
Future<bool?> deletePupilFromLessonGroup(int lessonGroupId, int pupilDataId)
Future<bool?> updatePupilMembershipsForLessonGroup(int lessonGroupId, List<int> pupilDataIds)
```

## Implementation Priority

### High Priority (Core Functionality)
1. **Timetable operations** - Basic timetable management
2. **ScheduledLesson operations** - Core lesson scheduling
3. **LessonGroup operations** - Class management
4. **Classroom operations** - Room management

### Medium Priority (Enhanced Features)
5. **TimetableSlot operations** - Time slot management
6. **Subject operations** - Subject management
7. **ScheduledLessonGroupMembership operations** - Pupil membership management

## Data Models Required

Ensure these models are defined in your server-side protocol:

```dart
// Core models
class Timetable {
  int? id;
  bool active;
  DateTime startsAt;
  DateTime endsAt;
  String name;
  int schoolSemesterId;
  List<TimetableSlot>? timetableSlots;
  List<ScheduledLesson>? scheduledLessons;
  String createdBy;
  DateTime createdAt;
}

class TimetableSlot {
  int? id;
  Weekday day;
  String startTime;
  String endTime;
  int timetableId;
}

class ScheduledLesson {
  int? id;
  bool active;
  String publicId;
  int subjectId;
  Subject? subject;
  int scheduledAtId;
  TimetableSlot? scheduledAt;
  String lessonId;
  int roomId;
  Classroom? room;
  int lessonGroupId;
  LessonGroup? lessonGroup;
  int mainTeacherId;
  List<ScheduledLessonTeacher>? lessonTeachers;
  int timetableSlotOrder;
  String createdBy;
  DateTime createdAt;
  String modifiedBy;
  DateTime modifiedAt;
}

class LessonGroup {
  int? id;
  String publicId;
  String name;
  String? color;
  String createdBy;
  DateTime createdAt;
  String modifiedBy;
  DateTime modifiedAt;
}

class Classroom {
  int? id;
  String roomCode;
  String roomName;
}

class Subject {
  int? id;
  String publicId;
  String name;
  String? description;
  String? color;
  String createdBy;
  DateTime createdAt;
  String modifiedBy;
}

class ScheduledLessonGroupMembership {
  int? id;
  int lessonGroupId;
  int pupilDataId;
}

class ScheduledLessonTeacher {
  int userId;
  String role; // e.g., "main", "assistant"
}
```

## Integration with TimetableManager

Once these server-side methods are implemented, the `TimetableManager` can be updated to use the `TimetableApiService` instead of mock data. The manager will need to:

1. Replace mock data loading with API calls
2. Add proper error handling for network operations
3. Implement caching strategies for better performance
4. Add offline support if needed

## Testing Recommendations

1. **Unit tests** for each endpoint method
2. **Integration tests** for complex operations (e.g., creating a lesson with all related data)
3. **Error handling tests** for network failures, validation errors, etc.
4. **Performance tests** for bulk operations

## Security Considerations

1. **Authentication** - Ensure all endpoints require proper authentication
2. **Authorization** - Implement role-based access control (e.g., only teachers can create lessons)
3. **Validation** - Validate all input data on the server side
4. **Audit logging** - Log all CRUD operations for accountability
