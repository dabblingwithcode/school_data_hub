import 'dart:io';

import 'package:dio/dio.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/policy.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/data/matrix_room_api_service.dart'
    as room_api;
import 'package:school_data_hub_flutter/features/matrix/services/api/api_client.dart';
import 'package:school_data_hub_flutter/features/matrix/services/api/api_settings.dart';
import 'package:school_data_hub_flutter/features/matrix/users/data/matrix_user_api_service.dart';
import 'package:watch_it/watch_it.dart';

enum MatrixAuthType { matrix, corporal }

class MatrixApiService {
  final _apiClient = ApiClient(Dio());
  final _notificationService = di<NotificationService>();

  String _matrixUrl;
  String _matrixToken;
  String _corporalToken;

  // Sub-services for users and rooms
  late final MatrixUserApiService _userApiService;
  late final room_api.MatrixRoomApiService _roomApiService;

  MatrixApiService({
    required String matrixUrl,
    required String matrixToken,
    required String corporalToken,
  })  : _matrixUrl = matrixUrl,
        _matrixToken = matrixToken,
        _corporalToken = corporalToken {
    _apiClient.setApiOptions(
        tokenKey: Token.matrix, token: 'Bearer $_matrixToken');
    _apiClient.setApiOptions(
        tokenKey: Token.corporal, token: 'Bearer $_corporalToken');

    // Initialize sub-services with shared ApiClient
    _userApiService = MatrixUserApiService(
      apiClient: _apiClient,
      matrixUrl: matrixUrl,
      matrixToken: matrixToken,
      corporalToken: corporalToken,
    );
    _roomApiService = room_api.MatrixRoomApiService(
      apiClient: _apiClient,
      matrixUrl: matrixUrl,
      matrixToken: matrixToken,
      corporalToken: corporalToken,
    );
  }

  // Getters to access sub-services
  MatrixUserApiService get userApi => _userApiService;
  room_api.MatrixRoomApiService get roomApi => _roomApiService;

  void setMatrixEnvironmentValues({
    required String url,
    required String matrixToken,
    required String policyToken,
  }) {
    _matrixUrl = url;
    _matrixToken = matrixToken;
    _corporalToken = policyToken;

    // Update sub-services as well
    _userApiService.setMatrixEnvironmentValues(
      url: url,
      matrixToken: matrixToken,
      policyToken: policyToken,
    );
    _roomApiService.setMatrixEnvironmentValues(
      url: url,
      matrixToken: matrixToken,
      policyToken: policyToken,
    );
    return;
  }

  //- POLICY OPERATIONS

  Future<Policy?> fetchMatrixPolicy() async {
    final response = await _apiClient.get(
      '$_matrixUrl/_matrix/corporal/policy',
      options: _apiClient.corporalOptions,
    );

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler: status code ${response.statusCode}');
      throw ApiException('Fehler beim Laden der Policy', response.statusCode);
    }
    final Policy policy = Policy.fromJson(response.data['policy']);
    _notificationService.showSnackBar(
        NotificationType.success, 'Matrix-Räumeverwaltung geladen');

    return policy;
  }

  static const String _putMatrixPolicy = '/_matrix/corporal/policy';

  Future<void> putMatrixPolicy() async {
    final File policyFile = await MatrixPolicyHelper.generatePolicyJsonFile(
        filename: 'matrix-policy');
    final bytes = policyFile.readAsBytesSync();

    final Response response = await _apiClient.put(
      '$_matrixUrl$_putMatrixPolicy',
      data: bytes,
      options: _apiClient.corporalOptions,
    );
    //delete file, we don't need it anymore
    // policyFile.deleteSync();
    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler: status code ${response.statusCode}');
      throw ApiException('Fehler beim Setzen der Policy', response.statusCode);
    }

    _notificationService.showSnackBar(
        NotificationType.success, 'Policy erfolgreich gesetzt');

    return;
  }

  // //- DELEGATION METHODS FOR BACKWARD COMPATIBILITY
  // // These methods delegate to the appropriate sub-services to maintain existing API

  // // User API delegation
  // Future<MatrixUser?> createNewMatrixUser({
  //   required String matrixId,
  //   required String displayName,
  //   required String password,
  // }) =>
  //     _userApiService.createNewMatrixUser(
  //       matrixId: matrixId,
  //       displayName: displayName,
  //       password: password,
  //     );

  // Future<bool> deleteMatrixUser(String userId) =>
  //     _userApiService.deleteMatrixUser(userId);

  // Future<bool> resetPassword({
  //   required String userId,
  //   required String newPassword,
  //   bool? logoutDevices,
  // }) =>
  //     _userApiService.resetPassword(
  //       userId: userId,
  //       newPassword: newPassword,
  //       logoutDevices: logoutDevices,
  //     );

  // Future<MatrixUser?> fetchMatrixUserById(String userId) =>
  //     _userApiService.fetchMatrixUserById(userId);

  // // Room API delegation
  // Future<MatrixRoom?> createMatrixRoom({
  //   required String name,
  //   required String topic,
  //   required room_api.ChatTypePreset chatTypePreset,
  //   String? aliasName,
  // }) =>
  //     _roomApiService.createMatrixRoom(
  //       name: name,
  //       topic: topic,
  //       chatTypePreset: chatTypePreset,
  //       aliasName: aliasName,
  //     );

  // Future<MatrixRoom> fetchAdditionalRoomInfos(String roomId) =>
  //     _roomApiService.fetchAdditionalRoomInfos(roomId);

  // Future<MatrixRoom> changeRoomPowerLevels({
  //   required String roomId,
  //   RoomAdmin? newRoomAdmin,
  //   String? removeAdminWithId,
  //   int? eventsDefault,
  //   int? reactions,
  //   required MatrixRoom currentRoom,
  //   required String matrixAdmin,
  // }) =>
  //     _roomApiService.changeRoomPowerLevels(
  //       roomId: roomId,
  //       newRoomAdmin: newRoomAdmin,
  //       removeAdminWithId: removeAdminWithId,
  //       eventsDefault: eventsDefault,
  //       reactions: reactions,
  //       currentRoom: currentRoom,
  //       matrixAdmin: matrixAdmin,
  //     );
}
