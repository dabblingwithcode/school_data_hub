import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Increases credit for all staff members based on their time units.
/// Each staff member receives their timeUnits + 2 as credit.
Future<void> increaseAllStaffCredit(Session session) async {
  final List<User> allStaff = await User.db.find(session);
  await session.db.transaction((transaction) async {
    for (var staff in allStaff) {
      final amount = staff.timeUnits + 2;

      staff.credit += amount;

      final creditTransaction = CreditTransaction(
        sender: 'Admin',
        receiver: staff.userInfoId,
        amount: amount,
        dateTime: DateTime.now(),
      );

      await User.db.updateRow(session, staff, transaction: transaction);
      await CreditTransaction.db
          .insertRow(session, creditTransaction, transaction: transaction);
    }
  });
}
