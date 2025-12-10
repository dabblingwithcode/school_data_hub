import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/hub_document_helper.dart';
import 'package:school_data_hub_server/src/schemas/pupil_schemas.dart';
import 'package:serverpod/serverpod.dart';

class CompetenceGoalEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create
  Future<PupilData> postCompetenceGoal(
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

    var transactionResult = await session.db.transaction((transaction) async {
      final competenceGoalInDatabase = await CompetenceGoal.db.insertRow(
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
          session, pupil!, competenceGoalInDatabase,
          transaction: transaction);

      final competence = await Competence.db.findById(
        session,
        competenceId,
        transaction: transaction,
      );

      await Competence.db.attachRow.competenceGoals(
          session, competence!, competenceGoalInDatabase,
          transaction: transaction);

      final pupilResponse = await PupilData.db.findById(
        session,
        pupilId,
        include: PupilSchemas.allInclude,
        transaction: transaction,
      );
      return pupilResponse!;
    });

    return transactionResult;
  }

  Future<PupilData> updateCompetenceGoal(
    Session session,
    String publicId, {
    ({String value})? description,
    ({List<String>? value})? strategies,
    ({String value})? modifiedBy,
    ({int? value})? score,
    ({DateTime value})? achievedAt,
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
    final pupil = await PupilData.db.findById(
      session,
      competenceGoal.pupilId,
      include: PupilSchemas.allInclude,
    );
    return pupil!;
  }

  Future<PupilData> deleteCompetenceGoal(
      Session session, String publicId) async {
    final competenceGoal = await CompetenceGoal.db
        .findFirstRow(session, where: (t) => t.publicId.equals(publicId));
    if (competenceGoal == null) {
      throw Exception('Competence goal with id $publicId not found.');
    }
    await CompetenceGoal.db.deleteRow(session, competenceGoal);
    final pupil = await PupilData.db.findById(
      session,
      competenceGoal.pupilId,
      include: PupilSchemas.allInclude,
    );
    return pupil!;
  }

  Future<PupilData> addFileToCompetenceGoal(
    Session session,
    String publicId,
    String filePath,
    String createdBy,
  ) async {
    final competenceGoal = await CompetenceGoal.db.findFirstRow(
      session,
      where: (t) => t.publicId.equals(publicId),
      include: CompetenceGoal.include(
        documents: HubDocument.includeList(),
      ),
    );
    if (competenceGoal == null) {
      throw Exception('CompetenceGoal with id $publicId not found');
    }

    final document = HubDocumentHelper().createHubDocumentObject(
      session: session,
      createdBy: createdBy,
      path: filePath,
    );

    final documentInDatabase = await HubDocument.db.insertRow(
      session,
      document,
    );

    await CompetenceGoal.db.attachRow.documents(
      session,
      competenceGoal,
      documentInDatabase,
    );

    final pupil = await PupilData.db.findById(
      session,
      competenceGoal.pupilId,
      include: PupilSchemas.allInclude,
    );
    return pupil!;
  }

  Future<PupilData> removeFileFromCompetenceGoal(
    Session session,
    String publicId,
    String documentId,
  ) async {
    final competenceGoal = await CompetenceGoal.db.findFirstRow(
      session,
      where: (t) => t.publicId.equals(publicId),
      include: CompetenceGoal.include(
        documents: HubDocument.includeList(),
      ),
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

    // Use a transaction
    await session.db.transaction((transaction) async {
      // Detach the file from the competence goal
      await CompetenceGoal.db.detachRow.documents(
        session,
        documentToRemove,
        transaction: transaction,
      );
      // Delete the file from the database
      await HubDocument.db.deleteRow(
        session,
        documentToRemove,
        transaction: transaction,
      );
      // Delete the file from the storage
      await session.storage.deleteFile(
        storageId: 'private',
        path: documentToRemove.documentPath!,
      );
    });

    final pupilData = await PupilData.db.findById(
      session,
      competenceGoal.pupilId,
      include: PupilSchemas.allInclude,
    );
    return pupilData!;
  }
}
