import 'dart:developer';
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

      // TODO: remove this test data after testing

      final pupilsFile =
          File('../test_data/schuldaten_hub_fake_schild_export_2024-02-02.txt');
      final result = await callEndpointMethod(
        session,
        'Admin',
        'updateBackendPupilDataState',
        {'file': pupilsFile},
      );
      debugger();
      session.log('Competences populated successfully!', level: LogLevel.info);
    } catch (e) {
      session.log('Error populating competences: $e', level: LogLevel.error);
    }
  }
}

Future<dynamic> callEndpointMethod(Session session, String endpointName,
    String methodName, Map<String, dynamic> params) async {
  // Get the endpoint connector by name
  var connector = session.server.endpoints.getConnectorByName(endpointName);
  if (connector == null) {
    throw Exception('Endpoint $endpointName not found');
  }

  // Get the method connector
  var methodConnector = connector.methodConnectors[methodName];
  if (methodConnector == null) {
    throw Exception('Method $methodName not found in endpoint $endpointName');
  }

  // Check the type and call with appropriate parameters
  if (methodConnector is MethodConnector) {
    return await methodConnector.call(session, params);
  } else if (methodConnector is MethodStreamConnector) {
    // For streaming methods, provide an empty stream params map
    return await methodConnector.call(session, params, {});
  } else {
    throw Exception(
        'Unsupported method connector type: ${methodConnector.runtimeType}');
  }
}
