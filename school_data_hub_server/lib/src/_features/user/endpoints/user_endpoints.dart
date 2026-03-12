import 'package:school_data_hub_server/src/_features/user/helpers/get_user_devices.dart';
import 'package:school_data_hub_server/src/_features/user/helpers/increase_staff_credit.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<User?> getCurrentUser(Session session) async {
    // Get the authenticated user's ID
    final authenticatedUder = await session.authenticated;
    var userId = authenticatedUder?.userId;
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

  Future<List<User>> getAllUsers(Session session) async {
    final users = await User.db.find(
      session,
      include: User.include(
        userInfo: UserInfo.include(),
      ),
    );
    return users;
  }

  Future<List<UserWithDevices>> getAllUsersWithDevices(Session session) async {
    final users = await User.db.find(
      session,
      include: User.include(
        userInfo: UserInfo.include(),
      ),
    );
    final userInfoIds = users.map((u) => u.userInfoId).toList();
    final devicesByUserInfoId =
        await getUserDevicesByUserInfoIds(session, userInfoIds);
    return users
        .map(
          (user) => UserWithDevices(
            user: user,
            userDevices: devicesByUserInfoId[user.userInfoId] ?? [],
          ),
        )
        .toList();
  }

  Future<bool> changePassword(
      Session session, String oldPassword, String newPassword) async {
    // Get the authenticated user
    final authenticationInfo = await session.authenticated;
    if (authenticationInfo == null) {
      session.log('User is not authenticated', level: LogLevel.error);
      return false; // User is not authenticated
    }
    final result = await Emails.changePassword(
        session, authenticationInfo.userId, oldPassword, newPassword);

    return result;
  }

  Future<bool> increaseStaffCredit(Session session) async {
    await increaseAllStaffCredit(session);
    return true;
  }
}
