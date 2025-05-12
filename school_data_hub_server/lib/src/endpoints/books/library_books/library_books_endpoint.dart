import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class LibraryBooksEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<LibraryBook> postLibraryBook(
      Session session, LibraryBook libraryBook) async {
    final libraryBookInDatabase =
        await LibraryBook.db.insertRow(session, libraryBook);
    return libraryBookInDatabase;
  }

  //- read
  Future<List<LibraryBook>> fetchLibraryBooks(Session session) async {
    final libraryBooks = await LibraryBook.db.find(
      session,
    );
    return libraryBooks;
  }

  Future<LibraryBook?> fetchLibraryBookByIsbn(
    Session session,
    int isbn,
  ) async {
    final libraryBook = await LibraryBook.db.findFirstRow(
      session,
      where: (t) => t.book.isbn.equals(isbn),
    );
    return libraryBook;
  }

  Future<List<LibraryBook>> fetchLibraryBooksMatchingQuery(
    Session session,
    LibraryBookQuery libraryBookQuery,
  ) async {
    Expression? whereClause;

    final libraryBooks = await LibraryBook.db.find(
      session,
      where: (t) {
        Expression? whereClause;
        // query title
        if (libraryBookQuery.title != null) {
          whereClause = t.book.title.equals(libraryBookQuery.title);
        }
        // query author
        if (libraryBookQuery.author != null) {
          whereClause = (whereClause == null)
              ? t.book.author.equals(libraryBookQuery.author)
              : whereClause & t.book.author.equals(libraryBookQuery.author);
        }
        // query location
        if (libraryBookQuery.location != null) {
          whereClause = (whereClause == null)
              ? t.location.location.equals(libraryBookQuery.location!.location)
              : whereClause &
                  t.location.location
                      .equals(libraryBookQuery.location!.location);
        }
        // query keywords
        if (libraryBookQuery.keywords != null) {
          whereClause = (whereClause == null)
              ? t.book.description.ilike('%${libraryBookQuery.keywords}%')
              : whereClause &
                  t.book.description.ilike('%${libraryBookQuery.keywords}%');
        }
        // query reading level
        if (libraryBookQuery.readingLevel != null) {
          whereClause = (whereClause == null)
              ? t.book.readingLevel.equals(libraryBookQuery.readingLevel)
              : whereClause &
                  t.book.readingLevel.equals(libraryBookQuery.readingLevel);
        }
        // query tags
        if (libraryBookQuery.tags != null) {
          final tagIds = libraryBookQuery.tags!.map((tag) => tag.id!).toSet();
          whereClause = (whereClause == null)
              ? t.book.tags.any((tag) => tag.id.inSet(tagIds))
              : whereClause & t.book.tags.any((tag) => tag.id.inSet(tagIds));
        }
        // query borrow status
        if (libraryBookQuery.borrowStatus != null) {
          whereClause = (whereClause == null)
              ? t.available.equals(libraryBookQuery.borrowStatus)
              : whereClause & t.available.equals(libraryBookQuery.borrowStatus);
        }
        return whereClause!;
      },
      limit: libraryBookQuery.perPage,
      offset: libraryBookQuery.page * libraryBookQuery.perPage,
    );
    return libraryBooks;
  }

  //-update
  Future<LibraryBook> updateLibraryBook(
      Session session, LibraryBook libraryBook) async {
    final updatedLibraryBook =
        await LibraryBook.db.updateRow(session, libraryBook);
    return updatedLibraryBook;
  }

  //- delete
  Future<bool> deleteLibraryBook(Session session, int id) async {
    // Check if the library book exists
    final libraryBook = await LibraryBook.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id),
    );
    if (libraryBook == null) {
      throw Exception('Library book with id $id does not exist.');
    }
    final deleted = await LibraryBook.db.deleteRow(session, libraryBook);
    return true;
  }
}
