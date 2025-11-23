# School Data Hub

A comprehensive software tool for managing school information flows between teachers and administrative staff in an effective, collaborative way.

## What does it do?

School Data Hub integrates with data exported from the NRW Education ministry software ([SVWS](https://www.svws.nrw.de/)) to build extended models of pupils in the backend without uploading any personal data to the server. The backend models are then used to add and manage additional information collaboratively.

## Technology Stack

- **Client**: Flutter (cross-platform mobile and desktop application)
- **Backend**: Serverpod 2.9.1 (Dart-based server framework)
- **Programming Language**: Dart (SDK >=3.8.0)
- **State Management**: watch_it 1.7.0

## Architecture & Data Protection

### Privacy-First Approach

School Data Hub implements a unique privacy-first architecture by **decoupling personal information from the database**. Instead of storing personal data on the server, this information is **stored locally on each device and shared through secure data transport between devices**.

### How It Works

1. **Initial Setup**: When the client is installed, it requires school keys to function. Without these keys, the client cannot access any functionality.

2. **School Key Distribution**: As a security measure, school keys are stored securely in the school's administrative office. Users must visit the office at least once to obtain access. Users scan school keys containing the server URL and encryption keys. These are stored in the device's secure storage.

3. **Authentication**: After scanning the keys, users can log in with their credentials. However, even after login, no pupil data will be available.

4. **Pupil Data Import**: Users must obtain pupil credentials by transferring them from another device (typically from a desktop version of the app). These credentials are stored in secure storage. API calls require both pupil data and JWT tokens for authentication.

### Encrypted Data

The following data is encrypted:
- All stored images
- Sensitive information, including special needs support strings

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

Document and track schoolday events with photo attachments. Events can include:
- Admonitions
- Accident reports
- Parent meetings
- Any other incidents associated with pupils

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

### Special Information (WIP)

Access special information - authorized by parents/guardians - that all staff need to know about students:
- Allergies
- Emergency medication requirements
- Medical conditions (e.g., epilepsy risk)
- Other critical health or safety information

### Individual Learning Support (WIP)

Document and track individual learning support plans for pupils. This feature supports inclusive education by:

- **Flexible Support Category System**: Works with any category tree structure, allowing schools to use their own categorization system
- **Status Tracking**: Document category statuses as estimated by the responsible teacher
- **Collaborative Progress**: Enable multiple colleagues to track and share progress
- **Development Goals**: Document educational goals, ideally formulated together with the pupil

### Pupil Profile (WIP)

Comprehensive pupil profile view consolidating all information about a student, including:
- Parents' language proficiency in German (important for multilingual families)
- Sibling information with relationship awareness
- Afterschool care details
- All other pupil-related data

### Timetable Management (WIP)

Complete timetable management system for scheduling and organizing classes:
- Weekly view with interactive timetable grid
- Multiple lesson groups/classes support
- Subject management with color coding
- Classroom/location management
- Flexible time slot configuration
- Create, edit, and delete scheduled lessons
- Filter by weekday and lesson group

### Library Books Management (WIP)

Digital library management system for tracking books:
- Book catalog with ISBN support
- Location tracking for library books
- Book tagging system
- Lending management
- Book search functionality
- Multiple book instances per ISBN

### Workbooks (WIP)

Manage educational workbooks used by students:
- Track workbook assignments to pupils
- Manage workbook inventory
- Associate workbooks with pupils

### Competence Management and Report (WIP)

Track and manage student competencies:
- Competence tree structure
- Competence checks per pupil
- Competence-based assessments
- Progress tracking
- Semester-based reporting

### School Calendar

Manage school calendar and semesters:
- View schooldays in calendar format
- Add and delete schooldays
- View attendance lists for selected dates
- Semester management

### User Management

Administrative interface for managing users:
- Add new users
- Update user information
- Delete users
- Reset passwords
- Manage user roles and permissions

### Matrix Integration (Matrix Corporal)

If configured with a Synapse server and [Matrix Corporal](https://github.com/devture/matrix-corporal), manage:
- Matrix user accounts
- Room membership
- Per-user power levels in rooms
- Sending messages from the admin account to users

## Utilities

Cross-feature utilities that enhance functionality across the application:

### PDF Export

Generate printable PDF reports for:
- Attendance lists (daily and summary reports)
- Individual learning support plans
- School lists
- Missed classes summaries

### Filters & Search

Advanced filtering and sorting capabilities:
- General filters (class, school year)
- View-specific filters
- Custom sorting by various criteria
- Quick search functionality

### Mail Notifications

Email notification system for various events and updates.


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

## Roadmap

### Planned Features

- Enhanced semester management UI
- Competence reports for school semesters with PDF export
- QR sticker generation as shortcuts for documenting features
- Additional backend models not yet implemented in the client

### Technical Improvements

- **Code Quality**: Migrate pupils' filter architecture to `PupilsFilter` (work in progress)
- **Architecture**: Replace hard-coded enum filters for class and school grade with a dynamic solution to support different schools
- **Error Handling**: Improve error handling in API calls
- **State Management**: Review state management across pages
- **Offline Support**: Handle 'no internet connection' scenarios
- **Navigation**: Review and improve navigation patterns
- **Internationalization**: Add multi-language support
- **Design**: Review widget design and implement a comprehensive theme system

## Credits

Thanks to the open source community for the excellent tools and libraries that make this project possible!

Original code written by [@dabblingwithcode](https://github.com/dabblingwithcode).

Special thanks to [@escamoteur](https://github.com/escamoteur) (developer of `get_it` and `watch_it`) for kindly answering questions and providing guidance on state management, the PupilProxy model, and its filters.
