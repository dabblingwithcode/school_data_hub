import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/data/learning_support_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

class LearningSupportPlanManager with ChangeNotifier {
  final _schoolCalendarManager = di<SchoolCalendarManager>();

  final _learningSupportApiService = LearningSupportApiService();

  final _pupilManager = di<PupilManager>();

  final _hubSessionManager = di<HubSessionManager>();

  final _notificationService = di<NotificationService>();

  final _learningSupportPlans =
      ValueNotifier<Map<int, List<LearningSupportPlan>>>({});

  LearningSupportPlan? getCurrentLearningSupportPlan(int pupilId) {
    return _learningSupportPlans.value[pupilId]?.firstWhereOrNull(
      (plan) =>
          plan.schoolSemesterId ==
          _schoolCalendarManager.currentSemester.value!.id,
    );
  }

  List<LearningSupportPlan> getLearningSupportPlans(int pupilId) {
    return _learningSupportPlans.value[pupilId] ?? [];
  }

  Future<void> postSupportCategoryStatus({
    required int pupilId,
    required int supportCategoryId,
    required int status,
    required String comment,
  }) async {
    final learningSupportPlan = getCurrentLearningSupportPlan(pupilId);

    if (learningSupportPlan == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Kein Förderplan für das aktuelle Semester gefunden.',
      );
      return;
    }
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _learningSupportApiService.postSupportCategoryStatus(
        pupilId: pupilId,
        supportCategoryId: supportCategoryId,
        learningSupportPlanId: learningSupportPlan.id!,
        status: status,
        comment: comment,
        createdBy: _hubSessionManager.userName!,
      ),
    );
    if (updatedPupil == null) {
      return;
    }
    _pupilManager.updatePupilProxyWithPupilData(updatedPupil);
    return;
  }

  Future<void> deleteSupportCategoryStatus(int pupilId, int statusId) async {
    final updatedPupil =
        await _learningSupportApiService.deleteSupportCategoryStatus(
      pupilId,
      statusId,
    );
    if (updatedPupil == null) {
      return;
    }
    _pupilManager.updatePupilProxyWithPupilData(updatedPupil);
    return;
  }
  // Future<void> updateSupportCategoryStatusProperty({
  //   required PupilProxy pupil,
  //   required String statusId,
  //   String? state,
  //   String? comment,
  //   String? createdBy,
  //   String? createdAt,
  // }) async {
  //   final PupilData responsePupil =
  //       await _learningSupportApiService.updateCategoryStatusProperty(
  //           pupil, statusId, state, comment, createdBy, createdAt);

  //   locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

  //   _notificationService.showSnackBar(
  //       NotificationType.success, 'Status aktualisiert');

  //   return;
  // }

  // Future<void> deleteSupportCategoryStatus(String statusId) async {
  //   final PupilData responsePupil =
  //       await _learningSupportApiService.deleteCategoryStatus(statusId);

  //   _notificationService.showSnackBar(
  //       NotificationType.success, 'Status gelöscht');

  //   locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);
  //   return;
  // }

  Future<void> postNewSupportCategoryGoal({
    required int goalCategoryId,
    required int pupilId,
    required String description,
    required String strategies,
  }) async {
    final PupilData? responsePupil =
        await _learningSupportApiService.postNewCategoryGoal(
      pupilId: pupilId,
      supportCategoryId: goalCategoryId,
      description: description,
      strategies: strategies,
      createdBy: _hubSessionManager.userName!,
    );
    if (responsePupil == null) {
      return;
    }
    _pupilManager.updatePupilProxyWithPupilData(responsePupil);

    _notificationService.showSnackBar(
        NotificationType.success, 'Ziel hinzugefügt');

    return;
  }
  // Future postNewSupportCategoryGoal(
  //     {required int goalCategoryId,
  //     required int pupilId,
  //     required String description,
  //     required String strategies}) async {
  //   final PupilData responsePupil =
  //       await _learningSupportApiService.postNewCategoryGoal(
  //           goalCategoryId: goalCategoryId,
  //           pupilId: pupilId,
  //           description: description,
  //           strategies: strategies);

  //   locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

  //   _notificationService.showSnackBar(
  //       NotificationType.success, 'Ziel hinzugefügt');

  //   return;
  // }

  // Future deleteGoal(String goalId) async {
  //   final PupilData responsePupil =
  //       await _learningSupportApiService.deleteGoal(goalId);

  //   locator<PupilManager>().updatePupilProxyWithPupilData(responsePupil);

  //   _notificationService.showSnackBar(
  //       NotificationType.success, 'Ziel gelöscht');

  //   return;
  // }
}
