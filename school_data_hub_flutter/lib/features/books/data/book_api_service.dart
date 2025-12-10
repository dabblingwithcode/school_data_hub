import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:watch_it/watch_it.dart';

class BookApiService {
  final _client = di<Client>();
  final _notificationService = di<NotificationService>();
  final _log = Logger('SchooldayEventApiService');

  // - BOOK TAGS - //

  Future<BookTag?> postBookTag(String name) async {
    final bookTag = BookTag(name: name);

    final bookTagInServer = await ClientHelper.apiCall(
      call: () => _client.bookTags.postBookTag(bookTag),
      errorMessage: 'Fehler beim Erstellen des Buchtags',
    );

    return bookTagInServer;
  }

  Future<List<BookTag>?> fetchBookTags() async {
    final bookTags = await ClientHelper.apiCall(
      call: () => _client.bookTags.fetchBookTags(),
      errorMessage: 'Fehler beim Laden der Buchtags',
    );

    return bookTags;
  }

  Future<BookTag?> updateBookTag(BookTag bookTag) async {
    final updatedBookTag = await ClientHelper.apiCall(
      call: () => _client.bookTags.updateBookTag(bookTag),
      errorMessage: 'Fehler beim Aktualisieren des Buchtags',
    );
    return updatedBookTag;
  }

  Future<bool?> deleteBookTag(BookTag bookTag) async {
    final success = await ClientHelper.apiCall(
      call: () => _client.bookTags.deleteBookTag(bookTag),
      errorMessage: 'Fehler beim Löschen des Buchtags',
    );
    return success;
  }

  // - BOOK LOCATIONS - //

  Future<LibraryBookLocation?> postBookLocation(
    LibraryBookLocation location,
  ) async {
    final bookLocationInServer = await ClientHelper.apiCall(
      call: () =>
          _client.libraryBookLocations.postLibraryBookLocation(location),
      errorMessage: 'Fehler beim Erstellen des Buchstandorts',
    );
    return bookLocationInServer;
  }

  Future<List<LibraryBookLocation>?> fetchBookLocations() async {
    final locations = await ClientHelper.apiCall(
      call: () => _client.libraryBookLocations.fetchLibraryBookLocations(),
      errorMessage: 'Fehler beim Laden der Buchstandorte',
    );
    return locations;
  }

  Future<bool?> deleteBookLocation(LibraryBookLocation location) async {
    final success = await ClientHelper.apiCall(
      call: () =>
          _client.libraryBookLocations.deleteLibraryBookLocation(location),
      errorMessage: 'Fehler beim Löschen des Buchstandorts',
    );
    return success;
  }

  // -BOOKS- //

  Future<Book?> fetchBookByIsbn(int isbn) async {
    final book = await ClientHelper.apiCall(
      call: () => _client.books.fetchBookByIsbn(isbn),
      errorMessage: 'Fehler beim Laden des Buches',
    );
    return book;
  }

  Future<LibraryBookStatsDto?> fetchBookStats() async {
    final stats = await ClientHelper.apiCall(
      call: () => _client.books.getBookStats(),
      errorMessage: 'Fehler beim Laden der Statistiken',
    );
    return stats;
  }

  Future<Book?> updateBookTags(int isbn, List<BookTag> tags) async {
    final updatedBook = await ClientHelper.apiCall(
      call: () => _client.books.updateBookTags(isbn, tags: tags),
      errorMessage: 'Fehler beim Aktualisieren der Buchtags',
    );
    return updatedBook;
  }

  Future<Book?> updateBookImage({required int isbn, required File file}) async {
    try {
      final documentId = isbn.toString();
      final path = p.posix.join('$documentId.jpg');
      String? uploadDescription;
      try {
        uploadDescription = await _client.files.getUploadDescription(
          StorageId.public.name,
          path,
        );
      } catch (e) {
        _notificationService.apiRunning(false);
        throw Exception('Failed to get upload description, $e');
      }

      if (uploadDescription != null) {
        _log.info('Upload description received for $path');
        _log.fine('Upload description: $uploadDescription');
        // Create an uploader
        final uploader = FileUploader(uploadDescription);

        // Upload the file
        final fileStream = file.openRead();

        final fileLength = await file.length();
        _log.info('File length: $fileLength');
        _notificationService.apiRunning(true);
        try {
          await uploader.upload(fileStream, fileLength);
        } catch (e) {
          _notificationService.apiRunning(false);
          _log.severe('Error while uploading file', e, StackTrace.current);

          throw Exception('Failed to upload file, $uploadDescription');
        }

        _notificationService.apiRunning(false);
        bool success = false;
        try {
          // Verify the upload
          success = await _client.files.verifyUpload('public', path);
        } catch (e) {
          _notificationService.apiRunning(false);
          throw Exception('Failed to verify upload, $e');
        }

        if (success) {
          try {
            final updatedSchooldayEvent = await _client.books.updateBookImage(
              isbn,
              path,
            );
            _notificationService.apiRunning(false);

            return updatedSchooldayEvent;
          } catch (e) {
            _notificationService.apiRunning(false);

            _log.severe(
              'Error while updating schoolday event file',
              e,
              StackTrace.current,
            );

            _notificationService.showSnackBar(
              NotificationType.error,
              'Das Dokument konnte nicht aktualisiert werden: ${e.toString()}',
            );

            throw Exception('Failed to update schoolday event file, $e');
          }
        } else {
          _notificationService.apiRunning(false);
          throw Exception('Failed to verify upload, $success');
        }
      } else {
        _notificationService.apiRunning(false);

        _log.severe('Error while uploading file', null, StackTrace.current);

        _notificationService.showSnackBar(
          NotificationType.error,
          'Das Ereignisdokument konnte nicht hochgeladen werden: ${uploadDescription.toString()}',
        );

        throw Exception('Failed to upload file, $uploadDescription');
      }
    } catch (e) {
      _notificationService.apiRunning(false);
      throw Exception('Failed to upload file, $e');
    }
    return null;
  }

