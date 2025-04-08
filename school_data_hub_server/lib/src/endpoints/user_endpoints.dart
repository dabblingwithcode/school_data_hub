import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<bool> changePassword(
      Session session, String oldPassword, String newPassword) async {
    // Get the authenticated user
    final authenticationInfo = await session.authenticated;
    if (authenticationInfo == null) {
      return false; // User is not authenticated
    }

    // Find the user's email auth entry
    var emailAuth = await EmailAuth.db.findFirstRow(session, where: (t) {
      return t.userId.equals(authenticationInfo.userId);
    });

    if (emailAuth == null) {
      return false; // User doesn't have email authentication
    }

    // Generate hash for the old password and compare with stored hash
    String oldPasswordHash = await Emails.generatePasswordHash(oldPassword);
    bool isValid = (oldPasswordHash == emailAuth.hash);

    if (!isValid) {
      return false; // Old password is incorrect
    }

    // Generate hash for the new password
    emailAuth.hash = await Emails.generatePasswordHash(newPassword);

    // Update the password in the database
    await EmailAuth.db.updateRow(session, emailAuth);

    return true;
  }
}
