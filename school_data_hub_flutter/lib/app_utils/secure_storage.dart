import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

const _secureStorage = FlutterSecureStorage();

enum SecureStorageKey {
  environments('environments'),
  sessions('sessions'),
  pupilIdentities('pupilIdentities'),
  matrix('matrix'),
  ;

  final String value;
  const SecureStorageKey(this.value);
}

/// We are using two interfaces to interact with
/// the same instance of [FlutterSecureStorage]
/// [AppSecureStorage] is used for the app
/// for storing pupil identities and environments
/// we keep it for legacy reasons
/// and to avoid breaking changes in the app
///
/// [ServerpodSecureStorage] is used for the serverpod client
/// for storing the authentication key
/// and implements the [Storage] interface
/// for the [FlutterAuthenticationKeyManager]

class AppSecureStorage {
  static Future<bool> containsKey(String key) async {
    if (await _secureStorage.containsKey(key: key)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String?> read(String key) async {
    final value = await _secureStorage.read(key: key);
    return value;
  }

  static Future<void> write(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
    return;
  }

  static Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
    return;
  }
}

/// We are using two interfaces to interact with
/// the same instance of [FlutterSecureStorage]
/// [AppSecureStorage] is used for the app
/// for storing pupil identities and environments
/// we keep it for legacy reasons
/// and to avoid breaking changes in the app
///
/// [ServerpodSecureStorage] is used for the serverpod client
/// for storing the authentication key
/// and implements the [Storage] interface
/// for the [FlutterAuthenticationKeyManager]
///
class ServerpodSecureStorage implements Storage {
  // Singleton instance
  static final ServerpodSecureStorage _instance =
      ServerpodSecureStorage._internal();

  // Private constructor
  ServerpodSecureStorage._internal();

  // Factory constructor to return the singleton instance
  factory ServerpodSecureStorage() {
    return _instance;
  }

  /// Stores an int value with the specified key.
  @override
  Future<void> setInt(String key, int value) async {
    return Future.value();
  }

  /// Retrieves an int value with the specified key.
  @override
  Future<int?> getInt(String key) {
    return Future.value(null);
  }

  /// Stores a string value with the specified key.
  @override
  Future<void> setString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
    return;
  }

  /// Retrieves a string value with the specified key.
  @override
  Future<String?> getString(String key) async {
    final value = await _secureStorage.read(key: key);
    return value;
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
