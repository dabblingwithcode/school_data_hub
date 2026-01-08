import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/utils/isbn_api.dart';
import 'package:serverpod/serverpod.dart';

class PupilWorkbooksEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<PupilWorkbook> postPupilWorkbook(
      Session session, int isbn, int pupilId, String createdBy) async {
    // Insert a new pupil workbook into the database
    final result = await session.db.transaction((transaction) async {
      Workbook? workbook = await Workbook.db.findFirstRow(
        session,
        where: (t) => t.isbn.equals(isbn),
        transaction: transaction,
      );
      if (workbook == null) {
        // If the workbook does not exist, fetch data from ISBN API and create it
        final IsbnApiData isbnApiData =
            await IsbnApi.fetchIsbnApiData(session, isbn);

        workbook = await Workbook.db.insertRow(
          session,
          Workbook(
            isbn: isbn,
            name: isbnApiData.title,
            imageUrl: isbnApiData.imagePath,
          ),
          transaction: transaction,
        );
      }

      final pupilWorkbook = PupilWorkbook(
        score: 0,
        pupilId: pupilId,
        workbookId: workbook.id!,
        isbn: isbn,
        createdBy: createdBy,
        createdAt: DateTime.now().toUtc(),
      );
      final pupilWorkbookInDatabase = await PupilWorkbook.db.insertRow(
        session,
        pupilWorkbook,
        transaction: transaction,
      );
      Workbook.db.attachRow.assignedPupils(
          session, workbook, pupilWorkbookInDatabase,
          transaction: transaction);

      return pupilWorkbookInDatabase;
    });

    return result;
  }

  //- read

  Future<List<PupilWorkbook>> fetchPupilWorkbooks(Session session) async {
    // Fetch all pupil workbooks
    final pupilWorkbooks = await PupilWorkbook.db.find(session);
    return pupilWorkbooks;
  }

  Future<List<PupilWorkbook>> fetchPupilWorkbooksFromPupil(
      Session session, int pupilId) async {
    // Implement logic to fetch workbooks associated with the given pupilId
    final pupilWorkbooks = await PupilWorkbook.db.find(
      session,
      where: (t) => t.pupilId.equals(pupilId),
    );

    return pupilWorkbooks;
  }

  //- update

  Future<PupilWorkbook> updatePupilWorkbook(
      Session session, PupilWorkbook pupilWorkbook) async {
    // Update an existing pupil workbook
    final updatedPupilWorkbook =
        await PupilWorkbook.db.updateRow(session, pupilWorkbook);
    return updatedPupilWorkbook;
  }

  //- delete

  Future<bool> deletePupilWorkbook(Session session, int pupilWorkbookId) async {
    final result = await session.db.transaction((transaction) async {
      // Check if the pupil workbook exists
      // Delete a pupil workbook by its ID
      final pupilWorkbook = await PupilWorkbook.db.findFirstRow(
        session,
        where: (t) => t.id.equals(pupilWorkbookId),
      );
      if (pupilWorkbook == null) {
        throw Exception(
            'Pupil workbook with id $pupilWorkbookId does not exist.');
      }
      await PupilWorkbook.db.deleteRow(session, pupilWorkbook);
      return true;
    });
    if (result != true) {
      throw Exception(
          'Failed to delete pupil workbook with id $pupilWorkbookId.');
    }
    return result;
  }
}
