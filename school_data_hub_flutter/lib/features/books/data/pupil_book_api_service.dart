import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();

class PupilBookApiService {
  //- create pupil book lending

  Future<PupilData?> postPupilBookLending({
    required int pupilId,
    required String libraryId,
    required String lentBy,
  }) async {
    final pupil = await ClientHelper.apiCall(
      call:
          () => _client.pupilBookLending.postPupilBookLending(
            pupilId,
            libraryId,
            lentBy,
          ),
      errorMessage: 'Fehler beim Erstellen des Leihvorgangs',
    );
    return pupil;
  }

  //- update pupil book lending

  Future<PupilData?> updatePupilBookLending({
    required PupilBookLending bookLending,
  }) async {
    final pupil = await ClientHelper.apiCall(
      call: () => _client.pupilBookLending.updatePupilBookLending(bookLending),
      errorMessage: 'Fehler beim Aktualisieren des Leihvorgangs',
    );
    return pupil;
  }

  //- delete pupil book

  Future<PupilData?> deletePupilBook(String lendingId) async {
    final pupil = await ClientHelper.apiCall(
      call: () => _client.pupilBookLending.deletePupilBookLending(lendingId),
      errorMessage: 'Fehler beim Löschen des Leihvorgangs',
    );
    return pupil;
  }
}
