import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class MissedClassEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<MissedClass> postMissedClass(
      Session session, MissedClass missedClass) async {
    final createdMissedClass = await session.db.insertRow(missedClass);
    return createdMissedClass;
  }

  Future<List<MissedClass>> postMissedClasses(
      Session session, List<MissedClass> missedClasses) async {
    final createdMissedClasses = await session.db.insert(missedClasses);
    return createdMissedClasses;
  }

  Future<List<MissedClass>> fetchAllMissedClasses(Session session) {
    return MissedClass.db.find(session);
  }

  Future<List<MissedClass>> fetchMissedClassesOnASchoolday(
      Session session, DateTime schoolday) {
    return MissedClass.db.find(
      session,
      where: (t) => t.schoolday.schoolday.equals(schoolday),
    );
  }

  Future<bool> deleteMissedClass(
      Session session, int internalId, DateTime schooldayDate) async {
    var missedClassToDelete = await MissedClass.db.findFirstRow(
      session,
      where: (t) =>
          t.pupil.internalId.equals(internalId) &
          t.schoolday.schoolday.equals(schooldayDate),
    );
    await MissedClass.db.deleteRow(session, missedClassToDelete!);
    return true;
  }

  Future<MissedClass> updateMissedClass(
      Session session, MissedClass missedClass) async {
    final updatedMissedClass = await session.db.updateRow(missedClass);
    return updatedMissedClass;
  }
}
