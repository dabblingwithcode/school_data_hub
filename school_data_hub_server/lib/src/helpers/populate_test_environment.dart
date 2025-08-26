import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_server/src/_features/learning/helpers/import_competences_from_json_file.dart';
import 'package:school_data_hub_server/src/_features/learning_support/helpers/import_support_categories_from_file_content_json.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/convert_file_to_content_string.dart';
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

      final fileContent = await convertFileToContentString(
          session, p.join(testDataDir.path, 'competence.json'));
      final content = await importCompetencesFromFileContentJson(fileContent);

      if (content.isNotEmpty) {
        _log.info('Competences file found! populating...');
        await Competence.db.insert(session, content);

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
      final fileContent = await convertFileToContentString(
          session, p.join(testDataDir.path, 'support_category.json'));

      final categories =
          await importSupportCategoriesFromFileContentJson(fileContent);
      if (categories.isNotEmpty) {
        _log.info('Support categories file found! populating...');
        await SupportCategory.db.insert(session, categories);
        _log.fine('Support categories populated successfully!');
      } else {
        _log.warning(
          'No support categories file found in the test_data directory.',
        );
      }
    }
  } catch (e) {
    _log.severe('Error populating test environment: $e');
  }
}
