import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/matrix_message.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/services/api/api_client.dart';
import 'package:school_data_hub_flutter/features/matrix/services/api/api_settings.dart';

enum ChatTypePreset {
  public('public_chat'),
  private('private_chat'),
  trustedPrivate('trusted_private_chat');

  final String value;
  const ChatTypePreset(this.value);
}

class MatrixRoomApiService {
  final ApiClient _apiClient;
  final _log = Logger('MatrixRoomApiService');

  MatrixRoomApiService({required ApiClient apiClient}) : _apiClient = apiClient;

  // TODO: There is still code left from the time where the power levels could not be set by matrix-coporal
  //- We should clean up here.

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
    final visibility = switch (chatTypePreset) {
      ChatTypePreset.public => 'public',
      ChatTypePreset.private => 'private',
      ChatTypePreset.trustedPrivate => 'private',
    };
    final data = jsonEncode({
      "creation_content": {"m.federate": false},
      "is_direct": false,
      "name": name,
      "preset": chatTypePreset.value,
      if (aliasName != null) "room_alias_name": aliasName,
      "topic": topic,
      "visibility": visibility,
      "power_level_content_override": {
        // "users": {"<user-id>": 100},
        "events": {
          // only the admin should be allowed to change the room name
          // because we use it to assign users to the room
          "m.room.name": 100,
          "m.reaction": 0,
          // only mods shall start a poll
          "org.matrix.msc3381.poll.start": 50,
          // anyone shall vote on a poll
          "org.matrix.msc3381.poll.response": 0,
          // only mods shall end a poll
          "org.matrix.msc3381.poll.end": 50,
        },
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
      _createRoom,
      data: data,
      options: _apiClient.matrixOptions,
    );
    //- TODO: Room version 12 will NOT respond with the complete address
    //- It leaves the domain part out - we need to consider this in the future
    if (response.statusCode == 200) {
      // extract the value of "room_id" out of the response
      final String roomId = response.data['room_id'] as String;
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

  String _fetchRoomAvatarUrl(String roomId) {
    return '/_matrix/client/v3/rooms/$roomId/state/m.room.avatar';
  }

  String _fetchRoomTopicUrl(String roomId) {
    return '/_matrix/client/v3/rooms/${_encodeRoomId(roomId)}/state/m.room.topic';
  }

  String _fetchRoomCanonicalAliasUrl(String roomId) {
    return '/_matrix/client/v3/rooms/${_encodeRoomId(roomId)}/state/m.room.canonical_alias';
  }

  Future<MatrixRoom> fetchAdditionalRoomInfos(String roomId) async {
    String? name;
    String? avatarUrl;
    int? powerLevelReactions;
    int? eventsDefault;
    List<RoomAdmin>? roomAdmins;

    // First API call
    final responseRoomSPowerLevels = await _apiClient.get(
      _fetchRoomPowerLevelsUrl(roomId),
      options: _apiClient.matrixOptions,
    );

    if (responseRoomSPowerLevels.statusCode == 200) {
      powerLevelReactions =
          responseRoomSPowerLevels.data['events']['m.reaction'] as int? ?? 0;
      eventsDefault =
          responseRoomSPowerLevels.data['events_default'] as int? ?? 0;

      if (responseRoomSPowerLevels.data['users'] is Map<String, dynamic>) {
        final usersMap =
            responseRoomSPowerLevels.data['users'] as Map<String, dynamic>;
        roomAdmins = usersMap.keys
            .map(
              (userId) => RoomAdmin(
                id: userId as String,
                powerLevel: usersMap[userId] as int? ?? 0,
              ),
            )
            .toList();
      }
    }

    // Second API call
    final responseRoomName = await _apiClient.get(
      _fetchRoomName(roomId),
      options: _apiClient.matrixOptions,
    );

    if (responseRoomName.statusCode == 200) {
      name = responseRoomName.data['name'] as String? ?? 'No Room Name';
    }

    final responseRoomAvatar = await _apiClient.get(
      _fetchRoomAvatarUrl(roomId),
      options: _apiClient.matrixOptions,
    );

    if (responseRoomAvatar.statusCode == 200) {
      final avatarData = responseRoomAvatar.data;
      if (avatarData is Map<String, dynamic>) {
        avatarUrl =
            avatarData['url'] as String? ??
            (avatarData['content'] is Map<String, dynamic>
                ? (avatarData['content']['url'] as String?)
                : null);
      }
    }

    MatrixRoom roomWithAdditionalInfos = MatrixRoom(
      id: roomId,
      name: name,
      avatarUrl: avatarUrl,
      powerLevelReactions: powerLevelReactions,
      eventsDefault: eventsDefault,
      roomAdmins: roomAdmins,
    );

    return roomWithAdditionalInfos;
  }

  //- SET ROOM POWER LEVELS

  Future<MatrixRoom> changeRoomPowerLevels({
    required String roomId,
    RoomAdmin? newRoomAdmin,
    String? adminIdToRemove,
    int? eventsDefault,
    int? reactions,
    required MatrixRoom currentRoom,
    required String matrixAdmin,
  }) async {
    if (newRoomAdmin != null || adminIdToRemove != null) {
      di<NotificationService>().showInformationDialog(
        'Power levels werden von der Policy geändert.',
      );
      return currentRoom;
    }

    if (eventsDefault == null && reactions == null) {
      return currentRoom;
    }

    final Response fetchResponse = await _apiClient.get(
      _fetchRoomPowerLevelsUrl(roomId),
      options: _apiClient.matrixOptions,
    );

    if (fetchResponse.statusCode != 200 ||
        fetchResponse.data is! Map<String, dynamic>) {
      throw ApiException(
        'Fehler beim Laden der Raum-Berechtigungen',
        fetchResponse.statusCode,
      );
    }

    final Map<String, dynamic> payload = Map<String, dynamic>.from(
      fetchResponse.data as Map<String, dynamic>,
    );
    final Map<String, dynamic> events = Map<String, dynamic>.from(
      payload['events'] as Map<String, dynamic>,
    );

    if (reactions != null) {
      events['m.reaction'] = reactions;
    }
    if (eventsDefault != null) {
      payload['events_default'] = eventsDefault;
    }
    payload['events'] = events;

    final Response putResponse = await _apiClient.put(
      _fetchRoomPowerLevelsUrl(roomId),
      data: payload,
      options: _apiClient.matrixOptions,
    );

    if (putResponse.statusCode != 200) {
      throw ApiException(
        'Fehler beim Setzen der Raum-Berechtigungen',
        putResponse.statusCode,
      );
    }

    return fetchAdditionalRoomInfos(roomId);
  }

  Future<MatrixRoom> setRoomAvatar({
    required String roomId,
    required Uint8List fileBytes,
    required String fileName,
  }) async {
    final extension = fileName.contains('.')
        ? fileName.split('.').last.toLowerCase()
        : '';
    final contentType = switch (extension) {
      'png' => 'image/png',
      'jpg' || 'jpeg' => 'image/jpeg',
      'gif' => 'image/gif',
      'webp' => 'image/webp',
      _ => 'application/octet-stream',
    };

    final Response uploadResponse = await _apiClient.post(
      '/_matrix/media/v3/upload',
      data: fileBytes,
      queryParameters: {'filename': fileName},
      options: _apiClient.matrixOptions.copyWith(contentType: contentType),
    );

    if (uploadResponse.statusCode != 200) {
      throw ApiException(
        'Fehler beim Hochladen des Raum-Avatars',
        uploadResponse.statusCode,
      );
    }

    final String? mxcUrl = uploadResponse.data['content_uri'] as String?;
    if (mxcUrl == null || mxcUrl.isEmpty) {
      throw ApiException('Ungültige Antwort beim Avatar-Upload', 500);
    }

    final Response stateResponse = await _apiClient.put(
      _fetchRoomAvatarUrl(roomId),
      data: {'url': mxcUrl},
      options: _apiClient.matrixOptions,
    );

    if (stateResponse.statusCode != 200) {
      throw ApiException(
        'Fehler beim Setzen des Raum-Avatars',
        stateResponse.statusCode,
      );
    }

    return fetchAdditionalRoomInfos(roomId);
  }

  Future<String?> fetchRoomTopic(String roomId) async {
    final Response<dynamic> response = await _apiClient.get(
      _fetchRoomTopicUrl(roomId),
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200 || response.data is! Map<String, dynamic>) {
      return null;
    }

    return response.data['topic'] as String?;
  }

  Future<String?> fetchRoomCanonicalAlias(String roomId) async {
    final Response response = await _apiClient.get(
      _fetchRoomCanonicalAliasUrl(roomId),
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200 || response.data is! Map<String, dynamic>) {
      return null;
    }

    return response.data['alias'] as String?;
  }

  Future<MatrixRoom> setRoomName({
    required String roomId,
    required String name,
  }) async {
    final Response response = await _apiClient.put(
      '/_matrix/client/v3/rooms/${_encodeRoomId(roomId)}/state/m.room.name',
      data: {'name': name},
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
      throw ApiException(
        'Fehler beim Setzen des Raumnamens',
        response.statusCode,
      );
    }

    return fetchAdditionalRoomInfos(roomId);
  }

  Future<void> setRoomTopic({
    required String roomId,
    required String topic,
  }) async {
    final Response response = await _apiClient.put(
      _fetchRoomTopicUrl(roomId),
      data: {'topic': topic},
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
      throw ApiException(
        'Fehler beim Setzen des Raumthemas',
        response.statusCode,
      );
    }
  }

  Future<void> setRoomCanonicalAlias({
    required String roomId,
    required String? alias,
  }) async {
    final Response response = await _apiClient.put(
      _fetchRoomCanonicalAliasUrl(roomId),
      data: {'alias': alias?.trim().isEmpty == true ? null : alias},
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
      throw ApiException(
        'Fehler beim Setzen des Raum-Alias',
        response.statusCode,
      );
    }
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
    final endpoint = '$_sendMessage/$encodedRoomId/send/$eventType/$txnId';

    // Create a simple message structure for testing
    final messageData = {'msgtype': 'm.text', 'body': message.body};

    try {
      _log.info('Sending message to room: $roomId');
      _log.fine('Endpoint: $endpoint');

      final Response response = await _apiClient.put(
        endpoint,
        data: messageData, // Send as Map, let Dio handle JSON encoding
        options: _apiClient.matrixOptions,
      );

      if (response.statusCode == 200) {
        final eventId = response.data['event_id'] as String;
        _log.info('Message sent successfully with event ID: $eventId');
        return MatrixMessageResponse(eventId: eventId);
      } else {
        _log.warning(
          'Send message failed: ${response.statusCode} - ${response.data}',
        );
        throw ApiException(
          'Fehler beim Senden der Nachricht: ${response.statusCode} - ${response.data}',
          response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      _log.severe('Send message exception: $e', e, stackTrace);
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
    final endpoint = '$_getRoomMessages/$encodedRoomId/messages';

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
        final List<dynamic> chunk = response.data['chunk'] as List<dynamic>;
        return chunk
            .map(
              (eventJson) => MatrixMessageEvent.fromJson(
                eventJson as Map<String, dynamic>,
              ),
            )
            .toList();
      } else {
        throw ApiException(
          'Fehler beim Laden der Nachrichten',
          response.statusCode,
        );
      }
    } catch (e) {
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
  Future<String> _findOrCreateDirectMessageRoom({
    required String targetUserId,
    required String currentUserId,
  }) async {
    try {
      final existingRoomId = await _findExistingDirectMessageRoom(
        targetUserId: targetUserId,
        currentUserId: currentUserId,
      );
      if (existingRoomId != null) {
        return existingRoomId;
      }

      final data = jsonEncode({
        "is_direct": true,
        "name": "Schuldaten Benachrichtigungen",
        "invite": [targetUserId],
        "preset": "private_chat",
        "creation_content": {"m.federate": false},
        "power_level_content_override": {
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
          "users_default": 0,
          "events_default": 50,
          "invite": 50,
          "kick": 50,
          "notifications": {"room": 20},
          "redact": 50,
          "state_default": 50,
        },
      });

      _log.info('Creating room with data: $data');

      final Response response = await _apiClient.post(
        '/_matrix/client/v3/createRoom',
        data: data,
        options: _apiClient.matrixOptions,
      );

      if (response.statusCode == 200) {
        final roomId = response.data['room_id'] as String;
        await _markRoomAsDirectChat(roomId, targetUserId);

        return roomId;
      } else {
        throw ApiException(
          'Fehler beim Erstellen des Direktnachrichten-Raums: ${response.statusCode} - ${response.data}',
          response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      _log.info('_findOrCreateDirectMessageRoom error: $e');
      _log.info('_findOrCreateDirectMessageRoom stackTrace: $stackTrace');
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
    try {
      return await _checkDirectRoomsInAccountData(
        targetUserId: targetUserId,
        currentUserId: currentUserId,
      );
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
      final directRooms = await _getDirectRoomsForUser(currentUserId);
      if (directRooms == null) {
        _log.info(
          'Failed to get m.direct account data for user $currentUserId',
        );
        return null;
      }

      final dynamic rawRoomIds = directRooms[targetUserId];
      if (rawRoomIds is! List) {
        return null;
      }

      final roomIds = rawRoomIds.whereType<String>().toList();
      if (roomIds.isEmpty) {
        return null;
      }

      bool directRoomsChanged = false;
      String? reusableRoomId;
      final retainedRoomIds = <String>[];

      for (final existingRoomId in roomIds) {
        try {
          final encodedRoomId = _encodeRoomId(existingRoomId);
          final Response membersResponse = await _apiClient.get(
            '/_matrix/client/v3/rooms/$encodedRoomId/members',
            options: _apiClient.matrixOptions,
          );

          if (membersResponse.statusCode != 200) {
            directRoomsChanged = true;
            continue;
          }

          final List<dynamic> members =
              membersResponse.data['chunk'] as List<dynamic>;
          final joinedMembers = members
              .where((member) => member['content']?['membership'] == 'join')
              .map((member) => member['state_key'] as String)
              .toSet();

          if (joinedMembers.length == 1 &&
              joinedMembers.contains(currentUserId)) {
            await _purgeDirectRoom(existingRoomId);
            directRoomsChanged = true;
            continue;
          }

          if (joinedMembers.contains(currentUserId) &&
              joinedMembers.contains(targetUserId)) {
            retainedRoomIds.add(existingRoomId);
            reusableRoomId ??= existingRoomId;
            continue;
          }

          directRoomsChanged = true;
        } catch (e) {
          _log.info('Error checking direct room $existingRoomId: $e');
          retainedRoomIds.add(existingRoomId);
        }
      }

      if (directRoomsChanged) {
        if (retainedRoomIds.isEmpty) {
          directRooms.remove(targetUserId);
        } else {
          directRooms[targetUserId] = retainedRoomIds;
        }
        await _putDirectRoomsForUser(currentUserId, directRooms);
      }

      return reusableRoomId;
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
    final roomId = await _findOrCreateDirectMessageRoom(
      targetUserId: targetUserId,
      currentUserId: currentUserId,
    );
    // Ensure admin is in the room (important when using existing rooms)
    await _ensureAdminInRoom(roomId);
    return roomId;
  }

  Future<int> cleanupAdminOnlyDirectRooms({
    required String currentUserId,
  }) async {
    final directRooms = await _getDirectRoomsForUser(currentUserId);
    if (directRooms == null || directRooms.isEmpty) {
      return 0;
    }

    bool directRoomsChanged = false;
    int purgedRooms = 0;

    final entries = directRooms.entries.toList();
    for (final entry in entries) {
      final targetUserId = entry.key;
      final roomIds = (entry.value as List<dynamic>)
          .whereType<String>()
          .toList();

      final retainedRoomIds = <String>[];
      for (final roomId in roomIds) {
        try {
          final encodedRoomId = _encodeRoomId(roomId);
          final Response membersResponse = await _apiClient.get(
            '/_matrix/client/v3/rooms/$encodedRoomId/members',
            options: _apiClient.matrixOptions,
          );

          if (membersResponse.statusCode != 200) {
            directRoomsChanged = true;
            continue;
          }

          final List<dynamic> members =
              membersResponse.data['chunk'] as List<dynamic>;
          final joinedMembers = members
              .where((member) => member['content']?['membership'] == 'join')
              .map((member) => member['state_key'] as String)
              .toSet();

          if (joinedMembers.length == 1 &&
              joinedMembers.contains(currentUserId)) {
            await _purgeDirectRoom(roomId);
            purgedRooms++;
            directRoomsChanged = true;
            continue;
          }

          retainedRoomIds.add(roomId);
        } catch (e) {
          _log.info('Error during orphan DM cleanup for room $roomId: $e');
          retainedRoomIds.add(roomId);
        }
      }

      if (retainedRoomIds.isEmpty) {
        directRooms.remove(targetUserId);
        directRoomsChanged = true;
      } else {
        if (retainedRoomIds.length != roomIds.length) {
          directRoomsChanged = true;
        }
        directRooms[targetUserId] = retainedRoomIds;
      }
    }

    if (directRoomsChanged) {
      await _putDirectRoomsForUser(currentUserId, directRooms);
    }

    return purgedRooms;
  }

  /// Invites a user to an existing room
  Future<void> inviteUserToRoom({
    required String roomId,
    required String userId,
  }) async {
    final encodedRoomId = _encodeRoomId(roomId);
    final endpoint = '/_matrix/client/v3/rooms/$encodedRoomId/invite';

    final data = jsonEncode({"user_id": userId});

    final Response response = await _apiClient.post(
      endpoint,
      data: data,
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
      throw ApiException(
        'Fehler beim Einladen des Benutzers',
        response.statusCode,
      );
    }
  }

  /// Manually marks a room as a direct chat in m.direct account data
  Future<void> _markRoomAsDirectChat(String roomId, String targetUserId) async {
    try {
      final currentUserId = await _getCurrentUserId();

      if (currentUserId == null) {
        return;
      }

      final directRooms = await _getDirectRoomsForUser(currentUserId) ?? {};

      // Add this room to the direct chat list for the target user
      if (directRooms.containsKey(targetUserId)) {
        final List<dynamic> existingRooms = List<dynamic>.from(
          directRooms[targetUserId] as List<dynamic>,
        );
        if (!existingRooms.contains(roomId)) {
          existingRooms.add(roomId);
          directRooms[targetUserId] = existingRooms;
        } else {
          return;
        }
      } else {
        directRooms[targetUserId] = [roomId];
      }

      final success = await _putDirectRoomsForUser(currentUserId, directRooms);

      if (!success) {
        _log.info('Failed to mark room as direct chat for $targetUserId');
      }
    } catch (e) {
      _log.info('Error marking room as direct chat: $e');
    }
  }

  Future<Map<String, dynamic>?> _getDirectRoomsForUser(String userId) async {
    final encodedUserId = Uri.encodeComponent(userId);
    final Response response = await _apiClient.get(
      '/_matrix/client/v3/user/$encodedUserId/account_data/m.direct',
      options: _apiClient.matrixOptions,
    );

    if (response.statusCode != 200) {
      return null;
    }

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      return null;
    }

    if (data['content'] is Map<String, dynamic>) {
      return Map<String, dynamic>.from(data['content'] as Map<String, dynamic>);
    }

    return Map<String, dynamic>.from(data);
  }

  Future<bool> _putDirectRoomsForUser(
    String userId,
    Map<String, dynamic> directRooms,
  ) async {
    final encodedUserId = Uri.encodeComponent(userId);
    final Response response = await _apiClient.put(
      '/_matrix/client/v3/user/$encodedUserId/account_data/m.direct',
      data: directRooms,
      options: _apiClient.matrixOptions,
    );

    return response.statusCode == 200;
  }

  Future<void> _purgeDirectRoom(String roomId) async {
    final encodedRoomId = _encodeRoomId(roomId);

    try {
      await _apiClient.post(
        '/_matrix/client/v3/rooms/$encodedRoomId/leave',
        options: _apiClient.matrixOptions,
      );
    } catch (e) {
      _log.info('Failed to leave room $roomId during purge: $e');
    }

    try {
      await _apiClient.post(
        '/_matrix/client/v3/rooms/$encodedRoomId/forget',
        options: _apiClient.matrixOptions,
      );
    } catch (e) {
      _log.info('Failed to forget room $roomId during purge: $e');
    }
  }

  Future<String?> _getCurrentUserId() async {
    final Response whoamiResponse = await _apiClient.get(
      '/_matrix/client/v3/account/whoami',
      options: _apiClient.matrixOptions,
    );

    if (whoamiResponse.statusCode != 200) {
      _log.info(
        'Failed to get current user info: ${whoamiResponse.statusCode}',
      );
      return null;
    }

    return whoamiResponse.data['user_id'] as String;
  }

  /// Ensures the admin account is in the room before sending messages
  /// This prevents 403 Forbidden errors when trying to send to existing rooms
  Future<void> _ensureAdminInRoom(String roomId) async {
    try {
      final currentUserId = await _getCurrentUserId();
      if (currentUserId == null) {
        return;
      }

      // Check if the admin is already in the room
      final Response membersResponse = await _apiClient.get(
        '/_matrix/client/v3/rooms/$roomId/members',
        options: _apiClient.matrixOptions,
      );

      if (membersResponse.statusCode == 200) {
        final List<dynamic> members =
            membersResponse.data['chunk'] as List<dynamic>;
        final isAdminInRoom = members.any(
          (member) =>
              member['state_key'] == currentUserId &&
              member['content']?['membership'] == 'join',
        );

        if (isAdminInRoom) {
          return;
        }
      }

      // If admin is not in the room, try to join it
      final Response joinResponse = await _apiClient.post(
        '/_matrix/client/v3/rooms/$roomId/join',
        options: _apiClient.matrixOptions,
      );

      if (joinResponse.statusCode != 200) {
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
