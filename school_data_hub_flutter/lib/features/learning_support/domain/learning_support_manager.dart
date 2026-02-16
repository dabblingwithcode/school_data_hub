import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/data/learning_support_api_service.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:flutter_it/flutter_it.dart';

class LearningSupportManager {
  //- IMPORTS -//

  final _schoolCalendarManager = di<SchoolCalendarManager>();

  final _learningSupportApiService = LearningSupportApiService();

  final _pupilManager = di<PupilProxyManager>();

  final _hubSessionManager = di<HubSessionManager>();

  final _notificationService = di<NotificationService>();

  //- OBSERVABLES -//
  void dispose() {
    _learningSupportPlans.dispose();
  }

  final _learningSupportPlans =
      ValueNotifier<Map<int, List<LearningSupportPlan>>>({});

  ValueListenable<Map<int, List<LearningSupportPlan>>>
  get learningSupportPlans => _learningSupportPlans;

  Future<void> postNewLearningSupportPlan({
    required int pupilId,
    required int supportLevelId,
    required String planId,
    String? comment,
    String? socialPedagogue,
    String? proffesionalsInvolved,
    String? strengthsDescription,
    String? problemsDescription,
  }) async {
    // First check if we have a current semester
    final currentSemester = _schoolCalendarManager.currentSemester.value;

    if (currentSemester == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Kein aktuelles Schulhalbjahr gefunden.',
      );
      return;
    }

