import 'dart:io';

import 'package:school_data_hub_server/src/endpoints/competence_endpoint.dart';
import 'package:school_data_hub_server/src/generated/learning/competence.dart';
import 'package:serverpod/serverpod.dart';

class PopulateCompetencesFutureCall extends FutureCall {
  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    try {
      // Path to the JSON file containing containing the competences
      final jsonFilePath = '../test_data/competence.json';

      // If there are competences already in the database, skip the import
      final existingCompetences = await Competence.db.find(session);

      if (existingCompetences.isNotEmpty) {
        session.log('Competences already exist in the database.',
            level: LogLevel.info);
        return;
      }
      final File file = File(jsonFilePath);

      if (!file.existsSync()) {
        throw Exception('File not found: $file');
      }
      // Call the endpoint to import competences from the JSON file
      final endpoint = CompetenceEndpoint();
      await endpoint.importCompetencesFromJsonFile(session, file);

      session.log('Competences populated successfully!', level: LogLevel.info);
    } catch (e) {
      session.log('Error populating competences: $e', level: LogLevel.error);
    }
  }
}
