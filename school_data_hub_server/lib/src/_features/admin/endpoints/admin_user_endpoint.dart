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
    Set<int>? pupilsAuth,
  }) async {
    session.log('Creating user: $userName, $email');
    return _createOneUser(
      session,
      userName: userName,
      fullName: fullName,
      email: email,
      password: password,
      role: role,
      timeUnits: timeUnits,
      reliefTimeUnits: reliefTimeUnits,
      scopeNames: scopeNames,
      isTester: isTester,
      matrixUserId: matrixUserId,
      credit: credit,
      pupilsAuth: pupilsAuth,
    );
  }

  /// Creates a single user (auth + UserInfo + scopes + User).
  ///
  /// Note: `auth.Emails.createUser()` auto-commits (creates UserInfo + EmailAuth
  /// on its own DB connection). `auth.Users.updateUserScopes()` doesn't accept a
  /// transaction parameter. Therefore all writes are sequential direct calls —
  /// wrapping in a transaction provides no atomicity benefit.
  Future<User> _createOneUser(
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
    String? matrixUserId,
    int? credit,
    Set<int>? pupilsAuth,
  }) async {
    // Declared outside try so the catch can reference it for cleanup.
    UserInfo? userInfo;
    try {
      userInfo = await auth.Emails.createUser(session, userName, email, password);

      if (userInfo?.id == null) {
        throw Exception('Failed to create user');
      }

      // Update fullName (direct, no transaction)
      userInfo!.fullName = fullName;
      await auth.UserInfo.db.updateRow(session, userInfo);

      // Set scopes (direct — updateUserScopes doesn't accept transaction)
      Set<Scope> scopes = {};
      for (final scope in scopeNames) {
        if (scope == 'admin') {
          scopes.add(Scope('serverpod.admin'));
        } else {
          scopes.add(Scope(scope));
        }
      }
      await auth.Users.updateUserScopes(session, userInfo.id!, scopes);

      // Create User record (direct)
      final user = User(
        userInfoId: userInfo.id!,
        userFlags: UserFlags(
          isTester: isTester,
          confirmedTermsOfUse: false,
          confirmedPrivacyPolicy: false,
          changedPassword: false,
          madeFirstSteps: false,
        ),
        pupilsAuth: pupilsAuth ?? {},
        role: role,
        timeUnits: timeUnits,
        reliefTimeUnits: reliefTimeUnits,
        credit: credit ?? 50,
        matrixUserId: matrixUserId,
      );

      await User.db.insertRow(session, user);
      return user;
    } catch (e) {
      if (userInfo?.id != null) {
        // Exception happened after auth.Emails.createUser returned — delete the
        // UserInfo it committed.
        try {
          await auth.UserInfo.db.deleteRow(session, userInfo!);
        } catch (cleanupError) {
          session.log(
            '[_createOneUser] Failed to clean up orphaned auth for '
            '${userInfo!.id}: $cleanupError',
            level: LogLevel.warning,
          );
        }
      } else if (e.toString().contains('serverpod_email_auth')) {
        // auth.Emails.createUser inserted UserInfo then threw on the EmailAuth
        // insert (e.g. duplicate email). The new UserInfo is orphaned — find it
        // by userName and remove it.
        try {
          final orphan = await auth.UserInfo.db.findFirstRow(
            session,
            where: (t) => t.userName.equals(userName),
          );
          if (orphan != null) {
            await auth.UserInfo.db.deleteRow(session, orphan);
          }
        } catch (cleanupError) {
          session.log(
            '[_createOneUser] Failed to clean up orphaned UserInfo for '
            '$userName: $cleanupError',
            level: LogLevel.warning,
          );
        }
      }
      rethrow;
    }
  }

  /// Returns a user-friendly message for create failures.
  String _messageForCreateError(Object e) {
    final msg = e.toString();
    if (e is DatabaseQueryException) {
      if (e.code == '23505') return 'E-Mail bzw. Anmeldename bereits vergeben.';
      if (e.code == '57014' || msg.contains('57014') || msg.contains('canceling statement')) {
        return 'Verbindung unterbrochen. Bitte erneut versuchen.';
      }
      if (msg.contains('23505') ||
          msg.contains('unique constraint') ||
          msg.contains('serverpod_user_info_user_identifier')) {
        return 'E-Mail bzw. Anmeldename bereits vergeben.';
      }
    }
    return msg.isEmpty ? 'Unbekannter Fehler' : msg;
  }

  /// Batch-creates users sequentially. Returns credentials for successes and errors for skipped/failed rows.
  /// Duplicates are detected by the DB (unique constraint); we catch 23505 and report a friendly message.
  Future<BatchCreateUsersResponse> batchCreateUsers(
    Session session,
    List<CreateUserRequest> requests,
  ) async {
    final credentials = <CreatedUserCredential>[];
    final errors = <BatchCreateUserError>[];

    for (var i = 0; i < requests.length; i++) {
      final req = requests[i];
      final rowIndex = i + 1;
      final userName = req.userName.trim();
      if (userName.isEmpty) {
        errors.add(BatchCreateUserError(
          rowIndex: rowIndex,
          userNameOrKurzel: req.fullName,
          message: 'Kürzel ist leer.',
        ));
        continue;
      }
      try {
        await _createOneUser(
          session,
          userName: userName,
          fullName: req.fullName,
          email: req.email,
          password: req.password,
          role: req.role,
          timeUnits: req.timeUnits,
          reliefTimeUnits: req.reliefTimeUnits,
          scopeNames: req.scopeNames,
          isTester: req.isTester,
          matrixUserId: req.matrixUserId,
          credit: req.credit,
          pupilsAuth: req.pupilsAuth,
        );
        credentials.add(CreatedUserCredential(
          userName: userName,
          fullName: req.fullName,
          email: req.email,
          password: req.password,
        ));
      } catch (e) {
        session.log('batchCreateUsers failed for $userName: $e');
        errors.add(BatchCreateUserError(
          rowIndex: rowIndex,
          userNameOrKurzel: userName,
          message: _messageForCreateError(e),
        ));
      }
    }

    return BatchCreateUsersResponse(
      credentials: credentials,
      errors: errors,
    );
  }

  /// Streams batch create results one-by-one to avoid HTTP timeout. Duplicates are detected by the DB; we catch 23505 and yield a friendly error event.
  Stream<BatchCreateUserEvent> batchCreateUsersStream(
    Session session,
    List<CreateUserRequest> requests,
  ) async* {
    session.log(
        level: LogLevel.info,
        '[batchCreateUsersStream] start requests=${requests.length}');
    try {
      for (var i = 0; i < requests.length; i++) {
        final req = requests[i];
        final rowIndex = i + 1;
        final userName = req.userName.trim();
        if (userName.isEmpty) {
          yield BatchCreateUserEvent(
            credential: null,
            error: BatchCreateUserError(
              rowIndex: rowIndex,
              userNameOrKurzel: req.fullName,
              message: 'Kürzel ist leer.',
            ),
          );
          continue;
        }
        try {
          await _createOneUser(
            session,
            userName: userName,
            fullName: req.fullName,
            email: req.email,
            password: req.password,
            role: req.role,
            timeUnits: req.timeUnits,
            reliefTimeUnits: req.reliefTimeUnits,
            scopeNames: req.scopeNames,
            isTester: req.isTester,
            matrixUserId: req.matrixUserId,
            credit: req.credit,
            pupilsAuth: req.pupilsAuth,
          );
          yield BatchCreateUserEvent(
            credential: CreatedUserCredential(
              userName: userName,
              fullName: req.fullName,
              email: req.email,
              password: req.password,
            ),
            error: null,
          );
        } catch (e) {
          session.log('batchCreateUsersStream failed for $userName: $e');
          yield BatchCreateUserEvent(
            credential: null,
            error: BatchCreateUserError(
              rowIndex: rowIndex,
              userNameOrKurzel: userName,
              message: _messageForCreateError(e),
            ),
          );
        }
      }
      session.log(level: LogLevel.info, '[batchCreateUsersStream] done');
    } catch (e, st) {
      session.log(
        level: LogLevel.error,
        '[batchCreateUsersStream] uncaught error',
        exception: e,
        stackTrace: st,
      );
      session.log('batchCreateUsersStream uncaught: $e');
      yield BatchCreateUserEvent(
        credential: null,
        error: BatchCreateUserError(
          rowIndex: 0,
          userNameOrKurzel: '',
          message: _messageForCreateError(e),
        ),
      );
    }
  }

  /// Updates both User and UserInfo in one go. [userId] is the UserInfo id.
  Future<User> updateUser(
    Session session,
    int userId, {
    required String userName,
    required String fullName,
    required String email,
    required Role role,
    String? matrixUserId,
    required int timeUnits,
    required int reliefTimeUnits,
    required int credit,
    required bool isTester,
    Set<int>? pupilsAuth,
  }) async {
    final user = await User.db
        .findFirstRow(session, where: (t) => t.userInfoId.equals(userId));
    if (user == null) throw Exception('User not found');
    final userInfo = await UserInfo.db
        .findFirstRow(session, where: (t) => t.id.equals(userId));
    if (userInfo == null) throw Exception('UserInfo not found');

    return await session.db.transaction((transaction) async {
      userInfo.userName = userName;
      userInfo.fullName = fullName;
      userInfo.email = email;
      await UserInfo.db.updateRow(session, userInfo, transaction: transaction);

      user.role = role;
      user.matrixUserId = matrixUserId;
      user.timeUnits = timeUnits;
      user.reliefTimeUnits = reliefTimeUnits;
      user.credit = credit;
      user.userFlags = user.userFlags.copyWith(isTester: isTester);
      if (pupilsAuth != null) {
        user.pupilsAuth = pupilsAuth;
      }
      await User.db.updateRow(session, user, transaction: transaction);
      return user;
    });
  }

  Future<bool> resetPassword(
      Session session, String userEmail, String newPassword) async {
    final emailAuth = await EmailAuth.db.findFirstRow(
      session,
      where: (t) => t.email.equals(userEmail),
    );
    if (emailAuth == null) throw Exception('EmailAuth not found');
    emailAuth.hash = await auth.Emails.generatePasswordHash(newPassword);

    final user = await User.db.findFirstRow(session,
        where: (t) => t.userInfoId.equals(emailAuth.userId));
    if (user == null) throw Exception('User not found');

    await session.db.transaction((transaction) async {
      await auth.EmailAuth.db
          .updateRow(session, emailAuth, transaction: transaction);
      user.userFlags = user.userFlags.copyWith(changedPassword: true);
      await User.db.updateRow(session, user, transaction: transaction);
    });

    return true;
  }

  Future<UserWithDevices?> deleteAuthKeyAssociatedWithDevice(
      Session session, UserDevice device) async {
    final authenticationInfo = await session.authenticated;
    if (authenticationInfo == null) {
      return null; // User is not authenticated
    }

    final authKey = await auth.AuthKey.db
        .findFirstRow(session, where: (t) => t.id.equals(device.authId));
    if (authKey == null) throw Exception('AuthKey not found');
    await auth.AuthKey.db.deleteRow(session, authKey);
    final user = await User.db.findFirstRow(session,
        where: (t) => t.userInfoId.equals(authenticationInfo.userId));
    if (user == null) throw Exception('User not found');
    final userDevices = await UserDevice.db.find(session,
        where: (t) => t.userInfoId.equals(authenticationInfo.userId));
    return UserWithDevices(user: user, userDevices: userDevices);
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
    final user = await auth.Users.findUserByUserId(session, userId);
    if (user == null) {
      throw Exception('User not found.');
    }

    await session.db.transaction((transaction) async {
      // 1. UserDevice (FK to serverpod_auth_key and serverpod_user_info)
      await UserDevice.db.deleteWhere(
        session,
        where: (t) => t.userInfoId.equals(userId),
        transaction: transaction,
      );

      // 2. AuthKey (referenced by user_device, now cleared)
      await auth.AuthKey.db.deleteWhere(
        session,
        where: (t) => t.userId.equals(userId),
        transaction: transaction,
      );

      // 3. EmailAuth
      await auth.EmailAuth.db.deleteWhere(
        session,
        where: (t) => t.userId.equals(userId),
        transaction: transaction,
      );

      // 4. User (FK to serverpod_user_info with ON DELETE CASCADE,
      //    but delete explicitly to be safe)
      await User.db.deleteWhere(
        session,
        where: (t) => t.userInfoId.equals(userId),
        transaction: transaction,
      );

      // 5. serverpod_user_image (no exported Dart class, images are disabled
      //    but clean up any stale rows)
      await session.db.unsafeExecute(
        'DELETE FROM serverpod_user_image WHERE "userId" = $userId',
        transaction: transaction,
      );

      // 6. UserInfo (last, since others reference it)
      await auth.UserInfo.db.deleteWhere(
        session,
        where: (t) => t.id.equals(userId),
        transaction: transaction,
      );
    });
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

  /// Sets the pupilsAuth value for the authenticated user.
  /// [pupilIds] is a set of pupil IDs that the user is authorized to access.
  Future<User?> setUserPupilsAuth(Session session, Set<int> pupilIds) async {
    // Get the authenticated user
    final authenticationInfo = await session.authenticated;
    if (authenticationInfo == null) {
      return null; // User is not authenticated
    }

    // Find the user
    var user = await User.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(authenticationInfo.userId),
    );
    if (user == null) {
      return null; // User not found
    }

    // Update the pupilsAuth field
    user.pupilsAuth = pupilIds;

    // Save the updated User
    await User.db.updateRow(session, user);
    return user;
  }
}
