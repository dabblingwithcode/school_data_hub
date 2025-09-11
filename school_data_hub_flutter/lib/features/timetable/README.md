# Timetable Feature

A comprehensive timetable management feature for the School Data Hub Flutter application.

## Overview

The timetable feature allows users to view and manage weekly schedules with support for multiple classes, subjects, rooms, and time slots. It provides an intuitive interface for creating, editing, and viewing lessons across different weekdays.

## Features

- **📅 Weekly View**: Interactive timetable grid with horizontal and vertical scrolling
- **📱 Responsive Design**: Optimized for mobile and tablet devices
- **🎨 Color-Coded Subjects**: Each subject has its own color for easy identification
- **🏫 Multi-Class Support**: Filter view by different lesson groups/classes
- **⏰ Flexible Time Slots**: Pre-configured time slots from 7:50 to 13:30
- **✏️ CRUD Operations**: Create, read, update, and delete scheduled lessons
- **🎯 Smart Navigation**: Tap on cells to add or edit lessons

## Architecture

The feature follows the established clean architecture pattern:

```
timetable/
├── data/
│   └── timetable_mock_data.dart          # Mock data generation
├── domain/
│   ├── timetable_manager.dart            # Main business logic
│   └── models/
│       └── timetable_proxy_models.dart   # Proxy models for UI
└── presentation/
    ├── timetable_page/
    │   └── timetable_page.dart           # Main timetable view
    ├── new_scheduled_lesson_page/
    │   └── new_scheduled_lesson_page.dart # Add/Edit lesson form
    ├── widgets/
    │   ├── timetable_grid.dart           # Main grid component
    │   ├── lesson_cell.dart              # Individual lesson cell
    │   ├── weekday_selector.dart         # Day selection chips
    │   └── lesson_group_selector.dart    # Class filter chips
    └── timetable_demo_page.dart          # Demo page
```

## Data Models

The feature uses the existing protocol models from the School Data Hub client:

- **TimetableSlot**: Represents a time slot (day + start/end time)
- **ScheduledLesson**: Represents a lesson scheduled in a time slot
- **Subject**: Represents a school subject with color coding
- **Classroom**: Represents a physical room/location
- **LessonGroup**: Represents a class or group of students
- **Weekday**: Enum for Monday through Friday

## Usage

### Basic Integration

```dart
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_page/timetable_page.dart';

// Navigate to timetable
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const TimetablePage(),
  ),
);
```

### Using the TimetableManager

```dart
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late TimetableManager _timetableManager;

  @override
  void initState() {
    super.initState();
    _timetableManager = TimetableManager();
    _initializeManager();
  }

  Future<void> _initializeManager() async {
    await _timetableManager.init();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ScheduledLesson>>(
      valueListenable: _timetableManager.scheduledLessons,
      builder: (context, lessons, child) {
        // Build your UI with the lessons
        return YourWidget();
      },
    );
  }
}
```

## Time Slots

The feature includes pre-configured time slots for a typical school day:

| Period | Start Time | End Time |
|--------|------------|----------|
| 1      | 07:50      | 08:15    |
| 2      | 08:15      | 09:00    |
| 3      | 09:00      | 09:45    |
| 4      | 09:45      | 10:30    |
| Break  | 10:30      | 10:50    |
| 5      | 10:50      | 11:15    |
| 6      | 11:15      | 12:00    |
| 7      | 12:00      | 12:45    |
| 8      | 12:45      | 13:30    |

## Mock Data

The feature includes comprehensive mock data for testing and development:

- **5 Subjects**: Mathematics, German, English, Science, PE (each with unique colors)
- **5 Classrooms**: Various room types including gym and lab
- **3 Lesson Groups**: Classes 5A, 5B, and 6A
- **Sample Lessons**: Pre-scheduled lessons across the week

## Navigation

The timetable page supports the following navigation patterns:

- **Empty Cell Tap**: Opens the new lesson form with the time slot pre-selected
- **Lesson Cell Tap**: Opens the edit lesson form with all data pre-filled
- **Add Button**: Opens the new lesson form
- **Weekday Chips**: Switch between different days of the week
- **Class Filter Chips**: Filter lessons by specific classes or view all

## Customization

### Adding Custom Time Slots

To modify the time slots, update the `generateMockTimetableSlots()` method in `timetable_mock_data.dart`:

```dart
final times = [
  {'start': '08:00', 'end': '08:45'},
  {'start': '08:45', 'end': '09:30'},
  // Add more time slots as needed
];
```

### Custom Colors

Subject colors can be customized in the `generateMockSubjects()` method:

```dart
Subject(
  id: 1,
  name: 'Mathematics',
  color: '#FF5722', // Custom hex color
  // ...
),
```

## Future Enhancements

- **📊 Statistics**: Lesson count per subject/teacher
- **🔍 Search**: Find specific lessons or time slots
- **📋 Export**: Export timetable to PDF or image
- **⚡ Conflicts**: Detect and highlight scheduling conflicts
- **👥 Teacher View**: Filter by teacher assignments
- **📱 Notifications**: Remind about upcoming lessons
- **🔄 Recurring Lessons**: Support for repeating lesson patterns

## Dependencies

The feature relies on the following packages:

- `flutter/material.dart` - UI components
- `school_data_hub_client` - Protocol models
- `watch_it` - State management utilities
- `collection` - Collection utilities

## Testing

To test the feature:

1. Navigate to the timetable demo page
2. Explore the weekly view with different class filters
3. Try adding, editing, and deleting lessons
4. Test horizontal and vertical scrolling
5. Verify color coding and responsive design

The mock data provides a realistic scenario for testing all functionality.
