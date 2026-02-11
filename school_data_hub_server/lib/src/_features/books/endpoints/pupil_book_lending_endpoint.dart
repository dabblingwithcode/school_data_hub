import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/hub_document_helper.dart';
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

      final pupilBookLendingInDatabase = await PupilBookLending.db
          .insertRow(session, pupilBookLending, transaction: transaction);
      await PupilBookLending.db.attachRow.pupil(
          session, pupilBookLendingInDatabase, pupil,
          transaction: transaction);
      await PupilBookLending.db.attachRow.libraryBook(
          session, pupilBookLendingInDatabase, libraryBook,
          transaction: transaction);
      libraryBook.available = false;
      await LibraryBook.db
          .updateRow(session, libraryBook, transaction: transaction);

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

  Future<PupilBookLending?> fetchPupilBookLendingByLendingId(
    Session session,
    String lendingId,
  ) async {
    final pupilBookLending = await PupilBookLending.db.findFirstRow(
      session,
      where: (t) => t.lendingId.equals(lendingId),
    );
    return pupilBookLending;
  }

  //-update
  Future<PupilData> updatePupilBookLending(
      Session session, PupilBookLending pupilBookLending) async {
    final updatedPupilBookLending =
        await PupilBookLending.db.updateRow(session, pupilBookLending);

    // if the book was returned, set the library book available to true
    if (pupilBookLending.returnedAt != null) {
      final libraryBook = await LibraryBook.db.findFirstRow(session,
          where: (t) => t.id.equals(updatedPupilBookLending.libraryBookId));
      libraryBook!.available = true;
      await LibraryBook.db.updateRow(session, libraryBook);
    }

    final pupil = await PupilData.db.findFirstRow(session,
        where: (t) => t.id.equals(updatedPupilBookLending.pupilId),
        include: PupilSchemas.allInclude);
    return pupil!;
  }

  //- delete
  Future<PupilData> deletePupilBookLending(
      Session session, String lendingId) async {
    // Check if the pupil book lending exists
    final pupilBookLending = await PupilBookLending.db.findFirstRow(
      session,
      where: (t) => t.lendingId.equals(lendingId),
    );
    if (pupilBookLending == null) {
      throw Exception('Pupil book lending with id $lendingId does not exist.');
    }

    await PupilBookLending.db.deleteRow(session, pupilBookLending);
    final pupil = await PupilData.db.findFirstRow(session,
        where: (t) => t.id.equals(pupilBookLending.pupilId),
        include: PupilSchemas.allInclude);
    return pupil!;
  }

  //- files

  /// Add a file to a PupilBookLending record
  Future<PupilData> addFileToPupilBookLending(
    Session session,
    String lendingId,
    String filePath,
    String createdBy,
  ) async {
    final pupilBookLending = await PupilBookLending.db.findFirstRow(
      session,
      where: (t) => t.lendingId.equals(lendingId),
    );

    if (pupilBookLending == null) {
      throw Exception('Pupil book lending with id $lendingId does not exist.');
    }

    // Create a new HubDocument for the file
    final hubDocument = HubDocumentHelper().createHubDocumentObject(
      session: session,
      createdBy: createdBy,
      path: filePath,
    );

    final createdDocument = await HubDocument.db.insertRow(
      session,
      hubDocument,
    );

    // Attach the document to the PupilBookLending record
    await PupilBookLending.db.attachRow.pupilBookLendingFiles(
      session,
      pupilBookLending,
      createdDocument,
    );

    final pupil = await PupilData.db.findFirstRow(
      session,
      where: (t) => t.id.equals(pupilBookLending.pupilId),
      include: PupilSchemas.allInclude,
    );
    return pupil!;
  }

  /// Remove a file from a PupilBookLending record
  Future<bool> removeFileFromPupilBookLending(
    Session session,
    String lendingId,
    String documentId,
  ) async {
    final pupilBookLending = await PupilBookLending.db.findFirstRow(
      session,
      where: (t) => t.lendingId.equals(lendingId),
    );

    if (pupilBookLending == null) {
      throw Exception('Pupil book lending with id $lendingId does not exist.');
    }

    final document = await HubDocument.db.findFirstRow(
      session,
      where: (t) => t.documentId.equals(documentId),
    );
    if (document == null) {
      throw Exception('Document not found');
    }

    await session.db.transaction((transaction) async {
      // Detach the document from the PupilBookLending record
      await PupilBookLending.db.detachRow.pupilBookLendingFiles(
        session,
        document,
        transaction: transaction,
      );

      // Delete the file from storage
      await session.storage.deleteFile(
        storageId: 'private',
        path: document.documentPath!,
      );

      // Delete the document from database
      await HubDocument.db
          .deleteRow(session, document, transaction: transaction);
    });

    return true;
  }
}
