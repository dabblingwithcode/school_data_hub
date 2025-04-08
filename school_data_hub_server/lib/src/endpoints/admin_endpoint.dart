import 'package:school_data_hub_server/src/generated/protocol.dart';
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

  Future<StaffUser> createUser(
    Session session, {
    required String userName,
    required String fullName,
    required String email,
    required String password,
    required Role role,
    required int timeUnits,
    required List<String> scopeNames,
  }) async {
    session.log('Creating user: $userName, $email, $password');
    final UserInfo? userInfo =
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

    // Create a new StaffUser object and insert it into the database
    final newStaffUser = StaffUser(
      userInfoId: userInfo.id!,
      userFlags: UserFlags(
        confirmedTermsOfUse: false,
        confirmedPrivacyPolicy: false,
        changedPassword: false,
        madeFirstSteps: false,
      ),
      pupilsAuth: {},
      role: role,
      timeUnits: timeUnits,
      credit: 50,
    );

    await StaffUser.db.insertRow(session, newStaffUser);

    return newStaffUser;
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

  Future<List<StaffUser>> getAllUsers(Session session) async {
    final users = await StaffUser.db.find(
      session,
      include: StaffUser.include(
        userInfo: UserInfo.include(),
      ),
    );
    return users;
  }

  Future<StaffUser?> getUserById(Session session, int userId) async {
    final user = await StaffUser.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(userId),
    );
    return user;
  }
}
