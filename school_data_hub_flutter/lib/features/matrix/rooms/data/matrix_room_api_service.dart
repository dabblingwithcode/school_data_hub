import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/services/api/api_client.dart';
import 'package:school_data_hub_flutter/features/matrix/services/api/api_settings.dart';
import 'package:watch_it/watch_it.dart';

enum ChatTypePreset {
  public('public_chat'),
  private('private_chat'),
  trustedPrivate('trusted_private_chat');

  final String value;
  const ChatTypePreset(this.value);
}

class MatrixRoomApiService {
  final ApiClient _apiClient;
  final _notificationService = di<NotificationService>();

  final String _matrixUrl;

  MatrixRoomApiService({
    required ApiClient apiClient,
    required String matrixUrl,
    required String matrixToken, // Keep for potential future use
    required String corporalToken, // Keep for potential future use
  }) : _apiClient = apiClient,
       _matrixUrl = matrixUrl;

  void setMatrixEnvironmentValues({
    required String url,
    required String matrixToken,
    required String policyToken,
  }) {
    // Note: This method might need to be coordinated with the main API service
    // Consider if this should be handled at a higher level
  }

  //- CREATE ROOM
  static const String _createRoom = '/_matrix/client/v3/createRoom';

  Future<MatrixRoom?> createMatrixRoom({
    required String name,
    required String topic,
    required ChatTypePreset chatTypePreset,
    String? aliasName,
  }) async {
    MatrixRoom? room;

    //- API: https://spec.matrix.org/latest/client-server-api/#create-room

    //- API power levels: https://spec.matrix.org/v1.15/client-server-api/#mroompower_levels

    final data = jsonEncode({
      "creation_content": {"m.federate": false},
      "is_direct": false,
      "name": name,
      "preset": "private_chat",
      if (aliasName != null) "room_alias_name": aliasName,
      "topic": topic,
      "visibility": 'private',
      "power_level_content_override": {
        "users": {"${di<MatrixPolicyManager>().matrixAdminId}": 100},
        "events": {"m.room.name": 50},
        "users_default": 0,
        "events_default": 50,
        "state_default": 50,
        "ban": 100,
        "kick": 100,
        "invite": 100,
        "redact": 50,
      },
    });

    final Response response = await _apiClient.post(
      '$_matrixUrl$_createRoom',
      data: data,
      options: _apiClient.matrixOptions,
    );
    if (response.statusCode == 200) {
      // extract the value of "room_id" out of the response
      final String roomId = response.data['room_id'];
      room = await fetchAdditionalRoomInfos(roomId);
    }

    return room;
  }

  //- GET ROOM NAME AND INFO
  String _fetchRoomName(String roomId) {
    return '/_matrix/client/v3/rooms/$roomId/state/m.room.name';
  }

  String _fetchRoomPowerLevelsUrl(String roomId) {
    return '/_matrix/client/v3/rooms/$roomId/state/m.room.power_levels';
  }

  Future<MatrixRoom> fetchAdditionalRoomInfos(String roomId) async {
    String? name;
    int? powerLevelReactions;
    int? eventsDefault;
    List<RoomAdmin>? roomAdmins;

    // First API call
    final responseRoomSPowerLevels = await _apiClient.get(
      // ignore: unnecessary_string_interpolations
      '$_matrixUrl${_fetchRoomPowerLevelsUrl(roomId)}',
      options: _apiClient.matrixOptions,
    );

    if (responseRoomSPowerLevels.statusCode == 200) {
      powerLevelReactions =
          responseRoomSPowerLevels.data['events']['m.reaction'] ?? 0;
      eventsDefault = responseRoomSPowerLevels.data['events_default'] ?? 0;

      if (responseRoomSPowerLevels.data['users'] is Map<String, dynamic>) {
        final usersMap =
            responseRoomSPowerLevels.data['users'] as Map<String, dynamic>;
        roomAdmins =
            usersMap.keys
                .map(
                  (userId) =>
                      RoomAdmin(id: userId, powerLevel: usersMap[userId]),
                )
                .toList();
      }
    }

    // Second API call
    final responseRoomName = await _apiClient.get(
      // ignore: unnecessary_string_interpolations
      '$_matrixUrl${_fetchRoomName(roomId)}',
      options: _apiClient.matrixOptions,
    );

    if (responseRoomName.statusCode == 200) {
      name = responseRoomName.data['name'] ?? 'No Room Name';
    }

    MatrixRoom roomWithAdditionalInfos = MatrixRoom(
      id: roomId,
      name: name,
      powerLevelReactions: powerLevelReactions,
      eventsDefault: eventsDefault,
      roomAdmins: roomAdmins,
    );

    return roomWithAdditionalInfos;
  }

  //- PUT ROOM POWER LEVELS
  String _putRoomPowerLevels(String roomId) {
    // ensure that ! and : are properly coded for the url
    final roomIdforUrl = roomId.replaceAllMapped(RegExp(r'[!:]'), (match) {
      switch (match.group(0)) {
        case '!':
          return '%21';
        case ':':
          return '%3A';
        default:
          return match.group(0)!;
      }
    });
    return '/_matrix/client/v3/rooms/$roomIdforUrl/state/m.room.power_levels';
  }

  Future<MatrixRoom> changeRoomPowerLevels({
    required String roomId,
    RoomAdmin? newRoomAdmin,
    String? adminIdToRemove,
    int? eventsDefault,
    int? reactions,
    required MatrixRoom currentRoom, // We need the current room info
    required String matrixAdmin, // We need the admin ID
  }) async {
    List<RoomAdmin> adminPowerLevels = [];

    Map<String, dynamic> adminPowerLevelsMap = {};

    // We make sure that the instance admin has admin power level in the room
    adminPowerLevels =
        currentRoom.roomAdmins ?? [RoomAdmin(id: matrixAdmin, powerLevel: 100)];

    if (newRoomAdmin != null) {
      adminPowerLevels.add(newRoomAdmin);
    }
    if (adminIdToRemove != null) {
      adminPowerLevels.removeWhere((admin) => admin.id == adminIdToRemove);
    }

    for (RoomAdmin admin in adminPowerLevels) {
      adminPowerLevelsMap[admin.id] = admin.powerLevel;
    }

    final data = jsonEncode({
      "ban": 50,
      "events": {
        "m.room.name": 50,
        "m.room.power_levels": 100,
        "m.room.history_visibility": 100,
        "m.room.canonical_alias": 50,
        "m.room.avatar": 50,
        "m.room.tombstone": 100,
        "m.room.server_acl": 100,
        "m.room.encryption": 100,
        "m.space.child": 50,
        "m.room.topic": 50,
        "m.room.pinned_events": 50,
        "m.reaction": reactions ?? currentRoom.powerLevelReactions,
        "m.room.redaction": 0,
        "org.matrix.msc3401.call": 50,
        "org.matrix.msc3401.call.member": 50,
        "im.vector.modular.widgets": 50,
        "io.element.voice_broadcast_info": 50,
      },
      "events_default": eventsDefault ?? currentRoom.eventsDefault,
      "invite": 50,
      "kick": 50,
      "notifications": {"room": 20},
      "redact": 50,
      "state_default": 50,
      "users": adminPowerLevelsMap,
      "users_default": 0,
    });

    final Response response = await _apiClient.put(
      '$_matrixUrl${_putRoomPowerLevels(roomId)}',
      data: data,
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler: status code ${response.statusCode}',
      );
      throw ApiException(
        'Fehler beim Setzen der Power Levels',
        response.statusCode,
      );
    }

    final MatrixRoom room = await fetchAdditionalRoomInfos(roomId);

    return room;
  }
}
