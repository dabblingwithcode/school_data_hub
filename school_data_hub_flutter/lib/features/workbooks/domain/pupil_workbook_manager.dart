import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/data/pupil_workbook_api_service.dart';

class PupilWorkbookManager with ChangeNotifier {
  HubSessionManager get _hubSessionManager => di<HubSessionManager>();
  NotificationManager get _notificationService => di<NotificationManager>();
  final _log = Logger('PupilWorkbookManager');
  StreamSubscription<dynamic>? _hubSubscription;
  final Map<int, List<PupilWorkbook>> _pupilWorkbooks = {};
  final _pupilWorkbookApiService = PupilWorkbookApiService();

  Future<PupilWorkbookManager> init() async {
    final pupilWorkbooks = await _pupilWorkbookApiService
        .fetchAllPupilWorkbooks();
    if (pupilWorkbooks == null) {
      return this;
    }
    for (var pupilWorkbook in pupilWorkbooks) {
      addPupilWorkbook(pupilWorkbook.pupilId, pupilWorkbook);
    }

    _hubSubscription = di<HubStreamService>().events.listen(_onHubEvent);

    return this;
  }

  List<PupilWorkbook> getPupilWorkbooks(int pupilId) {
    return _pupilWorkbooks[pupilId] ?? [];
  }

  List<PupilWorkbook> getAllPupilWorkbooks() {
    return _pupilWorkbooks.values.expand((workbooks) => workbooks).toList();
  }

  void addPupilWorkbook(int pupilId, PupilWorkbook workbook) {
    if (_pupilWorkbooks.containsKey(pupilId)) {
      _pupilWorkbooks[pupilId]!.add(workbook);
    } else {
      _pupilWorkbooks[pupilId] = [workbook];
    }
    notifyListeners();
  }

  void removePupilWorkbook(int pupilId, PupilWorkbook workbook) {
    if (_pupilWorkbooks.containsKey(pupilId)) {
      _pupilWorkbooks[pupilId]!.remove(workbook);
      if (_pupilWorkbooks[pupilId]!.isEmpty) {
        _pupilWorkbooks.remove(pupilId);
      }
      notifyListeners();
    }
  }

  void clearPupilWorkbooks() {
    _pupilWorkbooks.clear();
    notifyListeners();
  }

  //- Repository calls

  //- create

  Future<void> postPupilWorkbook(
    int pupilId,
    int isbn,
    String createdBy,
  ) async {
    final createdBy = _hubSessionManager.userName!;
    final PupilWorkbook? responsePupil = await _pupilWorkbookApiService
        .postNewPupilWorkbook(
          pupilId: pupilId,
          isbn: isbn,
          createdBy: createdBy,
        );
    if (responsePupil == null) {
      return;
    }
    addPupilWorkbook(pupilId, responsePupil);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Arbeitsheft erstellt',
    );

