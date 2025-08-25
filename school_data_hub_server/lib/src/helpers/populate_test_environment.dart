import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_server/src/_features/learning/endpoints/competence_endpoint.dart';
import 'package:school_data_hub_server/src/_features/learning_support/endpoints/support_category_endpoint.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/create_first_admin.dart';
import 'package:serverpod/serverpod.dart';

final _log = Logger('PopulateTestEnvironment');

Future<void> populateTestEnvironment(Session session) async {
  await createFirstAdmin(session);
  try {
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
