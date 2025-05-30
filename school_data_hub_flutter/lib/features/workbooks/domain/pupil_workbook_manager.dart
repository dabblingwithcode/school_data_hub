import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/data/pupil_workbook_api_service.dart';
import 'package:watch_it/watch_it.dart';

final _hubSessionManager = di<HubSessionManager>();
final _notificationService = di<NotificationService>();

class PupilWorkbookManager with ChangeNotifier {
  final Map<int, List<PupilWorkbook>> _pupilWorkbooks = {};
  final _pupilWorkbookApiService = PupilWorkbookApiService();

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
      int pupilId, int isbn, String createdBy) async {
    final createdBy = _hubSessionManager.userName!;
    final PupilWorkbook responsePupil =
        await _pupilWorkbookApiService.postNewPupilWorkbook(
            pupilId: pupilId, isbn: isbn, createdBy: createdBy);

    addPupilWorkbook(pupilId, responsePupil);

    _notificationService.showSnackBar(
        NotificationType.success, 'Arbeitsheft erstellt');

    return;
  }

  //- read

  Future<void> fetchPupilWorkbooks(int pupilId) async {
    // Simulate fetching from an API or database
    // In a real application, you would replace this with an actual API call
    List<PupilWorkbook> fetchedWorkbooks = await _pupilWorkbookApiService
        .fetchAllPupilWorkbooksFromPupil(pupilId: pupilId);

    _pupilWorkbooks[pupilId] = fetchedWorkbooks;
    notifyListeners();
  }

  //- update

  Future<void> updatePupilWorkbook(
      {required PupilWorkbook pupilWorkbook,
      ({String? value})? comment,
      int? score,
      String? createdBy,
      DateTime? createdAt,
      DateTime? finishedAt}) async {
    final PupilWorkbook pupilWorkbookToUpdate = pupilWorkbook.copyWith(
      comment: comment != null ? comment.value : pupilWorkbook.comment,
      score: score ?? pupilWorkbook.score,
      createdBy: createdBy ?? pupilWorkbook.createdBy,
      createdAt: createdAt ?? pupilWorkbook.createdAt,
      finishedAt: finishedAt ?? pupilWorkbook.finishedAt,
    );

    final updatedPupilWorkbook = await ClientHelper.apiCall(
      call: () => _pupilWorkbookApiService.updatePupilWorkbook(
        pupilWorkbook.pupilId,
        pupilWorkbookToUpdate,
      ),
      errorMessage: 'Fehler beim Aktualisieren des Arbeitshefts',
    );

    // - TODO: check this AI code
    //// Update the local collection
    if (_pupilWorkbooks.containsKey(pupilWorkbook.pupilId)) {
      final index = _pupilWorkbooks[pupilWorkbook.pupilId]!
          .indexWhere((wb) => wb.isbn == pupilWorkbook.isbn);
      if (index != -1) {
        _pupilWorkbooks[pupilWorkbook.pupilId]![index] = updatedPupilWorkbook;
        notifyListeners();
      }
    } else {
      _pupilWorkbooks[pupilWorkbook.pupilId] = [updatedPupilWorkbook];
      notifyListeners();
    }

    _notificationService.showSnackBar(
        NotificationType.success, 'Arbeitsheft aktualisiert');

    return;
  }

  //- delete

  Future<void> deletePupilWorkbook(int pupilId, int pupilWorkbookId) async {
    final response = await ClientHelper.apiCall<bool>(
      call: () => _pupilWorkbookApiService.deletePupilWorkbook(
        pupilWorkbookId,
      ),
      errorMessage: 'Fehler beim Löschen des Arbeitshefts',
    );
    if (!response) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen des Arbeitshefts');
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
        NotificationType.success, 'Arbeitsheft gelöscht');

    return;
  }
}
