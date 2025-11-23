# School Data Hub Flutter Client

The Flutter cross-platform client application for School Data Hub. This app provides the user interface for managing school information flows, working in conjunction with the School Data Hub Server.

## Overview

The Flutter client is a cross-platform application supporting:
- **Desktop**: Windows, Linux, macOS
- **Mobile**: Android, iOS
- **Web**: (Limited support)

It implements a privacy-first architecture where sensitive pupil data is stored locally on each device and never uploaded to the server.

**Shorebird Integration**: The client uses Shorebird for over-the-air (OTA) code push updates, allowing for rapid deployment of bug fixes and feature updates without requiring app store releases.

## Prerequisites

- **Flutter SDK**: >=3.19.0
- **Dart SDK**: >=3.8.0
- **Serverpod**: The project uses Serverpod 2.9.1 for backend communication
- **School Data Hub Client**: A local dependency (`../school_data_hub_client`)

## Getting Started

### Installation

1. Clone the repository and navigate to the Flutter client directory:
   ```bash
   cd school_data_hub_flutter
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Ensure the `school_data_hub_client` package is generated. You may need to run `serverpod generate` in the parent directory first.

### Running the App

#### Development Mode

Run the app in development mode:
```bash
flutter run
```

For a specific platform:
```bash
# Windows
flutter run -d windows

# Android
flutter run -d android

# iOS (macOS only)
flutter run -d ios

# Linux
flutter run -d linux

# macOS
flutter run -d macos
```

#### Local Development Server Connection

When connecting to a local development server:
- **Windows**: Use `http://127.0.0.1:5000/api` as the server URL
- **Android Emulator**: Use `http://10.0.2.2:5000/api` as the server URL

Configure this in your school key JSON during initial setup.

## Architecture

### Project Structure

The project follows a feature-based architecture:

```
lib/
├── app_utils/          # Application-level utilities
├── common/             # Shared widgets and utilities
├── core/               # Core functionality (DI, session, env)
├── features/           # Feature modules
│   ├── _attendance/    # Attendance management
│   ├── _schoolday_events/  # Schoolday events
│   ├── app_entry_point/    # Login and entry flow
│   ├── app_main_navigation/  # Main navigation
│   ├── app_settings/   # Settings
│   ├── authorizations/ # Authorization management
│   ├── books/          # Library management
│   ├── learning/       # Competence tracking
│   ├── learning_support/  # Learning support plans
│   ├── matrix/         # Matrix integration
│   ├── pupil/          # Pupil profiles and data
│   ├── school/         # School data management
│   ├── school_calendar/  # Calendar management
│   ├── school_lists/   # School lists
│   ├── timetable/      # Timetable management
│   ├── user/           # User management
│   └── workbooks/      # Workbook management
└── l10n/               # Localization files
```

Each feature follows a clean architecture pattern:
- `data/` - API services and data access
- `domain/` - Business logic and managers
- `presentation/` - UI components and pages

### State Management

The project uses `watch_it` (1.7.0) for dependency injection and state management:
- Dependency injection via `watch_it`'s `di` container
- ValueListenable-based reactive state management
- Watching widgets with `WatchItMixin`

### Key Technologies

- **Serverpod Flutter**: 2.9.1 - Backend communication
- **watch_it**: 1.7.0 - Dependency injection and state management
- **flutter_secure_storage**: 10.0.0-beta.1 - Secure local storage
- **encrypt**: 5.0.3 - Data encryption
- **pdf**: 3.11.3 - PDF generation
- **Shorebird**: 2.0.4 - Code push for over-the-air updates

## Development

### Code Generation

Generate JSON serialization code:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running Tests

Run all tests:
```bash
flutter test
```

### Code Analysis

Run the analyzer:
```bash
flutter analyze
```

### Shorebird Code Push

The project uses Shorebird for over-the-air (OTA) code push updates, allowing rapid deployment of bug fixes and features without app store releases.

#### Prerequisites

1. Install Shorebird CLI:
   ```bash
   dart pub global activate shorebird_cli
   ```

2. Login to Shorebird:
   ```bash
   shorebird login
   ```

3. Ensure `shorebird.yaml` is configured with your app ID.

#### Building with Shorebird

##### Initial Release (First Build)

When creating the first release of a version, you need to build and release through Shorebird:

**Android APK:**
```bash
make release_android
```

Or manually:
```bash
shorebird release android --artifact=apk
```

