# Learning Group List Page

## Overview

The `LearningGroupListPage` provides a comprehensive interface for managing lesson groups (classes) in the timetable system. It allows users to view, edit, delete, and create new lesson groups.

## Features

### 📋 **List View**
- Displays all existing lesson groups in a card-based layout
- Shows group name, color, and management options
- Color-coded avatars for easy visual identification
- Responsive design with proper spacing and typography

### ➕ **Add New Groups**
- Floating action button for quick access to group creation
- Navigates to `NewLessonGroupPage` for detailed group setup
- Consistent with Material Design guidelines

### ✏️ **Edit Existing Groups**
- Tap on any group card to edit its details
- Edit button in the trailing area for quick access
- Navigates to `NewLessonGroupPage` in edit mode

### 🗑️ **Delete Groups**
- Delete button with confirmation dialog
- Prevents accidental deletions with clear warning messages
- Immediate UI updates after deletion
- Success feedback via SnackBar

### 📱 **Empty State**
- Helpful empty state when no groups exist
- Clear call-to-action to create the first group
- Consistent with app design language

## Usage

### Navigation
```dart
// Navigate to the learning group list page
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const LearningGroupListPage(),
  ),
);
```

### Integration
The page is integrated into the timetable feature through:
- **Lesson Group Selector**: "Klassen verwalten" button
- **Bottom Navigation**: Accessible from timetable page
- **Direct Navigation**: From other parts of the app

## State Management

### Reactive Updates
- Uses `watch_it` for reactive state management
- Automatically updates when lesson groups are modified
- Real-time synchronization with `TimetableManager`

### Data Flow
```
TimetableManager.lessonGroups → LearningGroupListPage → UI Updates
```

## UI Components

### Card Layout
- **Leading**: Color-coded avatar with group initial
- **Title**: Group name with bold typography
- **Subtitle**: Color information
- **Trailing**: Edit and delete action buttons

### Color System
- Uses `TimetableUtils.parseColor()` for consistent color parsing
- Fallback to theme primary color for groups without custom colors
- Proper contrast for accessibility

### Responsive Design
- Adapts to different screen sizes
- Proper padding and margins
- Scrollable content for long lists

## Error Handling

### Delete Confirmation
- Confirmation dialog before deletion
- Clear warning about irreversible action
- Cancel option for safe operation

### Navigation Safety
- Proper context handling
- Safe navigation with null checks
- Error boundaries for robust operation

## Accessibility

### Screen Reader Support
- Proper tooltips for action buttons
- Semantic labels for interactive elements
- Clear navigation structure

### Visual Design
- High contrast colors
- Proper touch targets (44dp minimum)
- Clear visual hierarchy

## Dependencies

### Core Dependencies
- `flutter/material.dart` - UI framework
- `watch_it` - State management
- `school_data_hub_client` - Data models

### Internal Dependencies
- `TimetableManager` - Business logic
- `NewLessonGroupPage` - Group creation/editing
- `TimetableUtils` - Utility functions

## Future Enhancements

### Potential Improvements
- **Search/Filter**: Add search functionality for large lists
- **Sorting**: Sort by name, creation date, or usage
- **Bulk Operations**: Select multiple groups for batch operations
- **Statistics**: Show group usage statistics
- **Import/Export**: Support for data import/export

### Performance Optimizations
- **Lazy Loading**: For large datasets
- **Caching**: Optimize repeated data access
- **Virtual Scrolling**: For very long lists
