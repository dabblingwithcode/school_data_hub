import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();

final _client = di<Client>();

class PupilWorkbookApiService {
  //- create

  Future<PupilWorkbook> postNewPupilWorkbook(
      {required int pupilId,
      required int isbn,
      required String createdBy}) async {
    final postedPupilWorkbook = await ClientHelper.apiCall(
      call: () => _client.pupilWorkbooks.postPupilWorkbook(
        isbn,
        pupilId,
        createdBy,
      ),
      errorMessage: 'Fehler beim Erstellen des Arbeitshefts',
    );
    return postedPupilWorkbook;
  }

  //- read

  Future<List<PupilWorkbook>> fetchAllPupilWorkbooks() async {
    final fetchedPupilWorkbooks =
        await ClientHelper.apiCall<List<PupilWorkbook>>(
      call: () => _client.pupilWorkbooks.fetchPupilWorkbooks(),
      errorMessage: 'Fehler beim Laden der Arbeitshefte',
    );

    return fetchedPupilWorkbooks;
  }

  Future<List<PupilWorkbook>> fetchAllPupilWorkbooksFromPupil(
      {required int pupilId}) async {
    final fetchedPupilWorkbooks =
        await ClientHelper.apiCall<List<PupilWorkbook>>(
      call: () => _client.pupilWorkbooks.fetchPupilWorkbooksFromPupil(pupilId),
      errorMessage: 'Fehler beim Laden der Arbeitshefte des Schülers',
    );
    return fetchedPupilWorkbooks;
  }

  // - update

  Future<PupilWorkbook> updatePupilWorkbook(
      int pupilId, PupilWorkbook pupilWorkbook) async {
    final updatedPupilWorkbook = await ClientHelper.apiCall<PupilWorkbook>(
      call: () => _client.pupilWorkbooks.updatePupilWorkbook(
        pupilWorkbook,
      ),
      errorMessage: 'Fehler beim Aktualisieren des Arbeitshefts',
    );

    _notificationService.showSnackBar(
        NotificationType.success, 'Arbeitsheft erfolgreich aktualisiert');

    return updatedPupilWorkbook;
  }

  //- delete pupil workbook

  Future<bool> deletePupilWorkbook(int pupilWorkbookId) async {
    final result = await ClientHelper.apiCall<bool>(
      call: () => _client.pupilWorkbooks.deletePupilWorkbook(pupilWorkbookId),
      errorMessage: 'Fehler beim Löschen des Arbeitshefts',
    );

    return result;
  }
}
