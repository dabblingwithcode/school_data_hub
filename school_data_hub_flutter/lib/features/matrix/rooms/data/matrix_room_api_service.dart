import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_message.dart';
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
  final _log = Logger('MatrixRoomApiService');

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
        roomAdmins = usersMap.keys
            .map(
              (userId) => RoomAdmin(id: userId, powerLevel: usersMap[userId]),
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

  //- SEND MESSAGE
  static const String _sendMessage = '/_matrix/client/v3/rooms';

  /// Sends a message to a Matrix room using the admin account
  ///
  /// [roomId] - The Matrix room ID (e.g., "!roomId:domain.com")
  /// [message] - The message to send (text, emote, notice, etc.)
  /// [transactionId] - Optional transaction ID for deduplication
  ///
  /// Returns the event ID of the sent message
  Future<MatrixMessageResponse> sendMessage({
    required String roomId,
    required MatrixMessage message,
    String? transactionId,
  }) async {
    // Generate transaction ID if not provided
    final txnId = transactionId ?? _generateTransactionId();

    // URL encode the room ID for the API call
    final encodedRoomId = _encodeRoomId(roomId);

    // Determine event type based on message type
    final eventType = _getEventTypeForMessage(message);

    // Build the API endpoint
    final endpoint =
        '$_matrixUrl$_sendMessage/$encodedRoomId/send/$eventType/$txnId';

    // Create a simple message structure for testing
    final messageData = {'msgtype': 'm.text', 'body': message.body};

    try {
      _log.info('Sending message to room: $roomId');
      log('Endpoint: $endpoint');
      log('Message data: ${jsonEncode(messageData)}');
      log('Message data type: ${messageData.runtimeType}');
      log('JSON encoded data: ${jsonEncode(messageData)}');
      log('JSON encoded data type: ${jsonEncode(messageData).runtimeType}');
      log('API options: ${_apiClient.matrixOptions.headers}');

      final Response response = await _apiClient.put(
        endpoint,
        data: messageData, // Send as Map, let Dio handle JSON encoding
        options: _apiClient.matrixOptions,
      );

      log('Send message response status: ${response.statusCode}');
      log('Send message response data: ${response.data}');

      if (response.statusCode == 200) {
        final eventId = response.data['event_id'] as String;
        log('Message sent successfully with event ID: $eventId');
        _notificationService.showSnackBar(
          NotificationType.success,
          'Nachricht gesendet',
        );
        return MatrixMessageResponse(eventId: eventId);
      } else {
        log('Send message failed: ${response.statusCode} - ${response.data}');
        _notificationService.showSnackBar(
          NotificationType.error,
          'Fehler beim Senden: ${response.statusCode} - ${response.data}',
        );
        throw ApiException(
          'Fehler beim Senden der Nachricht: ${response.statusCode} - ${response.data}',
          response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      log('Send message exception: $e');
      log('Send message stack trace: $stackTrace');
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Senden der Nachricht: $e',
      );
      rethrow;
    }
  }

  /// Sends a text message to a room
  Future<MatrixMessageResponse> sendTextMessage({
    required String roomId,
    required String text,
    String? transactionId,
  }) async {
    final message = MatrixTextMessage(body: text);
    return sendMessage(
      roomId: roomId,
      message: message,
      transactionId: transactionId,
    );
  }

  /// Sends an emote message to a room
  Future<MatrixMessageResponse> sendEmoteMessage({
    required String roomId,
    required String emote,
    String? transactionId,
  }) async {
    final message = MatrixEmoteMessage(body: emote);
    return sendMessage(
      roomId: roomId,
      message: message,
      transactionId: transactionId,
    );
  }

  /// Sends a notice message to a room
  Future<MatrixMessageResponse> sendNoticeMessage({
    required String roomId,
    required String notice,
    String? transactionId,
  }) async {
    final message = MatrixNoticeMessage(body: notice);
    return sendMessage(
      roomId: roomId,
      message: message,
      transactionId: transactionId,
    );
  }

  /// Sends a reply to another message
  Future<MatrixMessageResponse> sendReplyMessage({
    required String roomId,
    required String replyText,
    required String originalEventId,
    String? transactionId,
  }) async {
    final message = MatrixReplyMessage(
      body: replyText,
      relatesToEventId: originalEventId,
      relatesToRelType: 'm.in_reply_to',
    );
    return sendMessage(
      roomId: roomId,
      message: message,
      transactionId: transactionId,
    );
  }

  //- GET ROOM MESSAGES
  static const String _getRoomMessages = '/_matrix/client/v3/rooms';

  /// Retrieves messages from a Matrix room
  ///
  /// [roomId] - The Matrix room ID
  /// [from] - Pagination token to start from (optional)
  /// [limit] - Maximum number of messages to retrieve (default: 10)
  /// [dir] - Direction to paginate ('b' for backwards, 'f' for forwards)
  Future<List<MatrixMessageEvent>> getRoomMessages({
    required String roomId,
    String? from,
    int limit = 10,
    String dir = 'b', // backwards by default
  }) async {
    final encodedRoomId = _encodeRoomId(roomId);
    final endpoint = '$_matrixUrl$_getRoomMessages/$encodedRoomId/messages';

    final queryParams = <String, dynamic>{'limit': limit, 'dir': dir};

    if (from != null) {
      queryParams['from'] = from;
    }

    try {
      final Response response = await _apiClient.get(
        endpoint,
        queryParameters: queryParams,
        options: _apiClient.matrixOptions,
      );

      if (response.statusCode == 200) {
        final List<dynamic> chunk = response.data['chunk'] ?? [];
        return chunk
            .map((eventJson) => MatrixMessageEvent.fromJson(eventJson))
            .toList();
      } else {
        _notificationService.showSnackBar(
          NotificationType.error,
          'Fehler beim Laden der Nachrichten: ${response.statusCode}',
        );
        throw ApiException(
          'Fehler beim Laden der Nachrichten',
          response.statusCode,
        );
      }
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Laden der Nachrichten: $e',
      );
      rethrow;
    }
  }

  //- HELPER METHODS

  /// Generates a unique transaction ID for message deduplication
  String _generateTransactionId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// URL encodes a Matrix room ID for API calls
  String _encodeRoomId(String roomId) {
    return roomId.replaceAllMapped(RegExp(r'[!:]'), (match) {
      switch (match.group(0)) {
        case '!':
          return '%21';
        case ':':
          return '%3A';
        default:
          return match.group(0)!;
      }
    });
  }

  /// Determines the Matrix event type for a given message
  String _getEventTypeForMessage(MatrixMessage message) {
    // All message types use the m.room.message event type
    return 'm.room.message';
  }

  //- DIRECT MESSAGING

  /// Creates a direct message room with a user and sends a message
  ///
  /// [targetUserId] - The Matrix user ID to send the message to
  /// [message] - The message to send
  /// [transactionId] - Optional transaction ID for deduplication
  ///
  /// Returns the event ID of the sent message and the room ID
  // Future<Map<String, String>> sendDirectMessage({
  //   required String targetUserId,
  //   required MatrixMessage message,
  //   String? transactionId,
  // }) async {
  //   // Step 1: Create direct message room
  //   final roomId = await _createDirectMessageRoom(targetUserId);

  //   // Step 2: Ensure the admin account is in the room before sending
  //   await _ensureAdminInRoom(roomId);

  //   // Step 3: Send message to the created room
  //   final response = await sendMessage(
  //     roomId: roomId,
  //     message: message,
  //     transactionId: transactionId,
  //   );

  //   return {'eventId': response.eventId, 'roomId': roomId};
  // }

  /// Creates a direct message room with a specific user
  /// First checks if a direct message room already exists with this user
  Future<String> _findOrcreateDirectMessageRoom({
    required String targetUserId,
    required String currentUserId,
  }) async {
    log('_createDirectMessageRoom called for: $targetUserId');

    try {
      // First, try to find an existing direct message room
      log('🔍 CHECKING FOR EXISTING DIRECT MESSAGE ROOM...');
      final existingRoomId = await _findExistingDirectMessageRoom(
        targetUserId: targetUserId,
        currentUserId: currentUserId,
      );
      if (existingRoomId != null) {
        log('✅ FOUND EXISTING ROOM: $existingRoomId');
        return existingRoomId;
      }

      log('❌ NO EXISTING ROOM FOUND, CREATING NEW DIRECT MESSAGE ROOM...');
      // If no existing room found, create a new one with specific power levels
      final data = jsonEncode({
        "is_direct": true,
        "name": "Schuldaten Benachrichtigungen",
        "invite": [targetUserId],
        "preset": "private_chat",
        "creation_content": {"m.federate": false},
        "power_level_content_override": {
          "users": {
            "$currentUserId": 100, // Admin has full permissions
            "$targetUserId": 0, // User has read-only permissions
          },
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
            "m.reaction": 0,
            "m.room.redaction": 0,
            "org.matrix.msc3401.call": 50,
            "org.matrix.msc3401.call.member": 50,
            "im.vector.modular.widgets": 50,
            "io.element.voice_broadcast_info": 50,
          },
          "events_default": 50,
          "invite": 50,
          "kick": 50,
          "notifications": {"room": 20},
          "redact": 50,
          "state_default": 50,
          "users_default": 0,
        },
      });

      _log.info('Creating room with data: $data');
      _log.info('Matrix URL: $_matrixUrl');
      _log.info('API Options: ${_apiClient.matrixOptions.headers}');

      final Response response = await _apiClient.post(
        '$_matrixUrl/_matrix/client/v3/createRoom',
        data: data,
        options: _apiClient.matrixOptions,
      );

      log('Create room response status: ${response.statusCode}');
      log('Create room response data: ${response.data}');

      if (response.statusCode == 200) {
        final roomId = response.data['room_id'] as String;
        log('Room created successfully: $roomId');
        log('Room creation response: ${response.data}');

        // Check if this room was actually marked as a direct chat
        log('🔍 Checking if the created room is marked as direct chat...');
        await _checkIfRoomIsMarkedAsDirectChat(roomId, targetUserId);

        // Manually mark this room as a direct chat in m.direct account data
        log('🔧 Manually marking room as direct chat...');
        await _markRoomAsDirectChat(roomId, targetUserId);

        return roomId;
      } else {
        log('Error creating room: ${response.statusCode} - ${response.data}');
        _notificationService.showSnackBar(
          NotificationType.error,
          'Fehler beim Erstellen des Direktnachrichten-Raums: ${response.statusCode}',
        );
        throw ApiException(
          'Fehler beim Erstellen des Direktnachrichten-Raums: ${response.statusCode} - ${response.data}',
          response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      log('_createDirectMessageRoom error: $e');
      log('_createDirectMessageRoom stackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Finds an existing direct message room with a specific user
  /// Uses the m.direct account data which is the standard Matrix approach
  /// Checks both the sender's (admin's) and receiver's (target user's) account data
  Future<String?> _findExistingDirectMessageRoom({
    required String targetUserId,
    required String currentUserId,
  }) async {
    _log.info('🔍 _findExistingDirectMessageRoom called for: $targetUserId');

    try {
      // First, check the admin's (sender's) m.direct account data
      _log.info(
        '🔍 Checking m.direct account data for existing direct message rooms...',
      );
      final existingRoomId = await _checkDirectRoomsInAccountData(
        targetUserId: targetUserId,
        currentUserId: currentUserId,
      );

      if (existingRoomId != null) {
        _log.info(
          '✅ Found existing room in admin\'s account data: $existingRoomId',
        );
        return existingRoomId;
      }

      // If not found in admin's account data, check the receiver's (target user's) account data
      _log.info(
        '🔍 No room found in admin\'s account data, checking receiver\'s m.direct account data...',
      );
      // final receiverRoomId = await _checkDirectRoomsInAccountData(
      //   targetUserId:
      //       targetUserId, // The target user's m.direct will have currentUserId as key
      //   currentUserId: currentUserId,
      // );

      // if (receiverRoomId != null) {
      //   _log.info(
      //     '✅ Found existing room in receiver\'s account data: $receiverRoomId',
      //   );
      //   return receiverRoomId;
      // }

      _log.info(
        '❌ No existing direct message room found in either account - will create new one',
      );
      return null;
    } catch (e, stackTrace) {
      _log.info('_findExistingDirectMessageRoom error: $e');
      _log.info('_findExistingDirectMessageRoom stackTrace: $stackTrace');
      // If we can't find existing rooms, we'll create a new one
      return null;
    }
  }

  /// Checks m.direct account data for a specific user and validates existing rooms
  /// [userId] - The user whose account data to check
  /// [targetUserId] - The user ID to look for in the m.direct data (the other participant)
  /// [currentUserId] - The current admin user ID for validation
  Future<String?> _checkDirectRoomsInAccountData({
    required String targetUserId,
    required String currentUserId,
  }) async {
    try {
      _log.info('🔍 Checking m.direct account data for user: $currentUserId');
      final Response accountDataResponse = await _apiClient.get(
        '$_matrixUrl/_matrix/client/v3/user/$currentUserId/account_data/m.direct',
        options: _apiClient.matrixOptions,
      );

      _log.info(
        '📊 m.direct response status: ${accountDataResponse.statusCode}',
      );
      _log.info('📊 m.direct response data: ${accountDataResponse.data}');

      if (accountDataResponse.statusCode == 200) {
        final directRooms = accountDataResponse.data as Map<String, dynamic>;
        _log.info('📊 All direct rooms: ${directRooms.keys.toList()}');
        _log.info('📊 Looking for target user: $targetUserId');

        if (directRooms.containsKey(targetUserId)) {
          final roomIds = directRooms[targetUserId] as List<dynamic>;
          _log.info(
            'Found ${roomIds.length} direct message rooms with target user: $roomIds',
          );

          // Try all existing rooms until we find one we can access
          if (roomIds.isNotEmpty) {
            _log.info(
              '🔍 Trying ${roomIds.length} existing direct message rooms...',
            );

            for (int i = 0; i < roomIds.length; i++) {
              final String existingRoomId = roomIds[i] as String;
              _log.info(
                '🔍 Trying room ${i + 1}/${roomIds.length}: $existingRoomId',
              );

              // Quick verification: check if we can still access this room
              try {
                final Response membersResponse = await _apiClient.get(
                  '$_matrixUrl/_matrix/client/v3/rooms/$existingRoomId/members',
                  options: _apiClient.matrixOptions,
                );

                if (membersResponse.statusCode == 200) {
                  final List<dynamic> members =
                      membersResponse.data['chunk'] ?? [];
                  final joinedMembers = members
                      .where(
                        (member) => member['content']?['membership'] == 'join',
                      )
                      .map((member) => member['state_key'] as String)
                      .toList();

                  _log.info(
                    '✅ Room $existingRoomId has ${joinedMembers.length} joined members: $joinedMembers',
                  );

                  // If it's a 2-person room with admin and target user, check power levels
                  if (joinedMembers.length == 2 &&
                      joinedMembers.contains(currentUserId) &&
                      joinedMembers.contains(targetUserId)) {
                    // Check if this room has the correct power levels for admin-only messaging
                    _log.info(
                      '🔍 Checking power levels for room: $existingRoomId',
                    );
                    final powerLevelsValid = await _checkRoomPowerLevels(
                      existingRoomId,
                      currentUserId,
                      targetUserId,
                    );

                    if (powerLevelsValid) {
                      _log.info(
                        '🎯 Found valid 2-person room with correct power levels: $existingRoomId',
                      );
                      return existingRoomId;
                    } else {
                      _log.info(
                        '⚠️ Room $existingRoomId has incorrect power levels (user can write), trying next...',
                      );
                    }
                  } else {
                    _log.info(
                      '⚠️ Room $existingRoomId is not a valid 2-person room, trying next...',
                    );
                  }
                } else {
                  _log.info(
                    '❌ Cannot access room $existingRoomId (status: ${membersResponse.statusCode}), leaving room...',
                  );
                  // Leave the room if we can't access it
                  await _apiClient.delete(
                    '$_matrixUrl/_matrix/client/v3/rooms/$existingRoomId',
                    options: _apiClient.matrixOptions,
                  );
                  _log.info('Room left successfully');
                }
              } catch (e) {
                _log.info(
                  '❌ Error checking room $existingRoomId: $e, trying next...',
                );
              }
            }

            _log.info(
              '❌ None of the ${roomIds.length} existing rooms are accessible or valid',
            );
          }
        } else {
          _log.info(
            '❌ No direct message rooms found with target user: $targetUserId',
          );
        }
      } else {
        _log.info(
          '❌ Failed to get m.direct account data for user $currentUserId: ${accountDataResponse.statusCode}',
        );
      }

      return null;
    } catch (e, stackTrace) {
      _log.info(
        '_checkDirectRoomsInAccountData error for user $currentUserId: $e',
      );
      _log.info('_checkDirectRoomsInAccountData stackTrace: $stackTrace');
      return null;
    }
  }

  /// Sends a direct text message to a user (creates room if needed)
  // Future<Map<String, String>> sendDirectTextMessage({
  //   required String targetUserId,
  //   required String text,
  //   String? transactionId,
  // }) async {
  //   _log.info('MatrixRoomApiService.sendDirectTextMessage called');
  //   _log.info('targetUserId: $targetUserId');
  //   _log.info('text: $text');
  //   _log.info('transactionId: $transactionId');

  //   try {
  //     final message = MatrixTextMessage(body: text);
  //     _log.info('Created MatrixTextMessage: ${message.toJson()}');
  //     _log.info('Message msgtype: ${message.msgtype}');
  //     _log.info('Message body: ${message.body}');

  //     final result = await sendDirectMessage(
  //       targetUserId: targetUserId,
  //       message: message,
  //       transactionId: transactionId,
  //     );

  //     _log.info('MatrixRoomApiService.sendDirectTextMessage result: $result');
  //     return result;
  //   } catch (e, stackTrace) {
  //     _log.info('MatrixRoomApiService.sendDirectTextMessage error: $e');
  //     _log.info(
  //       'MatrixRoomApiService.sendDirectTextMessage stackTrace: $stackTrace',
  //     );
  //     rethrow;
  //   }
  // }

  /// Gets or creates a direct message room with a specific user
  /// Returns the room ID whether it's existing or newly created
  /// Also ensures the admin is in the room before returning
  Future<String> findOrCreateDirectMessageRoom({
    required String targetUserId,
    required String currentUserId,
  }) async {
    final roomId = await _findOrcreateDirectMessageRoom(
      targetUserId: targetUserId,
      currentUserId: currentUserId,
    );
    // Ensure admin is in the room (important when using existing rooms)
    await _ensureAdminInRoom(roomId);
    return roomId;
  }

  /// Invites a user to an existing room
  Future<void> inviteUserToRoom({
    required String roomId,
    required String userId,
  }) async {
    final encodedRoomId = _encodeRoomId(roomId);
    final endpoint =
        '$_matrixUrl/_matrix/client/v3/rooms/$encodedRoomId/invite';

    final data = jsonEncode({"user_id": userId});

    final Response response = await _apiClient.post(
      endpoint,
      data: data,
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode == 200) {
      _notificationService.showSnackBar(
        NotificationType.success,
        'Benutzer eingeladen',
      );
    } else {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Einladen: ${response.statusCode}',
      );
      throw ApiException(
        'Fehler beim Einladen des Benutzers',
        response.statusCode,
      );
    }
  }

  /// Checks if a room has the correct power levels for admin-user communication
  /// Admin should have full permissions (100), user should have read-only (0)
  Future<bool> _checkRoomPowerLevels(
    String roomId,
    String adminUserId,
    String targetUserId,
  ) async {
    try {
      _log.info('Checking power levels for room: $roomId');

      final Response response = await _apiClient.get(
        '$_matrixUrl/_matrix/client/v3/rooms/$roomId/state/m.room.power_levels',
        options: _apiClient.matrixOptions,
      );

      if (response.statusCode == 200) {
        final powerLevels = response.data['content'] as Map<String, dynamic>;
        final users = powerLevels['users'] as Map<String, dynamic>? ?? {};

        final adminPowerLevel = users[adminUserId] as int? ?? 0;
        final userPowerLevel = users[targetUserId] as int? ?? 0;

        _log.info(
          'Admin power level: $adminPowerLevel, User power level: $userPowerLevel',
        );

        // Admin should have high power level (100), user should have low power level (0)
        final isValid = adminPowerLevel >= 50 && userPowerLevel == 0;

        if (isValid) {
          _log.info('Power levels are correct for admin-user communication');
        } else {
          _log.info(
            'Power levels are incorrect - admin: $adminPowerLevel, user: $userPowerLevel',
          );
        }

        return isValid;
      } else {
        _log.info(
          'Failed to get power levels for room $roomId: ${response.statusCode}',
        );
        return false;
      }
    } catch (e) {
      _log.info('Error checking power levels for room $roomId: $e');
      return false;
    }
  }

  /// Manually marks a room as a direct chat in m.direct account data
  Future<void> _markRoomAsDirectChat(String roomId, String targetUserId) async {
    try {
      // Get current user info
      final Response whoamiResponse = await _apiClient.get(
        '$_matrixUrl/_matrix/client/v3/account/whoami',
        options: _apiClient.matrixOptions,
      );

      if (whoamiResponse.statusCode == 200) {
        final currentUserId = whoamiResponse.data['user_id'] as String;

        // Get current m.direct account data
        final Response getResponse = await _apiClient.get(
          '$_matrixUrl/_matrix/client/v3/user/$currentUserId/account_data/m.direct',
          options: _apiClient.matrixOptions,
        );

        Map<String, dynamic> directRooms = {};
        if (getResponse.statusCode == 200) {
          directRooms = Map<String, dynamic>.from(getResponse.data ?? {});
          _log.info('📊 Current m.direct data: $directRooms');
        }

        // Add this room to the direct chat list for the target user
        if (directRooms.containsKey(targetUserId)) {
          final List<dynamic> existingRooms = List<dynamic>.from(
            directRooms[targetUserId] ?? [],
          );
          if (!existingRooms.contains(roomId)) {
            existingRooms.add(roomId);
            directRooms[targetUserId] = existingRooms;
            _log.info(
              '📊 Added room to existing direct chat list for $targetUserId',
            );
          } else {
            _log.info('📊 Room already in direct chat list for $targetUserId');
            return;
          }
        } else {
          directRooms[targetUserId] = [roomId];
          _log.info('📊 Created new direct chat entry for $targetUserId');
        }

        // Update m.direct account data
        final Response putResponse = await _apiClient.put(
          '$_matrixUrl/_matrix/client/v3/user/$currentUserId/account_data/m.direct',
          data: directRooms,
          options: _apiClient.matrixOptions,
        );

        if (putResponse.statusCode == 200) {
          _log.info(
            '✅ Successfully marked room $roomId as direct chat with $targetUserId',
          );
        } else {
          _log.info(
            '❌ Failed to mark room as direct chat: ${putResponse.statusCode} - ${putResponse.data}',
          );
        }
      }
    } catch (e) {
      _log.info('❌ Error marking room as direct chat: $e');
    }
  }

  /// Checks if a room is marked as a direct chat in m.direct account data
  Future<void> _checkIfRoomIsMarkedAsDirectChat(
    String roomId,
    String targetUserId,
  ) async {
    try {
      // Get current user info
      final Response whoamiResponse = await _apiClient.get(
        '$_matrixUrl/_matrix/client/v3/account/whoami',
        options: _apiClient.matrixOptions,
      );

      if (whoamiResponse.statusCode == 200) {
        final currentUserId = whoamiResponse.data['user_id'] as String;

        // Check m.direct account data
        final Response accountDataResponse = await _apiClient.get(
          '$_matrixUrl/_matrix/client/v3/user/$currentUserId/account_data/m.direct',
          options: _apiClient.matrixOptions,
        );

        if (accountDataResponse.statusCode == 200) {
          final directRooms = accountDataResponse.data as Map<String, dynamic>;
          _log.info('📊 Current m.direct data: $directRooms');

          if (directRooms.containsKey(targetUserId)) {
            final roomIds = directRooms[targetUserId] as List<dynamic>;
            if (roomIds.contains(roomId)) {
              _log.info(
                '✅ Room $roomId IS marked as direct chat with $targetUserId',
              );
            } else {
              _log.info(
                '❌ Room $roomId is NOT marked as direct chat with $targetUserId',
              );
              _log.info('📊 Direct chat rooms with $targetUserId: $roomIds');
            }
          } else {
            _log.info('❌ No direct chat rooms found with $targetUserId');
          }
        } else {
          _log.info(
            '❌ Failed to get m.direct data: ${accountDataResponse.statusCode}',
          );
        }
      }
    } catch (e) {
      _log.info('❌ Error checking if room is marked as direct chat: $e');
    }
  }

  /// Ensures the admin account is in the room before sending messages
  /// This prevents 403 Forbidden errors when trying to send to existing rooms
  Future<void> _ensureAdminInRoom(String roomId) async {
    _log.info('_ensureAdminInRoom called for room: $roomId');

    try {
      // Get current user info
      final Response whoamiResponse = await _apiClient.get(
        '$_matrixUrl/_matrix/client/v3/account/whoami',
        options: _apiClient.matrixOptions,
      );

      if (whoamiResponse.statusCode != 200) {
        _log.info(
          'Failed to get current user info: ${whoamiResponse.statusCode}',
        );
        return;
      }

      final currentUserId = whoamiResponse.data['user_id'] as String;
      _log.info('Current admin user: $currentUserId');

      // Check if the admin is already in the room
      final Response membersResponse = await _apiClient.get(
        '$_matrixUrl/_matrix/client/v3/rooms/$roomId/members',
        options: _apiClient.matrixOptions,
      );

      if (membersResponse.statusCode == 200) {
        final List<dynamic> members = membersResponse.data['chunk'] ?? [];
        final isAdminInRoom = members.any(
          (member) =>
              member['state_key'] == currentUserId &&
              member['content']?['membership'] == 'join',
        );

        if (isAdminInRoom) {
          _log.info('Admin is already in room: $roomId');
          return;
        }
      }

      // If admin is not in the room, try to join it
      _log.info('Admin not in room, attempting to join...');
      final Response joinResponse = await _apiClient.post(
        '$_matrixUrl/_matrix/client/v3/rooms/$roomId/join',
        options: _apiClient.matrixOptions,
      );

      if (joinResponse.statusCode == 200) {
        _log.info('Successfully joined room: $roomId');
      } else {
        _log.info(
          'Failed to join room: ${joinResponse.statusCode} - ${joinResponse.data}',
        );
        // Don't throw here, let the message sending attempt proceed
        // The error will be caught when trying to send the message
      }
    } catch (e, stackTrace) {
      _log.info('_ensureAdminInRoom error: $e');
      _log.info('_ensureAdminInRoom stackTrace: $stackTrace');
      // Don't throw here, let the message sending attempt proceed
    }
  }
}
