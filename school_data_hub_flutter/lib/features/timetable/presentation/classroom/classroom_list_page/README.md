# Classroom List Page

This page provides a comprehensive interface for managing classrooms in the timetable feature.

## Features

- **List all classrooms**: Display all available classrooms in a scrollable list
- **Edit classrooms**: Navigate to edit mode for existing classrooms
- **Delete classrooms**: Remove classrooms with confirmation dialog
- **Add new classrooms**: Navigate to create new classroom page
- **Responsive design**: Consistent layout with max-width constraints
- **Pull-to-refresh**: Refresh functionality for future data updates

## Structure

```
classroom_list_page/
├── classroom_list_page.dart                    # Main page widget
├── classroom_list.dart                         # Barrel exports
├── README.md                                   # This documentation
└── widgets/
    ├── classroom_list_card.dart                # Individual classroom card
    └── classroom_list_page_bottom_navbar.dart  # Bottom navigation bar
```

## Usage

### Navigation to the page
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ClassroomListPage(),
  ),
);
```

## Widgets

### ClassroomListPage
Main page widget that displays the list of classrooms.

**Features:**
- Uses `WatchingWidget` for reactive state management
- Integrates with `TimetableManager` for data access
- Provides navigation to create/edit classroom pages
- Handles delete confirmation dialogs

### ClassroomListCard
Individual card widget for displaying a classroom.

**Properties:**
- `classroom`: The classroom data to display
- `onEdit`: Callback for edit action
- `onDelete`: Callback for delete action

**Features:**
- Displays room code and name
- Shows room code in subtitle
- Provides edit and delete buttons
- Uses primary color for avatar background

### ClassroomListPageBottomNavBar
Bottom navigation bar with back and add buttons.

**Properties:**
- `onAddNewClassroom`: Callback for adding new classroom

**Features:**
- Back button for navigation
- Add button for creating new classrooms
- Consistent styling with other bottom nav bars

## State Management

The page uses `WatchingWidget` and `watchValue` for reactive state management:
- Watches `TimetableManager.classrooms` for real-time updates
- Automatically rebuilds when classroom data changes

## Integration

The page integrates with:
- `TimetableManager` for CRUD operations on classrooms
- `NewClassroomPage` for creating and editing classrooms
- `GenericAppBar` and `GenericSliverListWithEmptyListCheck` for consistent UI
- `BottomNavBarLayout` for consistent bottom navigation

## Navigation Flow

1. **List View**: Shows all classrooms with edit/delete options
2. **Edit Flow**: Tap classroom or edit button → `NewClassroomPage` in edit mode
3. **Create Flow**: Tap add button → `NewClassroomPage` in create mode
4. **Delete Flow**: Tap delete button → Confirmation dialog → Remove from manager

## Styling

- Uses `AppColors.canvasColor` for background
- Constrained to max-width of 700px for better readability
- Consistent card styling with 8px bottom margin
- Primary color for avatar backgrounds
- Blue edit icons and red delete icons
