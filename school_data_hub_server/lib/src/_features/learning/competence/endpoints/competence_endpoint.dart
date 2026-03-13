import 'package:school_data_hub_server/src/_features/hub/services/hub_updates_tracker.dart';
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
      id: null,
      publicId: maxPublicId + 1,
      parentCompetence: parentCompetence,
      name: name,
      level: level,
      indicators: indicators,
    );
    final competenceInDatabase = await session.db.insertRow(competence);
    session.messages.postMessage('hub_events_stream', competenceInDatabase);
    HubUpdatesTracker.instance.touch(HubObjectType.competence);
    return competenceInDatabase;
  }

  Future<List<Competence>> getAllCompetences(Session session) async {
    final competences = await Competence.db.find(session);
    return competences;
  }

  Future<Competence> updateCompetence(
      Session session, Competence competence) async {
    await session.db.updateRow(competence);
    session.messages.postMessage('hub_events_stream', competence);
    HubUpdatesTracker.instance.touch(HubObjectType.competence);
    return competence;
  }

  Future<bool> deleteCompetence(Session session, int publicId) async {
    final competence = await Competence.db.findFirstRow(
      session,
      where: (t) => t.publicId.equals(publicId),
    );
    if (competence == null) {
      throw Exception('Competence with publicId $publicId not found.');
    }
    // Recursively delete all child competences first
    final children = await Competence.db.find(
      session,
      where: (t) => t.parentCompetence.equals(publicId),
    );
    for (final child in children) {
      await deleteCompetence(session, child.publicId);
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
