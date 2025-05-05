import 'dart:io';

import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
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
      String description, String createdBy, List<int> pupilIds) async {
    final auth = ClientHelper.apiCall(
        call: () => _client.authorization.postAuthorizationWithPupils(
            name, description, createdBy, pupilIds));
    return auth;
  }

//- update authorization

  Future<Authorization> updateAuthorization(
      int authId,
      String? name,
      String? description,
      ({
        MemberOperation operation,
        List<int> pupilIds
      })? membersToUpdate) async {
    final updatedAuth = ClientHelper.apiCall(
      call: () => _client.authorization
          .updateAuthorization(authId, name, description, membersToUpdate),
      errorMessage: 'Einwilligung konnte nicht geändert werden',
    );
    return updatedAuth;
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

  //- update pupil authorization

  Future<PupilAuthorization> updatePupilAuthorization(
      PupilAuthorization pupilauth) {
    return ClientHelper.apiCall(
      call: () =>
          _client.pupilAuthorization.updatePupilAuthorization(pupilauth),
      errorMessage: 'Einwilligung konnte nicht geändert werden',
    );
  }

  Future<PupilAuthorization> addFileToPupilAuthorization(
    int pupilAuthId,
    File file,
    String createdBy,
  ) async {
    final path =
        await ClientFileUpload.uploadFile(file, ServerStorageFolder.documents);
    final result = ClientHelper.apiCall(
      call: () => _client.pupilAuthorization.addFileToPupilAuthorization(
        pupilAuthId,
        path.path!,
        createdBy,
      ),
      errorMessage: 'Einwilligung konnte nicht geändert werden',
    );
    return result;
  }

  Future<PupilAuthorization> removeFileFromPupilAuthorization(
    int pupilAuthId,
  ) async {
    final result = ClientHelper.apiCall(
      call: () => _client.pupilAuthorization
          .removeFileFromPupilAuthorization(pupilAuthId),
      errorMessage: 'Einwiligungsdokument konnte nicht gelöscht werden',
    );
    return result;
  }
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
