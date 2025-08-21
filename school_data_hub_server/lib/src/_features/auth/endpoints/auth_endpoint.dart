import 'package:school_data_hub_server/src/_features/auth/helpers/store_user_device.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

class AuthEndpoint extends Endpoint {
  Future<({AuthenticationResponse response, UserDevice? userDevice})> login(
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

  Future<bool> logOut(Session session, String keyId) async {
    await UserAuthentication.signOutUser(session);
    return true;
  }
}
