import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class BooksEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<Book> postBook(Session session, Book book) async {
    final bookInDatabase = await Book.db.insertRow(session, book);
    return bookInDatabase;
  }

  //- read

  Future<List<Book>> fetchBooks(Session session) async {
    final books = await Book.db.find(
      session,
    );
    return books;
  }

  Future<Book?> fetchBookByIsbn(
    Session session,
    int isbn,
  ) async {
    final book = await Book.db.findFirstRow(
      session,
      where: (t) => t.isbn.equals(isbn),
    );
    return book;
  }

  //-update

  Future<Book> updateBook(Session session, Book book) async {
    final updatedBook = await Book.db.updateRow(session, book);
    return updatedBook;
  }

  //- delete

  Future<bool> deleteBook(Session session, int id) async {
    // Check if the book exists
    final book = await Book.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id),
    );
    if (book == null) {
      throw Exception('Book with id $id does not exist.');
    }
    final deleted = await Book.db.deleteRow(session, book);
    // TODO: Is this the right way to check if the book was deleted?

    return true;
  }
}
