# NewTimetablePage

## Overview

The `NewTimetablePage` is a presentation feature that allows users to create new timetables or edit existing ones. It provides a form-based interface for managing timetable data.

## Features

- **Create new timetables** with name, school semester, start date, and optional end date
- **Edit existing timetables** by passing a timetable object to the constructor
- **Form validation** for required fields and date formats
- **Integration with TimetableManager** for data persistence
- **Fallback to mock data** when API calls fail

## Usage

### Creating a new timetable:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const NewTimetablePage(),
  ),
);
```

### Editing an existing timetable:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => NewTimetablePage(timetable: existingTimetable),
  ),
);
```

## Form Fields

### Required Fields:
- **Name**: The name of the timetable
- **School Semester**: Dropdown to select the associated school semester
- **Start Date**: Date when the timetable becomes active (DD.MM.YYYY format)

### Optional Fields:
- **End Date**: Date when the timetable expires (DD.MM.YYYY format)

## Widgets

### Main Widgets:
- `NewTimetablePage`: Main page widget
- `ActionButtons`: Save, cancel, and delete buttons
- `NameField`: Text field for timetable name
- `SchoolSemesterDropdown`: Dropdown for selecting school semester
- `StartDateField`: Date field for start date
- `EndDateField`: Optional date field for end date

## Dependencies

- `TimetableManager`: For data operations
- `SchoolCalendarManager`: For accessing school semesters
- `TimetableApiService`: For API calls (via TimetableManager)

## Architecture

The page follows the project's architecture guidelines:
- Uses `WatchingWidget` for reactive UI updates
- Implements proper form validation
- Uses `createOnce` for form controllers and state management
- Follows the established UI patterns and styling

## Error Handling

- Form validation for required fields
- Date format validation (DD.MM.YYYY)
- API error handling with fallback to local operations
- User-friendly error messages via SnackBar

## Navigation

The page automatically navigates back to the previous screen after successful save operations. Users can also cancel to return without saving changes.
