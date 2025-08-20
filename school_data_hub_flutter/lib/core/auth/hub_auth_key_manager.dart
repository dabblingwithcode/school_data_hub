import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

final _log = Logger('HubAuthKeyManager');

/// Implementation of a Serverpod [AuthenticationKeyManager] specifically for this app
/// because we need to consider the environment on which the app is running
/// and we want our storage implementation [HubSecureStorage] for the authentication key.
class HubAuthKeyManager extends AuthenticationKeyManager {
  // String _storageKey() => '${envName}_${runMode}_hub_auth_key';

  final String storageKeyForAuthKey;
  bool _initialized = false;
  String? _authenticationKey;

  final Storage _storage = HubSecureStorage();

  /// Creates a new authentication key manager. By default it will use
  /// secure storage for storing keys.
  HubAuthKeyManager({
    required this.storageKeyForAuthKey,
  });

  @override
  Future<String?> get() async {
    if (!_initialized) {
      _authenticationKey = await _storage.getString(storageKeyForAuthKey);

      _initialized = true;
      _log.info('Initialized - authKey from storage is: $_authenticationKey');
    }

    return _authenticationKey;
  }

  @override
  Future<void> put(String key) async {
    _authenticationKey = key;

    await _storage.setString(storageKeyForAuthKey, key);
    _log.info('Saved the authKey with storage key: $storageKeyForAuthKey');
  }

  @override
  Future<void> remove() async {
    _authenticationKey = null;
    _log.info('Removing the authKey from storage: $storageKeyForAuthKey');
    await _storage.remove(storageKeyForAuthKey);
  }
}
