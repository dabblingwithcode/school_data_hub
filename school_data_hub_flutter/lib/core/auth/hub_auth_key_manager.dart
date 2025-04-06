import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

final _log = Logger('HubAuthKeyManager');

/// Implementation of a Serverpod [AuthenticationKeyManager] specifically for
/// because we need to consider the environment on which the app is running
/// and we want [ServerpodSecureStorage] for the authentication key.
class HubAuthKeyManager extends AuthenticationKeyManager {
  String _storageKey() => '${envName}_${runMode}_hub_auth_key';

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
      _log.info('Initialized - got authKey from storage: $_authenticationKey');
    }

    return _authenticationKey;
  }

  @override
  Future<void> put(String key) async {
    _authenticationKey = key;

    await _storage.setString(_storageKey(), key);
    _log.info('Saved the authKey with storage key: ${_storageKey()}');
  }

  @override
  Future<void> remove() async {
    _authenticationKey = null;
    _log.info('Removing the user info from storage: ${_storageKey()}');
    await _storage.remove(_storageKey());
  }
}
