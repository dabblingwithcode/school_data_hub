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

  static const postSchoolList = '/school_lists/all';

  //- patch school list

  String _patchSchoolListUrl(String listId) {
    return '/school_lists/$listId/patch';
  }

  Future<SchoolList> updateSchoolListProperty(
      {required String listId,
      String? name,
      String? description,
      bool? public,
      ({List<int> pupilIds, String operation})? updateMembers}) async {
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

//   String _deleteSchoolListUrl(String listId) {
//     return '/school_lists/$listId';
//   }

//   Future<List<SchoolList>> deleteSchoolList(String listId) async {
//     _notificationService.apiRunning(true);

//     final Response response = await _client.delete(
//       '${_baseUrl()}${_deleteSchoolListUrl(listId)}',
//       options: _client.hubOptions,
//     );
//     _notificationService.apiRunning(false);

//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Fehler beim Löschen der Schulliste');

//       throw ApiException('Failed to delete school list', response.statusCode);
//     }
//     final List<SchoolList> schoolLists =
//         (response.data as List).map((e) => SchoolList.fromJson(e)).toList();

//     return schoolLists;
//   }

//   //- PUPIL LISTS -//

//   //- POST

//   String _addPupilsToSchoolList(String listId) {
//     return '/school_lists/$listId/pupils';
//   }

//   Future<SchoolList> addPupilsToSchoolList(
//       {required String listId, required List<int> pupilIds}) async {
//     final data = jsonEncode({"pupils": pupilIds});

//     _notificationService.apiRunning(true);

//     final response = await _client.post(
//       '${_baseUrl()}${_addPupilsToSchoolList(listId)}',
//       data: data,
//       options: _client.hubOptions,
//     );

//     _notificationService.apiRunning(false);

//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Fehler beim Hinzufügen zur Schulliste');

//       throw ApiException('Failed to delete school list', response.statusCode);
//     }
//     final SchoolList updatedSchoolList = SchoolList.fromJson(response.data);

//     return updatedSchoolList;
//   }

//   //- update pupil list property

//   String _patchPupilSchoolList(int pupilId, String listId) {
//     return '/pupil_lists/$pupilId/$listId';
//   }

//   Future<SchoolList> patchSchoolListPupil({
//     required int pupilId,
//     required String listId,
//     bool? value,
//     String? comment,
//   }) async {
//     String data;

//     if (value != null) {
//       data = jsonEncode({
//         "pupil_list_status": value,
//         "pupil_list_entry_by":
//             locator<SessionManager>().credentials.value.username
//       });
//     } else {
//       data = jsonEncode({
//         "pupil_list_comment": comment,
//         "pupil_list_entry_by":
//             locator<SessionManager>().credentials.value.username
//       });
//     }
//     _notificationService.apiRunning(true);
//     final response = await _client.patch(
//       '${_baseUrl()}${_patchPupilSchoolList(pupilId, listId)}',
//       data: data,
//       options: _client.hubOptions,
//     );

//     _notificationService.apiRunning(false);

//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Fehler beim Aktualisieren der Schulliste');

//       throw ApiException('Failed to patch school list', response.statusCode);
//     }

//     final SchoolList updatedSchoolList = SchoolList.fromJson(response.data);

//     return updatedSchoolList;
//   }

//   //-DELETE
//   String _deletePupilsFromSchoolList(String listId) {
//     return '/pupil_lists/$listId/delete_pupils';
//   }

//   Future<SchoolList> deletePupilsFromSchoolList({
//     required List<int> pupilIds,
//     required String listId,
//   }) async {
//     final data = jsonEncode({"pupils": pupilIds});

//     _notificationService.apiRunning(true);

//     final response = await _client.post(
//       '${_baseUrl()}${_deletePupilsFromSchoolList(listId)}',
//       data: data,
//       options: _client.hubOptions,
//     );

//     _notificationService.apiRunning(false);

//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Fehler beim Löschen von der Schulliste');

//       throw ApiException(
//           'Failed to delete pupils from school list', response.statusCode);
//     }

//     final SchoolList updatedSchoolList = SchoolList.fromJson(response.data);

//     return updatedSchoolList;
//   }

//   //- this endpoint is not used in the app
//   static const getSchoolListWithPupils = '/school_lists/all';
}
