import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

/// The endpoint for admin operations.
/// This endpoint requires the user to be logged in and have admin scope.
class AdminEndpoint extends Endpoint {
  // TODO: Uncomment this in production!
  // @override
  // bool get requireLogin => true;

  // @override
  // Set<Scope> get requiredScopes => {Scope.admin};

  Future<void> createUser(Session session,
      {required String userName,
      required String fullName,
      required String email,
      required String password,
      required List<String> scopeNames}) async {
    session.log('Creating user: $userName, $email, $password');
    final userInfo =
        await auth.Emails.createUser(session, userName, email, password);

    if (userInfo?.id == null) {
      throw 'Failed to create user';
    }
    // We need to do some updates to the user info object

    userInfo!.fullName = fullName;
    await auth.UserInfo.db.updateRow(session, userInfo);

    // Update scopes if provided

    // Convert string scopes to Scope objects
    final scopes = scopeNames.map((name) => Scope(name)).toSet();

    // Update user scopes
    await auth.Users.updateUserScopes(session, userInfo.id!, scopes);
  }

  Future<UserInfo?> createTestUser(Session session) async {
    // Create user
    final emailAddr = 'testmail';
    final password = 'test';

    final userInfo =
        await auth.Emails.createUser(session, 'Test user', emailAddr, password);

    if (userInfo?.id == null) {
      throw 'Failed to create test user';
    }

    // Try logging in as user
    await auth.UserAuthentication.signInUser(session, userInfo!.id!, 'server');
    assert(await session.authenticated != null);

    return userInfo;
  }

  Future<void> deleteUser(Session session, int userId) async {
    // Find the user by ID
    final user = await auth.Users.findUserByUserId(session, userId);
    if (user == null) {
      throw Exception('User not found.');
    }

    // TODO; for now no easy way to delete user from all tables, so just set blocked to true
    // await session.db.deleteRow(user);
    user.blocked = true;
  }

  Future<void> promoteUserScope(
      Session session, int userId, String scopeName) async {
    // Find the user by ID
    final user = await auth.Users.findUserByUserId(session, userId);
    if (user == null) {
      throw Exception('User not found.');
    }
    final Set<Scope> userscopes = {
      ...user.scopeNames.map((scope) => Scope(scope)).toSet(),
      Scope(scopeName)
    };
    // Add the scope to the user
    await auth.Users.updateUserScopes(session, user.id!, userscopes);
  }

  Future<void> demoteUserScope(
      Session session, int userId, String scopeName) async {
    // Find the user by ID
    final user = await auth.Users.findUserByUserId(session, userId);
    if (user == null) {
      throw Exception('User not found.');
    }
    final List<String> scopesWithoutDemotedScope =
        user.scopeNames.where((scope) => scope != scopeName).toList();
    final Set<Scope> userscopes = {
      ...scopesWithoutDemotedScope.map((scope) => Scope(scope)).toSet(),
      Scope(scopeName)
    };
    // Remove the scope from the user
    await auth.Users.updateUserScopes(session, user.id!, userscopes);
  }
}
