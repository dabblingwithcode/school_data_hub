import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/books/data/book_api_service.dart';
import 'package:school_data_hub_flutter/features/books/data/pupil_book_api_service.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/book_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

final _pupilBookApiService = PupilBookApiService();

final _bookApiService = BookApiService();

final _notificationService = di<NotificationService>();

final _pupilManager = di<PupilManager>();

class BookManager {
  final _books = ValueNotifier<List<BookProxy>>([]);
  ValueListenable<List<BookProxy>> get books => _books;

  final _isbnBooks = ValueNotifier<Map<int, List<BookProxy>>>({});
  ValueListenable<Map<int, List<BookProxy>>> get booksByIsbn => _isbnBooks;

  final _locations = ValueNotifier<List<String>>([]);
  ValueListenable<List<String>> get locations => _locations;

  final _bookTags = ValueNotifier<List<BookTag>>([]);
  ValueListenable<List<BookTag>> get bookTags => _bookTags;

  List<BookTag> selectedTags = []; // Liste für ausgewählte Buch-Tags

  final _lastSelectedLocation = ValueNotifier<String>('Bitte auswählen');
  ValueListenable<String> get lastLocationValue => _lastSelectedLocation;

  final searchResults = ValueNotifier<List<BookProxy>>([]);

  BookManager();

//  final session = di<ServerpodSessionManager>().credentials.value;

  int _currentPage = 1;
  final int _perPage = 30;
  bool _isLoadingMore = false;
  bool _hasMorePages = true;

  bool get hasMorePages => _hasMorePages;

  bool get isLoadingMore => _isLoadingMore;

  Future<BookManager> init() async {
    // await getLibraryBooks();
    await getLocations();
    await getBookTags();

    return this;
  }

  void clearData() {
    _books.value = [];
    _locations.value = [];
    _bookTags.value = [];
    _lastSelectedLocation.value = 'Bitte auswählen';
  }

  void _refreshIsbnBooksMap() {
    final Map<int, List<BookProxy>> isbnBooks = <int, List<BookProxy>>{};
    for (final book in _books.value) {
      if (isbnBooks.containsKey(book.isbn)) {
        isbnBooks[book.isbn]!.add(book);
      } else {
        isbnBooks[book.isbn] = [book];
      }
    }
    _isbnBooks.value = isbnBooks;
  }

  //- BOOK TAGS

  Future<void> getBookTags() async {
    final List<BookTag> responseTags = await _bookApiService.getBookTags();
    _bookTags.value = responseTags;
  }

  Future<void> addBookTag(String tag) async {
    final List<BookTag> responseTags = await _bookApiService.postBookTag(tag);
    _bookTags.value = responseTags;
  }

  Future<void> deleteBookTag(String tag) async {
    final List<BookTag> responseTags = await _bookApiService.deleteBookTag(tag);
    _bookTags.value = responseTags;
  }

  //- BOOK LOCATIONS

  Future<void> getLocations() async {
    final List<String> responseLocations =
        await _bookApiService.getBookLocations();
    _locations.value = responseLocations;
  }

  Future<void> addLocation(String location) async {
    final List<String> responseLocations =
        await _bookApiService.postBookLocation(location);
    _locations.value = responseLocations;
  }

  Future<void> deleteLocation(String location) async {
    final List<String> responseLocations =
        await _bookApiService.deleteBookLocation(location);
    _locations.value = responseLocations;
  }

  void setLastLocationValue(String location) {
    _lastSelectedLocation.value = location;
  }

  //- LIBRARY BOOKS

  Future<void> getLibraryBooks() async {
    final List<BookProxy> responseBooks =
        await _bookApiService.getLibraryBooks();

    if (responseBooks.isNotEmpty) {
      responseBooks.sort((a, b) => a.title.compareTo(b.title));
      _books.value = responseBooks;
    }
    _refreshIsbnBooksMap();
    _notificationService.showSnackBar(
        NotificationType.success, 'Bücher erfolgreich geladen');
  }

  Future<void> postLibraryBook({
    required int isbn,
    required String bookId,
    required String location,
  }) async {
    final BookProxy responseBook = await _bookApiService.postLibraryBook(
      isbn: isbn,
      bookId: bookId,
      location: location,
    );

    _books.value = [..._books.value, responseBook];

    _notificationService.showSnackBar(
        NotificationType.success, 'Arbeitsheft erfolgreich erstellt');
  }

