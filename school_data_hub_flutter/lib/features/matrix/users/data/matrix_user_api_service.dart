import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/features/matrix/services/api/api_client.dart';
import 'package:school_data_hub_flutter/features/matrix/services/api/api_settings.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';

class MatrixUserApiService {
  final ApiClient _apiClient;

  MatrixUserApiService({required ApiClient apiClient}) : _apiClient = apiClient;
  final _log = Logger('MatrixUserApiService');

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
      "threepids": <Map<String, dynamic>>[],
      "avatar_url": "",
    });

    // Add before your PUT request
    _log.info('Matrix API Request:');
    _log.info('URL: ${_createMatrixUser(matrixId)}');

    final Response<dynamic> response = await _apiClient.put(
      _createMatrixUser(matrixId),
      data: data,
      options: _apiClient.matrixOptions,
    );
    // statuscode 201 means: User created
    if (!(response.statusCode == 201 || response.statusCode == 200)) {
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

    return newUser;
  }

  //- DELETE USER
  String _deleteMatrixUser(String userId) {
    // return '/_synapse/admin/v2/users/$userId/deactivate';
    return '/_synapse/admin/v1/deactivate/$userId';
  }

  Future<bool> deleteMatrixUser(String userId) async {
    final data = jsonEncode({"erase": true});
    final Response<dynamic> response = await _apiClient.post(
      _deleteMatrixUser(userId),
      data: data,
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
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

    final Response<dynamic> response = await _apiClient.post(
      _resetPassword(userId),
      data: data,
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
      return false;
    }

    return true;
  }

  //- GET USER
  String _fetchMatrixUser(String userId) {
    return '/_synapse/admin/v2/users/$userId';
  }

  Future<MatrixUser?> fetchMatrixUserById(String userId) async {
    final Response<dynamic> response = await _apiClient.get(
      _fetchMatrixUser(userId),
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode == 200) {
      final MatrixUser user = MatrixUser.fromJson(
        response.data as Map<String, dynamic>,
      );

      return user;
    }

    return null;
  }

  Future<String?> fetchUserAvatarUrl(String userId) async {
    final encodedUserId = Uri.encodeComponent(userId);
    final Response<dynamic> response = await _apiClient.get(
      '/_matrix/client/v3/profile/$encodedUserId/avatar_url',
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
      return null;
    }

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      return null;
    }

    return data['avatar_url'] as String?;
  }
}
