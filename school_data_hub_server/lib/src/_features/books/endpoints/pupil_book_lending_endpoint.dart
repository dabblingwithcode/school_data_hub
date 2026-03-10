import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/helpers/hub_document_helper.dart';
import 'package:school_data_hub_server/src/_features/pupil/schemas/pupil_schemas.dart';
import 'package:serverpod/serverpod.dart';

class PupilBookLendingEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<PupilBookLending> postPupilBookLending(
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

      final createdLending = await PupilBookLending.db.findFirstRow(session,
          where: (t) => t.lendingId.equals(pupilBookLending.lendingId),
          include: PupilBookLendingSchemas.allInclude,
          transaction: transaction);

      return createdLending;
    });

    return result!;
  }

  //- read
  Future<List<PupilBookLending>> fetchPupilBookLendings(Session session) async {
    final pupilBookLendings = await PupilBookLending.db.find(
      session,
      include: PupilBookLendingSchemas.allInclude,
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
      include: PupilBookLendingSchemas.allInclude,
    );
    return pupilBookLending;
  }

  //-update
  Future<PupilBookLending> updatePupilBookLending(
      Session session, PupilBookLending pupilBookLending) async {
    return await session.db.transaction((transaction) async {
      final updatedPupilBookLending = await PupilBookLending.db
          .updateRow(session, pupilBookLending, transaction: transaction);

      // if the book was returned, set the library book available to true
      if (pupilBookLending.returnedAt != null) {
        final libraryBook = await LibraryBook.db.findFirstRow(session,
            where: (t) => t.id.equals(updatedPupilBookLending.libraryBookId),
            transaction: transaction);
        libraryBook!.available = true;
        await LibraryBook.db
            .updateRow(session, libraryBook, transaction: transaction);
      }

      final lending = await PupilBookLending.db.findFirstRow(session,
          where: (t) => t.lendingId.equals(updatedPupilBookLending.lendingId),
          include: PupilBookLendingSchemas.allInclude,
          transaction: transaction);
      return lending!;
    });
  }

  //- delete
  Future<bool> deletePupilBookLending(Session session, String lendingId) async {
    // Check if the pupil book lending exists
    final pupilBookLending = await PupilBookLending.db.findFirstRow(
      session,
      where: (t) => t.lendingId.equals(lendingId),
    );
    if (pupilBookLending == null) {
      throw Exception('Pupil book lending with id $lendingId does not exist.');
    }

    await session.db.transaction((transaction) async {
      // If the book was not returned, set the library book available to true
      if (pupilBookLending.returnedAt == null) {
        final libraryBook = await LibraryBook.db.findFirstRow(session,
            where: (t) => t.id.equals(pupilBookLending.libraryBookId),
            transaction: transaction);
        if (libraryBook != null) {
          libraryBook.available = true;
          await LibraryBook.db
              .updateRow(session, libraryBook, transaction: transaction);
        }
      }

      await PupilBookLending.db
          .deleteRow(session, pupilBookLending, transaction: transaction);
    });

    return true;
  }

  //- files

  /// Add a file to a PupilBookLending record
  Future<PupilBookLending> addFileToPupilBookLending(
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

    return await session.db.transaction((transaction) async {
      final createdDocument = await HubDocument.db.insertRow(
        session,
        hubDocument,
        transaction: transaction,
      );

      // Attach the document to the PupilBookLending record
      await PupilBookLending.db.attachRow.pupilBookLendingFiles(
        session,
        pupilBookLending,
        createdDocument,
        transaction: transaction,
      );

      final lending = await PupilBookLending.db.findFirstRow(
        session,
        where: (t) => t.lendingId.equals(lendingId),
        include: PupilBookLendingSchemas.allInclude,
        transaction: transaction,
      );
      return lending!;
    });
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
