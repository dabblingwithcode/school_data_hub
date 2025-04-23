import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class MissedClassEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Stream<MissedClassDto> streamMyModels(Session session) async* {
    // Create a stream from the server's message central
    var stream =
        session.messages.createStream<MissedClassDto>('missed_class_stream');

    // Relay messages from the stream to the client
    await for (var missedClassDto in stream) {
      yield missedClassDto;
    }
  }

  Future<MissedClass> postMissedClass(
      Session session, MissedClass missedClass) async {
    final createdMissedClass = await session.db.insertRow(missedClass);
    // Fetch the object again with the relation included
    final missedClassWithRelation = await MissedClass.db.findById(
      session,
      createdMissedClass.id!,
      include: MissedClass.include(
        schoolday: Schoolday.include(),
      ),
    );
    final newMissedClassDto = MissedClassDto(
      missedClass: missedClassWithRelation!,
      operation: 'add',
    );
    // Send the new missed class to the stream
    session.messages.postMessage(
      'missed_class_stream',
      newMissedClassDto,
    );
    return missedClassWithRelation;
  }

  Future<List<MissedClass>> postMissedClasses(
      Session session, List<MissedClass> missedClasses) async {
    final createdMissedClasses = await session.db.insert(missedClasses);
    return createdMissedClasses;
  }

  Future<List<MissedClass>> fetchAllMissedClasses(Session session) {
    return MissedClass.db.find(
      session,
      include: MissedClass.include(
        schoolday: Schoolday.include(),
      ),
    );
  }

  Future<List<MissedClass>> fetchMissedClassesOnASchoolday(
      Session session, DateTime schoolday) {
    return MissedClass.db.find(
      session,
      where: (t) => t.schoolday.schoolday.equals(schoolday),
      include: MissedClass.include(
        schoolday: Schoolday.include(),
      ),
    );
  }

  Future<bool> deleteMissedClass(
      Session session, int pupilId, DateTime schooldayDate) async {
    var missedClassToDelete = await MissedClass.db.findFirstRow(
      session,
      where: (t) =>
          t.pupilId.equals(pupilId) &
          t.schoolday.schoolday.equals(schooldayDate),
      include: MissedClass.include(
        schoolday: Schoolday.include(),
      ),
    );
    await MissedClass.db.deleteRow(session, missedClassToDelete!);
    final deletedMissedClassDto = MissedClassDto(
      missedClass: missedClassToDelete,
      operation: 'delete',
    );
    // Send the deleted missed class to the stream
    session.messages.postMessage(
      'missed_class_stream',
      deletedMissedClassDto,
    );
    return true;
  }

  Future<MissedClass> updateMissedClass(
      Session session, MissedClass missedClass) async {
    final updatedMissedClass = await session.db.updateRow(missedClass);
    // Fetch the object again with the relation included
    final missedClassWithRelation = await MissedClass.db.findById(
      session,
      updatedMissedClass.id!,
      include: MissedClass.include(
        schoolday: Schoolday.include(),
      ),
    );

    final updatedMissedClassDto = MissedClassDto(
      missedClass: missedClassWithRelation!,
      operation: 'update',
    );
    // Send the updated missed class to the stream
    session.messages.postMessage(
      'missed_class_stream',
      updatedMissedClassDto,
    );

    return missedClassWithRelation;
  }
}
