# School Data Hub

A comprehensive software tool for managing school information flows between teachers and administrative staff in an effective, collaborative way.

## What does it do?

School Data Hub integrates with data exported from the NRW Education ministry software ([SVWS](https://www.svws.nrw.de/)) to build extended models of pupils in the backend without uploading any personal data to the server. The backend models are then used to add and manage additional information collaboratively.

## Architecture & Data Protection

### Privacy-First Approach

School Data Hub implements a privacy-first architecture by **decoupling personal information from the database**. Instead of storing personal data on the server, this information is **stored locally on each device and shared through secure data transport between devices**.

### How It Works

1. **Initial Setup**: When the client is installed, it requires school keys to function. Without these keys, the client cannot access any functionality.

2. **School Key Distribution**: As a security measure, school keys are stored securely in the school's administrative office. Users must visit the office at least once to obtain access. Users scan school keys containing the server URL and encryption keys. These are stored in the device's secure storage.

3. **Authentication**: After scanning the keys, users can log in with their credentials. However, even after login, no pupil data will be available.

4. **Pupil Data Import**: Users must obtain pupil credentials by transferring them from another device (typically from a desktop version of the app), or by importing from an Excel template. These credentials are stored in secure storage. API calls require both authenticated access **and** the pupil's internal id.

### Real-Time Collaboration

Changes made by one user are pushed in real-time to all connected clients via `HubStreamService`, a server-sent event stream built on Serverpod streaming. This ensures that attendance records, schoolday events, authorizations, competence data, and learning support updates are immediately visible to all colleagues.

### Encrypted Data

The following data is encrypted:
- All stored files on the server
- Sensitive information text, like special needs support strings
- Encryption is gradually being migrated to an updated format; the client handles this transparently

## Features

### Attendance Management

Track student attendance with comprehensive details:
- Presence/absence status
- Minutes late
- Excused/unexcused absences
- Early departures (e.g., due to illness)
- Parent contact status (reached/not reached)
- Text remarks

### Schoolday Events

Document and track schoolday events with photo and audio attachments. Events can include:
- Admonitions
- Accident reports
- Parent meetings
- Any other incidents associated with pupils
- Event type icons for quick visual identification

### School Lists

Create private (user-specific) or public checklists to track various tasks and requirements:
- Payment confirmations (e.g., day trips)
- Signed forms from parents
- Any other administrative tasks
- Includes comment fields for additional notes

### Authorizations

Manage authorizations with document attachments. This feature is used for:
- Signed authorizations from parents/guardians
- Any other authorization documents requiring record-keeping

### Accounts & Currency System

Manage a school-specific currency system used as a reward mechanism. Students can earn currency and purchase items from the school shop, including:
- School merchandise (t-shirts, buttons)
- School supplies (pencils, erasers)
- Small games and activities (frisbees, etc.)
- Credit transaction history chart (WIP)

### Special Information (WIP)

Access special information - authorized by parents/guardians - that all staff need to know about students:
- Allergies
- Emergency medication requirements
- Medical conditions (e.g., epilepsy risk)
- Other critical health or safety information

### Individual Learning Support

Document and track individual learning support plans for pupils. This feature supports inclusive education by:

- **Flexible Support Category System**: Works with any category tree structure, allowing schools to use their own categorization system
- **Status Tracking**: Document category statuses as estimated by the responsible teacher
- **Development Goals**: Document educational learning support goals that are accessible for colleagues teaching the pupil.
- **Collaborative Progress**: Enable multiple colleagues to share documentation about the goals' progress over time.
- **Document & Audio Attachments**: Attach documents and audio recordings to support goals and checks
- **Special Needs Teacher**: Assign a special needs teacher per learning support plan
- **Configurable Print Options**: Control which support categories appear in printed reports
- **PDF Generation**: Print learning support plans as PDF documents

### Workbooks

Manage educational workbooks used by students:
- Track workbook assignments to pupils
- Manage workbook inventory
- Associate workbooks with pupils

### Competence Management and Report

Track and manage student competencies:
- Competence tree structure
- Competence checks per pupil
- Competence-based assessments
- Progress tracking
- Semester-based reporting
- Add, edit, and delete competencies and support categories
- Attach documents to competence goals
- Competence report PDF generation
  
### Library Books Management

Digital library management system for tracking books:
- Book catalog with ISBN support
- Location tracking for library books
- Book tagging system
- Lending management with audio recording support
- Book search functionality
- Multiple book instances per ISBN
- Lending-specific filters

### Pupil Profile 

Comprehensive pupil profile view consolidating all information about a student, including:
- Parents' language proficiency in German (important for multilingual families)
- Sibling information with relationship awareness
- Afterschool care details
- Kindergarten information
- All other pupil-related data

### Timetable Management (WIP)

Complete timetable management system for scheduling and organizing classes:
- Weekly view with interactive timetable grid
- Multiple lesson groups/classes support
- Subject management with color coding
- Classroom/location management
- Flexible time slot configuration
- Create, edit, and delete scheduled lessons
- Drag-and-drop lesson scheduling
- Multi-teacher support per lesson
- Filter by weekday and lesson group

### Over-the-Air Updates

The app supports code push updates via [Shorebird](https://shorebird.dev/), allowing patches to be delivered directly to users without requiring a full app store release. The app checks for updates on startup and prompts the user to restart when a patch is available.

### Multi-Instance Support

Use the app with multiple school environments. Users can store several school keys and switch between instances, enabling staff who work across schools to manage all their data from a single device.

### Statistics & Charts

Visual analytics across multiple data domains:
- Attendance statistics
- Schoolday event statistics
- Book lending statistics
- Credit transaction charts
- Pupil demographics (enrollment, groups, languages)

### School Data Management

View and edit school-level information such as school name, logo, and other institutional data.

### School Calendar

Manage school calendar and semesters:
- View schooldays in calendar format
- Add and delete schooldays
- View attendance lists for selected dates
- Semester management


### User Management

Administrative interface for managing users:
- Add new users (single or batch creation with progress feedback)
- Update user information
- Delete users (with forced logout on deleted devices)
- Reset passwords
- Manage user roles and permissions
- Per-user pupil access authorization

### Matrix Integration (Matrix Corporal)

If configured with a Synapse server and [Matrix Corporal](https://github.com/devture/matrix-corporal), manage:
- Matrix user accounts
- Room membership
- Per-user power levels in rooms
- Sending messages from the admin account to users
- Compulsory rooms (rooms all users must join)
- View reported messages from Matrix admin API
- Account type filtering

## Utilities

Cross-feature utilities that enhance functionality across the application:

### PDF Export

Generate printable PDF reports for:
- Attendance lists (daily and summary reports)
- Individual learning support plans
- Competence reports
- School lists
- Missed classes summaries

### Filters & Search

Advanced filtering and sorting capabilities:
- General filters (class, school year)
- Feature-specific filters (school lists, book lendings, learning support plans, Matrix accounts)
- Custom sorting by various criteria
- Quick search functionality

### Mail Notifications

Email notification system for various events and updates.

### (admin/dev) Logs

- UI implemented to access and/or delete client and server side logs.
- Copy-to-clipboard buttons to make log sharing easier.

### (admin/dev) Server Model Diagram

In-app viewer for the server's relational data model, useful for development and debugging.

### Audio Recordings

Record and attach audio files across multiple features:
- Schoolday event documentation
- Book lending notes
- Competence goal documentation
- Support goal and check attachments

## Technology Stack

- **Client**: Flutter (cross-platform mobile and desktop application)
- **Backend**: Serverpod 2.9.1 (Dart-based server framework)
- **Programming Language**: Dart (SDK >=3.8.0)
- **State Management**: watch_it 1.7.0
- **CI/CD**: GitHub Actions (deploys triggered by commits affecting server packages)
- **OTA Updates**: Shorebird (Android)
 
## Setup

### Prerequisites

- Flutter SDK (>=3.19.0)
- Dart SDK (>=3.8.0)
- Serverpod server instance

### School Keys

You will need a school key to configure the client. If you don't have one yet, you can generate one using the client application.

The school key format is:

```json
{
  "server": "Name of your server",
  "key": "your encryption key",
  "iv": "your initialization vector",
  "server_url": "your_instance_url/api"
}
```

### Local Development Environment

When setting up a local development environment, the `server_url` depends on which platform you are using for the client:

- **Windows**: `http://127.0.0.1:5000/api`
- **Android Emulator**: `http://10.0.2.2:5000/api`

## Contributing

These are some areas where contributions are welcome (pull requests appreciated):

- **Architecture**: Review presentation layers, evaluate event-based decoupling between managers
- **State Management (client)**: Review state management across pages
- **Navigation**: Review and improve navigation patterns
- **Internationalization (client)**: Add multi-language support (WIP)
- **Design (client)**: Review widget layout/design using Orient UI design system
- **Testing**: Extend test coverage — filter predicates and domain helpers are covered (92 tests); integration and widget tests needed

For a detailed analysis of the domain layer's current state, patterns, and remaining action steps, see [`docs/domain_layer_assessment.md`](docs/domain_layer_assessment.md).

## Credits

Thanks to the open source community for the excellent tools and libraries that make this project possible!

Original code written by [@dabblingwithcode](https://github.com/dabblingwithcode).

Special thanks to [@escamoteur](https://github.com/escamoteur) (developer of `get_it` and `watch_it`) for kindly answering questions and supporting through designing the PupilProxy model and its filters.
