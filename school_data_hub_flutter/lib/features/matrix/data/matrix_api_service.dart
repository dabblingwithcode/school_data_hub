import 'dart:io';

import 'package:dio/dio.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_message.dart';
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
  }) : _matrixUrl = matrixUrl,
       _matrixToken = matrixToken,
       _corporalToken = corporalToken {
    _apiClient.setApiOptions(
      tokenKey: Token.matrix,
      token: 'Bearer $_matrixToken',
    );
    _apiClient.setApiOptions(
      tokenKey: Token.corporal,
      token: 'Bearer $_corporalToken',
    );

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

  // Message API delegation methods
  Future<MatrixMessageResponse> sendTextMessage({
    required String roomId,
    required String text,
    String? transactionId,
  }) => _roomApiService.sendTextMessage(
    roomId: roomId,
    text: text,
    transactionId: transactionId,
  );

  Future<MatrixMessageResponse> sendEmoteMessage({
    required String roomId,
    required String emote,
    String? transactionId,
  }) => _roomApiService.sendEmoteMessage(
    roomId: roomId,
    emote: emote,
    transactionId: transactionId,
  );

  Future<MatrixMessageResponse> sendNoticeMessage({
    required String roomId,
    required String notice,
    String? transactionId,
  }) => _roomApiService.sendNoticeMessage(
    roomId: roomId,
    notice: notice,
    transactionId: transactionId,
  );

  Future<List<MatrixMessageEvent>> getRoomMessages({
    required String roomId,
    String? from,
    int limit = 10,
    String dir = 'b',
  }) => _roomApiService.getRoomMessages(
    roomId: roomId,
    from: from,
    limit: limit,
    dir: dir,
  );

  // Direct messaging methods
  // Future<Map<String, String>> sendDirectTextMessage({
  //   required String targetUserId,
  //   required String text,
  //   String? transactionId,
  // }) => _roomApiService.sendDirectTextMessage(
  //   targetUserId: targetUserId,
  //   text: text,
  //   transactionId: transactionId,
  // );

  Future<void> inviteUserToRoom({
    required String roomId,
    required String userId,
  }) => _roomApiService.inviteUserToRoom(roomId: roomId, userId: userId);

  Future<String> getOrCreateDirectMessageRoom({
    required String targetUserId,
    required String currentUserId,
  }) => _roomApiService.findOrCreateDirectMessageRoom(
    targetUserId: targetUserId,
    currentUserId: currentUserId,
  );

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
        NotificationType.error,
        'Fehler: status code ${response.statusCode}',
      );
      throw ApiException('Fehler beim Laden der Policy', response.statusCode);
    }

    //-TODO URGENT: remove this debug code later
    // final File file = File('matrix-fetched-policy.json');
    // if (file.existsSync()) {
    //   file.deleteSync();
    // }
    // file.writeAsStringSync(jsonEncode(response.data['policy']));

    final Policy policy = Policy.fromJson(response.data['policy']);
    _notificationService.showSnackBar(
      NotificationType.success,
      'Matrix-Räumeverwaltung geladen',
    );

    return policy;
  }

  static const String _putMatrixPolicy = '/_matrix/corporal/policy';

  Future<void> putMatrixPolicy() async {
    final File policyFile = await MatrixPolicyHelper.generatePolicyJsonFile(
      filename: 'updated-policy',
    );
    final bytes = policyFile.readAsBytesSync();

    final Response response = await _apiClient.put(
      '$_matrixUrl$_putMatrixPolicy',
      data: bytes,
      options: _apiClient.corporalOptions,
    );
    //- TODO URGENT: uncomment this when the backend is ready
    //delete file, we don't need it anymore
    // policyFile.deleteSync();
    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler: status code ${response.statusCode}',
      );
      throw ApiException('Fehler beim Setzen der Policy', response.statusCode);
    }

    _notificationService.showSnackBar(
      NotificationType.success,
      'Policy erfolgreich gesetzt',
    );

    return;
  }
}
