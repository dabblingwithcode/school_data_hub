import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

// Configure secure storage with platform-specific options
const _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
  iOptions: IOSOptions(
    accessibility: KeychainAccessibility.first_unlock_this_device,
  ),
);

/// [HubSecureStorage] implements the [Storage] interface
/// for the [FlutterAuthenticationKeyManager]. We use
/// the storage for the app.
///
class HubSecureStorage extends Storage {
  // Singleton instance
  static final HubSecureStorage _instance = HubSecureStorage._internal();

  // Private constructor
  HubSecureStorage._internal();

  // Factory constructor to return the singleton instance
  factory HubSecureStorage() {
    return _instance;
  }

  /// Stores an int value with the specified key.
  @override
  Future<void> setInt(String key, int value) async {
    await _secureStorage.write(key: key, value: value.toString());
    return;
  }

  /// Retrieves an int value with the specified key.
  @override
  Future<int?> getInt(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null ? int.tryParse(value) : null;
  }

  /// Stores a string value with the specified key.
  @override
  Future<void> setString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
    return;
  }

  /// Retrieves a string value with the specified key.
  /// Includes retry logic for Windows file locking issues.
  @override
  Future<String?> getString(String key) async {
    const maxRetries = 3;
    const baseDelay = Duration(milliseconds: 100);

    for (int attempt = 0; attempt < maxRetries; attempt++) {
      try {
        final value = await _secureStorage.read(key: key);
        return value;
      } catch (e) {
        // Check if it's a Windows file access error
        if (e.toString().contains('PathAccessException') ||
            e.toString().contains(
              'Der Prozess kann nicht auf die Datei zugreifen',
            )) {
          if (attempt < maxRetries - 1) {
            // Wait with exponential backoff
            final delay = Duration(
              milliseconds: baseDelay.inMilliseconds * (1 << attempt),
            );
            await Future.delayed(delay);
            continue;
          }
        }

        // Re-throw if it's not a retryable error or we've exhausted retries
        rethrow;
      }
    }

    return null;
  }

  /// Removes a value for the specified key.
  @override
  Future<void> remove(String key) async {
    await _secureStorage.delete(key: key);
    return;
  }

  Future<bool> containsKey(String key) async {
    if (await _secureStorage.containsKey(key: key)) {
      return true;
    } else {
      return false;
    }
  }
}
