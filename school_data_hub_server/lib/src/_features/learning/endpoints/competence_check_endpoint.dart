import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/hub_document_helper.dart';
import 'package:school_data_hub_server/src/schemas/pupil_schemas.dart';
import 'package:serverpod/serverpod.dart';

class CompetenceCheckEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;
  //- create

  Future<PupilData> postCompetenceCheck(
    Session session, {
    required int competenceId,
    required int pupilId,
    required int score,
    String? comment,
    required double valueFactor,
    required String createdBy,
  }) async {
    final competenceCheck = CompetenceCheck(
      checkId: Uuid().v4(),
      score: score,
      valueFactor: valueFactor,
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
      pupilId: pupilId,
      competenceId: competenceId,
      comment: comment,
    );

    var transactionResult = await session.db.transaction((transaction) async {
      final competenceCheckInDatabase = await CompetenceCheck.db.insertRow(
        session,
        competenceCheck,
        transaction: transaction,
      );
      final pupil = await PupilData.db.findById(
        session,
        pupilId,
        transaction: transaction,
      );
      await PupilData.db.attachRow.competenceChecks(
          session, pupil!, competenceCheckInDatabase,
          transaction: transaction);

      final competence = await Competence.db.findById(
        session,
        competenceId,
        transaction: transaction,
      );

      await Competence.db.attachRow.competenceChecks(
          session, competence!, competenceCheckInDatabase,
          transaction: transaction);

      // final attachedCompetenceCheck = await CompetenceCheck.db.findById(
      //     session, competenceCheckInDatabase.id!,
      //     transaction: transaction);
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

  Future<PupilData> updateCompetenceCheck(Session session, String checkId,
      {({int value})? score,
      ({double value})? valueFactor,
      ({String value})? createdBy,
      ({String? value})? comment}) async {
    final competenceCheck = await CompetenceCheck.db
        .findFirstRow(session, where: (t) => t.checkId.equals(checkId));
    if (competenceCheck == null) {
      throw Exception('Competence check with id $checkId not found.');
    }
    if (score != null) {
      competenceCheck.score = score.value;
    }
    if (valueFactor != null) {
      competenceCheck.valueFactor = valueFactor.value;
    }
    if (comment != null) {
      competenceCheck.comment = comment.value;
    }
    await CompetenceCheck.db.updateRow(session, competenceCheck);
    final pupil = await PupilData.db.findById(
      session,
      competenceCheck.pupilId,
      include: PupilSchemas.allInclude,
    );
    return pupil!;
  }

  Future<PupilData> deleteCompetenceCheck(
      Session session, String checkId) async {
    final competenceCheck = await CompetenceCheck.db
        .findFirstRow(session, where: (t) => t.checkId.equals(checkId));
    if (competenceCheck == null) {
      throw Exception('Competence check with id $checkId not found.');
    }
    await CompetenceCheck.db.deleteRow(session, competenceCheck);
    final pupil = await PupilData.db.findById(
      session,
      competenceCheck.pupilId,
      include: PupilSchemas.allInclude,
    );
    return pupil!;
  }

  Future<PupilData> addFileToCompetenceCheck(
    Session session,
    String checkId,
    String filePath,
    String createdBy,
  ) async {
    final competenceCheck = await CompetenceCheck.db.findFirstRow(
      session,
      where: (t) => t.checkId.equals(checkId),
      include: CompetenceCheck.include(
        documents: HubDocument.includeList(),
      ),
    );
    if (competenceCheck == null) {
      throw Exception('CompetenceCheck with id $checkId not found');
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

    await CompetenceCheck.db.attachRow.documents(
      session,
      competenceCheck,
      documentInDatabase,
    );

    final pupil = await PupilData.db.findById(
      session,
      competenceCheck.pupilId,
      include: PupilSchemas.allInclude,
    );
    return pupil!;
  }

  Future<PupilData> removeFileFromCompetenceCheck(
    Session session,
    String checkId,
    String documentId,
  ) async {
    final competenceCheck = await CompetenceCheck.db.findFirstRow(
      session,
      where: (t) => t.checkId.equals(checkId),
      include: CompetenceCheck.include(
        documents: HubDocument.includeList(),
      ),
    );
    if (competenceCheck == null) {
      throw Exception('CompetenceCheck with id $checkId not found');
    }

    final documentToRemove = competenceCheck.documents?.firstWhere(
      (doc) => doc.documentId == documentId,
      orElse: () => throw Exception(
          'Document with id $documentId not found in competence check'),
    );

    if (documentToRemove == null) {
      throw Exception(
          'Document with id $documentId not found in competence check');
    }

    // Use a transaction
    await session.db.transaction((transaction) async {
      // Detach the file from the competence check
      await CompetenceCheck.db.detachRow.documents(
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
      competenceCheck.pupilId,
      include: PupilSchemas.allInclude,
    );
    return pupilData!;
  }
}
