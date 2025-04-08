import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class MissedClassEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<bool> createMissedClass(
      Session session, MissedClass missedClass) async {
    await session.db.insertRow(missedClass);
    return true;
  }

  Future<List<MissedClass>> getAllMissedClasses(Session session) async {
    final missedClasses = await session.db.find<MissedClass>();
    return missedClasses;
  }

  Future<MissedClass?> getMissedClassesOnDate(
      Session session, DateTime schooldayDate) async {
    final missedClass = await MissedClass.db.findFirstRow(
      session,
      where: (t) => t.schoolday.schoolday.equals(schooldayDate),
    );
    return missedClass;
  }

  Future<bool> updateMissedClass(
      Session session, MissedClass missedClass) async {
    await session.db.updateRow(missedClass);
    return true;
  }

  Future<bool> deleteMissedClass(
      Session session, MissedClass missedClass) async {
    await session.db.deleteRow<MissedClass>(missedClass);
    return true;
  }
}
