import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';

class CompulsoryRoomApiService {
  Client get _client => di<Client>();

  Future<List<CompulsoryRoom>?> getCompulsoryRooms() async {
    return ClientHelper.apiCall<List<CompulsoryRoom>?>(
      call: () => _client.matrix.getCompulsoryRooms(),
      errorMessage: 'Fehler beim Laden der Pflichträume',
    );
  }

  Future<List<CompulsoryRoom>?> setCompulsoryRooms(
    List<CompulsoryRoom> compulsoryRooms,
  ) async {
    return ClientHelper.apiCall(
      call: () => _client.matrix.setCompulsoryRooms(compulsoryRooms),
      errorMessage: 'Fehler beim Speichern der Pflichträume',
    );
  }

  Future<void> deleteCompulsoryRoom(String roomId) async {
    await ClientHelper.apiCall(
      call: () => _client.matrix.deleteCompulsoryRoom(roomId),
      errorMessage: 'Fehler beim Löschen des Pflichtraums',
    );
  }
}
