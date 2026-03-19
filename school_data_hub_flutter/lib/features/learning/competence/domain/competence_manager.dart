import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/core/client/file_upload_service.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/data/competence_api_service.dart';
import 'package:school_data_hub_flutter/features/learning/competence/data/competence_check_api_service.dart';
import 'package:school_data_hub_flutter/features/learning/competence/data/competence_goal_api_service.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/filters/competence_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/models/pupil_competence_goals_proxy.dart';

final _log = Logger('CompetenceManager');

class CompetenceManager {
  final _envManager = di<EnvManager>();

  final _competenceApiService = CompetenceApiService();

  final _notificationService = di<NotificationManager>();

  final _competenceCheckApiService = CompetenceCheckApiService();
  final _competenceGoalApiService = CompetenceGoalApiService();
  final _competences = ValueNotifier<List<Competence>>([]);
  ValueListenable<List<Competence>> get competences => _competences;
  Map<int, int> _rootCompetencesMap = {};
  Map<int, int> get rootCompetencesMap => _rootCompetencesMap;

  StreamSubscription<dynamic>? _hubSubscription;

  // -- Competence goal state (per-pupil, lazy-loaded) --
  final Map<int, PupilCompetenceGoalsProxy> _pupilCompetenceGoalsMap = {};
  final Set<int> _loadedPupilIds = {};

  /// Returns the per-pupil proxy, creating it lazily if needed.
  PupilCompetenceGoalsProxy getPupilCompetenceGoalsProxy(int pupilId) {
    return _pupilCompetenceGoalsMap.putIfAbsent(
      pupilId,
      () => PupilCompetenceGoalsProxy(),
    );
  }

  /// Returns the current list of competence goals for a pupil.
  /// Returns an empty list if not yet loaded.
  List<CompetenceGoal> getCompetenceGoals(int pupilId) {
    return _pupilCompetenceGoalsMap[pupilId]?.competenceGoals ?? [];
  }

  /// Fetches goals for a single pupil from the server (lazy loading).
  Future<void> fetchGoalsForPupil(int pupilId) async {
    final goals = await _competenceGoalApiService.fetchCompetenceGoalsForPupil(
      pupilId,
    );
    if (goals != null) {
      getPupilCompetenceGoalsProxy(pupilId).setCompetenceGoals(goals);
      _loadedPupilIds.add(pupilId);
    }
  }

  /// Fetches all goals (used on reconnect for already-loaded pupils).
  Future<void> _refetchLoadedGoals() async {
    final goals = await _competenceGoalApiService.fetchAllCompetenceGoals();
    if (goals == null) return;

    // Clear and repopulate only loaded proxies.
    for (final pupilId in _loadedPupilIds) {
      final proxy = _pupilCompetenceGoalsMap[pupilId];
      if (proxy != null) {
        proxy.setCompetenceGoals(
          goals.where((g) => g.pupilId == pupilId).toList(),
        );
      }
    }
  }

  void _upsertGoalFromStream(CompetenceGoal goal) {
    getPupilCompetenceGoalsProxy(goal.pupilId).upsertCompetenceGoal(goal);
  }

  void _deleteGoalFromStream(int goalId) {
    for (final proxy in _pupilCompetenceGoalsMap.values) {
      if (proxy.competenceGoals.any((g) => g.id == goalId)) {
        proxy.removeCompetenceGoalById(goalId);
        return;
      }
    }
  }

  Competence getCompetenceById(int publicId) {
    return _competences.value.firstWhere(
      (element) => element.publicId == publicId,
    );
  }

  CompetenceManager();
  void dispose() {
    _hubSubscription?.cancel();
    _hubSubscription = null;
    _competences.dispose();
    for (final proxy in _pupilCompetenceGoalsMap.values) {
      proxy.dispose();
    }
    _pupilCompetenceGoalsMap.clear();
    _loadedPupilIds.clear();
  }

  Future<CompetenceManager> init() async {
    await firstFetchCompetences();
    _hubSubscription = di<HubStreamService>().events.listen(_onHubEvent);
    return this;
  }

