import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/core/auth/hub_auth_key_manager.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:watch_it/watch_it.dart';

// TODO: double check the behavior of these keys using different instances
const _storageUserInfoKey = 'hub_userinfo_key';
// const _prefsVersion = 2;

/// The [SessionManager] keeps track of and manages the signed-in state of the
/// user. Use the [instance] method to get access to the singleton instance.
/// Users are typically authenticated with Google, Apple, or other methods.
/// Please refer to the documentation to see supported methods. Session
/// information is stored in the shared preferences of the app and persists
/// between restarts of the app.
/// This [ServerpodSessionManager] is specifically modified for the School Data Hub
/// and uses the [HubAuthKeyManager] for authentication key management.
class ServerpodSessionManager with ChangeNotifier {
  static ServerpodSessionManager? _instance;
  final log = Logger('ServerpodSessionManager');

  /// The auth module's caller.
  Caller caller;

  /// The key manager, holding the keys of the user, if signed in.
  late HubAuthKeyManager keyManager;

  final Storage _storage;

  /// Creates a new session manager.
  ServerpodSessionManager({
    required this.caller,
  }) : _storage = ServerpodSecureStorage() {
    _instance = this;
    assert(caller.client.authenticationKeyManager != null,
        'The client needs an associated key manager');
    keyManager = caller.client.authenticationKeyManager! as HubAuthKeyManager;
  }

  /// Returns a singleton instance of the session manager
  static Future<ServerpodSessionManager> get instance async {
    assert(_instance != null,
        'You need to create a SessionManager before the instance method can be called');
    return _instance!;
  }

  UserInfo? _signedInUser;

  bool get isAdmin =>
      _signedInUser?.scopeNames.contains('serverpod.admin') ?? false;

  /// Returns information about the signed in user or null if no user is
  /// currently signed in.
  UserInfo? get signedInUser => _signedInUser;

  /// Registers the signed in user, updates the [keyManager], and upgrades the
  /// streaming connection if it is open.
  Future<void> registerSignedInUser(
    UserInfo userInfo,
    int authenticationKeyId,
    String authenticationKey,
  ) async {
    _signedInUser = userInfo;
    var key = '$authenticationKeyId:$authenticationKey';

    // Store in key manager.
    await keyManager.put(
      key,
    );
    await _handleAuthCallResultInStorage();

    // Update streaming connection, if it's open.
    await caller.client.updateStreamingConnectionAuthenticationKey(key);
    notifyListeners();
  }

  /// Returns true if the user is currently signed in.
  bool get isSignedIn => signedInUser != null;

  /// Initializes the session manager by reading the current state from
  /// shared preferences. The returned bool is true if the session was
  /// initialized, or false if the server could not be reached.
  Future<bool> initialize() async {
    log.info('Initializing session manager...');
    log.info(' Running in mode: ${keyManager.runMode}');
    await _loadStorage();
    return refreshSession();
  }

  /// Signs the user out from their devices.
  /// If [allDevices] is true, signs out from all devices; otherwise, signs out from the current device only.
  /// Returns true if the sign-out is successful.
  Future<bool> _signOut({
    required bool allDevices,
  }) async {
    if (!isSignedIn) return true;

    try {
      if (allDevices) {
        await caller.status.signOutAllDevices();
      } else {
        await caller.status.signOutDevice();
      }
      await caller.client.updateStreamingConnectionAuthenticationKey(null);

      _signedInUser = null;
      await _handleAuthCallResultInStorage();
      await keyManager.remove();

      notifyListeners();

      /// Don't forget to set the flag in [EnvManager] to false
      /// to get to the login screen.
      log.info('User signed out ');
      di<EnvManager>().setUserAuthenticated(false);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// **[Deprecated]** Signs the user out from all connected devices.
  /// Use `signOutDevice` for the current device or `signOutAllDevices` for all devices.
  /// Returns true if successful.
  @Deprecated(
      'Use signOutDevice for the current device or signOutAllDevices for all devices. This method will be removed in future releases.')
  Future<bool> signOut() async {
    return _signOut(allDevices: true);
  }

  /// Signs the user out from all connected devices.
  /// Returns true if successful.
  Future<bool> signOutAllDevices() async {
    return _signOut(allDevices: true);
  }

  /// Signs the user out from the current device.
  /// Returns true if successful.
  Future<bool> signOutDevice() async {
    return _signOut(allDevices: false);
  }

  /// Verify the current sign in status with the server and update the UserInfo.
  /// Returns true if successful.
  Future<bool> refreshSession() async {
    log.info('Refreshing session...');
    try {
      _signedInUser = await caller.status.getUserInfo();
      await _handleAuthCallResultInStorage();

      notifyListeners();
      if (_signedInUser != null) {
        /// Don't forget to set the flag in [EnvManager] to false
        /// to get to the login screen.
        log.info('User was authenticated by the server');
        di<EnvManager>().setUserAuthenticated(true);
        return false;
      } else {
        log.warning('User was not authenticated by the server');
      }

      return true;
    } catch (e) {
      /// Don't forget to set the flag in [EnvManager] to false
      /// to get to the login screen.
      di<EnvManager>().setUserAuthenticated(false);
      return false;
    }
  }

  Future<void> _loadStorage() async {
    var json = await _storage.getString(
        '${keyManager.envName}_${keyManager.runMode}_$_storageUserInfoKey');

    if (json == null) {
      log.warning('No user info found in storage');
      return;
    }

    _signedInUser = Protocol().deserialize<UserInfo>(jsonDecode(json));

    notifyListeners();
  }

  Future<void> _handleAuthCallResultInStorage() async {
    if (signedInUser == null) {
      log.warning('No signed user found');

      await keyManager.remove();
    } else {
      log.info('We have a signed user - Saving userinfo to storage');

      await _storage.setString(
          '${keyManager.envName}_${keyManager.runMode}_$_storageUserInfoKey',
          SerializationManager.encode(signedInUser));
    }
  }

  /// Uploads a new user image if the user is signed in. Returns true if upload
  /// was successful.
  Future<bool> uploadUserImage(ByteData image) async {
    if (_signedInUser == null) return false;

    try {
      var success = await caller.user.setUserImage(image);
      if (success) {
        _signedInUser = await caller.status.getUserInfo();

        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
