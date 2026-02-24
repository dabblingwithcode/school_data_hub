import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CompetenceReportEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<CompetenceReport> postCompetenceReport(
    Session session, {
    required int pupilId,
    required int schoolSemesterId,
    required String achievement,
    required DateTime achievedAt,
    required String createdBy,
  }) async {
    final report = CompetenceReport(
      reportId: Uuid().v4(),
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
      modifiedBy: createdBy,
      modifiedAt: null,
      achievement: achievement,
      achievedAt: achievedAt,
      pupilId: pupilId,
      schoolSemesterId: schoolSemesterId,
    );

    final result = await session.db.transaction((transaction) async {
      final inserted = await CompetenceReport.db.insertRow(
        session,
        report,
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
      await PupilData.db.attachRow.competenceReports(
        session,
        pupil,
        inserted,
        transaction: transaction,
      );

      final semester = await SchoolSemester.db.findById(
        session,
        schoolSemesterId,
        transaction: transaction,
      );
      if (semester == null) {
        throw Exception(
          'SchoolSemester with id $schoolSemesterId not found.',
        );
      }
      await SchoolSemester.db.attachRow.competenceReports(
        session,
        semester,
        inserted,
        transaction: transaction,
      );

      return inserted;
    });

    return result;
  }

  Future<List<CompetenceReport>> fetchCompetenceReports(
    Session session,
    int pupilId,
  ) async {
    return await CompetenceReport.db.find(
      session,
      where: (t) => t.pupilId.equals(pupilId),
      include: CompetenceReport.include(
        competenceReportChecks: CompetenceReportCheck.includeList(),
      ),
    );
  }

  Future<CompetenceReport> updateCompetenceReport(
    Session session,
    String reportId, {
    ({String value})? achievement,
    ({DateTime value})? achievedAt,
    ({String value})? modifiedBy,
    ({DateTime? value})? modifiedAt,
  }) async {
    final report = await CompetenceReport.db.findFirstRow(
      session,
      where: (t) => t.reportId.equals(reportId),
    );
    if (report == null) {
      throw Exception('CompetenceReport with reportId $reportId not found.');
    }

    if (achievement != null) {
      report.achievement = achievement.value;
    }
    if (achievedAt != null) {
      report.achievedAt = achievedAt.value;
    }
    if (modifiedBy != null) {
      report.modifiedBy = modifiedBy.value;
    }
    if (modifiedAt != null) {
      report.modifiedAt = modifiedAt.value;
    }

    return await CompetenceReport.db.updateRow(session, report);
  }

  Future<bool> deleteCompetenceReport(
    Session session,
    String reportId,
  ) async {
    final report = await CompetenceReport.db.findFirstRow(
      session,
      where: (t) => t.reportId.equals(reportId),
    );
    if (report == null) {
      throw Exception('CompetenceReport with reportId $reportId not found.');
    }

    await CompetenceReport.db.deleteRow(session, report);
    return true;
  }
}
