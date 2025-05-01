import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();
final _serverpodSessionManager = di<ServerpodSessionManager>();
final _notificationService = di<NotificationService>();
final _log = Logger('SchoolListApiService');

class SchoolListApiService {
  //- get school lists

  Future<List<SchoolList>> fetchSchoolLists() async {
    try {
      _notificationService.apiRunning(true);
      final response = await _client.schoolList
          .fetchSchoolLists(_serverpodSessionManager.userName!);
      _notificationService.apiRunning(false);
      return response;
    } catch (e) {
      _notificationService.apiRunning(false);

      _log.severe('Error fetching school lists: $e');

      throw Exception(
          'Fehler beim Abrufen der Schullisten: $e'); // Handle the error as needed
    }
  }

  //- post school list

  Future<SchoolList> postSchoolListWithGroup(
      {required String name,
      required String description,
      required List<int> pupilIds,
      required bool public}) async {
    _notificationService.apiRunning(true);

    try {
      _notificationService.apiRunning(true);
      final response = await _client.schoolList.postSchoolList(name,
          description, pupilIds, public, _serverpodSessionManager.userName!);
      _notificationService.apiRunning(false);
      return response;
    } catch (e) {
      _notificationService.apiRunning(false);
      _log.severe('Error creating school list: $e');

      throw Exception(
          'Fehler beim Erstellen der Schulliste: $e'); // Handle the error as needed
    }
  }

  //- update school list

  Future<SchoolList> updateSchoolListProperty(
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

    try {
      _notificationService.apiRunning(true);

      final response = await _client.schoolList
          .updateSchoolList(listId, name, description, public, updateMembers);

      _notificationService.apiRunning(false);
      return response;
    } catch (e) {
      _notificationService.apiRunning(false);
      _log.severe('Error updating school list: $e');
      throw Exception('Fehler beim Aktualisieren der Schulliste: $e');
    }
  }

//   //- delete school list

  Future<bool> deleteSchoolList(int listId) async {
    _notificationService.apiRunning(true);

    try {
      final response = await _client.schoolList.deleteSchoolList(listId);
      _notificationService.apiRunning(false);
      return response;
    } catch (e) {
      _notificationService.apiRunning(false);
      _log.severe('Error deleting school list: $e');
      throw Exception('Fehler beim Löschen der Schulliste: $e');
    }
  }

//   //- update pupil list property

  Future<PupilListEntry> updatePupilEntry({
    required PupilListEntry entry,
  }) async {
    try {
      _notificationService.apiRunning(true);

      final updatedEntry = await _client.schoolList.updatePupilListEntry(entry);
      _notificationService.apiRunning(false);
      return updatedEntry;
    } catch (e) {
      _notificationService.apiRunning(false);
      _log.severe('Error updating pupil list entry: $e');
      throw Exception('Fehler beim Aktualisieren des Eintrags: $e');
    }
  }
}