  Future<void> updateBookProperty({
    required int isbn,
    String? title,
    String? author,
    String? description,
    String? readingLevel,
    List<BookTag>? tags,
  }) async {
    final BookProxy updatedbook = await _bookApiService.patchBookData(
      isbn: isbn,
      title: title,
      author: author,
      description: description,
      readingLevel: readingLevel,
      bookTags: tags,
    );

    List<BookProxy> books = List.from(_books.value);
    int index = books.indexWhere((item) => item.bookId == updatedbook.bookId);
    books[index] = updatedbook;
    _books.value = books;

    _notificationService.showSnackBar(
        NotificationType.success, 'Arbeitsheft erfolgreich aktualisiert');
  }

  Future<void> patchBookImage(File imageFile, int isbn) async {
    final BookProxy responsebook =
        await _bookApiService.patchBookImage(imageFile, isbn);

    updateBookStateWithResponse(responsebook);

    _notificationService.showSnackBar(
        NotificationType.success, 'Bild erfolgreich hochgeladen');
  }

  Future<void> deleteLibraryBook(String bookId) async {
    final bool success = await _bookApiService.deleteLibraryBook(bookId);

    if (success) {
      List<BookProxy> books = List.from(_books.value);
      books.removeWhere((item) => item.bookId == bookId);
      _books.value = books;
      _notificationService.showSnackBar(
          NotificationType.success, 'Arbeitsheft erfolgreich gelöscht');
    }
  }

  //- PUPIL BOOKS

  List<BookProxy> getLibraryBooksByIsbn(int isbn) {
    List<BookProxy> books = [];
    for (BookProxy book in _books.value) {
      if (book.isbn == isbn) {
        books.add(book);
      }
    }
    return books;
  }

  //- helper function
  BookProxy? getLibraryBookByBookId(int? bookId) {
    if (bookId == null) return null;
    return _books.value.firstWhereOrNull((element) => element.bookId == bookId);
  }

  //- helper function
  void updateBookStateWithResponse(BookProxy book) {
    List<BookProxy> books = List.from(_books.value);
    int index = books.indexWhere((item) => item.bookId == book.bookId);
    books[index] = book;
    _books.value = books;
  }

  Future<void> searchBooks({
    String? title,
    String? author,
    String? keywords,
    String? location,
    String? readingLevel,
    String? borrowStatus,
  }) async {
    _currentPage = 1;
    _isLoadingMore = false;
    _hasMorePages = true;
    try {
      final List<BookProxy> results = await _bookApiService.searchBooks(
        title: title?.isNotEmpty == true ? title : null,
        author: author?.isNotEmpty == true ? author : null,
        keywords: keywords?.isNotEmpty == true ? keywords : null,
        location: location?.isNotEmpty == true ? location : null,
        readingLevel: readingLevel?.isNotEmpty == true ? readingLevel : null,
        borrowStatus: borrowStatus?.isNotEmpty == true ? borrowStatus : null,
        page: _currentPage,
        perPage: _perPage,
      );
      searchResults.value = results;
      _notificationService.showSnackBar(
          NotificationType.success, 'Suchergebnisse aktualisiert');
    } catch (e, s) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler bei der Suche: $e');
    }
  }

  Future<void> loadNextPage({
    String? title,
    String? author,
    String? keywords,
    String? location,
    String? readingLevel,
    String? borrowStatus,
  }) async {
    if (_isLoadingMore) return;
    if (!_hasMorePages) return;
    _isLoadingMore = true;

    try {
      _currentPage++;

      final newPageResults = await _bookApiService.searchBooks(
        title: title?.isNotEmpty == true ? title : null,
        author: author?.isNotEmpty == true ? author : null,
        keywords: keywords?.isNotEmpty == true ? keywords : null,
        location: location?.isNotEmpty == true ? location : null,
        readingLevel: readingLevel?.isNotEmpty == true ? readingLevel : null,
        borrowStatus: borrowStatus?.isNotEmpty == true ? borrowStatus : null,
        page: _currentPage,
        perPage: _perPage,
      );

      if (newPageResults.isEmpty) {
        _hasMorePages = false;
      } else {
        final List<BookProxy> oldList = searchResults.value;
        searchResults.value = [...oldList, ...newPageResults];
        if (newPageResults.length < _perPage) {
          _hasMorePages = false;
        }
      }
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Laden weiterer Ergebnisse: $e',
      );
    } finally {
      _isLoadingMore = false;
    }
  }
}
