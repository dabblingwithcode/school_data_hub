import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/utils/secure_storage.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

/// Implementation of a Serverpod [AuthenticationKeyManager] specifically for
/// School Data Hub
class HubAuthKeyManager extends AuthenticationKeyManager {
  String _storageKey() => 'hub_auth_key_${envName}_$runMode';

  bool _initialized = false;
  String? _authenticationKey;

  /// The run mode of the Serverpod.
  final String runMode;

  final String envName;
  final Storage _storage = ServerpodSecureStorage();

  /// Creates a new authentication key manager. By default it uses the
  /// shared preferences for storing keys.
  HubAuthKeyManager({
    required this.runMode,
    required this.envName,
  });

  @override
  Future<String?> get() async {
    if (!_initialized) {
      _authenticationKey = await _storage.getString(_storageKey());
      _initialized = true;
    }

    return _authenticationKey;
  }

  @override
  Future<void> put(String key) async {
    _authenticationKey = key;

    await _storage.setString(_storageKey(), key);
  }

  @override
  Future<void> remove() async {
    _authenticationKey = null;

    await _storage.remove(_storageKey());
  }
}
