import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/hub_document_helper.dart';
import 'package:school_data_hub_server/src/_features/pupil/schemas/pupil_schemas.dart';
import 'package:serverpod/serverpod.dart';

/// Include for fetching a SupportGoal with its goal checks and their documents.
final _supportGoalInclude = SupportGoal.include(
  goalChecks: SupportGoalCheck.includeList(
    include: SupportGoalCheck.include(documents: HubDocument.includeList()),
  ),
);

class LearningSupportPlanEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- SUPPORT GOALS: FETCH ---------------------------------------------------

  /// Fetch all support goals (used for reconnect / bulk loads).
  Future<List<SupportGoal>> fetchAllSupportGoals(
    Session session,
  ) async {
    return SupportGoal.db.find(
      session,
      include: _supportGoalInclude,
    );
  }

  /// Fetch support goals for a single pupil (lazy loading).
  Future<List<SupportGoal>> fetchSupportGoalsForPupil(
    Session session,
    int pupilId,
  ) async {
    return SupportGoal.db.find(
      session,
      where: (t) => t.pupilId.equals(pupilId),
      include: _supportGoalInclude,
    );
  }

  //- LEARNING SUPPORT PLANS -------------------------------------------------

  Future<List<LearningSupportPlan>> fetchLearningSupportPlans(
    Session session,
  ) async {
    final plans = await LearningSupportPlan.db.find(
      session,
      include: LearningSupportPlan.include(
        schoolSemester: SchoolSemester.include(),
      ),
    );
    return plans;
  }

  Future<LearningSupportPlan> createLearningSupportPlan(
    Session session,
    LearningSupportPlan plan,
  ) async {
    final newPlan = await session.db.insertRow(plan);
    return newPlan;
  }

  Future<bool> updateLearningSupportPlan(
    Session session,
    LearningSupportPlan plan,
  ) async {
    await session.db.updateRow(plan);
    return true;
  }

  Future<bool> deleteLearningSupportPlan(
    Session session,
    LearningSupportPlan plan,
  ) async {
    await session.db.deleteRow<LearningSupportPlan>(plan);
    return true;
  }

  //- SUPPORT CATEGORY STATUS ------------------------------------------------

  Future<PupilData> postSupportCategoryStatus(
    Session session,
    int pupilId,
    int supportCategoryId,
    int learningSupportPlanId,
    int status,
    String? comment,
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
    return await session.db.transaction((transaction) async {
      final categoryStatusInDataBase = await SupportCategoryStatus.db.insertRow(
        session,
        newSupportCategoryStatus,
        transaction: transaction,
      );
      await PupilData.db.attach.supportCategoryStatuses(
          session,
          pupil!,
          [
            categoryStatusInDataBase,
          ],
          transaction: transaction);
      final updatedPupil = await PupilData.db.findById(
        session,
        pupilId,
        include: PupilSchemas.allInclude,
        transaction: transaction,
      );
      return updatedPupil!;
    });
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
    int statusId,
    int? status,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
  ) async {
    final existingStatus = await SupportCategoryStatus.db.findById(
      session,
      statusId,
    );
    if (existingStatus == null) {
      throw Exception(
        'SupportCategoryStatus not found for statusId: $statusId',
      );
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
        'SupportCategoryStatus not found for pupilId: $pupilId and supportCategoryId: $statusId',
      );
    }
    return await session.db.transaction((transaction) async {
      await PupilData.db.detach.supportCategoryStatuses(
          session,
          [
            existingStatus,
          ],
          transaction: transaction);
      await SupportCategoryStatus.db
          .deleteRow(session, existingStatus, transaction: transaction);

      final updatedPupil = await PupilData.db.findById(
        session,
        pupilId,
        include: PupilSchemas.allInclude,
        transaction: transaction,
      );
      if (updatedPupil == null) {
        throw Exception('Pupil not found after deletion');
      }
      return updatedPupil;
    });
  }

  //- SUPPORT GOALS: CRUD ---------------------------------------------------

  Future<bool> postCategoryGoal(
    Session session,
    int pupilId,
    int supportCategoryId,
    String description,
    String strategies,
    String createdBy,
  ) async {
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

    final result = await session.db.transaction((transaction) async {
      final goalInDb = await SupportGoal.db.insertRow(
        session,
        newSupportGoal,
        transaction: transaction,
      );
      final pupil = await PupilData.db.findById(
        session,
        pupilId,
        transaction: transaction,
      );
      await PupilData.db.attach.supportGoals(
        session,
        pupil!,
        [goalInDb],
        transaction: transaction,
      );

      // Re-fetch with includes.
      return (await SupportGoal.db.findById(
        session,
        goalInDb.id!,
        include: _supportGoalInclude,
        transaction: transaction,
      ))!;
    });

    session.messages.postMessage('hub_events_stream', result);
    return true;
  }

  Future<bool> updateCategoryGoal(
    Session session,
    int pupilId,
    int supportGoalId,
    String? description,
    String? strategies,
    int? supportCategoryId,
  ) async {
    final existingGoal = await SupportGoal.db.findById(session, supportGoalId);
    if (existingGoal == null) {
      throw Exception('SupportGoal not found for id: $supportGoalId');
    }

    final updatedGoal = existingGoal.copyWith(
      description: description ?? existingGoal.description,
      strategies: strategies ?? existingGoal.strategies,
      supportCategoryId: supportCategoryId ?? existingGoal.supportCategoryId,
    );
    await SupportGoal.db.updateRow(session, updatedGoal);

    final result = (await SupportGoal.db.findById(
      session,
      supportGoalId,
      include: _supportGoalInclude,
    ))!;

    session.messages.postMessage('hub_events_stream', result);
    return true;
  }

  Future<bool> deleteCategoryGoal(
    Session session,
    int pupilId,
    int supportGoalId,
  ) async {
    final existingGoal = await SupportGoal.db.findById(
      session,
      supportGoalId,
      include: _supportGoalInclude,
    );
    if (existingGoal == null) {
      throw Exception('SupportGoal not found for id: $supportGoalId');
    }

    final goalId = existingGoal.id!;

    await session.db.transaction((transaction) async {
      // Delete all documents from all goal checks
      for (final check in existingGoal.goalChecks ?? <SupportGoalCheck>[]) {
        final checkWithDocs = await SupportGoalCheck.db.findById(
          session,
          check.id!,
          include: SupportGoalCheck.include(
            documents: HubDocument.includeList(),
          ),
          transaction: transaction,
        );
        for (final doc in checkWithDocs?.documents ?? <HubDocument>[]) {
          await SupportGoalCheck.db.detachRow.documents(
            session,
            doc,
            transaction: transaction,
          );
          await HubDocument.db.deleteRow(
            session,
            doc,
            transaction: transaction,
          );
          if (doc.documentPath != null) {
            await session.storage.deleteFile(
              storageId: 'private',
              path: doc.documentPath!,
            );
          }
        }
        // Detach and delete the goal check
        await SupportGoal.db.detach.goalChecks(
          session,
          [check],
          transaction: transaction,
        );
        await SupportGoalCheck.db.deleteRow(
          session,
          check,
          transaction: transaction,
        );
      }
      // Detach and delete the goal itself
      await PupilData.db.detach.supportGoals(
        session,
        [existingGoal],
        transaction: transaction,
      );
      await SupportGoal.db.deleteRow(
        session,
        existingGoal,
        transaction: transaction,
      );
    });

    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(
        id: goalId,
        objectType: HubObjectType.supportGoal,
      ),
    );
    return true;
  }

  //- SUPPORT GOAL CHECKS ---------------------------------------------------

  Future<bool> postSupportGoalCheck(
    Session session,
    int supportGoalId,
    int score,
    String comment,
    String createdBy,
  ) async {
    final supportGoal = await SupportGoal.db.findById(
      session,
      supportGoalId,
      include: _supportGoalInclude,
    );
    if (supportGoal == null) {
      throw Exception('SupportGoal not found for id: $supportGoalId');
    }
    final checkId = Uuid().v4().toString();
    final newSupportGoalCheck = SupportGoalCheck(
      checkId: checkId,
      supportGoalId: supportGoalId,
      score: score,
      comment: comment,
      createdBy: createdBy,
      createdAt: DateTime.now().toUtc(),
    );

    final result = await session.db.transaction((transaction) async {
      final checkInDatabase = await SupportGoalCheck.db.insertRow(
        session,
        newSupportGoalCheck,
        transaction: transaction,
      );
      await SupportGoal.db.attach.goalChecks(
        session,
        supportGoal,
        [checkInDatabase],
        transaction: transaction,
      );
      return (await SupportGoal.db.findById(
        session,
        supportGoalId,
        include: _supportGoalInclude,
        transaction: transaction,
      ))!;
    });

    session.messages.postMessage('hub_events_stream', result);
    return true;
  }

  Future<bool> updateSupportGoalCheck(
    Session session,
    int supportGoalCheckId,
    int? score,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
  ) async {
    final existingCheck = await SupportGoalCheck.db.findById(
      session,
      supportGoalCheckId,
    );
    if (existingCheck == null) {
      throw Exception('SupportGoalCheck not found for id: $supportGoalCheckId');
    }
    final updatedCheck = existingCheck.copyWith(
      score: score ?? existingCheck.score,
      comment: comment ?? existingCheck.comment,
      createdBy: createdBy ?? existingCheck.createdBy,
      createdAt: createdAt ?? existingCheck.createdAt,
    );
    await session.db.updateRow(updatedCheck);

    // Post the parent SupportGoal to hub stream.
    final result = (await SupportGoal.db.findById(
      session,
      existingCheck.supportGoalId,
      include: _supportGoalInclude,
    ))!;

    session.messages.postMessage('hub_events_stream', result);
    return true;
  }

  Future<bool> deleteSupportGoalCheck(
    Session session,
    int supportGoalId,
    int supportGoalCheckId,
  ) async {
    final existingCheck = await SupportGoalCheck.db.findById(
      session,
      supportGoalCheckId,
      include: SupportGoalCheck.include(documents: HubDocument.includeList()),
    );
    if (existingCheck == null) {
      throw Exception('SupportGoalCheck not found for id: $supportGoalCheckId');
    }
    await session.db.transaction((transaction) async {
      // Delete all documents from the goal check
      for (final doc in existingCheck.documents ?? <HubDocument>[]) {
        await SupportGoalCheck.db.detachRow.documents(
          session,
          doc,
          transaction: transaction,
        );
        await HubDocument.db.deleteRow(
          session,
          doc,
          transaction: transaction,
        );
        if (doc.documentPath != null) {
          await session.storage.deleteFile(
            storageId: 'private',
            path: doc.documentPath!,
          );
        }
      }
      // Detach and delete the goal check
      await SupportGoal.db.detach.goalChecks(
        session,
        [existingCheck],
        transaction: transaction,
      );
      await SupportGoalCheck.db.deleteRow(
        session,
        existingCheck,
        transaction: transaction,
      );
    });

    // Post the updated parent SupportGoal to hub stream.
    final result = (await SupportGoal.db.findById(
      session,
      supportGoalId,
      include: _supportGoalInclude,
    ))!;

    session.messages.postMessage('hub_events_stream', result);
    return true;
  }

  //- GOAL CHECK DOCUMENTS --------------------------------------------------

  Future<bool> addFileToSupportGoalCheck(
    Session session,
    int supportGoalId,
    int supportGoalCheckId,
    String filePath,
    String createdBy,
  ) async {
    final goalCheck = await SupportGoalCheck.db.findById(
      session,
      supportGoalCheckId,
      include: SupportGoalCheck.include(documents: HubDocument.includeList()),
    );
    if (goalCheck == null) {
      throw Exception('SupportGoalCheck not found for id: $supportGoalCheckId');
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

      await SupportGoalCheck.db.attachRow.documents(
        session,
        goalCheck,
        documentInDatabase,
        transaction: transaction,
      );

      return (await SupportGoal.db.findById(
        session,
        supportGoalId,
        include: _supportGoalInclude,
        transaction: transaction,
      ))!;
    });

    session.messages.postMessage('hub_events_stream', result);
    return true;
  }

  Future<bool> removeFileFromSupportGoalCheck(
    Session session,
    int supportGoalId,
    int supportGoalCheckId,
    String documentId,
  ) async {
    final goalCheck = await SupportGoalCheck.db.findById(
      session,
      supportGoalCheckId,
      include: SupportGoalCheck.include(documents: HubDocument.includeList()),
    );
    if (goalCheck == null) {
      throw Exception('SupportGoalCheck not found for id: $supportGoalCheckId');
    }

    final documentToRemove = goalCheck.documents?.firstWhere(
      (doc) => doc.documentId == documentId,
      orElse: () => throw Exception(
        'Document with id $documentId not found in goal check',
      ),
    );

    if (documentToRemove == null) {
      throw Exception('Document with id $documentId not found in goal check');
    }

    await session.db.transaction((transaction) async {
      await SupportGoalCheck.db.detachRow.documents(
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

    final result = (await SupportGoal.db.findById(
      session,
      supportGoalId,
      include: _supportGoalInclude,
    ))!;

    session.messages.postMessage('hub_events_stream', result);
    return true;
  }
}
