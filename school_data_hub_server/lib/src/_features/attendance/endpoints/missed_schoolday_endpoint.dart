import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class MissedSchooldayEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Stream<MissedSchooldayDto> streamMissedSchooldays(Session session) async* {
    // Create a stream from the server's message central
    var stream = session.messages
        .createStream<MissedSchooldayDto>('missed_schooldays_stream');

    // Relay messages from the stream to the client
    await for (var missedClassDto in stream) {
      yield missedClassDto;
    }
  }

  Future<MissedSchoolday> postMissedSchoolday(
      Session session, MissedSchoolday missedClass) async {
    final createdMissedSchoolday = await session.db.insertRow(missedClass);
    // Fetch the object again with the relation included
    final missedSchooldayWithRelation = await MissedSchoolday.db.findById(
      session,
      createdMissedSchoolday.id!,
      include: MissedSchoolday.include(
        schoolday: Schoolday.include(),
      ),
    );
    final newMissedSchooldayDto = MissedSchooldayDto(
      missedSchoolday: missedSchooldayWithRelation!,
      operation: 'add',
    );
    // Send the new missed class to the stream
    session.messages.postMessage(
      'missed_class_stream',
      newMissedSchooldayDto,
    );
    return missedSchooldayWithRelation;
  }

  Future<List<MissedSchoolday>> postMissedSchooldayes(
      Session session, List<MissedSchoolday> missedClasses) async {
    final createdMissedSchooldays = await session.db.insert(missedClasses);
    return createdMissedSchooldays;
  }

  Future<List<MissedSchoolday>> fetchAllMissedSchooldayes(Session session) {
    return MissedSchoolday.db.find(
      session,
      include: MissedSchoolday.include(
        schoolday: Schoolday.include(),
      ),
    );
  }

  Future<List<MissedSchoolday>> fetchMissedSchooldayesOnASchoolday(
      Session session, DateTime schoolday) async {
    final missedSchooldays = await MissedSchoolday.db.find(
      session,
      where: (t) => t.schoolday.schoolday.equals(schoolday),
      include: MissedSchoolday.include(
        schoolday: Schoolday.include(),
      ),
    );
    return missedSchooldays;
  }

  Future<bool> deleteMissedSchoolday(
      Session session, int pupilId, int schooldayId) async {
    var missedSchooldayToDelete = await MissedSchoolday.db.findFirstRow(
      session,
      where: (t) =>
          t.pupilId.equals(pupilId) & t.schooldayId.equals(schooldayId),
      include: MissedSchoolday.include(
        schoolday: Schoolday.include(),
      ),
    );
    await MissedSchoolday.db.deleteRow(session, missedSchooldayToDelete!);
    final deletedMissedSchooldayDto = MissedSchooldayDto(
      missedSchoolday: missedSchooldayToDelete,
      operation: 'delete',
    );
    // Send the deleted missed class to the stream
    session.messages.postMessage(
      'missed_class_stream',
      deletedMissedSchooldayDto,
    );
    return true;
  }

  Future<MissedSchoolday> updateMissedSchoolday(
      Session session, MissedSchoolday missedSchoolday) async {
    final updatedMissedSchoolday = await session.db.updateRow(missedSchoolday);
    // Fetch the object again with the relation included
    final missedSchooldayWithRelation = await MissedSchoolday.db.findById(
      session,
      updatedMissedSchoolday.id!,
      include: MissedSchoolday.include(
        schoolday: Schoolday.include(),
      ),
    );

    final updatedMissedSchooldayDto = MissedSchooldayDto(
      missedSchoolday: missedSchooldayWithRelation!,
      operation: 'update',
    );
    // Send the updated missed class to the stream
    session.messages.postMessage(
      'missed_class_stream',
      updatedMissedSchooldayDto,
    );

    return missedSchooldayWithRelation;
  }
}