**Windows:**
```bash
shorebird release windows --release-version=0.5.1+1
```

**iOS (macOS only):**
```bash
shorebird release ios
```

The initial release creates a baseline version that patches can be applied to.

##### Creating Patches

After an initial release, you can create patches for incremental updates:

**Android:**
```bash
make patch_android
```

Or manually:
```bash
shorebird patch android
```

**Windows:**
```bash
make patch_windows
```

Or manually:
```bash
shorebird patch windows --platforms=windows --release-version=0.5.1+1
```

**iOS (macOS only):**
```bash
shorebird patch ios
```

Patches allow you to update Dart code, assets, and some native code without rebuilding the entire app or going through app store review.

#### Shorebird Configuration

The Shorebird configuration is managed in `shorebird.yaml`:
- **app_id**: Unique identifier for your app
- **auto_update**: Controls automatic updates (currently enabled by default)

See `shorebird.yaml` for current configuration.

#### Version Management

When releasing a new version (not a patch), update the version in:
1. `pubspec.yaml` - Update the version number
2. Update the `--release-version` flag in Makefile commands if needed
3. Create a new release (not a patch) for the new version

#### Build Workflow

1. **New Version Release**:
   - Update version in `pubspec.yaml`
   - Build and release: `make release_android` (or platform-specific command)
   - This creates a new baseline version

2. **Incremental Updates**:
   - Make code changes
   - Create patch: `make patch_android` (or platform-specific command)
   - Patches are automatically distributed to users

#### Limitations

Shorebird patches have limitations:
- Cannot change native code (iOS/Android native code)
- Cannot change Flutter version
- Cannot change Dart version
- Cannot change signing keys
- Major architectural changes may require a new release

For changes that patches don't support, create a new release version.

## Configuration

### School Keys

The app requires school keys for initialization. See the main README.md for details on school key format and distribution.

### Environment Management

The app supports multiple server environments (development, staging, production) managed through the `EnvManager`.

### Localization

Localization files are located in `lib/l10n/`. The project uses Flutter's built-in localization system with ARB files.

## Known Issues & TODOs

- **Mail Notifications**: Email notification system implementation
- **Manager Reinitialization**: Handle manager reinitialization when changing instances or logging out
- **Offline Support**: Handle 'no internet connection' scenarios
- **Internationalization**: Expand language support
- **Theme System**: Implement comprehensive theme system
- **Navigation**: Review and improve navigation patterns
- **Shorebird iOS**: iOS support for Shorebird patches (currently Android and Windows supported)

## Building for Distribution

All production builds must be created using Shorebird. This enables over-the-air (OTA) updates and is the required build method for distribution.

### Android

**Initial Release:**
```bash
make release_android
```

Or manually:
```bash
shorebird release android --artifact=apk
```

**Patches:**
```bash
make patch_android
```

Or manually:
```bash
shorebird patch android
```

### Windows

**Initial Release:**
```bash
shorebird release windows --release-version=0.5.1+1
```

**Patches:**
```bash
make patch_windows
```

Or manually:
```bash
shorebird patch windows --platforms=windows --release-version=0.5.1+1
```

### iOS (macOS only)

**Initial Release:**
```bash
shorebird release ios
```

**Patches:**
```bash
shorebird patch ios
```

**Note**: Always build releases and patches using Shorebird. Standard Flutter builds are not used for distribution as they lack OTA update capability.

## Troubleshooting

### Common Issues

1. **Missing school_data_hub_client**: Ensure you've run `serverpod generate` in the server directory first.

2. **Connection Issues**: Verify your server URL in the school key matches your development server address.

3. **Secure Storage Errors**: Some platforms may require additional permissions. Check platform-specific documentation.

4. **Shorebird Build Errors**: 
   - Ensure you're logged in: `shorebird login`
   - Verify your `shorebird.yaml` has the correct app_id
   - Check that you've created an initial release before trying to create patches
   - For version mismatches, ensure the `--release-version` matches your `pubspec.yaml` version

5. **Shorebird Patch Issues**:
   - Patches can only be created from the most recent release
   - If you've made changes that patches don't support, create a new release instead
   - Ensure your code changes are compatible with the base release version

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Serverpod Documentation](https://serverpod.dev)
- [watch_it Package](https://pub.dev/packages/watch_it)
- [Shorebird Documentation](https://shorebird.dev)
- [Main README](../README.md)
