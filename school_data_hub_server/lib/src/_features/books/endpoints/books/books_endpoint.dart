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

      if (isbnApiData == null) {
        throw Exception('Book with isbn $isbn does not exist.');
      }
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

  Future<Book> updateBook(Session session, Book book) async {
    final updatedBook = await Book.db.updateRow(session, book);
    return updatedBook;
  }

  Future<Book> updateBookTags(
      Session session, Book book, List<BookTag> tags) async {
    await session.db.transaction((transaction) async {
      // 2. Insert or update tags, collect their IDs
      List<BookTag> updatedTags = [];
      for (var tag in tags) {
        if (tag.id == null) {
          updatedTags.add(await BookTag.db
              .insertRow(session, tag, transaction: transaction));
        } else {
          updatedTags.add(await BookTag.db
              .updateRow(session, tag, transaction: transaction));
        }
      }

      // 3. Remove existing taggings for this book
      await BookTagging.db.deleteWhere(
        session,
        where: (t) => t.bookId.equals(book.id),
        transaction: transaction,
      );

      // 4. Insert new taggings
      var newTaggings = updatedTags.map((tag) {
        return BookTagging(
          bookId: book.id!,
          bookTagId: tag.id!,
        );
      }).toList();

      await BookTagging.db
          .insert(session, newTaggings, transaction: transaction);
    });
    // return the updated book
    final updatedBook = await Book.db.findFirstRow(
      session,
      where: (t) => t.id.equals(book.id),
      include: Book.include(tags: BookTagging.includeList()),
    );

    return updatedBook!;
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