    return;
  }

  //- read

  Future<void> fetchPupilWorkbooks(int pupilId) async {
    // Simulate fetching from an API or database
    // In a real application, you would replace this with an actual API call
    List<PupilWorkbook>? fetchedWorkbooks = await _pupilWorkbookApiService
        .fetchAllPupilWorkbooksFromPupil(pupilId: pupilId);
    if (fetchedWorkbooks == null) {
      return;
    }
    _pupilWorkbooks[pupilId] = fetchedWorkbooks;
    notifyListeners();
  }

  //- update

  Future<void> updatePupilWorkbook({
    required PupilWorkbook pupilWorkbook,
    ({String? value})? comment,
    int? score,
    String? createdBy,
    DateTime? createdAt,

    /// Use [finishedAt: (value: date)] to set, [finishedAt: (value: null)] to clear.
    ({DateTime? value})? finishedAt,
  }) async {
    final PupilWorkbook pupilWorkbookToUpdate = pupilWorkbook.copyWith(
      comment: comment != null ? comment.value : pupilWorkbook.comment,
      score: score ?? pupilWorkbook.score,
      createdBy: createdBy ?? pupilWorkbook.createdBy,
      createdAt: createdAt ?? pupilWorkbook.createdAt,
      finishedAt: finishedAt != null
          ? finishedAt.value
          : pupilWorkbook.finishedAt,
    );

    final updatedPupilWorkbook = await ClientHelper.apiCall(
      call: () => _pupilWorkbookApiService.updatePupilWorkbook(
        pupilWorkbook.pupilId,
        pupilWorkbookToUpdate,
      ),
      errorMessage: 'Fehler beim Aktualisieren des Arbeitshefts',
    );
    if (updatedPupilWorkbook == null) {
      return;
    }

    if (_pupilWorkbooks.containsKey(pupilWorkbook.pupilId)) {
      final index = _pupilWorkbooks[pupilWorkbook.pupilId]!.indexWhere(
        (wb) => wb.isbn == pupilWorkbook.isbn,
      );
      if (index != -1) {
        _pupilWorkbooks[pupilWorkbook.pupilId]![index] = updatedPupilWorkbook;
        notifyListeners();
      }
    } else {
      _pupilWorkbooks[pupilWorkbook.pupilId] = [updatedPupilWorkbook];
      notifyListeners();
    }

    _notificationService.showSnackBar(
      NotificationType.success,
      'Arbeitsheft aktualisiert',
    );

    return;
  }

  //- delete

  void deleteAllPupilWorkbooks(int isbn) {
    for (final pupilId in _pupilWorkbooks.keys.toList()) {
      _pupilWorkbooks[pupilId]!.removeWhere((wb) => wb.isbn == isbn);
      if (_pupilWorkbooks[pupilId]!.isEmpty) {
        _pupilWorkbooks.remove(pupilId);
      }
    }
    notifyListeners();
  }

  Future<void> deletePupilWorkbook(int pupilId, int pupilWorkbookId) async {
    final response = await ClientHelper.apiCall(
      call: () => _pupilWorkbookApiService.deletePupilWorkbook(pupilWorkbookId),
      errorMessage: 'Fehler beim Löschen des Arbeitshefts',
    );
    if (response == null) {
      return;
    }

    // Remove the workbook from the local collection
    if (_pupilWorkbooks.containsKey(pupilId)) {
      _pupilWorkbooks[pupilId]!.removeWhere((wb) => wb.id == pupilWorkbookId);
      if (_pupilWorkbooks[pupilId]!.isEmpty) {
        _pupilWorkbooks.remove(pupilId);
      }
      notifyListeners();
    }

    _notificationService.showSnackBar(
      NotificationType.success,
      'Arbeitsheft gelöscht',
    );

    return;
  }

  //- Hub stream handlers

  void _onHubEvent(dynamic event) {
    if (event is PupilWorkbook) {
      _upsertFromStream(event);
    } else if (event is HubDeleteEvent &&
        event.objectType == HubObjectType.pupilWorkbook) {
      _deleteFromStream(event.id);
    } else if (event is HubReconnected) {
      _refetchAll();
    } else if (event is HubSelectiveReconnect) {
      if (event.changedTypes.contains(HubObjectType.pupilWorkbook)) {
        _refetchAll();
      }
    }
  }

  void _upsertFromStream(PupilWorkbook workbook) {
    _log.fine('[STREAM] upsert pupilWorkbook ${workbook.id}');
    final pupilId = workbook.pupilId;
    if (_pupilWorkbooks.containsKey(pupilId)) {
      final index = _pupilWorkbooks[pupilId]!.indexWhere(
        (wb) => wb.id == workbook.id,
      );
      if (index != -1) {
        _pupilWorkbooks[pupilId]![index] = workbook;
      } else {
        _pupilWorkbooks[pupilId]!.add(workbook);
      }
    } else {
      _pupilWorkbooks[pupilId] = [workbook];
    }
    notifyListeners();
  }

  void _deleteFromStream(int id) {
    _log.fine('[STREAM] delete pupilWorkbook $id');
    for (final pupilId in _pupilWorkbooks.keys.toList()) {
      _pupilWorkbooks[pupilId]!.removeWhere((wb) => wb.id == id);
      if (_pupilWorkbooks[pupilId]!.isEmpty) {
        _pupilWorkbooks.remove(pupilId);
      }
    }
    notifyListeners();
  }

  Future<void> _refetchAll() async {
    _pupilWorkbooks.clear();
    final pupilWorkbooks = await _pupilWorkbookApiService
        .fetchAllPupilWorkbooks();
    if (pupilWorkbooks == null) return;
    for (var pupilWorkbook in pupilWorkbooks) {
      if (_pupilWorkbooks.containsKey(pupilWorkbook.pupilId)) {
        _pupilWorkbooks[pupilWorkbook.pupilId]!.add(pupilWorkbook);
      } else {
        _pupilWorkbooks[pupilWorkbook.pupilId] = [pupilWorkbook];
      }
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _hubSubscription?.cancel();
    _hubSubscription = null;
    _pupilWorkbooks.clear();
    super.dispose();
  }
}
