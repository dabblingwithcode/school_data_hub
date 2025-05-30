import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/schemas/pupil_schemas.dart';
import 'package:serverpod/serverpod.dart';

class PupilBookLendingEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<PupilData> postPupilBookLending(
      Session session, int pupilId, String libraryId, String lentBy) async {
    final result = await session.db.transaction((transaction) async {
      final pupil = await PupilData.db.findById(
        session,
        pupilId,
        include: PupilSchemas.allInclude,
        transaction: transaction,
      );
      if (pupil == null) {
        throw Exception('Pupil with id $pupilId does not exist.');
      }
      final libraryBook = await LibraryBook.db.findFirstRow(session,
          where: (t) => t.libraryId.equals(libraryId),
          include: LibraryBookSchemas.allInclude,
          transaction: transaction);
      final pupilBookLending = PupilBookLending(
        score: 0,
        isbn: libraryBook!.book!.isbn,
        lendingId: Uuid().v4(),
        pupilId: pupilId,
        libraryBookId: libraryBook.id!,
        lentAt: DateTime.now(),
        lentBy: lentBy,
      );

      await PupilBookLending.db
          .insertRow(session, pupilBookLending, transaction: transaction);
      await PupilBookLending.db.attachRow
          .pupil(session, pupilBookLending, pupil, transaction: transaction);
      await PupilBookLending.db.attachRow.libraryBook(
          session, pupilBookLending, libraryBook,
          transaction: transaction);

      final updatedPupil = await PupilData.db.findFirstRow(session,
          where: (t) => t.id.equals(pupilBookLending.pupilId),
          include: PupilSchemas.allInclude,
          transaction: transaction);

      return updatedPupil;
    });

    return result!;
  }

  //- read
  Future<List<PupilBookLending>> fetchPupilBookLendings(Session session) async {
    final pupilBookLendings = await PupilBookLending.db.find(
      session,
    );
    return pupilBookLendings;
  }

  Future<PupilBookLending?> fetchPupilBookLendingById(
    Session session,
    int id,
  ) async {
    final pupilBookLending = await PupilBookLending.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id),
    );
    return pupilBookLending;
  }

  //-update
  Future<PupilData> updatePupilBookLending(
      Session session, PupilBookLending pupilBookLending) async {
    final updatedPupilBookLending =
        await PupilBookLending.db.updateRow(session, pupilBookLending);

    final pupil = await PupilData.db.findFirstRow(session,
        where: (t) => t.id.equals(updatedPupilBookLending.pupilId),
        include: PupilSchemas.allInclude);
    return pupil!;
  }

  //- delete
  Future<PupilData> deletePupilBookLending(Session session, int id) async {
    // Check if the pupil book lending exists
    final pupilBookLending = await PupilBookLending.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id),
    );
    if (pupilBookLending == null) {
      throw Exception('Pupil book lending with id $id does not exist.');
    }

    await PupilBookLending.db.deleteRow(session, pupilBookLending);
    final pupil = await PupilData.db.findFirstRow(session,
        where: (t) => t.id.equals(pupilBookLending.pupilId),
        include: PupilSchemas.allInclude);
    return pupil!;
  }
}
