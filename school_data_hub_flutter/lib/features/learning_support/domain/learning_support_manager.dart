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
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

class LearningSupportManager with ChangeNotifier {
  //- IMPORTS -//

  final _schoolCalendarManager = di<SchoolCalendarManager>();

  final _learningSupportApiService = LearningSupportApiService();

  final _pupilManager = di<PupilManager>();

  final _hubSessionManager = di<HubSessionManager>();

  final _notificationService = di<NotificationService>();

  //- OBSERVABLES -//
  void dispose() {
    _learningSupportPlans.dispose();
    super.dispose();
    return;
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

    notifyListeners();
    _notificationService.showSnackBar(
      NotificationType.success,
      'Förderplan erstellt',
    );
    return;
  }

  LearningSupportPlan? getCurrentLearningSupportPlan(int pupilId) {
    return di<PupilManager>()
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
          '${importedSupportLevels} Förderstufen erfolgreich importiert',
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
