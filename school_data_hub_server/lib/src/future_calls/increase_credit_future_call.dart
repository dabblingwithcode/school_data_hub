import 'dart:async';

import 'package:school_data_hub_server/src/_features/user/helpers/increase_staff_credit.dart';
import 'package:serverpod/serverpod.dart';

class IncreaseCreditFutureCall extends FutureCall {
  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    const identifier = 'increase-credit-weekly';

    try {
      await increaseAllStaffCredit(session);

      // Schedule the next run (one week from now)
      await session.serverpod.futureCallWithDelay(
        'increaseCreditFutureCall',
        null,
        const Duration(days: 7),
        identifier: identifier,
      );
    } catch (e) {
      session.log(
        'Error in IncreaseCreditFutureCall: $e',
        level: LogLevel.error,
      );

      // Reschedule the call in 1 hour
      final nextRunTime = DateTime.now().add(const Duration(hours: 1));
      unawaited(
        session.serverpod.futureCallAtTime(
          'increaseCreditFutureCall',
          null,
          nextRunTime,
          identifier: identifier,
        ),
      );
    }
  }
}
