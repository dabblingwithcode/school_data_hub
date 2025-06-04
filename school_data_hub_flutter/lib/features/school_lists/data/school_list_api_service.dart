import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();
final _hubSessionManager = di<HubSessionManager>();
final _notificationService = di<NotificationService>();
final _log = Logger('SchoolListApiService');

class SchoolListApiService {
  //- get school lists

  Future<List<SchoolList>?> fetchSchoolLists() async {
    final response = await ClientHelper.apiCall(
      call: () =>
          _client.schoolList.fetchSchoolLists(_hubSessionManager.userName!),
      errorMessage: 'Fehler beim Abrufen der Schullisten',
    );
    return response;
  }

  //- post school list

  Future<SchoolList?> postSchoolListWithGroup(
      {required String name,
      required String description,
      required List<int> pupilIds,
      required bool public}) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.schoolList.postSchoolList(
          name, description, pupilIds, public, _hubSessionManager.userName!),
      errorMessage: 'Fehler beim Erstellen der Schulliste',
    );
    return response;
  }

  //- update school list

  Future<SchoolList?> updateSchoolListProperty(
      {required int listId,
      String? name,
      String? description,
      bool? public,
      ({List<int> pupilIds, MemberOperation operation})? updateMembers}) async {
    assert(
        name != null ||
            description != null ||
            public != null ||
            updateMembers != null,
        'At least one property must be provided to update the school list.');
    final response = await ClientHelper.apiCall(
      call: () => _client.schoolList
          .updateSchoolList(listId, name, description, public, updateMembers),
      errorMessage: 'Fehler beim Aktualisieren der Schulliste',
    );
    return response;
  }

//   //- delete school list

  Future<bool?> deleteSchoolList(int listId) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.schoolList.deleteSchoolList(listId),
      errorMessage: 'Fehler beim Löschen der Schulliste',
    );

    return response;
  }

//   //- update pupil list property

  Future<PupilListEntry?> updatePupilEntry({
    required PupilListEntry entry,
  }) async {
    final response = await ClientHelper.apiCall(
      call: () => _client.schoolList.updatePupilListEntry(entry),
      errorMessage: 'Fehler beim Aktualisieren des Eintrags',
    );
    return response;
  }
}
