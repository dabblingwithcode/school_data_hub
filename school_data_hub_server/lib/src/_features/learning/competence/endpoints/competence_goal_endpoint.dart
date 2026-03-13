import 'package:school_data_hub_server/src/_features/hub/services/hub_updates_tracker.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/hub_document_helper.dart';
import 'package:serverpod/serverpod.dart';

/// Include for fetching a CompetenceGoal with its documents.
final _goalInclude = CompetenceGoal.include(
  documents: HubDocument.includeList(),
);

class CompetenceGoalEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Fetch all competence goals (used for reconnect / bulk loads).
  Future<List<CompetenceGoal>> fetchAllCompetenceGoals(
    Session session,
  ) async {
    return CompetenceGoal.db.find(
      session,
      include: _goalInclude,
    );
  }

  /// Fetch competence goals for a single pupil (lazy loading).
  Future<List<CompetenceGoal>> fetchCompetenceGoalsForPupil(
    Session session,
    int pupilId,
  ) async {
    return CompetenceGoal.db.find(
      session,
      where: (t) => t.pupilId.equals(pupilId),
      include: _goalInclude,
    );
  }

  //- create
  Future<bool> postCompetenceGoal(
    Session session, {
    required int competenceId,
    required int pupilId,
    required String description,
    List<String>? strategies,
    required String createdBy,
    String? modifiedBy,
    int? score,
    DateTime? achievedAt,
  }) async {
    final competenceGoal = CompetenceGoal(
      publicId: Uuid().v4(),
      description: description,
      strategies: strategies,
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
      modifiedBy: modifiedBy ?? createdBy,
      score: score,
      achievedAt: achievedAt ?? DateTime.now().toUtc(),
      pupilId: pupilId,
      competenceId: competenceId,
    );

    final result = await session.db.transaction((transaction) async {
      final goalInDb = await CompetenceGoal.db.insertRow(
        session,
        competenceGoal,
        transaction: transaction,
      );
      final pupil = await PupilData.db.findById(
        session,
        pupilId,
        transaction: transaction,
      );
      await PupilData.db.attachRow.competenceGoals(
        session,
        pupil!,
        goalInDb,
        transaction: transaction,
      );

      final competence = await Competence.db.findById(
        session,
        competenceId,
        transaction: transaction,
      );
      await Competence.db.attachRow.competenceGoals(
        session,
        competence!,
        goalInDb,
        transaction: transaction,
      );

      // Re-fetch with includes.
      return (await CompetenceGoal.db.findById(
        session,
        goalInDb.id!,
        include: _goalInclude,
        transaction: transaction,
      ))!;
    });

    session.messages.postMessage('hub_events_stream', result);
    HubUpdatesTracker.instance.touch(HubObjectType.competenceGoal);
    return true;
  }

  Future<bool> updateCompetenceGoal(
    Session session,
    String publicId, {
    ({String value})? description,
    ({List<String>? value})? strategies,
    ({String? value})? modifiedBy,
    ({int? value})? score,
    ({DateTime? value})? achievedAt,
  }) async {
    final competenceGoal = await CompetenceGoal.db
        .findFirstRow(session, where: (t) => t.publicId.equals(publicId));
    if (competenceGoal == null) {
      throw Exception('Competence goal with id $publicId not found.');
    }

    if (description != null) {
      competenceGoal.description = description.value;
    }
    if (strategies != null) {
      competenceGoal.strategies = strategies.value;
    }
    if (modifiedBy != null) {
      competenceGoal.modifiedBy = modifiedBy.value;
    }
    if (score != null) {
      competenceGoal.score = score.value;
    }
    if (achievedAt != null) {
      competenceGoal.achievedAt = achievedAt.value;
    }
    await CompetenceGoal.db.updateRow(session, competenceGoal);

    final result = (await CompetenceGoal.db.findById(
      session,
      competenceGoal.id!,
      include: _goalInclude,
    ))!;

    session.messages.postMessage('hub_events_stream', result);
    HubUpdatesTracker.instance.touch(HubObjectType.competenceGoal);
    return true;
  }

  Future<bool> deleteCompetenceGoal(
    Session session,
    String publicId,
  ) async {
    final competenceGoal = await CompetenceGoal.db.findFirstRow(
      session,
      where: (t) => t.publicId.equals(publicId),
      include: _goalInclude,
    );
    if (competenceGoal == null) {
      throw Exception('Competence goal with id $publicId not found.');
    }

    final goalId = competenceGoal.id!;

    await session.db.transaction((transaction) async {
      // Delete attached documents first
      final documents = competenceGoal.documents;
      if (documents != null && documents.isNotEmpty) {
        for (final document in documents) {
          await CompetenceGoal.db.detachRow.documents(
            session,
            document,
            transaction: transaction,
          );
          await HubDocument.db.deleteRow(
            session,
            document,
            transaction: transaction,
          );
          if (document.documentPath != null) {
            await session.storage.deleteFile(
              storageId: 'private',
              path: document.documentPath!,
            );
          }
        }
      }

      await CompetenceGoal.db.deleteRow(
        session,
        competenceGoal,
        transaction: transaction,
      );
    });

    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(
        id: goalId,
        objectType: HubObjectType.competenceGoal,
      ),
    );
    return true;
  }

  Future<bool> addFileToCompetenceGoal(
    Session session,
    String publicId,
    String filePath,
    String createdBy,
  ) async {
    final competenceGoal = await CompetenceGoal.db.findFirstRow(
      session,
      where: (t) => t.publicId.equals(publicId),
      include: _goalInclude,
    );
    if (competenceGoal == null) {
      throw Exception('CompetenceGoal with id $publicId not found');
    }

    final document = HubDocumentHelper().createHubDocumentObject(
      session: session,
      createdBy: createdBy,
      path: filePath,
    );

    final result = await session.db.transaction((transaction) async {
      final documentInDatabase = await HubDocument.db.insertRow(
        session,
        document,
        transaction: transaction,
      );

      await CompetenceGoal.db.attachRow.documents(
        session,
        competenceGoal,
        documentInDatabase,
        transaction: transaction,
      );

      return (await CompetenceGoal.db.findById(
        session,
        competenceGoal.id!,
        include: _goalInclude,
        transaction: transaction,
      ))!;
    });

    session.messages.postMessage('hub_events_stream', result);
    HubUpdatesTracker.instance.touch(HubObjectType.competenceGoal);
    return true;
  }

  Future<bool> removeFileFromCompetenceGoal(
    Session session,
    String publicId,
    String documentId,
  ) async {
    final competenceGoal = await CompetenceGoal.db.findFirstRow(
      session,
      where: (t) => t.publicId.equals(publicId),
      include: _goalInclude,
    );
    if (competenceGoal == null) {
      throw Exception('CompetenceGoal with id $publicId not found');
    }

    final documentToRemove = competenceGoal.documents?.firstWhere(
      (doc) => doc.documentId == documentId,
      orElse: () => throw Exception(
          'Document with id $documentId not found in competence goal'),
    );

    if (documentToRemove == null) {
      throw Exception(
          'Document with id $documentId not found in competence goal');
    }

    await session.db.transaction((transaction) async {
      await CompetenceGoal.db.detachRow.documents(
        session,
        documentToRemove,
        transaction: transaction,
      );
      await HubDocument.db.deleteRow(
        session,
        documentToRemove,
        transaction: transaction,
      );
      await session.storage.deleteFile(
        storageId: 'private',
        path: documentToRemove.documentPath!,
      );
    });

    final result = (await CompetenceGoal.db.findById(
      session,
      competenceGoal.id!,
      include: _goalInclude,
    ))!;

    session.messages.postMessage('hub_events_stream', result);
    HubUpdatesTracker.instance.touch(HubObjectType.competenceGoal);
    return true;
  }
}
