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

  /// Helper method that handles upsert logic for a single MissedSchoolday record.
  /// Returns a record containing the processed MissedSchoolday and the operation type.
  Future<({MissedSchoolday record, String operation})> _upsertMissedSchoolday(
      Session session, MissedSchoolday missedClass) async {
    late MissedSchoolday resultMissedSchoolday;
    String operation = 'add';

    try {
      // Try to insert the record (optimistic case - no duplicate)
      final createdMissedSchoolday = await session.db.insertRow(missedClass);
      resultMissedSchoolday = createdMissedSchoolday;
    } on DatabaseQueryException catch (e) {
      // Check if this is a duplicate key error (code 23505)
      if (e.toString().contains('23505') ||
          e.toString().contains('duplicate key')) {
        // Fetch the existing record with the same schooldayId and pupilId
        final existingRecord = await MissedSchoolday.db.findFirstRow(
          session,
          where: (t) =>
              t.schooldayId.equals(missedClass.schooldayId) &
              t.pupilId.equals(missedClass.pupilId),
        );

        if (existingRecord != null) {
          // Update the existing record with new data, preserving the ID
          final updatedMissedSchoolday = existingRecord.copyWith(
            missedType: missedClass.missedType,
            unexcused: missedClass.unexcused,
            contacted: missedClass.contacted,
            returned: missedClass.returned,
            returnedAt: missedClass.returnedAt,
            writtenExcuse: missedClass.writtenExcuse,
            minutesLate: missedClass.minutesLate,
            modifiedBy: missedClass.modifiedBy,
            comment: missedClass.comment,
          );

          resultMissedSchoolday =
              await session.db.updateRow(updatedMissedSchoolday);
          operation = 'update';
        } else {
          // If we can't find the existing record, rethrow the original error
          rethrow;
        }
      } else {
        // If it's not a duplicate key error, rethrow
        rethrow;
      }
    }

    // Fetch the object again with the relation included
    final missedSchooldayWithRelation = await MissedSchoolday.db.findById(
      session,
      resultMissedSchoolday.id!,
      include: MissedSchoolday.include(
        schoolday: Schoolday.include(),
      ),
    );

    return (record: missedSchooldayWithRelation!, operation: operation);
  }

  Future<MissedSchoolday> postMissedSchoolday(
      Session session, MissedSchoolday missedClass) async {
    final result = await _upsertMissedSchoolday(session, missedClass);

    final missedSchooldayDto = MissedSchooldayDto(
      missedSchoolday: result.record,
      operation: result.operation,
    );

    // Send the missed class to the stream
    session.messages.postMessage(
      'missed_schooldays_stream',
      missedSchooldayDto,
    );

    return result.record;
  }

  Future<List<MissedSchoolday>> postMissedSchooldays(
      Session session, List<MissedSchoolday> missedClasses) async {
    final results = <MissedSchoolday>[];

    // Process each record individually to handle duplicates gracefully
    for (final missedClass in missedClasses) {
      final result = await _upsertMissedSchoolday(session, missedClass);

      // Send stream notification for each record
      session.messages.postMessage(
        'missed_schooldays_stream',
        MissedSchooldayDto(
          missedSchoolday: result.record,
          operation: result.operation,
        ),
      );

      results.add(result.record);
    }

    return results;
  }

  Future<List<MissedSchoolday>> fetchAllMissedSchooldays(Session session) {
    return MissedSchoolday.db.find(
      session,
      include: MissedSchoolday.include(
        schoolday: Schoolday.include(),
      ),
    );
  }

  Future<List<MissedSchoolday>> fetchMissedSchooldaysOnASchoolday(
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
      'missed_schooldays_stream',
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
      'missed_schooldays_stream',
      updatedMissedSchooldayDto,
    );

    return missedSchooldayWithRelation;
  }
}
