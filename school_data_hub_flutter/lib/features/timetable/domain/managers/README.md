# Timetable Manager Refactoring

## Overview

The original `TimetableManager` class was a large monolithic class (1307 lines) that handled multiple responsibilities. It has been refactored into smaller, focused classes following the Single Responsibility Principle.

## Architecture

### Main Manager
- **`TimetableManager`** (`timetable_manager_refactored.dart`) - Orchestrates all sub-managers and provides a unified interface

### Sub-Managers

#### 1. **TimetableDataManager** (`timetable_data_manager.dart`)
- **Responsibility**: Data loading, API calls, and state management
- **Key Features**:
  - Loads data from API with fallback to mock data
  - Manages timetable, slots, subjects, classrooms, lesson groups, and scheduled lessons
  - Handles data refresh and initialization
  - Maintains lookup maps for quick access

#### 2. **TimetableCrudManager** (`timetable_crud_manager.dart`)
- **Responsibility**: CRUD operations for all timetable entities
- **Key Features**:
  - Create, read, update, delete operations for scheduled lessons
  - CRUD operations for subjects, classrooms, lesson groups, timetables, and slots
  - API communication with error handling
  - Logging for debugging

#### 3. **TimetableUiManager** (`timetable_ui_manager.dart`)
- **Responsibility**: UI state management, filtering, and weekday selection
- **Key Features**:
  - Manages selected weekday and lesson group filters
  - Builds weekday proxies for UI display
  - Handles lesson group selection and filtering
  - Provides utility methods for UI components

#### 4. **TimetableLessonManager** (`timetable_lesson_manager.dart`)
- **Responsibility**: Business logic for lesson operations
- **Key Features**:
  - Lesson ordering and positioning logic
  - Slot management and conflict detection
  - Time period calculations
  - Lesson manipulation utilities

#### 5. **TimetableMembershipManager** (`timetable_membership_manager.dart`)
- **Responsibility**: Lesson group membership operations
- **Key Features**:
  - Manages pupil memberships in lesson groups
  - Add/remove pupils from groups
  - Membership validation and queries

## Benefits of Refactoring

### 1. **Maintainability**
- Each manager has a single, clear responsibility
- Easier to locate and modify specific functionality
- Reduced cognitive load when working on specific features

### 2. **Testability**
- Smaller classes are easier to unit test
- Each manager can be tested in isolation
- Mock dependencies more easily

### 3. **Reusability**
- Individual managers can be used independently
- Better separation of concerns allows for more flexible usage
- Easier to extend or modify specific functionality

### 4. **Code Organization**
- Clear separation of data, business logic, and UI concerns
- Better adherence to SOLID principles
- More modular architecture

## Usage

### Basic Usage
```dart
final timetableManager = TimetableManager();
await timetableManager.init();

// Access data
final timetable = timetableManager.timetable.value;
final subjects = timetableManager.subjects.value;

// Perform operations
await timetableManager.addSubject(newSubject);
await timetableManager.createTimetable(newTimetable);
```

### UI State Management
```dart
// Select weekday
timetableManager.selectWeekday(Weekday.monday);

// Filter by lesson group
timetableManager.selectLessonGroup(someLessonGroup);

// Get filtered data
final currentWeekday = timetableManager.getCurrentWeekdayProxy();
```

### Lesson Operations
```dart
// Get lessons for a slot
final lessons = timetableManager.getAllLessonsForSlot(slotId);

// Insert lesson at position
timetableManager.insertLessonAtPosition(lesson, targetSlotId, targetPosition);
```

## Migration Notes

### From Original TimetableManager
The refactored `TimetableManager` maintains the same public interface as the original, so existing code should work without changes. The main differences are:

1. **Internal Architecture**: The implementation is now split across multiple managers
2. **Data Refresh**: CRUD operations now trigger a full data refresh to ensure consistency
3. **Error Handling**: Better error handling and logging throughout

### Future Improvements
1. **Direct State Updates**: Expose underlying ValueNotifier for more efficient state updates
2. **Caching**: Implement caching strategies for better performance
3. **Event System**: Add event system for better decoupling
4. **Validation**: Add comprehensive validation logic

## File Structure
```
lib/features/timetable/domain/
├── managers/
│   ├── README.md
│   ├── timetable_data_manager.dart
│   ├── timetable_crud_manager.dart
│   ├── timetable_ui_manager.dart
│   ├── timetable_lesson_manager.dart
│   └── timetable_membership_manager.dart
├── timetable_manager.dart (original)
└── timetable_manager_refactored.dart (new)
```
