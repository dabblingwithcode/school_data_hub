import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/utils/matrix_notifications/matrix_client.dart';
import 'package:school_data_hub_server/src/utils/matrix_notifications/matrix_helper.dart';
import 'package:school_data_hub_server/src/utils/matrix_notifications/matrix_models.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

class MatrixNotifications {
  static MatrixNotifications? _instance;
  static MatrixNotifications get instance {
    _instance ??= MatrixNotifications._internal();
    return _instance!;
  }

  MatrixNotifications._internal();

  final _currentUserId = '@schuldaten-hub:hermannschule.de';
  final MatrixClient _matrixClient = MatrixClient();
  final _log = Logger('MatrixNotifications');

  //- SEND MESSAGE

  /// Sends a message to a Matrix room using the notifications account
  Future<MatrixMessageResponse> sendMessage({
    required MatrixMessage message,
    required String roomId,
  }) async {
    try {
      final transactionId = MatrixHelper.generateTransactionId();
      final encodedRoomId = MatrixHelper.encodeRoomId(roomId);
      final encodedTransactionId = Uri.encodeComponent(transactionId);
      final endpoint =
          '/_matrix/client/v3/rooms/$encodedRoomId/send/m.room.message/$encodedTransactionId';

      final messageData = <String, dynamic>{
        'msgtype': message.msgtype,
        'body': message.body,
      };

      // Add formatted body if format and formattedBody are provided
      if (message.format != null && message.formattedBody != null) {
        messageData['format'] = message.format;
        messageData['formatted_body'] = message.formattedBody;
      }

      final response =
          await _matrixClient.put(endpoint, jsonEncode(messageData));

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to send message: ${response.statusCode} - ${response.body}',
        );
      }