  void _onHubEvent(dynamic event) {
    if (event is Competence) {
      upsertFromStream(event);
    } else if (event is CompetenceGoal) {
      _upsertGoalFromStream(event);
    } else if (event is HubDeleteEvent) {
      if (event.objectType == HubObjectType.competence) {
        deleteFromStream(event.id);
      } else if (event.objectType == HubObjectType.competenceGoal) {
        _deleteGoalFromStream(event.id);
      }
    } else if (event is HubReconnected) {
      fetchCompetences();
      _refetchLoadedGoals();
    } else if (event is HubSelectiveReconnect) {
      if (event.changedTypes.contains(HubObjectType.competence)) {
        fetchCompetences();
      }
      if (event.changedTypes.contains(HubObjectType.competenceGoal)) {
        _refetchLoadedGoals();
      }
    }
  }

  void upsertFromStream(Competence competence) {
    final list = List<Competence>.from(_competences.value);
    final index = list.indexWhere((c) => c.publicId == competence.publicId);
    if (index >= 0) {
      list[index] = competence;
    } else {
      list.add(competence);
    }
    final sorted = CompetenceHelper.sortCompetences(list);
    _competences.value = sorted;
    _rootCompetencesMap = CompetenceHelper.generateRootCompetencesMap(sorted);
    di<CompetenceFilterManager>().refreshFilteredCompetences(sorted);
  }

  void deleteFromStream(int publicId) {
    final current = _competences.value;
    final toRemove = <int>{publicId};
    // Include all descendants so root map never references a deleted competence
    bool added;
    do {
      added = false;
      for (final c in current) {
        if (c.parentCompetence != null &&
            toRemove.contains(c.parentCompetence) &&
            !toRemove.contains(c.publicId)) {
          toRemove.add(c.publicId);
          added = true;
        }
      }
    } while (added);
    final list = current.where((c) => !toRemove.contains(c.publicId)).toList();
    _competences.value = list;
    _rootCompetencesMap = CompetenceHelper.generateRootCompetencesMap(list);
    di<CompetenceFilterManager>().refreshFilteredCompetences(list);
  }

  void clearData() {
    _competences.value = [];
  }

  //-TODO: Workaround to avoid registration error
  //- when inclduing the CompetenceFilterManager because
  //- the CompetenceFilterManager is not registered in the di yet

  Future<void> firstFetchCompetences() async {
    final competences = await _competenceApiService.getAllCompetences();
    if (competences != null && competences.isNotEmpty) {
      _competences.value = competences;
      _envManager.setPopulatedEnvServerData(competences: true);
      _rootCompetencesMap.clear();
      _rootCompetencesMap = CompetenceHelper.generateRootCompetencesMap(
        competences,
      );
      _log.info('Kompetenzen geladen!');
    }
  }

  Future<void> fetchCompetences() async {
    final competences = await _competenceApiService.getAllCompetences();
    if (competences != null) {
      final sortedCompetences = CompetenceHelper.sortCompetences(competences);
      _competences.value = sortedCompetences;
      _rootCompetencesMap.clear();
      _rootCompetencesMap = CompetenceHelper.generateRootCompetencesMap(
        competences,
      );
      di<CompetenceFilterManager>().refreshFilteredCompetences(competences);
      _log.info('Kompetenzen geladen!');
    }
  }

  Future<void> postNewCompetence({
    int? parentCompetence,
    required String competenceName,
    required List<String> competenceLevel,
    required List<String> indicators,
  }) async {
    final newCompetence = await _competenceApiService.postCompetence(
      parentCompetence: parentCompetence,
      name: competenceName,
      level: competenceLevel,
      indicators: indicators,
    );
    if (newCompetence != null) {
      upsertFromStream(newCompetence);
    }
    //- The competence is coming back from the stream, we don't need to do this
    // _competences.value = CompetenceHelper.sortCompetences([
    //   ..._competences.value,
    //   newCompetence,
    // ]);
    // di<CompetenceFilterManager>().refreshFilteredCompetences(
    //   _competences.value,
    // );
    // _rootCompetencesMap = CompetenceHelper.generateRootCompetencesMap(
    //   _competences.value,
    // );

    return;
  }

