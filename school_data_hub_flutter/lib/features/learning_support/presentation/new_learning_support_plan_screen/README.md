# New Learning Support Plan Page

This module implements a complete page for creating new learning support plans for pupils in the School Data Hub Flutter application.

## Structure

```
new_learning_support_plan/
├── index.dart                          # Main export file
├── new_learning_support_plan.dart     # Entry point widget
├── new_learning_support_plan_page.dart # UI implementation
└── controller/
    └── new_learning_support_plan_controller.dart # Business logic
```

## Features

- ✅ **Support Level Selection**: Choose from 3 support levels with descriptions
- ✅ **Plan ID Generation**: Auto-generates plan ID based on semester and pupil name
- ✅ **Comment Support**: Optional comments for additional notes
- ✅ **Semester Integration**: Automatically uses current school semester
- ✅ **Validation**: Form validation ensures required fields are filled
- ✅ **API Integration**: Creates support level history and learning support plan
- ✅ **Responsive UI**: Works on different screen sizes with max-width constraint
- ✅ **Consistent Theming**: Uses app's color scheme and styles

## Usage

### Basic Usage

```dart
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/new_learning_support_plan.dart';

// Navigate to create new learning support plan
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => NewLearningSupportPlan(pupil: pupil),
  ),
);
```

### Integration with Existing Pages

The page can be integrated into existing learning support workflows by adding navigation buttons or menu items that call the above navigation code.

## Architecture

The implementation follows the established patterns in the School Data Hub app:

1. **Separation of Concerns**: UI (Page) and Logic (Controller) are separated
2. **State Management**: Uses `ValueNotifier` for reactive UI updates
3. **API Integration**: Uses the existing `LearningSupportApiService` and `PupilManager`
4. **Dependency Injection**: Uses `watch_it` for service dependencies
5. **Error Handling**: Proper error messages through `NotificationService`

## API Flow

1. **Support Level Creation**: Creates a new support level entry in the pupil's history
2. **Plan Creation**: Creates the learning support plan linked to the support level and semester
3. **Success Handling**: Shows success notification and navigates back

## Dependencies

- `school_data_hub_client`: For API models and client
- `flutter/material.dart`: For UI components
- `gap`: For consistent spacing
- `watch_it`: For dependency injection

## Customization

The page can be customized by:

- Modifying support level descriptions in the UI
- Changing validation rules in the controller
- Updating the default plan ID generation logic
- Adding additional form fields as needed

## Testing

To test the implementation:

1. Ensure you have a valid pupil object
2. Ensure there's an active school semester
3. Navigate to the page and test different scenarios:
   - Valid form submission
   - Invalid form submission (missing fields)
   - Network errors during creation
   - Successfully created plans
