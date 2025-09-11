# New Lesson Group Page

This page allows users to create and edit lesson groups (classes) in the timetable system.

## Features

- **Create new lesson groups** with name and color selection
- **Edit existing lesson groups** with pre-filled form data
- **Delete lesson groups** with validation to prevent deletion of groups in use
- **Color picker** with predefined color options
- **Form validation** for required fields
- **Real-time state management** using `watch_it`

## Usage

### Creating a new lesson group

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => NewLessonGroupPage(
      timetableManager: timetableManager,
    ),
  ),
);
```

### Editing an existing lesson group

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => NewLessonGroupPage(
      timetableManager: timetableManager,
      editingLessonGroupId: lessonGroupId,
    ),
  ),
);
```

## Components

### Main Page
- `new_lesson_group_page.dart` - Main page with form and state management

### Widgets
- `name_field.dart` - Text field for lesson group name
- `color_picker_field.dart` - Color selection with predefined options
- `action_buttons.dart` - Save, cancel, and delete buttons

## Form Fields

1. **Name** (required) - The name of the lesson group (e.g., "Klasse 5a")
2. **Color** (required) - Visual color for the lesson group in the timetable

## Validation

- Name field is required and cannot be empty
- Color selection is required
- Cannot delete lesson groups that are used in scheduled lessons

## State Management

The page uses `watch_it` for reactive state management and integrates with the `TimetableManager` for data persistence.

## Integration

The page integrates with the existing timetable system through the `TimetableManager` class, which provides:
- `addLessonGroup()` - Add new lesson groups
- `updateLessonGroup()` - Update existing lesson groups  
- `removeLessonGroup()` - Remove lesson groups
- `lessonGroups` - Observable list of all lesson groups
