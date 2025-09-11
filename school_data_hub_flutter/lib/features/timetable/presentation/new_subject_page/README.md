# NewSubjectPage

A Flutter page for creating and editing subjects in the School Data Hub timetable system.

## Features

- **Create new subjects** with name, public ID, description, and color
- **Edit existing subjects** with pre-filled form data
- **Delete subjects** with confirmation
- **Color picker** with predefined color options
- **Form validation** for required fields
- **API integration** with fallback to local operations

## Usage

### Creating a New Subject
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const NewSubjectPage(),
  ),
);
```

### Editing an Existing Subject
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => NewSubjectPage(subject: existingSubject),
  ),
);
```

## Form Fields

### Name Field
- **Required**: Yes
- **Max length**: 100 characters
- **Hint**: "z.B. Mathematik"

### Public ID Field
- **Required**: Yes
- **Max length**: 20 characters
- **Format**: Uppercase letters and numbers only
- **Hint**: "z.B. MATH001"

### Description Field
- **Required**: No
- **Max length**: 500 characters
- **Multi-line**: Yes (3 lines)
- **Hint**: "z.B. Grundlegende Mathematik"

### Color Picker
- **Required**: No (defaults to red)
- **Options**: 10 predefined colors
- **Visual preview**: Color swatch with dropdown

## Architecture

### Widgets
- `NewSubjectPage` - Main page component
- `NameField` - Subject name input
- `PublicIdField` - Public ID input with validation
- `DescriptionField` - Optional description input
- `ColorPickerField` - Color selection with visual preview
- `ActionButtons` - Save, cancel, and delete buttons

### State Management
- Uses `watch_it` package for dependency injection
- Uses `createOnce` for form controllers and state
- Integrates with `TimetableManager` for data operations

### Data Flow
1. User fills out form
2. Validation checks required fields
3. Subject object created/updated
4. API call made via `TimetableManager`
5. Local fallback if API fails
6. UI updates and navigation back

## Integration

### TimetableManager Methods
- `addSubject(Subject subject)` - Create new subject
- `updateSubject(Subject subject)` - Update existing subject
- `removeSubject(int subjectId)` - Delete subject

### API Service
- `createSubject(Subject subject)` - API call to create
- `updateSubject(Subject subject)` - API call to update
- `deleteSubject(int subjectId)` - API call to delete

## Error Handling

- **Form validation** with user-friendly error messages
- **API error handling** with local fallback operations
- **Network error handling** with graceful degradation
- **Input validation** with real-time feedback

## Styling

- Follows app theme and color scheme
- Consistent with other "new" pages in the app
- Responsive design for different screen sizes
- Accessible color contrast ratios
