import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/schemas/pupil_schemas.dart';
import 'package:serverpod/serverpod.dart';

class LearningSupportPlanEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<LearningSupportPlan>> fetchLearningSupportPlans(
      Session session) async {
    final plans = await LearningSupportPlan.db.find(session);
    return plans;
  }

  Future<bool> createLearningSupportPlan(
      Session session, LearningSupportPlan plan) async {
    await session.db.insertRow(plan);
    return true;
  }

  Future<bool> updateLearningSupportPlan(
      Session session, LearningSupportPlan plan) async {
    await session.db.updateRow(plan);
    return true;
  }

  Future<bool> deleteLearningSupportPlan(
      Session session, LearningSupportPlan plan) async {
    await session.db.deleteRow<LearningSupportPlan>(plan);
    return true;
  }

  Future<PupilData> postSupportCategoryStatus(
    Session session,
    int pupilId,
    int supportCategoryId,
    int learningSupportPlanId,
    int status,
    String comment,
    String createdBy,
  ) async {
    final pupil = await PupilData.db.findById(
      session,
      pupilId,
      include: PupilSchemas.allInclude,
    );
    final newSupportCategoryStatus = SupportCategoryStatus(
      learningSupportPlanId: learningSupportPlanId,
      pupilId: pupilId,
      supportCategoryId: supportCategoryId,
      comment: comment,
      score: status,
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
    );
    final categoryStatusInDataBase = await SupportCategoryStatus.db
        .insertRow(session, newSupportCategoryStatus);
    await PupilData.db.attach
        .supportCategoryStatuses(session, pupil!, [categoryStatusInDataBase]);
    final updatedPupil = await PupilData.db.findById(
      session,
      pupilId,
      include: PupilSchemas.allInclude,
    );
    return updatedPupil!;
  }

  Future<List<SupportCategoryStatus>> fetchSupportCategoryStatus(
    Session session,
    int pupilId,
  ) async {
    final statusList = await SupportCategoryStatus.db.find(
      session,
      orderBy: (t) => t.createdAt,
    );
    return statusList;
  }

  Future<List<SupportCategoryStatus>> fetchSupportCategoryStatusFromPupil(
    Session session,
    int pupilId,
  ) async {
    final statusList = await SupportCategoryStatus.db.find(
      session,
      where: (t) => t.pupilId.equals(pupilId),
      orderBy: (t) => t.createdAt,
    );
    return statusList;
  }

  Future<SupportCategoryStatus> updateCategoryStatus(
    Session session,
    int pupilId,
    int supportCategoryId,
    int? status,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
  ) async {
    final existingStatus = await SupportCategoryStatus.db.findFirstRow(
      session,
      where: (t) =>
          t.pupilId.equals(pupilId) &
          t.supportCategoryId.equals(supportCategoryId),
    );
    if (existingStatus == null) {
      throw Exception(
          'SupportCategoryStatus not found for pupilId: $pupilId and supportCategoryId: $supportCategoryId');
    }
    final updatedStatus = existingStatus.copyWith(
      score: status ?? existingStatus.score,
      createdBy: createdBy ?? existingStatus.createdBy,
      createdAt: createdAt ?? existingStatus.createdAt,
      comment: comment ?? existingStatus.comment,
    );
    await session.db.updateRow(updatedStatus);
    return updatedStatus;
  }

  Future<PupilData> deleteSupportCategoryStatus(
    Session session,
    int pupilId,
    int statusId,
  ) async {
    final pupil = await PupilData.db.findById(
      session,
      pupilId,
      include: PupilSchemas.allInclude,
    );
    if (pupil == null) {
      throw Exception('Pupil not found');
    }
    final existingStatus = await SupportCategoryStatus.db.findFirstRow(
      session,
      where: (t) => t.pupilId.equals(pupilId) & t.id.equals(statusId),
    );
    if (existingStatus == null) {
      throw Exception(
          'SupportCategoryStatus not found for pupilId: $pupilId and supportCategoryId: $statusId');
    }
    await PupilData.db.detach
        .supportCategoryStatuses(session, [existingStatus]);
    await session.db.deleteRow<SupportCategoryStatus>(existingStatus);

    final updatedPupil = await PupilData.db.findById(
      session,
      pupilId,
      include: PupilSchemas.allInclude,
    );
    if (updatedPupil == null) {
      throw Exception('Pupil not found after deletion');
    }
    return updatedPupil;
  }

  Future<PupilData> postCategoryGoal(
    Session session,
    int pupilId,
    int supportCategoryId,
    String description,
    String strategies,
    String createdBy,
  ) async {
    final pupil = await PupilData.db.findById(
      session,
      pupilId,
      include: PupilSchemas.allInclude,
    );
    final goalId = Uuid().v4().toString();
    final newSupportGoal = SupportGoal(
      pupilId: pupilId,
      supportCategoryId: supportCategoryId,
      goalId: goalId,
      score: 0,
      description: description,
      strategies: strategies,
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
    );
    final goalInDataBase = await SupportGoal.db.insertRow(
      session,
      newSupportGoal,
    );
    await PupilData.db.attach.supportGoals(session, pupil!, [goalInDataBase]);
    final updatedPupil = await PupilData.db.findById(
      session,
      pupilId,
      include: PupilSchemas.allInclude,
    );
    return updatedPupil!;
  }
}
