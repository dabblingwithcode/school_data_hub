import 'dart:developer';

import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

class AuthEndpoint extends Endpoint {
  Future<
      ({
        AuthenticationResponse response,
        UserDevice? userDevice,
      })> login(
    Session session,
    String email,
    String password,
    DeviceInfo deviceInfo,
  ) async {
    // Find the user by email
    UserInfo? userInfo = await Users.findUserByEmail(session, email);

    // If user doesn't exist or is blocked, authentication fails
    if (userInfo == null) {
      return (
        response: AuthenticationResponse(
            success: false,
            failReason: AuthenticationFailReason.invalidCredentials),
        userDevice: null
      );
    }
    if (userInfo.blocked) {
      return (
        response: AuthenticationResponse(
            success: false, failReason: AuthenticationFailReason.blocked),
        userDevice: null
      );
    }

    // Check if the password is correct

    final AuthenticationResponse authResponse =
        await Emails.authenticate(session, email, password);

    // Create an authentication token for the user
    if (authResponse.success) {
      final userDevice = UserDevice(
        authId: authResponse.keyId!,
        userInfoId: userInfo.id!,
        deviceId: deviceInfo.deviceId,
        deviceName: deviceInfo.deviceName,
        lastLogin: DateTime.now().toUtc(),
        isActive: true,
      );
      await storeUserDevice(
          session: session,
          userInfoId: userInfo.id!,
          authId: authResponse.keyId!,
          user: userDevice);
      return (response: authResponse, userDevice: userDevice);
    } else {
      return (
        response: AuthenticationResponse(
            success: false,
            failReason: AuthenticationFailReason.invalidCredentials),
        userDevice: null
      );
    }

    // Return the authentication response
  }

  Future<void> storeUserDevice({
    required Session session,
    required int userInfoId,
    required int authId,
    required UserDevice user,
  }) async {
    // Find existing device
    var existingDevice = await UserDevice.db.findFirstRow(
      session,
      where: (t) =>
          t.userInfoId.equals(userInfoId) & t.deviceId.equals(user.deviceId),
    );

    if (existingDevice != null) {
      // Update existing device with new auth key
      existingDevice.lastLogin = DateTime.now().toUtc();
      existingDevice.isActive = true;
      existingDevice.authId = authId;
      await UserDevice.db.updateRow(session, existingDevice);
    } else {
      // Create new device entry
      var userDevice = UserDevice(
        userInfoId: userInfoId,
        deviceId: user.deviceId,
        deviceName: user.deviceName,
        lastLogin: DateTime.now().toUtc(),
        isActive: true,
        authId: authId,
      );
      final newDeviceInDatabase =
          await UserDevice.db.insertRow(session, userDevice);
      log('New device created: ${newDeviceInDatabase.deviceId}');
      log('User ID: ${newDeviceInDatabase.userInfoId}');
    }
  }

// Your custom password verification method
  Future<bool> verifyPassword(
      Session session, int userId, String password) async {
    // TODO: Implement this
    // Implement your password verification logic here
    // For example, retrieve the stored password hash and compare it
    // with the hash of the provided password

    // This is just a placeholder - you would need to implement
    // the actual password verification logic
    return true; // Replace with actual verification
  }

  Future<bool> logOut(Session session, String keyId) async {
    await UserAuthentication.signOutUser(session);
    return true;
  }
}

// Response class
class LoginResponse {
  final bool success;
  final String? token;
  final int? userId;
  final String? message;

  LoginResponse({
    this.success = false,
    this.token,
    this.userId,
    this.message,
  });

  Map<String, dynamic> toJson() => {
        'success': success,
        'token': token,
        'userId': userId,
        'message': message,
      };
}
