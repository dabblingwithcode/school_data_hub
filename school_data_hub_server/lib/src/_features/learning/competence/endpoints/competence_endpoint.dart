import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CompetenceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<Competence> postCompetence(
    Session session, {
    int? parentCompetence,
    required String name,
    required List<String> level,
    required List<String> indicators,
  }) async {
    // Next publicId = max(publicId) + 1 so we never reuse an existing value
    final List<Competence> competences = await Competence.db.find(session);
    final int maxPublicId = competences.isNotEmpty
        ? competences.map((c) => c.publicId).reduce((a, b) => a > b ? a : b)
        : 0;

    final competence = Competence(
      publicId: maxPublicId + 1,
      parentCompetence: parentCompetence,
      name: name,
      level: level,
      indicators: indicators,
    );
    await session.db.insertRow(competence);
    session.messages.postMessage('hub_events_stream', competence);
    return competence;
  }

  Future<List<Competence>> getAllCompetences(Session session) async {
    final competences = await Competence.db.find(session);
    return competences;
  }

  Future<Competence> updateCompetence(
      Session session, Competence competence) async {
    await session.db.updateRow(competence);
    session.messages.postMessage('hub_events_stream', competence);
    return competence;
  }

  Future<bool> deleteCompetence(Session session, int publicId) async {
    // Find the competence by publicId
    final competence = await Competence.db.findById(session, publicId);
    if (competence == null) {
      throw Exception('Competence with publicId $publicId not found.');
    }
    await session.db.deleteRow<Competence>(competence);
    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(
        objectType: HubObjectType.competence,
        id: publicId,
      ),
    );
    return true;
  }
}
