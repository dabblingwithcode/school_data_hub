import 'dart:io';

import 'package:school_data_hub_server/src/endpoints/admin_endpoint.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PopulatePupilsFutureCall extends FutureCall {
  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    try {
      // Path to the JSON file containing support categories
      final jsonFilePath = '../test_data/fake_pupils_export.txt';
      final pupilsFile = File(jsonFilePath);
      // If there are support categories already in the database, skip the import
      final pupils = await PupilData.db.find(session);

      if (pupils.isNotEmpty) {
        session.log('Pupils already exist in the database.',
            level: LogLevel.info);
        return;
      }
      // Call the endpoint to import support categories from the JSON file
      final endpoint = AdminEndpoint();
      await endpoint.updateBackendPupilDataState(session, pupilsFile);

      session.log('Support categories populated successfully!',
          level: LogLevel.info);
    } catch (e) {
      session.log('Error populating support categories: $e',
          level: LogLevel.error);
    }
  }
}
