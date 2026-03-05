import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class MissedSchooldayEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

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
          rethrow;
        }
      } else {
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

    session.messages.postMessage('hub_events_stream', result.record);

    return result.record;
  }

  Future<List<MissedSchoolday>> postMissedSchooldays(
      Session session, List<MissedSchoolday> missedClasses) async {
    final results = await session.db.transaction((transaction) async {
      final processed = <MissedSchoolday>[];

      for (final missedClass in missedClasses) {
        final existing = await MissedSchoolday.db.findFirstRow(
          session,
          where: (t) =>
              t.schooldayId.equals(missedClass.schooldayId) &
              t.pupilId.equals(missedClass.pupilId),
          transaction: transaction,
        );

        late MissedSchoolday resultRecord;

        if (existing != null) {
          final updated = existing.copyWith(
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
          resultRecord = await MissedSchoolday.db.updateRow(
            session,
            updated,
            transaction: transaction,
          );
        } else {
          resultRecord = await MissedSchoolday.db.insertRow(
            session,
            missedClass,
            transaction: transaction,
          );
        }

        final withRelation = await MissedSchoolday.db.findById(
          session,
          resultRecord.id!,
          include: MissedSchoolday.include(
            schoolday: Schoolday.include(),
          ),
          transaction: transaction,
        );

        session.messages.postMessage('hub_events_stream', withRelation!);
        processed.add(withRelation);
      }

      return processed;
    });

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
    final missedSchooldayToDelete = await MissedSchoolday.db.findFirstRow(
      session,
      where: (t) =>
          t.pupilId.equals(pupilId) & t.schooldayId.equals(schooldayId),
    );
    await MissedSchoolday.db.deleteRow(session, missedSchooldayToDelete!);
    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(
        objectType: HubObjectType.missedSchoolday,
        id: missedSchooldayToDelete.id!,
      ),
    );
    return true;
  }

  Future<MissedSchoolday> updateMissedSchoolday(
      Session session, MissedSchoolday missedSchoolday) async {
    final updatedMissedSchoolday = await session.db.updateRow(missedSchoolday);
    final missedSchooldayWithRelation = await MissedSchoolday.db.findById(
      session,
      updatedMissedSchoolday.id!,
      include: MissedSchoolday.include(
        schoolday: Schoolday.include(),
      ),
    );

    session.messages.postMessage('hub_events_stream', missedSchooldayWithRelation!);

    return missedSchooldayWithRelation;
  }
}
