import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

/// The endpoint for admin operations.
/// This endpoint requires the user to be logged in and have admin scope.
class AdminUserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {Scope('serverpod.admin')};

  Future<User> createUser(
    Session session, {
    required String userName,
    required String fullName,
    required String email,
    required String password,
    required Role role,
    required int timeUnits,
    required int reliefTimeUnits,
    required List<String> scopeNames,
    required bool isTester,
    String? schooldayEventsProcessingTeam,
    String? matrixUserId,
    int? credit,
  }) async {
    session.log('Creating user: $userName, $email');
    final UserInfo? userInfo =
        await auth.Emails.createUser(session, userName, email, password);

    if (userInfo?.id == null) {
      throw 'Failed to create user';
    }
    // We need to do some updates to the user info object

    userInfo!.fullName = fullName;

    await auth.UserInfo.db.updateRow(session, userInfo);

    // Convert string scopes to Scope objects
    Set<Scope> scopes = {};

    for (final scope in scopeNames) {
      if (scope == 'admin') {
        scopes.add(Scope('serverpod.admin'));
      } else {
        scopes.add(Scope(scope));
      }
    }
    // Update scopes if provided
    await auth.Users.updateUserScopes(session, userInfo.id!, scopes);
    // Create a new User object and insert it into the database
    final newUser = User(
      userInfoId: userInfo.id!,
      userFlags: UserFlags(
        isTester: isTester,
        confirmedTermsOfUse: false,
        confirmedPrivacyPolicy: false,
        changedPassword: false,
        madeFirstSteps: false,
      ),
      pupilsAuth: {},
      role: role,
      timeUnits: timeUnits,
      reliefTimeUnits: reliefTimeUnits,
      credit: credit ?? 50,
      matrixUserId: matrixUserId,
    );

    await User.db.insertRow(session, newUser);

    return newUser;
  }

  Future<bool> resetPassword(
      Session session, String userEmail, String newPassword) async {
    final emailAuth = await EmailAuth.db.findFirstRow(
      session,
      where: (t) => t.email.equals(userEmail),
    );
    if (emailAuth == null) throw Exception('EmailAuth not found');
    emailAuth.hash = await auth.Emails.generatePasswordHash(newPassword);
    await auth.EmailAuth.db.updateRow(session, emailAuth);
    final user = await User.db.findFirstRow(session,
        where: (t) => t.userInfoId.equals(emailAuth.userId));
    if (user == null) throw Exception('User not found');
    user.userFlags = user.userFlags.copyWith(changedPassword: true);
    await User.db.updateRow(session, user);
    return true;
  }

  Future<User?> updateUserInfo(
      {required Session session,
      String? userName,
      String? fullName,
      String? email}) async {
    // Get the authenticated user
    final authenticationInfo = await session.authenticated;
    if (authenticationInfo == null) {
      return null; // User is not authenticated
    }
    // Find the user's UserInfo
    var userInfo = await UserInfo.db.findFirstRow(session,
        where: (t) => t.id.equals(authenticationInfo.userId));
    if (userInfo == null) {
      return null; // UserInfo not found
    }
    // Update the UserInfo fields
    if (userName != null) {
      userInfo.userName = userName;
    }
    if (fullName != null) {
      userInfo.fullName = fullName;
    }
    if (email != null) {
      userInfo.email = email;
    }
    // Save the updated UserInfo
    await UserInfo.db.updateRow(session, userInfo);
    // Optionally, update the User object if needed
    var user = await User.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(userInfo.id),
    );
    return user;
  }

  Future<UserDevice?> updateUserDevice({
    required Session session,
    String? deviceName,
  }) async {
    // Get the authenticated user
    final authenticationInfo = await session.authenticated;
    if (authenticationInfo == null) {
      return null; // User is not authenticated
    }

    // Find the user's device
    var userDevice = await UserDevice.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(authenticationInfo.userId),
    );
    if (userDevice == null) {
      return null; // UserDevice not found
    }

    // Update the UserDevice fields
    if (deviceName != null) {
      userDevice.deviceName = deviceName;
    }

    // Save the updated UserDevice
    await UserDevice.db.updateRow(session, userDevice);
    return userDevice;
  }

  Future<void> deleteUser(Session session, int userId) async {
    // Find the user by ID
    final user = await auth.Users.findUserByUserId(session, userId);
    if (user == null) {
      throw Exception('User not found.');
    }

    // TODO; for now no flow to delete user from all tables, so just set blocked to true
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

  Future<User?> getUserById(Session session, int userId) async {
    final user = await User.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(userId),
    );
    return user;
  }
}
