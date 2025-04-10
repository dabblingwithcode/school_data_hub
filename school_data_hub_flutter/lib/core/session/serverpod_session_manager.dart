import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/core/auth/hub_auth_key_manager.dart';
import 'package:school_data_hub_flutter/core/dependency_injection.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart'
    as auth_client;
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('ServerpodSessionManager');
final _envManager = di<EnvManager>();

/// The [SessionManager] keeps track of and manages the signed-in state of the
/// user. Use the [instance] method to get access to the singleton instance.
/// This [ServerpodSessionManager] is specifically modified for the School Data Hub
/// and uses the [HubAuthKeyManager] for authentication key management.
class ServerpodSessionManager with ChangeNotifier {
  static ServerpodSessionManager? _instance;

  String get _userInfoStorageKey => _envManager.storageKeyForUserInfo;
  bool _matrixPolicyManagerRegistrationStatus = false;
  bool get matrixPolicyManagerRegistrationStatus =>
      _matrixPolicyManagerRegistrationStatus;

  /// The auth module's caller.
  auth_client.Caller caller;

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

  auth_client.UserInfo? _signedInUser;

  StaffUser? _staffUser;

  bool get isAdmin =>
      _signedInUser?.scopeNames.contains('serverpod.admin') ?? false;

  /// Returns information about the signed in user or null if no user is
  /// currently signed in.
  auth_client.UserInfo? get signedInUser => _signedInUser;

  /// Registers the signed in user, updates the [keyManager], and upgrades the
  /// streaming connection if it is open.
  Future<void> registerSignedInUser(
    auth_client.UserInfo userInfo,
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
    _log.info('Initializing session manager...');
    _log.info(' Running in mode: ${_envManager.activeEnv!.runMode.name}');
    await _loadUserInfoFromStorage();
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
      _log.info('User signed out ');
      _envManager.setUserAuthenticated(false);
      return true;
    } catch (e) {
      return false;
    }
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
    _log.info('Refreshing session...');

    try {
      _signedInUser = await caller.status.getUserInfo();
      await _handleAuthCallResultInStorage();

      notifyListeners();
      if (_signedInUser != null) {
        /// Don't forget to set the flag in [EnvManager] to false
        /// to get to the login screen.
        _log.info('User was authenticated by the server');
        _envManager.setUserAuthenticated(true);

        unawaited(DiManager.registerManagersDependingOnSession());
        return false;
      } else {
        _log.warning('User was not authenticated by the server');
      }

      return true;
    } catch (e) {
      // Something wentwrong with the getUserInfo call
      // so we don't have a signed user.
      // we better delete the user info from storage and remove the key.
      _log.warning('User was not authenticated by the server: $e');
      await keyManager.remove();
      _signedInUser = null;
      await _handleAuthCallResultInStorage();

      /// Don't forget to set the flag in [EnvManager] to false
      /// to get to the login screen.
      _envManager.setUserAuthenticated(false);
      return false;
    }
  }

  Future<void> _loadUserInfoFromStorage() async {
    var json = await _storage.getString(_userInfoStorageKey);

    if (json == null) {
      _log.warning('No user info found in storage');
      return;
    }

    _signedInUser =
        Protocol().deserialize<auth_client.UserInfo>(jsonDecode(json));

    notifyListeners();
  }

  Future<void> _handleAuthCallResultInStorage() async {
    if (signedInUser == null) {
      _log.warning('No signed user found');

      await keyManager.remove();
    } else {
      _log.info(
          'We have a signed user - Saving userinfo to storage with key: $_userInfoStorageKey');
      _log.fine('User info: ${signedInUser!.toJson()}');

      await _storage.setString(
          _userInfoStorageKey, SerializationManager.encode(signedInUser));
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

  void changeMatrixPolicyManagerRegistrationStatus(bool isRegistered) {
    if (_matrixPolicyManagerRegistrationStatus != isRegistered) {
      _matrixPolicyManagerRegistrationStatus = isRegistered;
      notifyListeners();
      _log.info(
          'MatrixPolicyManager registration status changed to $isRegistered');
    }
  }
}
