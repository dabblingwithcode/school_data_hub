import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

/// Debug endpoint to check user scopes (no admin required)
class DebugEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // No required scopes - anyone logged in can access this

  Future<Map<String, dynamic>> debugUserScopes(Session session) async {
    final authenticatedUser = await session.authenticated;
    return {
      'userId': authenticatedUser?.userId,
      'scopes': authenticatedUser?.scopes.map((s) => s.toString()).toList(),
      'hasAdminScope':
          authenticatedUser?.scopes.contains(Scope('serverpod.admin')),
      'allScopes': authenticatedUser?.scopes.toList(),
    };
  }

  // Temporary endpoint to fix user scope
  Future<bool> fixUserScope(Session session) async {
    final authenticatedUser = await session.authenticated;
    if (authenticatedUser?.userId != null) {
      await auth.Users.updateUserScopes(
          session, authenticatedUser!.userId!, {Scope('serverpod.admin')});
      return true;
    }
    return false;
  }

  // Force logout all sessions for the current user
  Future<bool> forceLogoutAllSessions(Session session) async {
    final authenticatedUser = await session.authenticated;
    if (authenticatedUser?.userId != null) {
      // Delete all auth keys for this user
      await auth.AuthKey.db.deleteWhere(
        session,
        where: (t) => t.userId.equals(authenticatedUser!.userId!),
      );
      return true;
    }
    return false;
  }
}