    final pupilLearningSupportPlans =
        _learningSupportPlans.value[pupilId] ?? [];
    final existingPlan = pupilLearningSupportPlans.firstWhereOrNull(
      (p) => p.schoolSemesterId == currentSemester.id,
    );
    if (existingPlan != null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Für das aktuelle Schulhalbjahr existiert bereits ein Förderplan.',
      );
      return;
    }
    final plan = await _learningSupportApiService.postLearningSupportPlan(
      LearningSupportPlan(
        pupilId: pupilId,
        learningSupportLevelId: supportLevelId,
        planId: planId,
        comment: comment,
        socialPedagogue: socialPedagogue,
        proffesionalsInvolved: proffesionalsInvolved,
        strengthsDescription: strengthsDescription,
        problemsDescription: problemsDescription,
        schoolSemesterId: currentSemester.id!,
        createdBy: _hubSessionManager.userName!,
        createdAt: DateTime.now(),
      ),
    );

    if (plan == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Erstellen des Förderplans.',
      );
      return;
    }
    final plansToUpdate = _learningSupportPlans.value;
    plansToUpdate[pupilId] = [...pupilLearningSupportPlans, plan];

    _learningSupportPlans.value = plansToUpdate;

    await _pupilManager.updatePupilData(pupilId);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Förderplan erstellt',
    );
    return;
  }

  Future<bool> updateLearningSupportPlan({
    required LearningSupportPlan plan,
  }) async {
    final success = await _learningSupportApiService.updateLearningSupportPlan(
      plan,
    );

    if (!success) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Aktualisieren des Förderplans.',
      );
      return false;
    }

    // Update the local plan in the pupil's data
    await _pupilManager.updatePupilData(plan.pupilId);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Förderplan aktualisiert',
    );
    return true;
  }

  LearningSupportPlan? getCurrentLearningSupportPlan(int pupilId) {
    return di<PupilProxyManager>()
        .getPupilByPupilId(pupilId)!
        .learningSupportPlans
        ?.firstWhereOrNull(
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
    final updatedPupil = await _learningSupportApiService
        .deleteSupportCategoryStatus(pupilId, statusId);
    if (updatedPupil == null) {
      return;
    }
    _pupilManager.updatePupilProxyWithPupilData(updatedPupil);
    return;
  }

  Future<void> updateSupportCategoryStatus({
    required int pupilId,
    required int statusId,
    int? score,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
  }) async {
    final updatedStatus = await _learningSupportApiService.updateCategoryStatus(
      pupilId,
      statusId,
      score,
      comment,
      createdBy,
      createdAt,
    );

    if (updatedStatus == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Aktualisieren des Status.',
      );
      return;
    }

    // Update the status in-place on the pupil proxy
    final pupil = _pupilManager.getPupilByPupilId(pupilId);
    if (pupil != null) {
      final statuses = pupil.supportCategoryStatuses;
      if (statuses != null) {
        final index = statuses.indexWhere((s) => s.id == statusId);
        if (index != -1) {
          statuses[index] = updatedStatus;
          pupil.notifyChanged();
        }
      }
    }

    _notificationService.showSnackBar(
      NotificationType.success,
      'Status aktualisiert',
    );
  }

  Future<void> postNewSupportCategoryGoal({
    required int goalCategoryId,
    required int pupilId,
    required String description,
    required String strategies,
  }) async {
    final PupilData? responsePupil = await _learningSupportApiService
        .postNewCategoryGoal(
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
      NotificationType.success,
      'Ziel hinzugefügt',
    );

    return;
  }

  Future<void> updateSupportGoal({
    required int pupilId,
    required int supportGoalId,
    String? description,
    String? strategies,
    int? supportCategoryId,
  }) async {
    final responsePupil = await _learningSupportApiService.updateCategoryGoal(
      pupilId: pupilId,
      supportGoalId: supportGoalId,
      description: description,
      strategies: strategies,
      supportCategoryId: supportCategoryId,
    );
    if (responsePupil == null) {
      return;
    }
    _pupilManager.updatePupilProxyWithPupilData(responsePupil);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Ziel aktualisiert',
    );
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

  Future<void> deleteSupportGoal({
    required int pupilId,
    required int supportGoalId,
  }) async {
    final updatedPupil = await _learningSupportApiService.deleteCategoryGoal(
      pupilId: pupilId,
      supportGoalId: supportGoalId,
    );
    if (updatedPupil == null) {
      return;
    }
    _pupilManager.updatePupilProxyWithPupilData(updatedPupil);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Ziel gelöscht',
    );
  }

  //- GOAL CHECKS ----------------------------------------------------------

  Future<void> postSupportGoalCheck({
    required int supportGoalId,
    required int pupilId,
    required int score,
    required String comment,
  }) async {
    final updatedGoal = await _learningSupportApiService.postSupportGoalCheck(
      supportGoalId: supportGoalId,
      score: score,
      comment: comment,
      createdBy: _hubSessionManager.userName!,
    );

    if (updatedGoal == null) {
      return;
    }

    _updatePupilSupportGoal(pupilId, updatedGoal);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Ziel-Check hinzugefügt',
    );
  }

  Future<void> deleteSupportGoalCheck({
    required int supportGoalId,
    required int supportGoalCheckId,
    required int pupilId,
  }) async {
    final updatedGoal = await _learningSupportApiService.deleteSupportGoalCheck(
      supportGoalId: supportGoalId,
      supportGoalCheckId: supportGoalCheckId,
    );

    if (updatedGoal == null) {
      return;
    }

    _updatePupilSupportGoal(pupilId, updatedGoal);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Ziel-Check gelöscht',
    );
  }

  void _updatePupilSupportGoal(int pupilId, SupportGoal updatedGoal) {
    final pupil = _pupilManager.getPupilByPupilId(pupilId);
    if (pupil == null) return;

    final goals = pupil.supportGoals;
    if (goals == null) return;

    final goalIndex = goals.indexWhere((g) => g.id == updatedGoal.id);
    if (goalIndex != -1) {
      goals[goalIndex] = updatedGoal;
      pupil.notifyChanged();
    }
  }

  //- GOAL CHECK DOCUMENTS --------------------------------------------------

  Future<void> addFileToSupportGoalCheck({
    required int supportGoalId,
    required int supportGoalCheckId,
    required int pupilId,
    required File file,
    String? fileInfo,
  }) async {
    final encryptedFile = await customEncrypter.encryptFile(file);
    final createdBy = _hubSessionManager.userName!;
    final updatedGoal = await _learningSupportApiService
        .addFileToSupportGoalCheck(
          supportGoalId: supportGoalId,
          supportGoalCheckId: supportGoalCheckId,
          file: encryptedFile,
          createdBy: createdBy,
          fileInfo: fileInfo,
        );

    if (updatedGoal == null) {
      return;
    }

    _updatePupilSupportGoal(pupilId, updatedGoal);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Datei hinzugefügt',
    );
  }

  Future<void> removeFileFromSupportGoalCheck({
    required int supportGoalId,
    required int supportGoalCheckId,
    required int pupilId,
    required String documentId,
  }) async {
    final updatedGoal = await _learningSupportApiService
        .removeFileFromSupportGoalCheck(
          supportGoalId: supportGoalId,
          supportGoalCheckId: supportGoalCheckId,
          documentId: documentId,
        );

    if (updatedGoal == null) {
      return;
    }

    _updatePupilSupportGoal(pupilId, updatedGoal);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Datei entfernt',
    );
  }

  //- BULK IMPORT SUPPORT LEVELS ------------------------------------------

  Future<void> importSupportLevelsFromFile() async {
    try {
      _notificationService.showSnackBar(
        NotificationType.info,
        'Förderstufen werden importiert...',
      );

      // Let user pick the JSON file
      final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (pickedFile == null) {
        _notificationService.showSnackBar(
          NotificationType.info,
          'Import abgebrochen',
        );
        return;
      }

      final File file = File(pickedFile.files.single.path!);

      if (!await file.exists()) {
        _notificationService.showSnackBar(
          NotificationType.error,
          'Datei nicht gefunden',
        );
        return;
      }

      // Read and parse the JSON file
      final String jsonString = await file.readAsString();
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<Map<String, dynamic>> supportLevelData = jsonList
          .cast<Map<String, dynamic>>();

      List<SupportLevelLegacyDto> supportLevelDataDtos = supportLevelData
          .map(
            (e) => SupportLevelLegacyDto(
              pupilId: e['pupil_id'] as int,
              level: int.parse(e['level'] as String),
              comment: e['comment'] != ''
                  ? customEncrypter.encryptString(e['comment'] as String)
                  : '',
              createdAt: DateTime.parse(e['created_at'] as String).toUtc(),
              createdBy: e['created_by'] as String? ?? 'ADM',
            ),
          )
          .toList();
      // Call the API service
      final bool importedSupportLevels = await _learningSupportApiService
          .bulkImportSupportLevels(supportLevelDataDtos);

      if (importedSupportLevels) {
        _notificationService.showSnackBar(
          NotificationType.success,
          '$importedSupportLevels Förderstufen erfolgreich importiert',
        );
      } else {
        _notificationService.showSnackBar(
          NotificationType.warning,
          'Keine Förderstufen importiert',
        );
      }
    } catch (e) {
      _notificationService.showInformationDialog(
        'Fehler beim Importieren der Förderstufen: $e',
      );
    }
  }
}