  // - LIBRARY BOOKS - //

  Future<List<LibraryBook>?> fetchLibraryBooks() async {
    final libraryBooks = await ClientHelper.apiCall(
      call: () => _client.libraryBooks.fetchLibraryBooks(),
      errorMessage: 'Fehler beim Laden der Bibliotheksbücher',
    );
    return libraryBooks;
  }

  Future<LibraryBook?> fetchLibraryBookByIsbn(int isbn) async {
    final librarybook = await ClientHelper.apiCall(
      call: () => _client.libraryBooks.fetchLibraryBookByIsbn(isbn),
      errorMessage: 'Fehler beim Laden des Buches',
    );
    return librarybook!;
  }

  Future<LibraryBook?> postLibraryBook({
    required int isbn,
    required String bookId,
    required LibraryBookLocation location,
  }) async {
    final returnedLibraryBook = await ClientHelper.apiCall(
      call: () => _client.libraryBooks.postLibraryBook(isbn, bookId, location),
      errorMessage: 'Fehler beim Erstellen des Buches',
    );
    return returnedLibraryBook;
  }

  Future<LibraryBook?> updateLibraryBookAndRelatedBook({
    required int isbn,
    required String libraryId,
    bool? available,
    LibraryBookLocation? location,
    String? title,
    String? author,
    String? description,
    String? readingLevel,
    List<BookTag>? tags,
  }) async {
    final updatedLibraryBook = await ClientHelper.apiCall(
      call: () => _client.libraryBooks.updateLibraryBookAndRelatedBook(
        isbn,
        libraryId,
        available,
        location,
        title,
        author,
        description,
        readingLevel,
        tags,
      ),
      errorMessage: 'Fehler beim Aktualisieren des Buches',
    );
    return updatedLibraryBook;
  }

  //- post book image

  // Future<BookProxy> patchBookImage(File imageFile, int isbn) async {
  //   final encryptedFile = await customEncrypter.encryptFile(imageFile);

  //   String fileName = encryptedFile.path.split('/').last;

  //   var formData = FormData.fromMap({
  //     'file': await MultipartFile.fromFile(
  //       encryptedFile.path,
  //       filename: fileName,
  //     ),
  //   });

  //   _notificationService.apiRunning(true);
  //   final Response response = await _client.patch(
  //     '${_baseUrl()}$_patchBookWithImageUrl(bookId)',
  //     data: formData,
  //     options: _client.hubOptions,
  //   );
  //   _notificationService.apiRunning(false);

  //   // Handle errors.
  //   if (response.statusCode != 200) {
  //     _notificationService.showSnackBar(
  //         NotificationType.error, 'Fehler beim Hochladen des Bildes');

  //     throw ApiException('Failed to upload book image', response.statusCode);
  //   }

  //   final BookProxy book = BookProxy.fromJson(response.data);

  //   return book;
  // }

  // Future<File> getBookImage(int isbn) async {
  //   final options =
  //       _client.hubOptions.copyWith(responseType: ResponseType.bytes);

  //   _notificationService.apiRunning(true);

  //   final Response response = await _client
  //       .get('${_baseUrl()}${getBookImageUrl(isbn)}', options: options);
  //   _notificationService.apiRunning(false);

  //   if (response.statusCode != 200) {
  //     _notificationService.showSnackBar(
  //         NotificationType.error, 'Fehler beim Laden des Bildes');

  //     throw ApiException('Failed to fetch book image', response.statusCode);
  //   }

  //   final encryptedBytes = Uint8List.fromList(response.data!);
  //   final decryptedBytes = customEncrypter.decryptTheseBytes(encryptedBytes);

  //   final tempDir = await Directory.systemTemp.createTemp();
  //   final file = File('${tempDir.path}/$isbn.png');
  //   await file.writeAsBytes(decryptedBytes);

  //   return file;
  // }

  //- delete library book

  static String deleteLibraryBookUrl(String bookId) {
    return '/library_books/$bookId';
  }

  Future<bool?> deleteLibraryBook(int libraryBookId) async {
    final success = await ClientHelper.apiCall(
      call: () => _client.libraryBooks.deleteLibraryBook(libraryBookId),
      errorMessage: 'Fehler beim Löschen des Buches',
    );
    return success;
  }

  //- fetch library book by library id

  Future<LibraryBook?> fetchLibraryBookByLibraryId(String libraryId) async {
    final libraryBook = await ClientHelper.apiCall(
      call: () => _client.libraryBooks.fetchLibraryBookByLibraryId(libraryId),
      errorMessage: 'Fehler beim Laden des Buches',
    );

    return libraryBook;
  }

  Future<List<LibraryBook>?> searchBooks({
    String? title,
    String? author,
    String? keywords,
    LibraryBookLocation? location,
    List<BookTag>? tags,
    String? readingLevel,
    bool? available,
    required int page,
    required int perPage,
  }) async {
    final LibraryBookQuery query = LibraryBookQuery(
      title: title,
      author: author,
      keywords: keywords,
      location: location,
      tags: tags,
      readingLevel: readingLevel,
      borrowStatus: available,
      page: page,
      perPage: perPage,
    );

    final queriedLibraryBooks = await ClientHelper.apiCall(
      call: () => _client.libraryBooks.fetchLibraryBooksMatchingQuery(query),
      errorMessage: 'Fehler bei der Suche',
    );
    return queriedLibraryBooks;
  }
}
