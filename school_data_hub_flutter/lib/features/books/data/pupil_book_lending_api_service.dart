import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';

class PupilBookLendingApiService {
  Client get _client => di<Client>();

  //- read

  Future<List<PupilBookLending>?> fetchAllPupilBookLendings() async {
    final lendings = await ClientHelper.apiCall(
      call: () => _client.pupilBookLending.fetchPupilBookLendings(),
      errorMessage: 'Fehler beim Laden der Leihvorgänge',
    );
    return lendings;
  }

  Future<PupilBookLending?> fetchPupilBookLendingByLendingId(
    String lendingId,
  ) async {
    final lending = await ClientHelper.apiCall(
      call: () =>
          _client.pupilBookLending.fetchPupilBookLendingByLendingId(lendingId),
      errorMessage: 'Fehler beim Laden des Leihvorgangs',
    );
    return lending;
  }

  //- create

  Future<PupilBookLending?> postPupilBookLending({
    required int pupilId,
    required String libraryId,
    required String lentBy,
  }) async {
    final lending = await ClientHelper.apiCall(
      call: () => _client.pupilBookLending.postPupilBookLending(
        pupilId,
        libraryId,
        lentBy,
      ),
      errorMessage: 'Fehler beim Erstellen des Leihvorgangs',
    );
    return lending;
  }

  //- update

  Future<PupilBookLending?> updatePupilBookLending({
    required PupilBookLending bookLending,
  }) async {
    final lending = await ClientHelper.apiCall(
      call: () => _client.pupilBookLending.updatePupilBookLending(bookLending),
      errorMessage: 'Fehler beim Aktualisieren des Leihvorgangs',
    );
    return lending;
  }

  //- Add file to lending

  Future<PupilBookLending?> addFileToPupilBookLending({
    required String lendingId,
    required String filePath,
    required String addedBy,
  }) async {
    final lending = await ClientHelper.apiCall(
      call: () => _client.pupilBookLending.addFileToPupilBookLending(
        lendingId,
        filePath,
        addedBy,
      ),
      errorMessage: 'Fehler beim Hinzufügen der Datei zur Ausleihe',
    );
    return lending;
  }

  //- delete file from lending

  Future<bool?> removeFileFromPupilBookLending({
    required String lendingId,
    required String fileId,
  }) async {
    final success = await ClientHelper.apiCall(
      call: () => _client.pupilBookLending.removeFileFromPupilBookLending(
        lendingId,
        fileId,
      ),
      errorMessage: 'Fehler beim Entfernen der Datei von der Ausleihe',
    );
    return success;
  }

  //- delete

  Future<bool?> deletePupilBookLending({required String lendingId}) async {
    final success = await ClientHelper.apiCall(
      call: () => _client.pupilBookLending.deletePupilBookLending(lendingId),
      errorMessage: 'Fehler beim Löschen des Leihvorgangs',
    );
    return success;
  }
}
