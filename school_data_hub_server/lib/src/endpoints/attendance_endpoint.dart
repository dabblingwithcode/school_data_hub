import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class AttendanceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<MissedClass>> fetchMissedClassesOnASchoolday(
      Session session, DateTime schoolday) {
    return MissedClass.db.find(
      session,
      where: (t) => t.schoolday.schoolday.equals(schoolday),
    );
  }

  Future<List<MissedClass>> fetchMissedClasses(Session session) {
    return MissedClass.db.find(session);
  }

  Future<bool> createMissedClass(
      Session session, MissedClass missedClass) async {
    await session.db.insertRow(missedClass);
    return true;
  }

  Future<bool> deleteMissedClass(
      Session session, MissedClass missedClass) async {
    await session.db.deleteRow(missedClass);
    return true;
  }
}
