import 'dart:async';

import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// This future call increases the credit of all staff users by
/// a factor staff.timeUnits + 2
/// and is scheduled to run every week.
class IncreaseCreditFutureCall extends FutureCall {
  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    try {
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
      // Schedule the next run (one week from now)
      await session.serverpod.futureCallWithDelay(
        'increaseCreditFutureCall',
        null,
        const Duration(days: 7),
      );
    } catch (e) {
      session.log('Error in IncreaseCreditFutureCall: $e',
          level: LogLevel.error);
      // reschedule the call in 1 hour
      final nextRunTime = DateTime.now().add(Duration(hours: 1));
      unawaited(session.serverpod.futureCallAtTime(
        'increaseCreditFutureCall',
        null,
        nextRunTime,
      ));
    }
  }
}
