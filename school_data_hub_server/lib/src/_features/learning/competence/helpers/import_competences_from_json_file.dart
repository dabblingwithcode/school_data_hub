import 'dart:convert';

import 'package:school_data_hub_server/src/generated/protocol.dart';

Future<List<Competence>> importCompetencesFromFileContentJson(
    String fileContent) async {
  // Parse the JSON content
  final List<dynamic> jsonList = jsonDecode(fileContent);
  final List<Competence> categories = jsonList.map((json) {
    return Competence.fromJson(json as Map<String, dynamic>);
  }).toList();

  return categories;
}
