import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:watch_it/watch_it.dart';

final _client = di<Client>();
final _notificationService = di<NotificationService>();

class AuthorizationApiService {
  //- AUTHORIZATIONS -------------------------------------------

  //- getAuthorizations

  Future<List<Authorization>> fetchAuthorizations() async {
    final auths = ClientHelper.apiCall(
        call: () => _client.authorization.fetchAuthorizations());
    return auths;
  }

  //- post authorization with a list of pupils as members

  Future<Authorization> postAuthorizationWithPupils(String name,
      String description, String createdNy, List<int> pupilIds) async {
    _notificationService.apiRunning(true);
    try {
      _notificationService.apiRunning(true);
      final authorization = await _client.authorization
          .postAuthorizationWithPupils(name, description, createdNy, pupilIds);
      _notificationService.apiRunning(false);
      return authorization;
    } catch (e) {
      _notificationService.apiRunning(false);
      throw Exception('Failed to post authorization: $e');
    }
  }

  //- delete authorization

  Future<bool> deleteAuthorization(int authId) async {
    final success = await ClientHelper.apiCall(
      call: () => _client.authorization.deleteAuthorization(authId),
      errorMessage: 'Einwilligung konnte nicht gelöscht werden',
    );
    return success;
  }

//   //-PUPIL AUTHORIZATIONS -------------------------------------------

//   //- add pupil to authorization

//   Future<Authorization> postPupilAuthorization(
//       int pupilId, String authId) async {
//     _notificationService.apiRunning(true);

//     final data = jsonEncode({"comment": null, "file_id": null, "status": null});

//     final response = await _client.post(
//       _postPupilAuthorizationUrl(pupilId, authId),
//       data: data,
//       options: _client.hubOptions,
//     );

//     _notificationService.apiRunning(false);

//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Error: ${response.data}');

//       throw ApiException(
//           'Failed to post pupil authorization', response.statusCode);
//     }

//     return Authorization.fromJson(response.data);
//   }

//   //- post pupil authorizations for a list of pupils as members of an authorization

//   Future<Authorization> postPupilAuthorizations(
//       List<int> pupilIds, String authId) async {
//     _notificationService.apiRunning(true);

//     final data = jsonEncode({"pupils": pupilIds});

//     final response = await _client.post(
//       _postPupilAuthorizationsUrl(authId),
//       data: data,
//       options: _client.hubOptions,
//     );
//     _notificationService.apiRunning(false);
//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(NotificationType.error,
//           'Es konnten keine Einwilligungen erstellt werden');

//       _notificationService.apiRunning(false);

//       throw ApiException(
//           'Failed to post pupil authorizations', response.statusCode);
//     }
//     final Authorization authorization = Authorization.fromJson(response.data);

//     return authorization;
//   }

//   //- delete pupil authorization

//   String _deletePupilAuthorizationUrl(int pupilId, String authorizationId) {
//     return '${_baseUrl()}/pupil_authorizations/$pupilId/$authorizationId';
//   }

//   Future<Authorization> deletePupilAuthorization(
//       int pupilId, String authId) async {
//     _notificationService.apiRunning(true);

//     final response = await _client.delete(
//       _deletePupilAuthorizationUrl(pupilId, authId),
//       options: _client.hubOptions,
//     );
//     _notificationService.apiRunning(false);

//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(NotificationType.error,
//           'Die Einwilligung konnte nicht gelöscht werden');

//       _notificationService.apiRunning(false);

//       throw ApiException(
//           'Failed to delete pupil authorization', response.statusCode);
//     }

//     final authorization = Authorization.fromJson(response.data);

//     return authorization;
//   }

//   //- patch pupil authorization

//   String _patchPupilAuthorizationUrl(int pupilId, String authorizationId) {
//     return '${_baseUrl()}/pupil_authorizations/$pupilId/$authorizationId';
//   }

//   Future<Authorization> updatePupilAuthorizationProperty(
//       int pupilId, String listId, bool? value, String? comment) async {
//     _notificationService.apiRunning(true);

//     String data = '';
//     if (value == null) {
//       data = jsonEncode({"comment": comment});
//     } else if (comment == null) {
//       data = jsonEncode({"status": value});
//     } else {
//       data = jsonEncode({"comment": comment, "status": value});
//     }

//     final response = await _client.patch(
//       _patchPupilAuthorizationUrl(pupilId, listId),
//       data: data,
//       options: _client.hubOptions,
//     );

//     _notificationService.apiRunning(false);

//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Einwilligung konnte nicht geändert werden');

//       _notificationService.apiRunning(false);

//       throw ApiException(
//           'Failed to patch pupil authorization', response.statusCode);
//     }

//     final authorization = Authorization.fromJson(response.data);

//     return authorization;
//   }

//   // - patch pupil authorization with file
//   String _patchPupilAuthorizationWithFileUrl(
//       int pupilId, String authorizationId) {
//     return '${_baseUrl()}/pupil_authorizations/$pupilId/$authorizationId/file';
//   }

//   Future<Authorization> postAuthorizationFile(
//     File file,
//     int pupilId,
//     String authId,
//   ) async {
//     _notificationService.apiRunning(true);

//     final encryptedFile = await customEncrypter.encryptFile(file);
//     String fileName = encryptedFile.path.split('/').last;

//     final Response response = await _client.patch(
//       _patchPupilAuthorizationWithFileUrl(pupilId, authId),
//       data: FormData.fromMap(
//         {
//           "file": await MultipartFile.fromFile(encryptedFile.path,
//               filename: fileName),
//         },
//       ),
//       options: _client.hubOptions,
//     );
//     _notificationService.apiRunning(false);
//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Error: ${response.data}');

//       _notificationService.apiRunning(false);

//       throw ApiException(
//           'Failed to post pupil authorization file', response.statusCode);
//     }

//     return Authorization.fromJson(response.data);
//   }

// //- delete pupil authorization file

//   String _deletePupilAuthorizationFileUrl(int pupilId, String authorizationId) {
//     return '${_baseUrl()}/pupil_authorizations/$pupilId/$authorizationId/file';
//   }

//   Future<Authorization> deleteAuthorizationFile(
//       int pupilId, String authId, String cacheKey) async {
//     _notificationService.apiRunning(true);

//     final Response response = await _client.delete(
//       _deletePupilAuthorizationFileUrl(pupilId, authId),
//       options: _client.hubOptions,
//     );
//     _notificationService.apiRunning(false);
//     if (response.statusCode != 200) {
//       _notificationService.showSnackBar(
//           NotificationType.error, 'Error: ${response.data}');

//       _notificationService.apiRunning(false);

//       throw ApiException(
//           'Failed to delete pupil authorization file', response.statusCode);
//     }

//     // First we delete the cached image
//     final cacheManager = locator<DefaultCacheManager>();
//     await cacheManager.removeFile(cacheKey);

//     return Authorization.fromJson(response.data);
//   }

//   //-dieser Endpoint wird in widgets benutzt
//   String getPupilAuthorizationFile(int pupilId, String authorizationId) {
//     return '${_baseUrl()}/pupil_authorizations/$pupilId/$authorizationId/file';
//   }

//   //- diese Endpoints sind noch nicht implementiert
//   // String _patchAuthorization(int id) {
//   //   return '${_baseUrl()}/authorizations/$id';
//   // }

//   String postAuthorizationWithAllPupils = '/authorizations/new/all';

//   //- diese Endpunkte werden nicht verwendet
//   // String _postAuthorization(int id) {
//   //   return '${_baseUrl()}/pupil/$id/authorization';
//   // }

//   String getAuthorizationsFlatUrl(String baseUrl) {
//     return '$baseUrl/authorizations/all/flat';
//   }
}