      return MatrixMessageResponse.fromJson(jsonDecode(response.body));
    } catch (e, stackTrace) {
      _log.severe('Failed to send message', e, stackTrace);
      rethrow;
    }
  }

  /// Sends a direct text message to multiple recipients with HTML formatting
  /// Finds recipients by matching tutor username or scope names containing team name character
  Future<void> sendDirectTextMessage({
    required Session session,
    required List<String> recipients,
    required String text,
    String? html,
  }) async {
    if (recipients.isEmpty) {
      _log.warning('No recipients provided, skipping notification');
      return;
    }

    _log.info('Sending direct text message to ${recipients.length} recipients');

    for (final recipient in recipients) {
      try {
        await _sendDirectTextMessageToSingleUser(
          targetUserId: recipient,
          text: text,
          html: html,
        );
        _log.info('Successfully sent message to $recipient');
      } catch (e, stackTrace) {
        _log.severe(
          'Failed to send message to $recipient',
          e,
          stackTrace,
        );
        // Continue sending to other recipients even if one fails
      }
    }
  }

  /// Finds notification recipients based on tutor and team name from pupil name
  /// Returns list of Matrix user IDs (usernames) that should receive notifications
  Future<Set<String>> findNotificationRecipients({
    required Session session,
    required String pupilNameAndGroup,
    required String tutor,
  }) async {
    // Extract the group name from the pupilNameAndGroup string
    // that is everything between the first and last parenthesis
    final schooldayEventManagementTeamName =
        pupilNameAndGroup.split('(')[1].split(')')[0].substring(0, 1);

    // Fetch all users with their UserInfo, then filter in memory
    // because Serverpod's query builder doesn't support .any() on list fields
    final allUsers = await User.db
        .find(session, include: User.include(userInfo: UserInfo.include()));

    final notificationRecipients = allUsers.where((user) {
      // Check if user is the tutor
      if (user.userInfo?.userName == tutor) {
        return true;
      }
      // Check if any scope name contains the team name character
      final scopeNames = user.userInfo?.scopeNames ?? [];
      return scopeNames.any((scope) =>
          scope.contains('SchooldayEventsManagement.') &&
          scope.split('.').last.contains(schooldayEventManagementTeamName));
    }).toList();

    // Convert to list of user names (Matrix user IDs)
    return notificationRecipients
        .map((user) => user.matrixUserId!)
        .whereType<String>()
        .toSet();
  }

  /// Internal method to send a direct text message to a single user
  Future<MatrixMessageResponse> _sendDirectTextMessageToSingleUser({
    required String targetUserId,
    required String text,
    String? html,
  }) async {
    try {
      _log.info('Sending direct text message to $targetUserId');

      final roomId = await _findOrCreateDirectMessageRoom(
        targetUserId: targetUserId,
        currentUserId: _currentUserId,
      );

      _log.info('Using room ID: $roomId');

      final response = await sendMessage(
        message: MatrixMessage(
          msgtype: 'm.text',
          body: text, // Plain text fallback
          format: html != null ? 'org.matrix.custom.html' : null,
          formattedBody: html,
        ),
        roomId: roomId,
      );

      _log.info('Message sent successfully with event ID: ${response.eventId}');
      return response;
    } catch (e, stackTrace) {
      _log.severe('Failed to send direct text message', e, stackTrace);
      rethrow;
    }
  }

  //- ROOM MANAGEMENT

  /// Finds or creates a direct message room with a specific user
  Future<String> _findOrCreateDirectMessageRoom({
    required String targetUserId,
    required String currentUserId,
  }) async {
    try {
      _log.info('Finding or creating direct message room for: $targetUserId');

      final existingRoomId = await _findExistingDirectMessageRoom(
        targetUserId: targetUserId,
        currentUserId: currentUserId,
      );

      if (existingRoomId != null) {
        _log.info('Found existing room: $existingRoomId');
        return existingRoomId;
      }

      _log.info('No existing room found, creating new direct message room');
      return await _createDirectMessageRoom(
        targetUserId: targetUserId,
        currentUserId: currentUserId,
      );
    } catch (e, stackTrace) {
      _log.severe(
          'Failed to find or create direct message room', e, stackTrace);
      rethrow;
    }
  }

  /// Creates a new direct message room with specific power levels
  Future<String> _createDirectMessageRoom({
    required String targetUserId,
    required String currentUserId,
  }) async {
    try {
      final roomData = {
        'is_direct': true,
        'name': 'Schuldaten Benachrichtigungen',
        'invite': [targetUserId],
        'preset': 'trusted_private_chat',
        'creation_content': {'m.federate': false},
        'initial_state': [
          {
            'type': 'm.room.encryption',
            'content': {
              'algorithm': 'm.megolm.v1.aes-sha2',
            },
          },
        ],
        'power_level_content_override': {
          'users': {
            currentUserId: 100, // Admin has full permissions
            targetUserId: 0, // User has read-only permissions
          },
          'events': {
            'm.room.name': 100,
            'm.room.power_levels': 100,
            'm.room.history_visibility': 100,
            'm.room.canonical_alias': 50,
            'm.room.avatar': 50,
            'm.room.tombstone': 100,
            'm.room.server_acl': 100,
            'm.room.encryption': 100,
            'm.space.child': 50,
            'm.room.topic': 50,
            'm.room.pinned_events': 50,
            'm.reaction': 0,
            'm.room.redaction': 0,
            'org.matrix.msc3401.call': 50,
            'org.matrix.msc3401.call.member': 50,
            'im.vector.modular.widgets': 50,
            'io.element.voice_broadcast_info': 50,
          },
          'events_default': 50,
          'invite': 50,
          'kick': 50,
          'notifications': {'room': 20},
          'redact': 50,
          'state_default': 50,
          'users_default': 0,
        },
      };

      final response = await _matrixClient.post(
        '/_matrix/client/v3/createRoom',
        jsonEncode(roomData),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to create room: ${response.statusCode} - ${response.body}',
        );
      }

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      final roomId = responseData['room_id'] as String;

      _log.info('Room created successfully: $roomId');

      await _ensureRoomIsMarkedAsDirectChat(roomId, targetUserId);
      return roomId;
    } catch (e, stackTrace) {
      _log.severe('Failed to create direct message room', e, stackTrace);
      rethrow;
    }
  }

  /// Finds an existing direct message room with a specific user
  Future<String?> _findExistingDirectMessageRoom({
    required String targetUserId,
    required String currentUserId,
  }) async {
    try {
      _log.info('Checking for existing direct message room with $targetUserId');

      final existingRoomId = await _checkDirectRoomsInAccountData(
        targetUserId: targetUserId,
        currentUserId: currentUserId,
      );

      if (existingRoomId != null) {
        _log.info('Found existing room: $existingRoomId');
        // Test if there is still access to the room

        return existingRoomId;
      }

      _log.info('No existing direct message room found');
      return null;
    } catch (e, stackTrace) {
      _log.warning('Error finding existing room', e, stackTrace);
      return null;
    }
  }

  /// Checks m.direct account data for existing rooms and validates them
  Future<String?> _checkDirectRoomsInAccountData({
    required String targetUserId,
    required String currentUserId,
  }) async {
    try {
      final encodedUserId = Uri.encodeComponent(currentUserId);
      final response = await _matrixClient.get(
        '/_matrix/client/v3/user/$encodedUserId/account_data/m.direct',
      );

      if (response.statusCode != 200) {
        _log.warning(
          'Failed to get m.direct account data: ${response.statusCode}',
        );
        return null;
      }

      final directRooms = jsonDecode(response.body) as Map<String, dynamic>;
      final roomIds = directRooms[targetUserId] as List<dynamic>?;

      if (roomIds == null || roomIds.isEmpty) {
        _log.info('No direct rooms found for $targetUserId');
        return null;
      }

      _log.info('Found ${roomIds.length} potential rooms for $targetUserId');

      for (final roomId in roomIds) {
        final existingRoomId = roomId as String;
        if (await _validateRoom(existingRoomId, currentUserId, targetUserId)) {
          return existingRoomId;
        }
      }

      _log.info('No valid rooms found among ${roomIds.length} existing rooms');
      return null;
    } catch (e, stackTrace) {
      _log.warning(
          'Error checking direct rooms in account data', e, stackTrace);
      return null;
    }
  }

  /// Validates that a room is accessible and has the correct members
  Future<bool> _validateRoom(
    String roomId,
    String currentUserId,
    String targetUserId,
  ) async {
    try {
      // Check if current user is a member of the room
      final encodedRoomId = MatrixHelper.encodeRoomId(roomId);
      final encodedCurrentUserId = Uri.encodeComponent(currentUserId);
      final currentUserResponse = await _matrixClient.get(
        '/_matrix/client/v3/rooms/$encodedRoomId/state/m.room.member/$encodedCurrentUserId',
      );

      if (currentUserResponse.statusCode != 200) {
        _log.info(
          'Cannot access room $roomId (status: ${currentUserResponse.statusCode})',
        );
        await _leaveAndRemoveRoom(roomId, targetUserId, currentUserId);
        return false;
      }

      final currentMember =
          jsonDecode(currentUserResponse.body) as Map<String, dynamic>;
      if (currentMember['membership'] != 'join') {
        _log.info('Current user is not a member of room $roomId');
        await _leaveAndRemoveRoom(roomId, targetUserId, currentUserId);
        return false;
      }

      // Check if target user is also a member of the room
      final encodedTargetUserId = Uri.encodeComponent(targetUserId);
      final targetUserResponse = await _matrixClient.get(
        '/_matrix/client/v3/rooms/$encodedRoomId/state/m.room.member/$encodedTargetUserId',
      );

      if (targetUserResponse.statusCode != 200) {
        _log.info(
          'Target user membership not found for room $roomId (status: ${targetUserResponse.statusCode})',
        );
        await _leaveAndRemoveRoom(roomId, targetUserId, currentUserId);
        return false;
      }

      final targetMember =
          jsonDecode(targetUserResponse.body) as Map<String, dynamic>;
      if (targetMember['membership'] != 'join') {
        _log.info('Target user is not a member of room $roomId');
        await _leaveAndRemoveRoom(roomId, targetUserId, currentUserId);
        return false;
      }

      _log.info('Valid room found: $roomId (both users are members)');
      return true;
    } catch (e) {
      _log.warning('Error validating room $roomId: $e');
      return false;
    }
  }

  /// Leaves a room and removes it from m.direct account data
  Future<void> _leaveAndRemoveRoom(
    String roomId,
    String targetUserId,
    String currentUserId,
  ) async {
    try {
      final encodedRoomId = MatrixHelper.encodeRoomId(roomId);
      await _matrixClient.post(
        '/_matrix/client/v3/rooms/$encodedRoomId/leave',
        '{}',
      );
      _log.info('Left room $roomId');

      final encodedUserId = Uri.encodeComponent(currentUserId);
      final response = await _matrixClient.get(
        '/_matrix/client/v3/user/$encodedUserId/account_data/m.direct',
      );

      if (response.statusCode == 200) {
        final directRooms = jsonDecode(response.body) as Map<String, dynamic>;
        final roomIds = (directRooms[targetUserId] as List<dynamic>?) ?? [];

        directRooms[targetUserId] =
            roomIds.where((room) => room != roomId).toList();

        await _matrixClient.put(
          '/_matrix/client/v3/user/$encodedUserId/account_data/m.direct',
          jsonEncode(directRooms),
        );
        _log.info('Removed room $roomId from m.direct');
      }
    } catch (e) {
      _log.warning('Error leaving/removing room $roomId: $e');
    }
  }

  /// Ensures a room is marked as a direct chat in m.direct account data
  Future<void> _ensureRoomIsMarkedAsDirectChat(
    String roomId,
    String targetUserId,
  ) async {
    try {
      final encodedUserId = Uri.encodeComponent(_currentUserId);
      final response = await _matrixClient.get(
        '/_matrix/client/v3/user/$encodedUserId/account_data/m.direct',
      );

      if (response.statusCode != 200) {
        _log.warning(
          'Failed to get m.direct data: ${response.statusCode}',
        );
        return;
      }

      final directRooms = jsonDecode(response.body) as Map<String, dynamic>;
      final roomIds = (directRooms[targetUserId] as List<dynamic>?) ?? [];

      if (roomIds.contains(roomId)) {
        _log.info('Room $roomId already marked as direct chat');
        return;
      }

      _log.info('Marking room $roomId as direct chat with $targetUserId');
      directRooms[targetUserId] = [...roomIds, roomId];

      await _matrixClient.put(
        '/_matrix/client/v3/user/$encodedUserId/account_data/m.direct',
        jsonEncode(directRooms),
      );
      _log.info('Room marked as direct chat successfully');
    } catch (e) {
      _log.warning('Error ensuring room is marked as direct chat: $e');
    }
  }

  /// Clean up resources
  void dispose() {
    _matrixClient.dispose();
  }
}
