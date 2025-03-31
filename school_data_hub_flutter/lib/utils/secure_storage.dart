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

class AppSecureStorage implements Storage {
  // Singleton instance
  static final AppSecureStorage _instance = AppSecureStorage._internal();

  // Private constructor
  AppSecureStorage._internal();

  // Factory constructor to return the singleton instance
  factory AppSecureStorage() {
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
