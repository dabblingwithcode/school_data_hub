import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/data/learning_support_api_service.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/models/pupil_support_goals_proxy.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class LearningSupportManager {
  //- IMPORTS -//

  final _schoolCalendarManager = di<SchoolCalendarManager>();

  final _learningSupportApiService = LearningSupportApiService();

  final _pupilManager = di<PupilProxyManager>();

  final _hubSessionManager = di<HubSessionManager>();

  final _notificationService = di<NotificationManager>();

  //- OBSERVABLES -//

  final _learningSupportPlans =
      ValueNotifier<Map<int, List<LearningSupportPlan>>>({});

  ValueListenable<Map<int, List<LearningSupportPlan>>>
  get learningSupportPlans => _learningSupportPlans;

  // -- Support goal state (per-pupil, lazy-loaded) --
  final Map<int, PupilSupportGoalsProxy> _pupilSupportGoalsMap = {};
  final Set<int> _loadedPupilIds = {};

  StreamSubscription<dynamic>? _hubSubscription;

  /// Returns the per-pupil proxy, creating it lazily if needed.
  PupilSupportGoalsProxy getPupilSupportGoalsProxy(int pupilId) {
    return _pupilSupportGoalsMap.putIfAbsent(
      pupilId,
      () => PupilSupportGoalsProxy(),
    );
  }

  /// Returns the current list of support goals for a pupil.
  /// Returns an empty list if not yet loaded.
  List<SupportGoal> getSupportGoals(int pupilId) {
    return _pupilSupportGoalsMap[pupilId]?.supportGoals ?? [];
  }

  /// Fetches goals for a single pupil from the server (lazy loading).
  Future<void> fetchGoalsForPupil(int pupilId) async {
    final goals = await _learningSupportApiService.fetchSupportGoalsForPupil(
      pupilId,
    );
    if (goals != null) {
      getPupilSupportGoalsProxy(pupilId).setSupportGoals(goals);
      _loadedPupilIds.add(pupilId);
    }
  }

  /// Fetches all goals (used on reconnect for already-loaded pupils).
  Future<void> _refetchLoadedGoals() async {
    final goals = await _learningSupportApiService.fetchAllSupportGoals();
    if (goals == null) return;

    // Clear and repopulate only loaded proxies.
    for (final pupilId in _loadedPupilIds) {
      final proxy = _pupilSupportGoalsMap[pupilId];
      if (proxy != null) {
        proxy.setSupportGoals(
          goals.where((g) => g.pupilId == pupilId).toList(),
        );
      }
    }
  }

  void _upsertGoalFromStream(SupportGoal goal) {
    getPupilSupportGoalsProxy(goal.pupilId).upsertSupportGoal(goal);
  }

  void _deleteGoalFromStream(int goalId) {
    for (final proxy in _pupilSupportGoalsMap.values) {
      if (proxy.supportGoals.any((g) => g.id == goalId)) {
        proxy.removeSupportGoalById(goalId);
        return;
      }
    }
  }

  LearningSupportManager() {
    _hubSubscription = di<HubStreamService>().events.listen(_onHubEvent);
  }

  void _onHubEvent(dynamic event) {
    if (event is SupportGoal) {
      _upsertGoalFromStream(event);
    } else if (event is HubDeleteEvent) {
      if (event.objectType == HubObjectType.supportGoal) {
        _deleteGoalFromStream(event.id);
      }
    } else if (event is HubReconnected) {
      _refetchLoadedGoals();
    } else if (event is HubSelectiveReconnect) {
      if (event.changedTypes.contains(HubObjectType.supportGoal)) {
        _refetchLoadedGoals();
      }
    }
  }

  void dispose() {
    _hubSubscription?.cancel();
    _hubSubscription = null;
    _learningSupportPlans.dispose();
    _pupilSupportGoalsMap.clear();
    _loadedPupilIds.clear();
  }

  Future<void> postNewLearningSupportPlan({
    required int pupilId,
    required int supportLevelId,

    required int number,
    String? specialNeedsTeacher,
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
    final encryptedComment = comment != null
        ? customEncrypter.encryptString(comment)
        : null;
    final encryptedStrengthsDescription = strengthsDescription != null
        ? customEncrypter.encryptString(strengthsDescription)
        : null;
    final encryptedProblemsDescription = problemsDescription != null
        ? customEncrypter.encryptString(problemsDescription)
        : null;
    final plan = await _learningSupportApiService.postLearningSupportPlan(
      LearningSupportPlan(
        pupilId: pupilId,
        number: number,
        learningSupportLevelId: supportLevelId,
        planId: const Uuid().v4(),
        comment: encryptedComment,
        socialPedagogue: socialPedagogue,
        specialNeedsTeacher: specialNeedsTeacher,
        proffesionalsInvolved: proffesionalsInvolved,
        strengthsDescription: encryptedStrengthsDescription,
        problemsDescription: encryptedProblemsDescription,
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
    required int number,
    required String? comment,
    required String? socialPedagogue,
    required String? specialNeedsTeacher,
    required String? proffesionalsInvolved,
    required String? strengthsDescription,
    required String? problemsDescription,
  }) async {
    final encryptedComment = comment != null
        ? customEncrypter.encryptString(comment)
        : null;

    final encryptedStrengthsDescription = strengthsDescription != null
        ? customEncrypter.encryptString(strengthsDescription)
        : null;
    final encryptedProblemsDescription = problemsDescription != null
        ? customEncrypter.encryptString(problemsDescription)
        : null;
    final updatedPlan = plan.copyWith(
      comment: encryptedComment,
      specialNeedsTeacher: specialNeedsTeacher,
      number: number,
      socialPedagogue: socialPedagogue,
      proffesionalsInvolved: proffesionalsInvolved,
      strengthsDescription: encryptedStrengthsDescription,
      problemsDescription: encryptedProblemsDescription,
    );
    final success = await _learningSupportApiService.updateLearningSupportPlan(
      updatedPlan,
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
    required String? comment,
  }) async {
    final learningSupportPlan = getCurrentLearningSupportPlan(pupilId);

    if (learningSupportPlan == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Kein Förderplan für das aktuelle Semester gefunden.',
      );
      return;
    }
    final encryptedComment = comment != null && comment != ''
        ? customEncrypter.encryptString(comment)
        : null;
    final updatedPupil = await ClientHelper.apiCall(
      call: () => _learningSupportApiService.postSupportCategoryStatus(
        pupilId: pupilId,
        supportCategoryId: supportCategoryId,
        learningSupportPlanId: learningSupportPlan.id!,
        status: status,
        comment: encryptedComment,
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

  //- SUPPORT GOALS ----------------------------------------------------------

  Future<void> postNewSupportCategoryGoal({
    required int goalCategoryId,
    required int pupilId,
    required String description,
    required String strategies,
  }) async {
    await _learningSupportApiService.postNewCategoryGoal(
      pupilId: pupilId,
      supportCategoryId: goalCategoryId,
      description: description,
      strategies: strategies,
      createdBy: _hubSessionManager.userName!,
    );

    _notificationService.showSnackBar(
      NotificationType.success,
      'Ziel hinzugefügt',
    );
  }

  Future<void> updateSupportGoal({
    required int pupilId,
    required int supportGoalId,
    String? description,
    String? strategies,
    int? supportCategoryId,
  }) async {
    await _learningSupportApiService.updateCategoryGoal(
      pupilId: pupilId,
      supportGoalId: supportGoalId,
      description: description,
      strategies: strategies,
      supportCategoryId: supportCategoryId,
    );

    _notificationService.showSnackBar(
      NotificationType.success,
      'Ziel aktualisiert',
    );
  }

  Future<void> deleteSupportGoal({
    required int pupilId,
    required int supportGoalId,
  }) async {
    await _learningSupportApiService.deleteCategoryGoal(
      pupilId: pupilId,
      supportGoalId: supportGoalId,
    );

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
    await _learningSupportApiService.postSupportGoalCheck(
      supportGoalId: supportGoalId,
      score: score,
      comment: comment,
      createdBy: _hubSessionManager.userName!,
    );

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
    await _learningSupportApiService.deleteSupportGoalCheck(
      supportGoalId: supportGoalId,
      supportGoalCheckId: supportGoalCheckId,
    );

    _notificationService.showSnackBar(
      NotificationType.success,
      'Ziel-Check gelöscht',
    );
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
    await _learningSupportApiService.addFileToSupportGoalCheck(
      supportGoalId: supportGoalId,
      supportGoalCheckId: supportGoalCheckId,
      file: encryptedFile,
      createdBy: createdBy,
      fileInfo: fileInfo,
    );

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
    await _learningSupportApiService.removeFileFromSupportGoalCheck(
      supportGoalId: supportGoalId,
      supportGoalCheckId: supportGoalCheckId,
      documentId: documentId,
    );

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
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
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
        NotificationType.error,
        'Fehler beim Importieren der Förderstufen: $e',
      );
    }
  }
}
