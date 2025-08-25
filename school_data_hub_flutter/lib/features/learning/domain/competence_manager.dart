import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning/data/competence_check_api_service.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/domain/filters/competence_filter_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class CompetenceManager {
  final _envManager = di<EnvManager>();

  final _client = di<Client>();

  final _notificationService = di<NotificationService>();

  final _competenceCheckApiService = CompetenceCheckApiService();

  final _competences = ValueNotifier<List<Competence>>([]);
  ValueListenable<List<Competence>> get competences => _competences;

  final _isRunning = ValueNotifier<bool>(false);
  ValueListenable<bool> get isRunning => _isRunning;

  Map<int, int> _rootCompetencesMap = {};
  Map<int, int> get rootCompetencesMap => _rootCompetencesMap;

  Competence getCompetenceById(int publicId) {
    return _competences.value.firstWhere(
      (element) => element.publicId == publicId,
    );
  }

  CompetenceManager();
  Future<CompetenceManager> init() async {
    await firstFetchCompetences();

    return this;
  }

  void clearData() {
    _competences.value = [];
  }

  //-TODO: Workaround to avoid registration error
  //- when inclduing the CompetenceFilterManager because
  //- the CompetenceFilterManager is not registered in the di yet

  Future<void> firstFetchCompetences() async {
    final List<Competence> competences =
        await _client.competence.getAllCompetences();
    if (competences.isNotEmpty) {
      //- Do we need to sort the competences here?
      //   competences.sort((a, b) => a.publicId.compareTo(b.publicId));

      _competences.value = competences;

      _envManager.setPopulatedEnvServerData(competences: true);

      _rootCompetencesMap.clear();

      _rootCompetencesMap = CompetenceHelper.generateRootCompetencesMap(
        competences,
      );
    }

    _notificationService.showSnackBar(
      NotificationType.success,
      'Kompetenzen aktualisiert!',
    );

    return;
  }

  Future<void> fetchCompetences() async {
    final List<Competence> competences =
        await _client.competence.getAllCompetences();

    final sortedCompetences = CompetenceHelper.sortCompetences(competences);
    _competences.value = sortedCompetences;

    _rootCompetencesMap.clear();

    _rootCompetencesMap = CompetenceHelper.generateRootCompetencesMap(
      competences,
    );

    di<CompetenceFilterManager>().refreshFilteredCompetences(competences);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Kompetenzen aktualisiert!',
    );

    return;
  }

  Future<void> postNewCompetence({
    int? parentCompetence,
    required String competenceName,
    required List<String> competenceLevel,
    required List<String> indicators,
  }) async {
    final newCompetence = await _client.competence.postCompetence(
      name: competenceName,
      level: competenceLevel,
      indicators: indicators,
    );

    _competences.value = CompetenceHelper.sortCompetences([
      ..._competences.value,
      newCompetence,
    ]);
    di<CompetenceFilterManager>().refreshFilteredCompetences(
      _competences.value,
    );
    _rootCompetencesMap = CompetenceHelper.generateRootCompetencesMap(
      _competences.value,
    );
    _notificationService.showSnackBar(
      NotificationType.success,
      'Kompetenz erstellt',
    );

    return;
  }

  Future<void> importCompetencesFromFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      File file = File(pickedFile.files.single.path!);

      final fileResponse = await ClientFileUpload.uploadFile(
        file,
        ServerStorageFolder.temp,
      );

      if (fileResponse.success == false) {
        _notificationService.showSnackBar(
          NotificationType.error,
          'Die Datei konnte nicht hochgeladen werden!',
        );
        return;
      }
      final List<Competence> importedCompetences = await _client.admin
          .importCompetencesFromJsonFile(fileResponse.path!);

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
    final competence =
        competenceListIndex != -1
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
    final verifiedUpdatedCompetence = await _client.competence.updateCompetence(
      updatedCompetence,
    );

    final List<Competence> competences = List.from(_competences.value);

    competences[competenceListIndex] = verifiedUpdatedCompetence;

    _competences.value = competences;

    di<CompetenceFilterManager>().refreshFilteredCompetences(
      _competences.value,
    );

    _notificationService.showSnackBar(
      NotificationType.success,
      'Kompetenz aktualisiert',
    );

    return;
  }

  Future<void> deleteCompetence(int publicId) async {
    final bool success = await _client.competence.deleteCompetence(publicId);

    if (success) {
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
    } else {
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
  }) async {
    final createdBy = di<HubSessionManager>().userName;
    final PupilData? updatedPupilData = await _competenceCheckApiService
        .postCompetenceCheck(
          pupilId: pupilId,
          competenceId: competenceId,
          createdBy: createdBy!,
        );
    if (updatedPupilData == null) {
      return;
    }
    di<PupilManager>().updatePupilProxyWithPupilData(updatedPupilData);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Kompetenzcheck erstellt',
    );

    return;
  }

  Future<void> postCompetenceCheckWithFile({
    required int pupilId,
    required int publicId,
    required int competenceStatus,
    required String competenceComment,
    required String? groupId,
    required File file,
  }) async {
    // final PupilData updatedPupilData =
    //     await _competenceCheckApiService.postCompetenceCheckWithFile(
    //   pupilId: pupilId,
    //   publicId: publicId,
    //   groupId: groupId,
    //   file: file,
    // );
    // di<PupilManager>().updatePupilProxyWithPupilData(updatedPupilData);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Kompetenzcheck erstellt',
    );

    return;
  }

  Future<void> updateCompetenceCheck({
    required String competenceCheckId,
    int? competenceStatus,
    String? competenceComment,
    DateTime? createdAt,
    String? createdBy,
    bool? isReport,
  }) async {
    // final PupilData updatedPupilData =
    //     await _competenceCheckApiService.patchCompetenceCheck(
    //   competenceCheckId: competenceCheckId,
    //   competenceStatus: competenceStatus,
    //   createdAt: createdAt,
    //   createdBy: createdBy,
    //   comment: competenceComment,
    // );
    //   di<PupilManager>().updatePupilProxyWithPupilData(updatedPupilData);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Kompetenzcheck aktualisiert',
    );

    return;
  }

  Future<void> deleteCompetenceCheck(String competenceCheckId) async {
    // final PupilData pupilData = await _competenceCheckApiService
    //     .deleteCompetenceCheck(competenceCheckId);

    // _notificationService.showSnackBar(
    //     NotificationType.success, 'Kompetenzcheck gelöscht');

    // di<PupilManager>().updatePupilProxyWithPupilData(pupilData);

    return;
  }

  Future<void> postCompetenceCheckFile({
    required String competenceCheckId,
    required File file,
  }) async {
    // final PupilData updatedPupilData =
    //     await _competenceCheckApiService.postCompetenceCheckFile(
    //   competenceCheckId: competenceCheckId,
    //   file: file,
    // );

    // di<PupilManager>().updatePupilProxyWithPupilData(updatedPupilData);

    // _notificationService.showSnackBar(
    //     NotificationType.success, 'Datei zum Kompetenzcheck hinzugefügt');

    // return;
  }

  Future<void> deleteCompetenceCheckFile({
    required String competenceCheckId,
    required String fileId,
  }) async {
    // final PupilData updatedPupilData =
    //     await _competenceCheckApiService.deleteCompetenceCheckFile(fileId);

    // di<PupilManager>().updatePupilProxyWithPupilData(updatedPupilData);

    // _notificationService.showSnackBar(
    //     NotificationType.success, 'Datei vom Kompetenzcheck gelöscht');

    // return;
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

  bool isCompetenceWithChildren(Competence competence) {
    return _competences.value.any(
      (element) => element.parentCompetence == competence.publicId,
    );
  }
}
