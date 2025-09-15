import 'package:school_data_hub_server/src/_features/books/endpoints/books/book_tagging_helper.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/utils/isbn_api.dart';
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
    if (book == null) {
      final IsbnApiData isbnApiData =
          await IsbnApi.fetchIsbnApiData(session, isbn);

      // if (isbnApiData == null) {
      //   throw Exception('Book with isbn $isbn does not exist.');
      // }
      final book = Book(
        isbn: isbn,
        title: isbnApiData.title,
        description: isbnApiData.description,
        author: isbnApiData.author,
        imagePath: isbnApiData.imagePath,
      );

      final bookInDatabase = await Book.db.insertRow(session, book);
      return bookInDatabase;
    }
    return book;
  }

  //-update

  Future<Book> updateBookTags(Session session, int isbn,
      {List<BookTag>? tags}) async {
    final book = await Book.db.findFirstRow(
      session,
      where: (t) => t.isbn.equals(isbn),
    );
    if (book == null) {
      throw Exception('Book with isbn $isbn does not exist.');
    }
    if (tags != null) {
      await BookTaggingHelper.updateBookWithTags(session, book, tags);
    }
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
    await Book.db.deleteRow(session, book);
    // QUESTION: Is this the right way to check if the book was deleted?

    return true;
  }
}
