import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

class AuthEndpoint extends Endpoint {
  Future<AuthenticationResponse> login(
    Session session,
    String email,
    String password,
  ) async {
    // Find the user by email
    UserInfo? userInfo = await Users.findUserByEmail(session, email);

    // If user doesn't exist or is blocked, authentication fails
    if (userInfo == null) {
      return AuthenticationResponse(
          success: false,
          failReason: AuthenticationFailReason.invalidCredentials);
    }
    if (userInfo.blocked) {
      return AuthenticationResponse(
          success: false, failReason: AuthenticationFailReason.blocked);
    }

    // Check if the password is correct
    // This would be your custom password verification logic
    bool passwordCorrect =
        await verifyPassword(session, userInfo.id!, password);
    if (!passwordCorrect) {
      return AuthenticationResponse(
          success: false,
          failReason: AuthenticationFailReason.invalidCredentials);
    }

    // Create an authentication token for the user
    var authKey = await UserAuthentication.signInUser(
      session,
      userInfo.id!,
      'myAuth',
      scopes: userInfo.scopes,
    );

    // Return the authentication response
    return AuthenticationResponse(
      success: true,
      keyId: authKey.id,
      key: authKey.key,
      userInfo: userInfo,
    );
  }

// Your custom password verification method
  Future<bool> verifyPassword(
      Session session, int userId, String password) async {
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
