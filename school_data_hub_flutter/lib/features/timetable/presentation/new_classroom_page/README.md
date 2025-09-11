# New Classroom Page

This page allows users to create and edit classrooms in the timetable feature.

## Features

- **Create new classrooms**: Add new classrooms with room code and room name
- **Edit existing classrooms**: Modify room code and room name of existing classrooms
- **Delete classrooms**: Remove classrooms with confirmation dialog
- **Form validation**: Ensures all required fields are filled

## Structure

```
new_classroom_page/
├── new_classroom_page.dart          # Main page widget
├── README.md                        # This documentation
└── widgets/
    ├── action_buttons.dart          # Save, cancel, delete buttons
    ├── room_code_field.dart         # Room code input field
    └── room_name_field.dart         # Room name input field
```

## Usage

### Creating a new classroom
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const NewClassroomPage(),
  ),
);
```

### Editing an existing classroom
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => NewClassroomPage(classroom: existingClassroom),
  ),
);
```

## Widgets

### NewClassroomPage
Main page widget that handles the classroom creation/editing form.

**Properties:**
- `classroom`: Optional existing classroom for editing mode

### RoomCodeField
Text input field for the room code (e.g., "A101", "B205").

### RoomNameField
Text input field for the room name (e.g., "Klassenraum A101").

### ActionButtons
Button group containing:
- Save/Update button
- Cancel button
- Delete button (only shown in edit mode)

## State Management

The page uses `WatchingWidget` and `createOnce` for state management:
- Form key and text controllers are created using `createOnce`
- State is managed reactively through the `TimetableManager`

## Integration

The page integrates with:
- `TimetableManager` for CRUD operations on classrooms
- Consistent styling with `AppStyles` and `AppColors`
- Navigation patterns used throughout the app