  Future<void> importCompetencesFromFile() async {
    final fileResponse = await ClientFileUpload.uploadFile(
      storageId: StorageId.private,
      folder: ServerStorageFolder.temp,
    );

    if (fileResponse.success == false) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Die Datei konnte nicht hochgeladen werden!',
      );
      return;
    }
    final importedCompetences = await _competenceApiService
        .importCompetencesFromJsonFile(fileResponse.path!);
    if (importedCompetences != null) {
      final sortedCompetences = CompetenceHelper.sortCompetences(
        importedCompetences,
      );
      _competences.value = sortedCompetences;
      _rootCompetencesMap.clear();
      _rootCompetencesMap = CompetenceHelper.generateRootCompetencesMap(
        sortedCompetences,
      );
      di<CompetenceFilterManager>().refreshFilteredCompetences(
        sortedCompetences,
      );
      _envManager.setPopulatedEnvServerData(competences: true);
      _notificationService.showSnackBar(
        NotificationType.success,
        'Kompetenzen importiert',
      );
    }
  }

  Future<void> updateCompetenceOrder({
    required int publicId,
    required int order,
  }) async {
    final index = _competences.value.indexWhere((c) => c.publicId == publicId);
    if (index == -1) return;

    final competence = _competences.value[index];
    final updatedCompetence = competence.copyWith(order: order);
    final verifiedUpdated = await _competenceApiService.updateCompetence(
      updatedCompetence,
    );
    if (verifiedUpdated != null) {
      _competences.value[index] = verifiedUpdated;
    }
  }

  /// Sorts the competences list by order and notifies listeners.
  /// Call this after order updates are complete (e.g. when leaving the
  /// sortable page) so other pages see the correct order.
  void sortAndNotifyCompetences() {
    final competences = CompetenceHelper.sortCompetences(
      List<Competence>.from(_competences.value),
    );
    _competences.value = competences;
    di<CompetenceFilterManager>().refreshFilteredCompetences(competences);
  }

  Future<void> updateCompetenceProperty({
    required int publicId,
    String? competenceName,
    ({List<String>? value})? competenceLevel,
    ({List<String>? value})? indicators,
    ({int? value})? order,
  }) async {
    final competenceListIndex = _competences.value.indexWhere(
      (element) => element.publicId == publicId,
    );
    final competence = competenceListIndex != -1
        ? _competences.value[competenceListIndex]
        : null;
    if (competence == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Kompetenz nicht gefunden',
      );
      return;
    }

    final updatedCompetence = competence.copyWith(
      name: competenceName ?? competence.name,
      level: competenceLevel != null ? competenceLevel.value : competence.level,
      indicators: indicators != null ? indicators.value : competence.indicators,
      order: order != null ? order.value : competence.order,
    );
    final verifiedUpdatedCompetence = await _competenceApiService
        .updateCompetence(updatedCompetence);
    if (verifiedUpdatedCompetence == null) {
      return;
    }
    final List<Competence> competences = List.from(_competences.value);
    competences[competenceListIndex] = verifiedUpdatedCompetence;
    _competences.value = competences;
    di<CompetenceFilterManager>().refreshFilteredCompetences(
      _competences.value,
    );
    return;
  }

  Future<void> deleteCompetence(int publicId) async {
    if (_competences.value.any((c) => c.parentCompetence == publicId)) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Kompetenz hat Unterkompetenzen. Bitte zuerst die Unterkompetenzen löschen.',
      );
      return;
    }
    final success = await _competenceApiService.deleteCompetence(publicId);

    if (success == true) {
      final List<Competence> competences = List.from(_competences.value);
      competences.removeWhere((element) => element.publicId == publicId);
      _competences.value = competences;
      di<CompetenceFilterManager>().refreshFilteredCompetences(
        _competences.value,
      );
      _notificationService.showSnackBar(
        NotificationType.success,
        'Kompetenz gelöscht',
      );
    } else if (success == false) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Löschen der Kompetenz',
      );
    }
  }

  Future<void> postCompetenceCheck({
    required int pupilId,
    required int competenceId,
    required int score,
    required String? competenceComment,
    required String? groupId,
    String? groupCheckName,
  }) async {
    final createdBy = di<HubSessionManager>().userName;
    final PupilData? updatedPupilData = await _competenceCheckApiService
        .postCompetenceCheck(
          pupilId: pupilId,
          competenceId: competenceId,
          createdBy: createdBy!,
          comment: competenceComment,
          score: score,
          valueFactor: 1,
          groupCheckId: groupId,
          groupCheckName: groupCheckName,
        );
    if (updatedPupilData == null) {
      return;
    }
    di<PupilProxyManager>().updatePupilProxyWithPupilData(updatedPupilData);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Kompetenzcheck erstellt',
    );

    return;
  }

  Future<void> postCompetenceCheckWithFile({
    required int pupilId,
    required int competenceId,
    required int score,
    required String? competenceComment,
    required String? groupId,
    String? groupCheckName,
    String? fileInfo,
    required File file,
  }) async {
    final createdBy = di<HubSessionManager>().userName;

    // First, create the competence check
    final PupilData? updatedPupilData = await _competenceCheckApiService
        .postCompetenceCheck(
          pupilId: pupilId,
          competenceId: competenceId,
          createdBy: createdBy!,
          comment: competenceComment,
          score: score,
          valueFactor: 1,
          groupCheckId: groupId,
          groupCheckName: groupCheckName,
        );

    if (updatedPupilData == null) {
      return;
    }

    // Find the newly created competence check
    final newCheck = updatedPupilData.competenceChecks
        ?.where((check) => check.competenceId == competenceId)
        .lastOrNull;

    if (newCheck == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Erstellen des Kompetenzchecks',
      );
      return;
    }

    // Encrypt and add the file
    final File encryptedFile = await customEncrypter.encryptFile(file);
    final PupilData updatedPupilDataWithFile = await _competenceCheckApiService
        .addFileToCompetenceCheck(
          newCheck.checkId,
          encryptedFile,
          createdBy,
          fileInfo,
        );

    di<PupilProxyManager>().updatePupilProxyWithPupilData(
      updatedPupilDataWithFile,
    );

    _notificationService.showSnackBar(
      NotificationType.success,
      'Kompetenzcheck mit Datei erstellt',
    );

    return;
  }

  Future<void> postCompetenceGoal({
    required int pupilId,
    required int competenceId,
    required String description,
    required List<String> strategies,
  }) async {
    final success = await _competenceGoalApiService.postCompetenceGoal(
      pupilId: pupilId,
      competenceId: competenceId,
      description: description,
      strategies: strategies,
    );
    if (success != true) return;

    _notificationService.showSnackBar(
      NotificationType.success,
      'Lernziel erstellt',
    );
  }

  Future<void> updateCompetenceGoal({
    required String publicId,
    ({int? value})? score,
    ({DateTime? value})? achievedAt,
    ({String value})? description,
    ({List<String>? value})? strategies,
  }) async {
    await _competenceGoalApiService.updateCompetenceGoal(
      publicId: publicId,
      score: score,
      achievedAt: achievedAt,
      description: description,
      strategies: strategies,
    );
  }

  Future<void> deleteCompetenceGoal(String publicId) async {
    final success = await _competenceGoalApiService.deleteCompetenceGoal(
      publicId,
    );
    if (success != true) return;

    _notificationService.showSnackBar(
      NotificationType.success,
      'Lernziel gelöscht',
    );
  }

  Future<void> addFileToCompetenceGoal({
    required String publicId,
    required File file,
    String? fileInfo,
  }) async {
    final encryptedFile = await customEncrypter.encryptFile(file);
    final createdBy = di<HubSessionManager>().userName;
    await _competenceGoalApiService.addFileToCompetenceGoal(
      publicId,
      encryptedFile,
      createdBy!,
      fileInfo,
    );
  }

  Future<void> removeFileFromCompetenceGoal({
    required String publicId,
    required String documentId,
  }) async {
    await _competenceGoalApiService.removeFileFromCompetenceGoal(
      publicId,
      documentId,
    );
  }

  Future<void> updateCompetenceCheck({
    required String competenceCheckId,
    ({int value})? score,
    ({String? value})? competenceComment,
    ({DateTime? value})? createdAt,
    ({String value})? createdBy,
    ({bool? value})? isReport,
    ({double value})? valueFactor,
  }) async {
    final updatedPupilData = await _competenceCheckApiService
        .updateCompetenceCheck(
          competenceCheckId: competenceCheckId,
          score: score,
          createdAt: createdAt,
          createdBy: createdBy,
          competenceComment: competenceComment,
          valueFactor: valueFactor,
        );
    di<PupilProxyManager>().updatePupilProxyWithPupilData(updatedPupilData);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Kompetenzcheck aktualisiert',
    );

    return;
  }

  Future<void> deleteCompetenceCheck(String competenceCheckId) async {
    final PupilData pupilData = await _competenceCheckApiService
        .deleteCompetenceCheck(competenceCheckId);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Kompetenzcheck gelöscht',
    );

    di<PupilProxyManager>().updatePupilProxyWithPupilData(pupilData);

    return;
  }

  Future<void> addFileToCompetenceCheck({
    required String competenceCheckId,
    required File file,
    String? fileInfo,
  }) async {
    try {
      final encryptedFile = await customEncrypter.encryptFile(file);
      final createdBy = di<HubSessionManager>().userName;
      final updatedPupilData = await _competenceCheckApiService
          .addFileToCompetenceCheck(
            competenceCheckId,
            encryptedFile,
            createdBy!,
            fileInfo,
          );
      di<PupilProxyManager>().updatePupilProxyWithPupilData(updatedPupilData);

      _notificationService.showSnackBar(
        NotificationType.success,
        'Datei zum Kompetenzcheck hinzugefügt',
      );
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Hochladen der Datei: $e',
      );
    }
  }

  Future<void> removeFileFromCompetenceCheck({
    required String competenceCheckId,
    required String documentId,
  }) async {
    try {
      final updatedPupilData = await _competenceCheckApiService
          .removeFileFromCompetenceCheck(competenceCheckId, documentId);
      di<PupilProxyManager>().updatePupilProxyWithPupilData(updatedPupilData);

      _notificationService.showSnackBar(
        NotificationType.success,
        'Datei vom Kompetenzcheck entfernt',
      );
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Löschen der Datei: $e',
      );
    }
  }

  Competence findCompetenceById(int competenceId) {
    final Competence competence = _competences.value.firstWhere(
      (element) => element.publicId == competenceId,
    );

    return competence;
  }

  Competence findRootCompetence(Competence competence) {
    return findCompetenceById(_rootCompetencesMap[competence.publicId]!);
  }

  Competence findRootCompetenceById(int competenceId) {
    return findCompetenceById(_rootCompetencesMap[competenceId]!);
  }

  /// Computes badge counts per root competence from the given checks.
  Map<int, int> computeBadgeCounts(List<CompetenceCheck> checks) {
    final Map<int, int> counts = {};
    final Set<int> countedIds = {};

    // Initialize counts for all root competences
    for (final competenceId in _rootCompetencesMap.keys) {
      if (_rootCompetencesMap[competenceId] == competenceId) {
        counts[competenceId] = 0;
      }
    }

    // Count checks per root competence
    for (final check in checks) {
      if (countedIds.contains(check.competenceId)) continue;
      countedIds.add(check.competenceId);

      final rootCompetence = findRootCompetenceById(check.competenceId);
      final int rootId = rootCompetence.publicId;

      if (counts.containsKey(rootId)) {
        counts[rootId] = counts[rootId]! + 1;
      } else {
        counts[rootId] = 1;
      }
    }

    return counts;
  }

  bool isCompetenceWithChildren(Competence competence) {
    return _competences.value.any(
      (element) => element.parentCompetence == competence.publicId,
    );
  }
}
