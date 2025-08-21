import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<User?> getCurrentUser(Session session) async {
    // Get the authenticated user's ID
    var userId = (await session.authenticated)?.userId;
    if (userId == null) {
      return null;
    }

    // Find the UserInfo
    var userInfo = await Users.findUserByUserId(session, userId);
    if (userInfo == null) {
      return null;
    }

    // Find your custom User object that references this UserInfo
    return await User.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(userInfo.id),
      include: User.include(
        userInfo: UserInfo.include(),
      ),
    );
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

  Future<bool> increaseStaffCredit(Session session) async {
    // TODO: this code is duplicated in the future call
    // and still does not have any checks!
    final List<User> allStaff = await User.db.find(session);
    for (var staff in allStaff) {
      final amount = staff.timeUnits + 2;

      staff.credit += amount;

      final CreditTransaction transaction = CreditTransaction(
          sender: 'Admin',
          receiver: staff.userInfoId,
          amount: amount,
          dateTime: DateTime.now());

      await session.db.updateRow(staff);

      await CreditTransaction.db.insertRow(session, transaction);
    }
    return true;
  }
}
