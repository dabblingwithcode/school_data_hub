import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/utils/isbn_api.dart';
import 'package:serverpod/serverpod.dart';

class WorkbooksEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<Workbook> postWorkbook(Session session, Workbook workbook) async {
    final result = await session.db.transaction((transaction) async {
      final workbookId = await Workbook.db.insertRow(
        session,
        workbook,
        transaction: transaction,
      );
      return workbookId;
    });

    return result;
  }

  Future<Workbook> fetchWorkbookByIsbn(
    Session session,
    int isbn,
  ) async {
    final book = await Workbook.db.findFirstRow(
      session,
      where: (t) => t.isbn.equals(isbn),
    );
    if (book == null) {
      final IsbnApiData isbnApiData =
          await IsbnApi.fetchIsbnApiData(session, isbn);

      final workbook = Workbook(
        isbn: isbn,
        name: isbnApiData.title,
        imageUrl: isbnApiData.imagePath,
      );

      final bookInDatabase = await Workbook.db.insertRow(session, workbook);
      return bookInDatabase;
    }
    return book;
  }

  //- read
  Future<List<Workbook>> fetchWorkbooks(Session session) async {
    final workbooks = await Workbook.db.find(session);
    return workbooks;
  }

  //- update
  Future<Workbook> updateWorkbook(Session session, Workbook workbook) async {
    final result = await session.db.transaction((transaction) async {
      final workbookId = await Workbook.db.updateRow(
        session,
        workbook,
        transaction: transaction,
      );
      return workbookId;
    });

    return result;
  }

  //- delete
  Future<bool> deleteWorkbook(Session session, int id) async {
    // Check if the workbook exists
    final workbook = await Workbook.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id),
    );
    if (workbook == null) {
      throw Exception('Workbook with id $id does not exist.');
    }
    await Workbook.db.deleteRow(session, workbook);
    return true;
  }
}
