import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_server/src/endpoints/admin/admin_endpoint.dart';
import 'package:school_data_hub_server/src/endpoints/learning/competence_endpoint.dart';
import 'package:school_data_hub_server/src/endpoints/learning_support/support_category_endpoint.dart';
import 'package:school_data_hub_server/src/endpoints/schoolday_admin_endpoint.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

final _log = Logger('PopulateTestEnvironment');

void createLocalStorageDirectories(String projectRootPath) {
  // Create the directories for local storage
  final storageDir = Directory(p.join(projectRootPath, 'storage'));

  // If the storage directory does not exist,
  // the subdirectories do not exist either
  if (!storageDir.existsSync()) {
    _log.warning(
        'Storage directories not found in [${storageDir.path}] - creating...');
    final publicDir = Directory(p.join(storageDir.path, 'public'));
    final privateDir = Directory(p.join(storageDir.path, 'private'));
    final tempDir = Directory(p.join(storageDir.path, 'temp'));
    final authsDir = Directory(p.join(privateDir.path, 'auths'));
    final avatarsDir = Directory(p.join(privateDir.path, 'avatars'));
    final documentsDir = Directory(p.join(privateDir.path, 'documents'));
    final evertsDir = Directory(p.join(privateDir.path, 'events'));

    publicDir.createSync(recursive: true);

    tempDir.createSync(recursive: true);
    authsDir.createSync(recursive: true);
    avatarsDir.createSync(recursive: true);
    documentsDir.createSync(recursive: true);
    evertsDir.createSync(recursive: true);
    _log.fine(
        'Storage directories created successfully in [${storageDir.path}]');
  }
}

Future<void> populateTestEnvironment(Session session) async {
  // Get the current working directory
  final serverDirPath = Directory.current.path;

  final projectRootPath = p.dirname(serverDirPath);

  createLocalStorageDirectories(projectRootPath);

  try {
    //- Create test admin

    final adminEmail = 'admin';
    var adminUser = await auth.Users.findUserByEmail(session, adminEmail);

    // For email authentication, you need to create a user with email/password
    final adminPassword = 'admin'; // Set a secure password in production

    // Create the userinfo
    adminUser = await auth.Emails.createUser(
      session,
      'ADM', // User name
      adminEmail,
      adminPassword,
    );

    if (adminUser != null) {
      // Grant admin scope to the user
      await auth.Users.updateUserScopes(session, adminUser.id!, {Scope.admin});

      final User adminuser = User(
          userInfoId: adminUser.id!,
          role: Role.technical,
          timeUnits: 28,
          credit: 50,
          userFlags: UserFlags(
              confirmedTermsOfUse: false,
              confirmedPrivacyPolicy: false,
              changedPassword: false,
              madeFirstSteps: false));

      await session.db.insertRow(adminuser);

      _log.fine('Admin user created successfully: ');
      _log.fine('Email: $adminEmail');
      _log.fine('Password: $adminPassword'); // Log the password for reference
      _log.warning('You should NOT use this in production!');
    } else {
      _log.severe('Failed to create admin user');
    }

    // Check if there is a folder 'test_data' in the project root directory
    final serverDir = Directory.current.path;

    final projectRoot = p.dirname(serverDir);

    final testDataDir = Directory(p.join(projectRoot, 'test_data'));

    if (!testDataDir.existsSync()) {
      _log.warning(
          'Directory not found: [${testDataDir.path}] - aborting test environment population...');
      return;
    }

    //- Competences

    // Check if there are any competences in the database
    final existingCompetences = await Competence.db.find(session);

    if (existingCompetences.isEmpty) {
      _log.info(
        'No competences in the database. Looking for file...',
      );

      // Path to the JSON file containing containing the competences
      final competenceJsonFilePath =
          p.join(testDataDir.path, 'competence.json');

      final File file = File(competenceJsonFilePath);

      if (file.existsSync()) {
        _log.info('Competences file found! populating...');
        // Call the endpoint to import competences from the JSON file
        final competenceEndpoint = CompetenceEndpoint();

        await competenceEndpoint.importCompetencesFromJsonFile(session, file);

        _log.fine('Competences populated successfully!');
      } else {
        _log.warning(
          'No competences file found in the test_data directory.',
        );
      }
    }

    //- Support categories

    final existingCategories = await SupportCategory.db.find(session);

    if (existingCategories.isEmpty) {
      _log.info('No support categories in the database. Looking for file...');

      // Path to the JSON file containing support categories

      final supportCategoriesjsonFilePath =
          p.join(testDataDir.path, 'support_category.json');

      if (File(supportCategoriesjsonFilePath).existsSync()) {
        _log.info('Support categories file found! populating...');

        // Call the endpoint to import support categories from the JSON file
        final supportCategoryEndpoint = SupportCategoryEndpoint();

        await supportCategoryEndpoint.importSupportCategoriesFromJsonFile(
            session, supportCategoriesjsonFilePath);

        _log.fine('Support categories populated successfully!');
      } else {
        _log.warning(
            'No support categories file found in the test_data directory.');
      }
    }

    //- Pupils

    final existingPupils = await PupilData.db.find(session);

    if (existingPupils.isEmpty) {
      _log.info(
        'No pupils in the database. Populating...',
      );

      // Path to the JSON file containing support categories
      final pupilsFilePath = p.join(testDataDir.path, 'fake_pupils_export.txt');

      // Call the endpoint to import support categories from the JSON file
      final adminEndpoint = AdminEndpoint();

      await adminEndpoint.updateBackendPupilDataState(session, pupilsFilePath);

      _log.fine('Pupils populated successfully!');
    }

    //- School semesters

    final existingSchoolSemesters = await SchoolSemester.db.find(session);

    if (existingSchoolSemesters.isEmpty) {
      _log.info('No school semesters in the database. Populating...');

      final schoolSemesterFilePath =
          p.join(testDataDir.path, 'school_semester.json');

      final schoolSemesterFile = File(schoolSemesterFilePath);

      if (schoolSemesterFile.existsSync()) {
        _log.info('School semester file found! populating...');
        final jsonString = schoolSemesterFile.readAsStringSync();

        final schoolSemester = SchoolSemester.fromJson(jsonDecode(jsonString));

        await SchoolSemester.db.insertRow(session, schoolSemester);
        _log.fine('School semesters populated successfully!');
      } else {
        _log.warning(
          'No school semester file found in the test_data directory.',
        );
      }
    }

    //- Schooldays

    final existingSchooldays = await Schoolday.db.find(session);

    if (existingSchooldays.isEmpty) {
      _log.info(
        'No school days in the database. Populating...',
      );

      final schooldayEndpoint = SchooldayAdminEndpoint();

      final schooldays =
          generateWeekdays(DateTime(2025, 2, 7), DateTime(2025, 7, 11));

      await schooldayEndpoint.createSchooldays(session, schooldays);

      _log.fine('Schooldays populated successfully!');
    }

    _log.fine(
      'Test environment populated successfully!',
    );
  } catch (e) {
    _log.severe('Error populating test environment: $e');
  }
}

List<DateTime> generateWeekdays(DateTime start, DateTime end) {
  final List<DateTime> weekdays = [];

  // Create a new DateTime starting at the first date
  DateTime current = start;

  // Loop until we reach or pass the end date
  while (!current.isAfter(end)) {
    // Check if it's a weekday (1-5 are Monday to Friday)
    if (current.weekday >= 1 && current.weekday <= 5) {
      weekdays.add(DateTime(current.year, current.month, current.day));
    }

    // Move to next day
    current = current.add(const Duration(days: 1));
  }

  return weekdays;
}
