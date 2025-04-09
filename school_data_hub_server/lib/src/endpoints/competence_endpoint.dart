import 'dart:convert';
import 'dart:io';

import 'package:school_data_hub_server/src/generated/learning/competence.dart';
import 'package:serverpod/serverpod.dart';

class CompetenceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<Competence>> importCompetencesFromJsonFile(
      Session session, File jsonFile) async {
    final fileContent = await jsonFile.readAsString();
    if (fileContent.isEmpty) {
      throw Exception('File is empty: $jsonFile');
    }
    // Parse the JSON content
    final List<dynamic> jsonList = jsonDecode(fileContent);
    final List<Competence> categories = jsonList.map((json) {
      return Competence.fromJson(json as Map<String, dynamic>);
    }).toList();
    await Competence.db.insert(session, categories);
    return categories;
  }

  Future<Competence> postCompetence(
    Session session, {
    int? parentCompetence,
    required String name,
    required List<String> level,
    required List<String> indicators,
  }) async {
    // look for the highest competence id in the database
    final List<Competence> competences = await Competence.db.find(session);
    int? maxId = competences.isNotEmpty
        ? competences.map((c) => c.id).reduce((a, b) => a! > b! ? a : b)
        : 0;

    final competence = Competence(
      publicId: maxId! + 1,
      parentCompetence: parentCompetence,
      name: name,
      level: level,
      indicators: indicators,
    );
    await session.db.insertRow(competence);
    return competence;
  }

  Future<List<Competence>> getAllCompetences(Session session) async {
    final competences = await Competence.db.find(session);
    return competences;
  }

  Future<Competence> updateCompetence(
      Session session, Competence competence) async {
    await session.db.updateRow(competence);
    return competence;
  }

  Future<bool> deleteCompetence(Session session, int publicId) async {
    // Find the competence by publicId
    final competence = await Competence.db.findById(session, publicId);
    if (competence == null) {
      throw Exception('Competence with publicId $publicId not found.');
    }
    await session.db.deleteRow<Competence>(competence);
    return true;
  }
}
