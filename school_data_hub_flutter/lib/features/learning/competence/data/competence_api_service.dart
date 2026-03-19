import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';

/// API service for competence CRUD operations.
///
/// Handles fetching, creating, updating, deleting, and importing competences.
class CompetenceApiService {
  Client get _client => di<Client>();

  /// Fetch all competences from the server.
  Future<List<Competence>?> getAllCompetences() async {
    return ClientHelper.apiCall(
      call: () => _client.competence.getAllCompetences(),
      errorMessage: 'Kompetenzen',
    );
  }

  /// Create a new competence.
  Future<Competence?> postCompetence({
    int? parentCompetence,
    required String name,
    required List<String> level,
    required List<String> indicators,
  }) async {
    return ClientHelper.apiCall(
      call: () => _client.competence.postCompetence(
        parentCompetence: parentCompetence,
        name: name,
        level: level,
        indicators: indicators,
      ),
      errorMessage: 'Kompetenz erstellen',
    );
  }

  /// Update an existing competence.
  Future<Competence?> updateCompetence(Competence competence) async {
    return ClientHelper.apiCall(
      call: () => _client.competence.updateCompetence(competence),
      errorMessage: 'Kompetenz aktualisieren',
    );
  }

  /// Delete a competence by its public ID. Returns `true` on success.
  Future<bool?> deleteCompetence(int publicId) async {
    return ClientHelper.apiCall(
      call: () => _client.competence.deleteCompetence(publicId),
      errorMessage: 'Kompetenz löschen',
    );
  }

  /// Import competences from a previously-uploaded JSON file.
  Future<List<Competence>?> importCompetencesFromJsonFile(
    String filePath,
  ) async {
    return ClientHelper.apiCall(
      call: () => _client.adminCategories.importCompetencesFromJsonFile(filePath),
      errorMessage: 'Kompetenzen importieren',
    );
  }
}
