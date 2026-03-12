import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:school_data_hub_server/src/_features/learning/competence/helpers/import_competences_from_json_file.dart';
import 'package:school_data_hub_server/src/_features/learning_support/helpers/import_support_categories_from_file_content_json.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/convert_file_to_content_string.dart';
import 'package:school_data_hub_server/src/helpers/create_first_admin.dart';
import 'package:serverpod/serverpod.dart';

Future<void> populateTestEnvironment(Session session) async {
  await createFirstAdmin(session);
  try {
    // Check if there is a folder 'test_data' in the project root directory
    final serverDir = Directory.current.path;

    final projectRoot = p.dirname(serverDir);

    final testDataDir = Directory(p.join(projectRoot, 'test_data'));

    if (!testDataDir.existsSync()) {
      session.log(
          'Directory not found: [${testDataDir.path}] - aborting test environment population...',
          level: LogLevel.warning);
      return;
    }

    //- Competences

    // Check if there are any competences in the database
    final existingCompetences = await Competence.db.find(session);

    if (existingCompetences.isEmpty) {
      session.log('No competences in the database. Looking for file...');

      final fileContent = await convertFileToContentString(
          session, p.join(testDataDir.path, 'competence.json'));
      final content = await importCompetencesFromFileContentJson(fileContent);

      if (content.isNotEmpty) {
        session.log('Competences file found! populating...');
        await Competence.db.insert(session, content);

        session.log('Competences populated successfully!', level: LogLevel.debug);
      } else {
        session.log('No competences file found in the test_data directory.',
            level: LogLevel.warning);
      }
    }

    //- Support categories

    final existingCategories = await SupportCategory.db.find(session);

    if (existingCategories.isEmpty) {
      session.log('No support categories in the database. Looking for file...');

      // Path to the JSON file containing support categories
      final fileContent = await convertFileToContentString(
          session, p.join(testDataDir.path, 'support_category.json'));

      final categories =
          await importSupportCategoriesFromFileContentJson(fileContent);
      if (categories.isNotEmpty) {
        session.log('Support categories file found! populating...');
        await SupportCategory.db.insert(session, categories);
        session.log('Support categories populated successfully!', level: LogLevel.debug);
      } else {
        session.log('No support categories file found in the test_data directory.',
            level: LogLevel.warning);
      }
    }
  } catch (e) {
    session.log('Error populating test environment: $e', level: LogLevel.error);
  }
}
