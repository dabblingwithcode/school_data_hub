# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

This is a monorepo with four sub-projects:

- `school_data_hub_flutter/` — Flutter client (Android, Windows; WIP iOS/macOS/Linux)
- `school_data_hub_server/` — Serverpod 2.9.1 Dart backend
- `school_data_hub_client/` — Serverpod-generated shared client library (used by both Flutter and server)
- `school_data_hub_website/` — Project website

## Common Commands

### Flutter Client (`school_data_hub_flutter/`)

```bash
flutter run                        # Run on connected device/emulator
flutter test                       # Run all tests
flutter test test/path/to/test.dart  # Run a single test file
flutter analyze                    # Lint
flutter pub get                    # Install dependencies
```

### Server (`school_data_hub_server/`)

```bash
# Run locally (apply pending migrations on start)
dart run bin/main.dart --apply-migrations

# Shortcut via Makefile
make run

# After modifying .yaml model schemas — regenerate models + UML
make generate        # = serverpod generate + uml
make migration       # = serverpod generate + create-migration + apply + uml

# Start Docker (Postgres + Redis) for local dev
make docker          # = docker compose up --build --detach
```

### Release (Shorebird — from `school_data_hub_flutter/`)

```bash
shorebird release android --artifact=apk   # Full release
shorebird patch android                    # OTA patch
```

## Architecture

### Privacy-First Design

Personal pupil data (`PupilIdentity`) is **never stored on the server**. It is stored encrypted on each device (via `flutter_secure_storage`) and transferred between devices over an encrypted stream. The server only holds anonymous `PupilData` referenced by a numeric internal ID. API calls require both an authenticated session **and** the pupil's internal ID.

### Flutter Client Architecture

**Dependency Injection** uses `get_it` (accessed via the `di` global from `flutter_it`). Managers are registered in three ordered scopes:

1. **Core scope** (always registered, `InitManager.registerCoreManagers()`): `EnvManager`, `NotificationService`, `ServerpodConnectivityMonitor`, `ShorebirdUpdateManager`
2. **Active-env scope** (`InitScope.onActiveEnvScope`): registered in `InitOnActiveEnv` after an environment (school key) is set
3. **Auth scope** (`InitScope.onAuthScope`): registered in `InitOnUserAuth` after login — contains all feature managers (`PupilProxyManager`, `AttendanceManager`, etc.)
4. **Matrix scope** (`InitScope.onMatrixEnvScope`): lazily pushed when Matrix credentials are present

Scopes are dropped on logout/env-change and re-registered fresh. See `core/init/init_manager.dart` and `core/init/init_on_user_auth.dart` for the full dependency graph.

**State management** uses `watch_it` (`flutter_it` package). All managers extend `ChangeNotifier`. Widgets extend `WatchingWidget` (stateless) or `WatchingStatefulWidget` (stateful) and use:
- `watchValue((ManagerType x) => x.someValueNotifier)` — watch a `ValueNotifier` field
- `watch(someChangeNotifier)` — watch any `Listenable`

**The `PupilProxy` model** (`features/_pupil/domain/models/pupil_proxy.dart`) is the central reactive object. It combines:
- `PupilData` — server model from Serverpod, fetched via `PupilDataApiService`
- `PupilIdentity` — local personal data (name, class, birthday, etc.) managed by `PupilIdentityManager`

`PupilProxyManager` holds the master list of all proxies, keeps them updated via the `HubStreamService` server-sent event stream, and re-fetches on reconnect.

**Feature structure** follows `data / domain / presentation` layers:
- `data/` — API service classes (one per feature, calling Serverpod endpoints via `school_data_hub_client`)
- `domain/` — manager singletons, domain models, filter managers
- `presentation/` — pages and widgets

**Real-time updates** flow through `HubStreamService`, which wraps a Serverpod streaming endpoint. Managers subscribe to this stream and handle `PupilData` (upsert) and `HubReconnected` (re-fetch) events.

**Filtering** is done through a hierarchy of filter managers (`PupilsFilter`, `PupilFilterManager`, feature-specific filter managers). `PupilsFilter` is the aggregate filter used to produce the filtered list shown in UIs. Migration to the `PupilsFilter` architecture is in progress — some older features still use ad-hoc filtering.

**Navigation** uses a bottom navigation bar with 5 tabs: Pupil Lists, School Lists, Learning Resources, Tools, Settings. Individual features navigate imperatively (no `go_router` routing in use for main flow; `go_router` is listed as a dependency but is a WIP).

### Server Architecture

Built on **Serverpod 2.9.1**. Model schemas live in `lib/src/_features/<feature>/schemas/` as `.yaml` files. Running `serverpod generate` produces Dart classes in `lib/src/generated/` and the client library in `school_data_hub_client/`.

Features mirror the Flutter client: `_attendance`, `_authorizations`, `_pupil`, `_school_lists`, `_schoolday_events`, `books`, `learning`, `learning_support`, `matrix`, `timetable`, `user`, `workbooks`, etc.

Encrypted files (documents, images) are stored in `storage/private/` subdirectories (`avatars`, `documents`, `events`, `auths`).

### Local Development Setup

Server URL in the school key:
- **Windows**: `http://127.0.0.1:5000/api`
- **Android Emulator**: `http://10.0.2.2:5000/api`

The server requires Docker running (Postgres + Redis). Start with `make docker` from `school_data_hub_server/`, then `make run` to apply migrations and start the Dart server.

## Key Conventions

- `di<SomeManager>()` — access any registered singleton anywhere in the Flutter app
- Managers own their API service instances directly (instantiated in the manager, not DI-registered separately, unless shared)
- Use `_log = Logger('FeatureName')` in every class; logs are collected by `LogService` and visible in the in-app log viewer
- Server model changes: edit the `.yaml` schema → `make migration` → never hand-edit generated files in `lib/src/generated/`
- All `.dart` files in `school_data_hub_client/` are generated — do not edit them directly
