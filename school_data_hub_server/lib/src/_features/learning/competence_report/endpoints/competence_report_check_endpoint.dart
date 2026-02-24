import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CompetenceReportCheckEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<CompetenceReportCheck> postCompetenceReportCheck(
    Session session, {
    required int pupilId,
    required int competenceReportItemId,
    required int competenceReportId,
    required int achievement,
    required String comment,
    required String createdBy,
    bool? shouldPrint,
  }) async {
    final check = CompetenceReportCheck(
      publicId: Uuid().v4(),
      achievement: achievement,
      comment: comment,
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
      shouldPrint: shouldPrint,
      pupilId: pupilId,
      competenceId: competenceReportItemId,
      competenceReportId: competenceReportId,
    );

    final result = await session.db.transaction((transaction) async {
      final inserted = await CompetenceReportCheck.db.insertRow(
        session,
        check,
        transaction: transaction,
      );

      final pupil = await PupilData.db.findById(
        session,
        pupilId,
        transaction: transaction,
      );
      if (pupil == null) {
        throw Exception('PupilData with id $pupilId not found.');
      }
      await PupilData.db.attachRow.competenceReportChecks(
        session,
        pupil,
        inserted,
        transaction: transaction,
      );

      final reportItem = await CompetenceReportItem.db.findById(
        session,
        competenceReportItemId,
        transaction: transaction,
      );
      if (reportItem == null) {
        throw Exception(
          'CompetenceReportItem with id $competenceReportItemId not found.',
        );
      }
      await CompetenceReportItem.db.attachRow.competenceReportchecks(
        session,
        reportItem,
        inserted,
        transaction: transaction,
      );

      final report = await CompetenceReport.db.findById(
        session,
        competenceReportId,
        transaction: transaction,
      );
      if (report == null) {
        throw Exception(
          'CompetenceReport with id $competenceReportId not found.',
        );
      }
      await CompetenceReport.db.attachRow.competenceReportChecks(
        session,
        report,
        inserted,
        transaction: transaction,
      );

      return inserted;
    });

    return result;
  }

  Future<CompetenceReportCheck> updateCompetenceReportCheck(
    Session session,
    String publicId, {
    ({int value})? achievement,
    ({String value})? comment,
    ({bool? value})? shouldPrint,
  }) async {
    final check = await CompetenceReportCheck.db.findFirstRow(
      session,
      where: (t) => t.publicId.equals(publicId),
    );
    if (check == null) {
      throw Exception(
        'CompetenceReportCheck with publicId $publicId not found.',
      );
    }

    if (achievement != null) {
      check.achievement = achievement.value;
    }
    if (comment != null) {
      check.comment = comment.value;
    }
    if (shouldPrint != null) {
      check.shouldPrint = shouldPrint.value;
    }

    return await CompetenceReportCheck.db.updateRow(session, check);
  }

  Future<bool> deleteCompetenceReportCheck(
    Session session,
    String publicId,
  ) async {
    final check = await CompetenceReportCheck.db.findFirstRow(
      session,
      where: (t) => t.publicId.equals(publicId),
    );
    if (check == null) {
      throw Exception(
        'CompetenceReportCheck with publicId $publicId not found.',
      );
    }

    await CompetenceReportCheck.db.deleteRow(session, check);
    return true;
  }
}
