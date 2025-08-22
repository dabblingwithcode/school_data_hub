import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:school_data_hub_server/src/schemas/pupil_schemas.dart';
import 'package:serverpod/serverpod.dart';

class LibraryBooksEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<LibraryBook> postLibraryBook(Session session, int isbn,
      String libraryId, LibraryBookLocation location) async {
    final libraryBookResponse =
        await session.db.transaction((transaction) async {
      final book = await Book.db.findFirstRow(
        session,
        where: (t) => t.isbn.equals(isbn),
        transaction: transaction,
      );
      final libraryBookLocation = await LibraryBookLocation.db.findFirstRow(
          session,
          where: (t) => t.location.equals(location.location),
          transaction: transaction);
      final libraryBook = LibraryBook(
        id: null,
        bookId: book!.id!,
        libraryId: libraryId,
        available: true,
        book: book,
        location: libraryBookLocation!,
        locationId: libraryBookLocation.id!,
      );

      final libraryBookInDatabase = await LibraryBook.db
          .insertRow(session, libraryBook, transaction: transaction);
      await LibraryBook.db.attachRow
          .book(session, libraryBookInDatabase, book, transaction: transaction);
      await LibraryBook.db.attachRow.location(
          session, libraryBookInDatabase, libraryBookLocation,
          transaction: transaction);

      final attachedLibraryBookInDatabase = await LibraryBook.db.findById(
          session, libraryBookInDatabase.id!,
          include: LibraryBookSchemas.allInclude, transaction: transaction);
      return attachedLibraryBookInDatabase;
    });

    return libraryBookResponse!;
  }

  //- read
  Future<List<LibraryBook>> fetchLibraryBooks(Session session) async {
    final libraryBooks = await LibraryBook.db.find(
      session,
      include: LibraryBookSchemas.allInclude,
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
      include: LibraryBookSchemas.allInclude,
    );
    return libraryBook;
  }

  Future<LibraryBook?> fetchLibraryBookByLibraryId(
    Session session,
    String libraryId,
  ) async {
    final libraryBook = await LibraryBook.db.findFirstRow(
      session,
      where: (t) => t.libraryId.equals(libraryId),
      include: LibraryBookSchemas.allInclude,
    );
    return libraryBook;
  }

  Future<List<LibraryBook>> fetchLibraryBooksMatchingQuery(
    Session session,
    LibraryBookQuery libraryBookQuery,
  ) async {
    var t = LibraryBook.t;
    Expression? query;

    // query title
    if (libraryBookQuery.title != null) {
      query = t.book.title.ilike('%${libraryBookQuery.title}%');
    }
    // query author
    if (libraryBookQuery.author != null) {
      query = (query == null)
          ? t.book.author.equals(libraryBookQuery.author)
          : query & t.book.author.equals(libraryBookQuery.author);
    }
    // query location
    if (libraryBookQuery.location != null) {
      query = (query == null)
          ? t.location.location.equals(libraryBookQuery.location!.location)
          : query &
              t.location.location.equals(libraryBookQuery.location!.location);
    }
    // query keywords
    if (libraryBookQuery.keywords != null) {
      query = (query == null)
          ? t.book.description.ilike('%${libraryBookQuery.keywords}%')
          : (query &
              t.book.description.ilike('%${libraryBookQuery.keywords}%'));
    }
    // query reading level
    if (libraryBookQuery.readingLevel != null) {
      query = (query == null)
          ? t.book.readingLevel.equals(libraryBookQuery.readingLevel)
          : (query & t.book.readingLevel.equals(libraryBookQuery.readingLevel));
    }
    // query tags
    if (libraryBookQuery.tags != null) {
      final tagIds = libraryBookQuery.tags!.map((tag) => tag.id!).toSet();
      query = (query == null)
          ? t.book.tags.any((tag) => tag.id.inSet(tagIds))
          : (query & t.book.tags.any((tag) => tag.id.inSet(tagIds)));
    }
    // query borrow status
    if (libraryBookQuery.borrowStatus != null) {
      query = (query == null)
          ? t.available.equals(libraryBookQuery.borrowStatus)
          : (query & t.available.equals(libraryBookQuery.borrowStatus));
    }

    final libraryBooks = await LibraryBook.db.find(
      session,
      where: (_) => query!,
      include: LibraryBookSchemas.allInclude,
      // limit: libraryBookQuery.perPage,
      // offset: libraryBookQuery.page * libraryBookQuery.perPage,
    );
    return libraryBooks;
  }

  //-update
  Future<LibraryBook> updateLibraryBook(
    Session session,
    int isbn,
    String libraryId,
    bool? available,
    LibraryBookLocation? location,
    String? title,
    String? author,
    String? description,
    String? readingLevel,
  ) async {
    await session.db.transaction((transaction) async {
      if (available != null || location != null) {
        final libraryBook = await LibraryBook.db.findFirstRow(
          session,
          where: (t) => t.libraryId.equals(libraryId),
          include: LibraryBookSchemas.allInclude,
          transaction: transaction,
        );
        if (libraryBook == null) {
          throw Exception('Library book with id $libraryId does not exist.');
        }
        if (available != null) {
          libraryBook.available = available;
        }
        if (location != null) {
          final libraryBookLocation = await LibraryBookLocation.db.findFirstRow(
              session,
              where: (t) => t.location.equals(location.location),
              transaction: transaction);
          if (libraryBookLocation == null) {
            throw Exception(
                'Library book location with id ${location.id} does not exist.');
          }
          libraryBook.location = libraryBookLocation;
          libraryBook.locationId = libraryBookLocation.id!;
          await LibraryBook.db.attachRow.location(
              session, libraryBook, libraryBookLocation,
              transaction: transaction);
        }
        await LibraryBook.db.updateRow(session, libraryBook);
      }
      // check if the book object needs to be updated
      if (title != null ||
          author != null ||
          description != null ||
          readingLevel != null) {
        final book = await Book.db.findFirstRow(
          session,
          where: (t) => t.isbn.equals(isbn),
          transaction: transaction,
        );
        if (book == null) {
          throw Exception('Book with isbn $isbn does not exist.');
        }
        if (title != null) {
          book.title = title;
        }
        if (author != null) {
          book.author = author;
        }
        if (description != null) {
          book.description = description;
        }
        if (readingLevel != null) {
          book.readingLevel = readingLevel;
        }

        await Book.db.updateRow(session, book, transaction: transaction);
      }

      // check if the library book needs to be updated

      final libraryBook = await LibraryBook.db.findFirstRow(
        session,
        where: (t) => t.libraryId.equals(libraryId),
        include: LibraryBookSchemas.allInclude,
        transaction: transaction,
      );
      if (libraryBook == null) {
        throw Exception('Library book with id $libraryId does not exist.');
      }
      libraryBook.available = available ?? libraryBook.available;

      // check if the location needs to be updated
      if (location != null) {
        final libraryBookLocation = await LibraryBookLocation.db.findFirstRow(
            session,
            where: (t) => t.location.equals(location.location),
            transaction: transaction);
        if (libraryBookLocation == null) {
          throw Exception(
              'Library book location with id ${location.id} does not exist.');
        }

        await LibraryBook.db.attachRow.location(
            session, libraryBook, libraryBookLocation,
            transaction: transaction);
      }

      if (available != null) {
        libraryBook.available = available;
      }

      await LibraryBook.db.updateRow(session, libraryBook);

      return libraryBook;
    });
    final updatedLibraryBook = await LibraryBook.db.findFirstRow(
      session,
      where: (t) => t.libraryId.equals(libraryId),
      include: LibraryBookSchemas.allInclude,
    );
    return updatedLibraryBook!;
  }

  //- delete
  Future<bool> deleteLibraryBook(Session session, int libraryBookId) async {
    // Check if the library book exists
    final libraryBook = await LibraryBook.db.findFirstRow(
      session,
      where: (t) => t.id.equals(libraryBookId),
    );
    if (libraryBook == null) {
      throw Exception('Library book with id $libraryBookId does not exist.');
    }
    await LibraryBook.db.deleteRow(session, libraryBook);
    return true;
  }
}
