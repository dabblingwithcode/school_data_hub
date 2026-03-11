import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/matrix_event_report.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/matrix_message.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/policy.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/data/matrix_room_api_service.dart'
    as room_api;
import 'package:school_data_hub_flutter/features/matrix/services/api/api_client.dart';
import 'package:school_data_hub_flutter/features/matrix/services/api/api_settings.dart';
import 'package:school_data_hub_flutter/features/matrix/users/data/matrix_user_api_service.dart';

enum MatrixAuthType { matrix, corporal }

class MatrixApiService {
  late final ApiClient _apiClient;

  String _matrixToken;
  String _corporalToken;

  // Sub-services for users and rooms
  late final MatrixUserApiService _userApiService;
  late final room_api.MatrixRoomApiService _roomApiService;

  MatrixApiService({
    required String matrixUrl,
    required String matrixToken,
    required String corporalToken,
  }) : _matrixToken = matrixToken,
       _corporalToken = corporalToken {
    _apiClient = ApiClient(Dio(), baseUrl: matrixUrl);

    _apiClient.setApiOptions(
      tokenKey: Token.matrix,
      token: 'Bearer $_matrixToken',
    );
    _apiClient.setApiOptions(
      tokenKey: Token.corporal,
      token: 'Bearer $_corporalToken',
    );

    // Initialize sub-services with shared ApiClient
    _userApiService = MatrixUserApiService(apiClient: _apiClient);
    _roomApiService = room_api.MatrixRoomApiService(apiClient: _apiClient);
  }

  // Getters to access sub-services
  ApiClient get apiClient => _apiClient;
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

  Future<MatrixEventReportsResponse> fetchEventReports({
    int? from,
    int? limit,
    String? dir,
    String? userId,
    String? roomId,
    String? eventSenderUserId,
  }) async {
    final queryParameters = <String, dynamic>{
      if (from != null) 'from': from,
      if (limit != null) 'limit': limit,
      if (dir != null && dir.isNotEmpty) 'dir': dir,
      if (userId != null && userId.isNotEmpty) 'user_id': userId,
      if (roomId != null && roomId.isNotEmpty) 'room_id': roomId,
      if (eventSenderUserId != null && eventSenderUserId.isNotEmpty)
        'event_sender_user_id': eventSenderUserId,
    };

    final Response<dynamic> response = await _apiClient.get(
      '/_synapse/admin/v1/event_reports',
      queryParameters: queryParameters,
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
      throw ApiException(
        'Fehler beim Laden der Event Reports',
        response.statusCode,
      );
    }

    return MatrixEventReportsResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<MatrixEventReportDetail> fetchEventReportDetail(int reportId) async {
    final Response<dynamic> response = await _apiClient.get(
      '/_synapse/admin/v1/event_reports/$reportId',
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
      throw ApiException(
        'Fehler beim Laden des Event Report Details',
        response.statusCode,
      );
    }

    return MatrixEventReportDetail.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<void> deleteEventReport(int reportId) async {
    final response = await _apiClient.delete(
      '/_synapse/admin/v1/event_reports/$reportId',
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
      throw ApiException(
        'Fehler beim Löschen des Event Reports',
        response.statusCode,
      );
    }
  }

  Future<String> getOrCreateDirectMessageRoom({
    required String targetUserId,
    required String currentUserId,
  }) => _roomApiService.findOrCreateDirectMessageRoom(
    targetUserId: targetUserId,
    currentUserId: currentUserId,
  );

  Future<int> cleanupAdminOnlyDirectRooms({required String currentUserId}) =>
      _roomApiService.cleanupAdminOnlyDirectRooms(currentUserId: currentUserId);

  void setMatrixEnvironmentValues({
    required String url,
    required String matrixToken,
    required String policyToken,
  }) {
    _matrixToken = matrixToken;
    _corporalToken = policyToken;

    _apiClient.setBaseUrl(url);
    _apiClient.setApiOptions(
      tokenKey: Token.matrix,
      token: 'Bearer $_matrixToken',
    );
    _apiClient.setApiOptions(
      tokenKey: Token.corporal,
      token: 'Bearer $_corporalToken',
    );

    return;
  }

  //- POLICY OPERATIONS

  Future<Policy?> fetchMatrixPolicy() async {
    final response = await _apiClient.get(
      '/_matrix/corporal/policy',
      options: _apiClient.corporalOptions,
    );

    if (response.statusCode != 200) {
      throw ApiException('Fehler beim Laden der Policy', response.statusCode);
    }

    return Policy.fromJson(response.data['policy'] as Map<String, dynamic>);
  }

  static const String _putMatrixPolicy = '/_matrix/corporal/policy';

  Future<void> putMatrixPolicy() async {
    final String policyJson = MatrixPolicyHelper.generatePolicyJson();
    //TODO:; remove after debugging
    developer.log(
      'PUT $_putMatrixPolicy payload: $policyJson',
      name: 'MatrixApiService.putMatrixPolicy',
    );

    final Response<dynamic> response = await _apiClient.put(
      _putMatrixPolicy,
      data: policyJson,
      options: _apiClient.corporalOptions.copyWith(
        contentType: 'application/json',
      ),
    );

    if (response.statusCode != 200) {
      throw ApiException('Fehler beim Setzen der Policy', response.statusCode);
    }

    return;
  }
}
