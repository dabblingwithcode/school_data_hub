import 'package:school_data_hub_server/src/generated/protocol.dart';
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

      return pupil;
    });

    return transactionResult;
  }
}
