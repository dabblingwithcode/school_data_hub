import 'package:logging/logging.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/_features/user/helpers/get_user_devices.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

class UserEndpoint extends Endpoint {
  final _log = Logger('UserEndpoint');
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
    _log.info('oldPassword: $oldPassword');
    _log.info('newPassword: $newPassword');
    // Get the authenticated user
    final authenticationInfo = await session.authenticated;
    if (authenticationInfo == null) {
      _log.severe('User is not authenticated');
      return false; // User is not authenticated
    }
    final result = await Emails.changePassword(
        session, authenticationInfo.userId, oldPassword, newPassword);

    return result;
  }

  Future<bool> increaseStaffCredit(Session session) async {
    // TODO: this code is duplicated in the future call
    // and still does not have any checks!
    final List<User> allStaff = await User.db.find(session);
    await session.db.transaction((transaction) async {
      for (var staff in allStaff) {
        final amount = staff.timeUnits + 2;

        staff.credit += amount;

        final creditTransaction = CreditTransaction(
            sender: 'Admin',
            receiver: staff.userInfoId,
            amount: amount,
            dateTime: DateTime.now());

        await User.db.updateRow(session, staff, transaction: transaction);
        await CreditTransaction.db
            .insertRow(session, creditTransaction, transaction: transaction);
      }
    });
    return true;
  }
}
