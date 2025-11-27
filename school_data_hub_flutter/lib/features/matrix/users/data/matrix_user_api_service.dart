import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/services/api/api_client.dart';
import 'package:school_data_hub_flutter/features/matrix/services/api/api_settings.dart';
import 'package:watch_it/watch_it.dart';

class MatrixUserApiService {
  final ApiClient _apiClient;
  final _notificationService = di<NotificationService>();

  final String _matrixUrl;

  MatrixUserApiService({
    required ApiClient apiClient,
    required String matrixUrl,
    required String matrixToken, // Keep for potential future use
    required String corporalToken, // Keep for potential future use
  }) : _apiClient = apiClient,
       _matrixUrl = matrixUrl;
  final _log = Logger('MatrixUserApiService');
  void setMatrixEnvironmentValues({
    required String url,
    required String matrixToken,
    required String policyToken,
  }) {
    // Note: This method might need to be coordinated with the main API service
    // Consider if this should be handled at a higher level
  }

  //- CREATE MATRIX USER
  String _createMatrixUser(String userId) {
    return '/_synapse/admin/v2/users/$userId';
  }

  Future<MatrixUser?> createNewMatrixUser({
    required String matrixId,
    required String displayName,
    required String password,
  }) async {
    final data = jsonEncode({
      "user_id": matrixId,
      "password": password,
      "admin": false,
      "displayname": displayName,
      "threepids": [],
      "avatar_url": "",
    });

    // Add before your PUT request
    _log.info('Matrix API Request:');
    _log.info('URL: $_matrixUrl${_createMatrixUser(matrixId)}');
    _log.info('Data: $data');
    _log.info('Headers: ${_apiClient.matrixOptions.headers}');

    final Response response = await _apiClient.put(
      '$_matrixUrl${_createMatrixUser(matrixId)}',
      data: data,
      options: _apiClient.matrixOptions,
    );
    // statuscode 201 means: User created
    if (!(response.statusCode == 201 || response.statusCode == 200)) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler: status code ${response.statusCode}',
      );
      throw ApiException(
        'Fehler beim Erstellen des Benutzers',
        response.statusCode,
      );
    }
    final MatrixUser newUser = MatrixUser(
      id: matrixId,
      displayName: displayName,
      joinedRooms: [],
      active: true,
      authType: "passthrough",
    );
    if (response.statusCode == 201) {
      _notificationService.showSnackBar(
        NotificationType.success,
        'Benutzer erstellt',
      );
    }
    if (response.statusCode == 200) {
      _notificationService.showSnackBar(
        NotificationType.success,
        'Deaktivierter Benutzer reaktiviert',
      );
    }

    return newUser;
  }

  //- DELETE USER
  String _deleteMatrixUser(String userId) {
    // return '/_synapse/admin/v2/users/$userId/deactivate';
    return '/_synapse/admin/v1/deactivate/$userId';
  }

  Future<bool> deleteMatrixUser(String userId) async {
    final data = jsonEncode({"erase": true});
    final Response response = await _apiClient.post(
      '$_matrixUrl${_deleteMatrixUser(userId)}',
      data: data,
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler: status code ${response.statusCode}',
      );

      return false;
    }

    return true;
  }

  //- RESET PASSWORD
  String _resetPassword(String userId) {
    return '/_synapse/admin/v1/reset_password/$userId';
  }

  Future<bool> resetPassword({
    required String userId,
    required String newPassword,
    bool? logoutDevices,
  }) async {
    final data = jsonEncode({
      "new_password": newPassword,
      "logout_devices": logoutDevices,
    });

    final Response response = await _apiClient.post(
      '$_matrixUrl${_resetPassword(userId)}',
      data: data,
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler: status code ${response.statusCode}',
      );

      return false;
    }

    return true;
  }

  //- GET USER
  String _fetchMatrixUser(String userId) {
    return '/_synapse/admin/v2/users/$userId';
  }

  Future<MatrixUser?> fetchMatrixUserById(String userId) async {
    final Response response = await _apiClient.get(
      '$_matrixUrl${_fetchMatrixUser(userId)}',
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode == 200) {
      final MatrixUser user = MatrixUser.fromJson(response.data);

      return user;
    }

    return null;
  }
}
