import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

Future<String?> getUserName(Session session) async {
  // Get the authenticated user's ID
  final authenticationInfo = await session.authenticated;
  if (authenticationInfo == null) {
    // User is not authenticated
    return null;
  }

  final userId = authenticationInfo.userId;

  // Retrieve the user information from the database
  var userInfo = await Users.findUserByUserId(session, userId);

  if (userInfo == null) {
    return null;
  }

  // Return the user's name
  return userInfo.userName;
}
