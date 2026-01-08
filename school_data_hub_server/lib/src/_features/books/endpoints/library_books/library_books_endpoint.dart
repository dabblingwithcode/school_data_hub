import 'package:school_data_hub_server/src/_features/books/endpoints/books/book_tagging_helper.dart';
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
      if (book == null) {
        throw Exception('Book with ISBN $isbn not found.');
      }
      final libraryBookLocation = await LibraryBookLocation.db.findFirstRow(
          session,
          where: (t) => t.location.equals(location.location),
          transaction: transaction);
      if (libraryBookLocation == null) {
        throw Exception(
            'Library book location "${location.location}" not found.');
      }

      late LibraryBook libraryBookInDatabase;

      try {
        // Try to insert (optimistic case - no duplicate)
        final libraryBook = LibraryBook(
          id: null,
          bookId: book.id!,
          libraryId: libraryId,
          available: true,
          book: book,
          location: libraryBookLocation,
          locationId: libraryBookLocation.id!,
        );

        libraryBookInDatabase = await LibraryBook.db
            .insertRow(session, libraryBook, transaction: transaction);

        await LibraryBook.db.attachRow.book(
            session, libraryBookInDatabase, book,
            transaction: transaction);
        await LibraryBook.db.attachRow.location(
            session, libraryBookInDatabase, libraryBookLocation,
            transaction: transaction);
      } on DatabaseQueryException catch (e) {
        // Check if this is a duplicate key error (code 23505)
        if (e.toString().contains('23505') ||
            e.toString().contains('duplicate key')) {
          // Find the existing record with the same libraryId
          final existingRecord = await LibraryBook.db.findFirstRow(
            session,
            where: (t) => t.libraryId.equals(libraryId),
            transaction: transaction,
          );

          if (existingRecord != null) {
            // Update the existing record with new data
            final updatedLibraryBook = existingRecord.copyWith(
              bookId: book.id!,
              locationId: libraryBookLocation.id!,
              available: true,
            );

            libraryBookInDatabase = await LibraryBook.db.updateRow(
                session, updatedLibraryBook,
                transaction: transaction);

            // Update relations
            await LibraryBook.db.attachRow.book(
                session, libraryBookInDatabase, book,
                transaction: transaction);
            await LibraryBook.db.attachRow.location(
                session, libraryBookInDatabase, libraryBookLocation,
                transaction: transaction);
          } else {
            // If we can't find the existing record, rethrow the original error
            rethrow;
          }
        } else {
          // If it's not a duplicate key error, rethrow
          rethrow;
        }
      }

      if (libraryBookInDatabase.id == null) {
        throw Exception('Failed to create library book - no ID assigned.');
      }
      final attachedLibraryBookInDatabase = await LibraryBook.db.findById(
          session, libraryBookInDatabase.id!,
          include: LibraryBookSchemas.allInclude, transaction: transaction);
      if (attachedLibraryBookInDatabase == null) {
        throw Exception('Failed to retrieve created library book.');
      }
      return attachedLibraryBookInDatabase;
    });

    return libraryBookResponse;
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
          ? t.book.tags.any((tag) => tag.bookTagId.inSet(tagIds))
          : (query & t.book.tags.any((tag) => tag.bookTagId.inSet(tagIds)));
    }
    // query borrow status
    if (libraryBookQuery.borrowStatus != null) {
      query = (query == null)
          ? t.available.equals(libraryBookQuery.borrowStatus)
          : (query & t.available.equals(libraryBookQuery.borrowStatus));
    }

    final libraryBooks = await LibraryBook.db.find(
      session,
      where: query != null ? (_) => query! : null,
      include: LibraryBookSchemas.allInclude,
      // limit: libraryBookQuery.perPage,
      // offset: libraryBookQuery.page * libraryBookQuery.perPage,
    );
    return libraryBooks;
  }

  //-update
  Future<LibraryBook> updateLibraryBookAndRelatedBook(
    Session session,
    int isbn,
    String libraryId,
    bool? available,
    LibraryBookLocation? location,
    String? title,
    String? author,
    String? description,
    String? readingLevel,
    List<BookTag>? tags,
  ) async {
    await session.db.transaction((transaction) async {
      final libraryBook = await LibraryBook.db.findFirstRow(
        session,
        where: (t) => t.libraryId.equals(libraryId),
        include: LibraryBookSchemas.allInclude,
        transaction: transaction,
      );
      if (libraryBook == null) {
        throw Exception('Library book with id $libraryId does not exist.');
      }
      // We have the library book
      // update the available status if needed
      if (available != null) {
        libraryBook.available = available;
      }

      // update the location if needed
      if (location != null) {
        final libraryBookLocation = await LibraryBookLocation.db.findFirstRow(
            session,
            where: (t) => t.location.equals(location.location),
            transaction: transaction);
        if (libraryBookLocation == null) {
          throw Exception(
              'Library book location with id ${location.id} does not exist.');
        }
        libraryBook.locationId = libraryBookLocation.id!;
        libraryBook.location = libraryBookLocation;

        await LibraryBook.db.attachRow.location(
            session, libraryBook, libraryBookLocation,
            transaction: transaction);
      }

      await LibraryBook.db
          .updateRow(session, libraryBook, transaction: transaction);

      // check if the book object needs to be updated
      if (title != null ||
          author != null ||
          description != null ||
          readingLevel != null ||
          tags != null) {
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
        if (tags != null) {
          final bookWithTags = await BookTaggingHelper.updateBookWithTags(
              session, book, tags,
              transaction: transaction);
          book.tags = bookWithTags.tags;
        }
        await Book.db.updateRow(session, book, transaction: transaction);
      }
    });
    final updatedLibraryBook = await LibraryBook.db.findFirstRow(
      session,
      where: (t) => t.libraryId.equals(libraryId),
      include: LibraryBookSchemas.allInclude,
    );
    if (updatedLibraryBook == null) {
      throw Exception(
          'Library book with id $libraryId not found after update.');
    }
    return updatedLibraryBook;
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
