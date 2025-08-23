import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

/// Utility functions for stream operations
class StreamUtils {
  /// Generates a unique connection code
  static String generateConnectionCode() {
    final random = const Uuid().v4().substring(1, 10);
    return random;
  }

  /// Formats a timestamp to a readable string
  static String formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'vor ${difference.inSeconds} Sekunden';
    } else if (difference.inHours < 1) {
      return 'vor ${difference.inMinutes} Minuten';
    } else if (difference.inDays < 1) {
      return 'vor ${difference.inHours} Stunden';
    } else {
      return 'vor ${difference.inDays} Tagen';
    }
  }

  /// Creates a transfer history entry
  static String createTransferHistoryEntry(
    String receiverName,
    int totalPupils,
    int newPupils,
  ) {
    final timestamp = DateTime.now();
    final timeStr =
        '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';

    String countInfo;
    if (newPupils == 0) {
      countInfo = '$totalPupils Schüler (keine neuen)';
    } else if (newPupils == totalPupils) {
      countInfo = '$totalPupils neue Schüler';
    } else {
      countInfo = '$totalPupils Schüler ($newPupils neue)';
    }

    return '$timeStr - $receiverName: $countInfo';
  }

  /// Parses targeted message format "targetUser:actualValue"
  static Map<String, String> parseTargetedMessage(String message) {
    final parts = message.split(':');
    if (parts.length >= 2) {
      return {
        'targetUser': parts[0],
        'actualValue': parts
            .sublist(1)
            .join(':'), // Handle case where value contains ':'
      };
    }
    return {'targetUser': '', 'actualValue': message};
  }

  /// Creates a targeted message in format "targetUser:actualValue"
  static String createTargetedMessage(String targetUser, String actualValue) {
    return '$targetUser:$actualValue';
  }

  /// Validates if a user should be auto-rejected based on rejection tracking
  static bool shouldAutoReject(
    String userName,
    Set<String> rejectedUsers,
    Duration cooldownDuration,
  ) {
    // For simplicity, we're using a set here
    // In a real implementation, you might store rejection timestamps
    // and check if the cooldown period has passed
    return rejectedUsers.contains(userName);
  }

  /// Logs debug information in debug mode only
  static void debugLog(String message) {
    if (kDebugMode) {
      print('[PupilIdentityStream] $message');
    }
  }

  /// Safely encodes JSON data
  static String safeJsonEncode(dynamic data) {
    try {
      return jsonEncode(data);
    } catch (e) {
      debugLog('JSON encode error: $e');
      return '{}';
    }
  }

  /// Safely decodes JSON data
  static dynamic safeJsonDecode(String jsonString) {
    try {
      return jsonDecode(jsonString);
    } catch (e) {
      debugLog('JSON decode error: $e');
      return null;
    }
  }

  /// Validates connection code format
  static bool isValidConnectionCode(String code) {
    if (code.length != 9) return false;
    // Check if it's a valid UUID substring (alphanumeric + hyphens)
    return RegExp(r'^[a-f0-9-]+$').hasMatch(code.toLowerCase());
  }

  /// Gets status color based on state
  static Color getStatusColor(bool isConnected, bool hasError) {
    if (hasError) return Colors.red;
    if (isConnected) return Colors.green;
    return Colors.orange;
  }

  /// Gets status icon based on state
  static IconData getStatusIcon(
    bool isConnected,
    bool hasError,
    bool isProcessing,
  ) {
    if (hasError) return Icons.error;
    if (isProcessing) return Icons.sync;
    if (isConnected) return Icons.wifi;
    return Icons.wifi_off;
  }
}
