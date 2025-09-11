# SubjectListPage

A Flutter page for viewing and managing subjects in the School Data Hub timetable system.

## Features

- **List all subjects** in a scrollable list view
- **Subject cards** with color indicators, names, descriptions, and IDs
- **Tap to edit** - Navigate to NewSubjectPage for editing
- **Add new subjects** via bottom navigation button
- **Empty state** when no subjects are available
- **Reactive UI** - Automatically updates when subjects change

## Usage

### Navigation to SubjectListPage
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const SubjectListPage(),
  ),
);
```

## Architecture

### Widgets
- `SubjectListPage` - Main page component
- `SubjectList` - List view of subjects with empty state handling
- `SubjectListCard` - Individual subject card with tap functionality
- `SubjectListPageBottomNavBar` - Bottom navigation with back and add buttons

### State Management
- Uses `watch_it` package for dependency injection
- Uses `watch()` to observe `TimetableManager.subjects`
- Automatically rebuilds when subject data changes

### Data Flow
1. Page loads and watches `TimetableManager.subjects`
2. Displays subjects in list or empty state
3. User can tap subjects to edit them
4. User can add new subjects via bottom nav
5. Navigation to `NewSubjectPage` for create/edit operations

## UI Components

### SubjectListCard
- **Color indicator** - Shows subject color as a small circle
- **Subject name** - Bold, prominent display
- **Description** - Optional, smaller text below name
- **Public ID** - Monospace font, smaller text
- **Tap target** - Entire card is tappable
- **Visual feedback** - InkWell effect on tap

### Empty State
- **Icon** - Subject icon in grey
- **Message** - "Keine Fächer verfügbar"
- **Subtitle** - "Erstellen Sie ein neues Fach"
- **Centered layout** - Clean, minimal design

### Bottom Navigation
- **Back button** - Returns to previous page
- **Add button** - Creates new subject
- **Consistent styling** - Matches app theme

## Integration

### TimetableManager
- **Watches** `subjects` ValueListenable
- **Reactive updates** when subjects are added/removed/modified
- **No direct data manipulation** - All operations go through NewSubjectPage

### Navigation
- **From TimetablePage** - "Fächer verwalten" button
- **To NewSubjectPage** - For creating/editing subjects
- **Back navigation** - Returns to TimetablePage

## Styling

- **Consistent with app theme** - Uses AppColors and theme colors
- **Card-based design** - Elevated cards with rounded corners
- **Color indicators** - Visual representation of subject colors
- **Responsive layout** - Works on different screen sizes
- **Accessible** - Proper contrast and touch targets

## Error Handling

- **Empty state handling** - Graceful display when no subjects exist
- **Color parsing** - Fallback to grey if color parsing fails
- **Navigation safety** - Proper context handling

## Performance

- **ListView.builder** - Efficient rendering for large lists
- **Minimal rebuilds** - Only rebuilds when subject data changes
- **Lazy loading** - Cards are created only when visible
