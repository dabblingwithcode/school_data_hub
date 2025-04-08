import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

// Future calls are calls that will be invoked at a later time. An example is if
// you want to send a drip-email campaign after a user signs up. You can
// schedule a future call for a day, a week, or a month. The calls are stored in
// the database, so they will persist even if the server is restarted.
//
//  To add a future call to your server, you need to register it in the
//  `server.dart` file. Schedule the call using the
//  `session.serverpod.futureCallWithDelay` or `session.serverpod.futureCallAtTime`
//  methods. You can optionally pass a serializable object together with the
//  call.

class IncreaseCreditFutureCall extends FutureCall {
  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    // Do something interesting in the future here.
    final List<StaffUser> allStaff = await StaffUser.db.find(session);
    for (var staff in allStaff) {
      final amount = staff.timeUnits + 2;

      staff.credit += amount;

      final CreditTransaction transaction = CreditTransaction(
          sender: 'Admin',
          receiver: staff.userInfoId,
          amount: amount,
          dateTime: DateTime.now());

      await session.db.updateRow(staff);
    }
    // Schedule the next run (one week from now)
    await session.serverpod.futureCallWithDelay(
      'weeklyTask',
      null,
      const Duration(days: 7),
    );
  }
}
