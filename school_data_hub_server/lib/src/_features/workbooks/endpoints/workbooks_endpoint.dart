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

  //- read

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

  Future<List<Workbook>> fetchWorkbooks(Session session) async {
    final workbooks = await Workbook.db.find(session);
    return workbooks;
  }

  //- update

  Future<Workbook> updateWorkbookImage(
    Session session,
    int isbn,
    String imageUrl,
  ) async {
    session.log('updateWorkbookImage: isbn=$isbn imageUrl=$imageUrl');
    try {
      final workbook = await Workbook.db.findFirstRow(
        session,
        where: (t) => t.isbn.equals(isbn),
      );
      if (workbook == null) {
        session.log('updateWorkbookImage: workbook not found for isbn=$isbn',
            level: LogLevel.error);
        throw Exception('Workbook with isbn $isbn does not exist.');
      }
      session.log('updateWorkbookImage: found workbook id=${workbook.id}');
      workbook.imageUrl = imageUrl;
      final updatedWorkbook = await Workbook.db.updateRow(session, workbook);
      session.log('updateWorkbookImage: updated successfully');
      return updatedWorkbook;
    } catch (e, st) {
      session.log('updateWorkbookImage: FAILED $e\n$st',
          level: LogLevel.error);
      rethrow;
    }
  }

  Future<Workbook> deleteWorkbookImage(
    Session session,
    int isbn,
  ) async {
    final workbook = await Workbook.db.findFirstRow(
      session,
      where: (t) => t.isbn.equals(isbn),
    );
    if (workbook == null) {
      throw Exception('Workbook with isbn $isbn does not exist.');
    }
    if (workbook.imageUrl.isNotEmpty &&
        !workbook.imageUrl.startsWith('http')) {
      await session.storage.deleteFile(
        storageId: 'public',
        path: workbook.imageUrl,
      );
    }
    workbook.imageUrl = '';
    final updatedWorkbook = await Workbook.db.updateRow(session, workbook);
    return updatedWorkbook;
  }

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
