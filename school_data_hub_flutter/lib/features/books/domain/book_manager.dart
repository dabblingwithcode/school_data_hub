import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/books/data/book_api_service.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:watch_it/watch_it.dart';

final _bookApiService = BookApiService();

final _notificationService = di<NotificationService>();

class BookManager {
  final _libraryBookProxies = ValueNotifier<List<LibraryBookProxy>>([]);
  ValueListenable<List<LibraryBookProxy>> get libraryBookProxies =>
      _libraryBookProxies;

  final _isbnLibraryBooksMap =
      ValueNotifier<Map<int, List<LibraryBookProxy>>>({});
  ValueListenable<Map<int, List<LibraryBookProxy>>> get isbnLibraryBooksMap =>
      _isbnLibraryBooksMap;

  final _locations = ValueNotifier<List<LibraryBookLocation>>([]);
  ValueListenable<List<LibraryBookLocation>> get locations => _locations;

  final _bookTags = ValueNotifier<List<BookTag>>([]);
  ValueListenable<List<BookTag>> get bookTags => _bookTags;

  List<BookTag> selectedTags = []; // Liste für ausgewählte Buch-Tags

  final _lastSelectedLocation = ValueNotifier<LibraryBookLocation>(
    LibraryBookLocation(
      location: 'Bitte auswählen',
    ),
  );
  ValueListenable<LibraryBookLocation> get lastLocationValue =>
      _lastSelectedLocation;

  ValueListenable<List<LibraryBookProxy>> get searchResults => _searchResults;
  final _searchResults = ValueNotifier<List<LibraryBookProxy>>([]);

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
    await fetchLocations();
    await fetchBookTags();

    return this;
  }

  void clearData() {
    _libraryBookProxies.value = [];
    _locations.value = [];
    _bookTags.value = [];
    _lastSelectedLocation.value = LibraryBookLocation(
      location: 'Bitte auswählen',
    );
  }

  // - manage collections

  void _refreshLibraryBookProxyCollection(
    List<LibraryBook> libraryBooks,
  ) {
    final List<LibraryBookProxy> libraryBookProxies = [];
    for (LibraryBook libraryBook in libraryBooks) {
      LibraryBookProxy libraryBookProxy =
          LibraryBookProxy(librarybook: libraryBook);
      // 1. Add the libraryBookProxy to the collection
      libraryBookProxies.add(libraryBookProxy);
      // 2. Add the libraryBookProxy to the isbnLibraryBooksMap
      if (_isbnLibraryBooksMap.value.containsKey(libraryBook.book!.isbn)) {
        _isbnLibraryBooksMap.value[libraryBook.book!.isbn]!
            .add(libraryBookProxy);
      } else {
        _isbnLibraryBooksMap.value[libraryBook.book!.isbn] = [libraryBookProxy];
      }
    }
    // 3. Sort the collection
    libraryBookProxies.sort((a, b) => a.title.compareTo(b.title));
    // 4. Update the libraryBookProxies value
    _libraryBookProxies.value = libraryBookProxies;
  }

  void _addLibraryBookProxyToCollection(LibraryBook libraryBook) {
    final LibraryBookProxy libraryBookProxy =
        LibraryBookProxy(librarybook: libraryBook);
    final List<LibraryBookProxy> libraryBookProxies =
        _libraryBookProxies.value.toList();
    libraryBookProxies.add(libraryBookProxy);
    _libraryBookProxies.value = libraryBookProxies;
    _isbnLibraryBooksMap.value[libraryBook.book!.isbn] = libraryBookProxies;
  }

  void _updateLibraryBookProxyInCollection(
    LibraryBook libraryBook,
  ) {
    final LibraryBookProxy libraryBookProxy =
        LibraryBookProxy(librarybook: libraryBook);
    final List<LibraryBookProxy> libraryBookProxies =
        _libraryBookProxies.value.toList();
    int index = libraryBookProxies.indexWhere(
      (item) => item.libraryId == libraryBookProxy.libraryId,
    );
    if (index != -1) {
      libraryBookProxies[index] = libraryBookProxy;
      _libraryBookProxies.value = libraryBookProxies;
    }
    // Update the isbnLibraryBooksMap
    if (_isbnLibraryBooksMap.value.containsKey(libraryBook.book!.isbn)) {
      _isbnLibraryBooksMap.value[libraryBook.book!.isbn] = libraryBookProxies;
    } else {
      _isbnLibraryBooksMap.value[libraryBook.book!.isbn] = [libraryBookProxy];
    }
  }

  void _removeLibraryBookProxyFromCollection(
      LibraryBookProxy libraryBookProxy) {
    final List<LibraryBookProxy> libraryBookProxies =
        _libraryBookProxies.value.toList();
    libraryBookProxies
        .removeWhere((p) => p.libraryId == libraryBookProxy.libraryId);
    _libraryBookProxies.value = libraryBookProxies;
    // Remove from the isbnLibraryBooksMap
    final isbnLibraryBookProxyList =
        _isbnLibraryBooksMap.value[libraryBookProxy.isbn];
    if (isbnLibraryBookProxyList != null) {
      isbnLibraryBookProxyList.removeWhere(
        (p) => p.libraryId == libraryBookProxy.libraryId,
      );
      if (isbnLibraryBookProxyList.isEmpty) {
        _isbnLibraryBooksMap.value.remove(libraryBookProxy.isbn);
      } else {
        _isbnLibraryBooksMap.value[libraryBookProxy.isbn] =
            isbnLibraryBookProxyList;
      }
    }
  }

  //- get functions

  LibraryBookProxy? getLibraryBookByLibraryBookId(int? libraryBookId) {
    if (libraryBookId == null) return null;
    return _libraryBookProxies.value
        .firstWhereOrNull((element) => element.libraryBookId == libraryBookId);
  }

  List<LibraryBookProxy> getLibraryBooksByIsbn(int isbn) {
    return _isbnLibraryBooksMap.value[isbn] ?? [];
  }

  //- Repository calls

  //- BOOK TAGS

  Future<void> fetchBookTags() async {
    final List<BookTag> responseTags = await _bookApiService.fetchBookTags();
    _bookTags.value = responseTags;
  }

  Future<void> postBookTag(String tag) async {
    final BookTag responseTag = await _bookApiService.postBookTag(tag);
    _bookTags.value = [..._bookTags.value, responseTag];
  }

  Future<void> deleteBookTag(BookTag tag) async {
    final success = await _bookApiService.deleteBookTag(tag);
    if (success) {
      _bookTags.value = _bookTags.value.where((t) => t != tag).toList();
    }
  }

  //- BOOK LOCATIONS

  Future<void> fetchLocations() async {
    final List<LibraryBookLocation> responseLocations =
        await _bookApiService.fetchBookLocations();
    _locations.value = responseLocations;
  }

  Future<void> postLocation(String locationName) async {
    final newLocation = LibraryBookLocation(
      location: locationName,
    );
    final LibraryBookLocation responseLocation =
        await _bookApiService.postBookLocation(newLocation);
    _locations.value = [
      ..._locations.value,
      responseLocation
    ]; // Add the new location
  }

  Future<void> deleteLocation(LibraryBookLocation location) async {
    final bool success = await _bookApiService.deleteBookLocation(location);
    if (success) {
      _locations.value = _locations.value
          .where((loc) => loc.location != location.location)
          .toList();
    }
  }

  void setLastLocationValue(LibraryBookLocation location) {
    _lastSelectedLocation.value = location;
  }

  //- LIBRARY BOOKS

  Future<void> fetchLibraryBooks() async {
    final List<LibraryBook> responseBooks =
        await _bookApiService.fetchLibraryBooks();

    _refreshLibraryBookProxyCollection(responseBooks);

    _notificationService.showSnackBar(
        NotificationType.success, 'Bücher erfolgreich geladen');
  }

  Future<void> postLibraryBook({
    required int isbn,
    required String libraryId,
    required LibraryBookLocation location,
  }) async {
    final LibraryBook responseBook = await _bookApiService.postLibraryBook(
      isbn: isbn,
      bookId: libraryId,
      location: location,
    );
    _addLibraryBookProxyToCollection(responseBook);

    _notificationService.showSnackBar(
        NotificationType.success, 'Arbeitsheft erfolgreich erstellt');
  }

  Future<void> updateBookProperty({
    required int isbn,
    required String libraryId,
    String? title,
    String? author,
    String? description,
    String? readingLevel,
  }) async {
    final LibraryBook updatedbook =
        await _bookApiService.updateLibraryBookOrBook(
      isbn: isbn,
      libraryId: libraryId,
      title: title,
      author: author,
      description: description,
      readingLevel: readingLevel,
    );

    _updateLibraryBookProxyInCollection(updatedbook);

    _notificationService.showSnackBar(
        NotificationType.success, 'Arbeitsheft erfolgreich aktualisiert');
  }

  // Future<void> patchBookImage(File imageFile, int isbn) async {
  //   final LibraryBookProxy responsebook =
  //       await _bookApiService.patchBookImage(imageFile, isbn);

  //   updateBookStateWithResponse(responsebook);

  //   _notificationService.showSnackBar(
  //       NotificationType.success, 'Bild erfolgreich hochgeladen');
  // }

  Future<void> deleteLibraryBook(LibraryBookProxy libraryBookProxy) async {
    final bool success =
        await _bookApiService.deleteLibraryBook(libraryBookProxy.libraryBookId);

    if (success) {
      _removeLibraryBookProxyFromCollection(libraryBookProxy);
    }
  }

  Future<void> searchBooks({
    String? title,
    String? author,
    String? keywords,
    LibraryBookLocation? location,
    String? readingLevel,
    bool? available,
  }) async {
    _currentPage = 1;
    _isLoadingMore = false;
    _hasMorePages = true;
    try {
      final List<LibraryBook> results = await _bookApiService.searchBooks(
        title: title?.isNotEmpty == true ? title : null,
        author: author?.isNotEmpty == true ? author : null,
        keywords: keywords?.isNotEmpty == true ? keywords : null,
        location: location ?? null,
        readingLevel: readingLevel?.isNotEmpty == true ? readingLevel : null,
        available: available ?? null,
        page: _currentPage,
        perPage: _perPage,
      );
      final searchResults = <LibraryBookProxy>[];
      for (final result in results) {
        final LibraryBookProxy libraryBookProxy =
            LibraryBookProxy(librarybook: result);
        searchResults.add(libraryBookProxy);
      }
      _searchResults.value = searchResults;

      _notificationService.showSnackBar(
          NotificationType.success, 'Suchergebnisse aktualisiert');
    } catch (e) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler bei der Suche: $e');
    }
  }

  Future<void> loadNextPage({
    String? title,
    String? author,
    String? keywords,
    LibraryBookLocation? location,
    String? readingLevel,
    bool? available,
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
        location: location ?? null,
        readingLevel: readingLevel?.isNotEmpty == true ? readingLevel : null,
        available: available ?? null,
        page: _currentPage,
        perPage: _perPage,
      );

      if (newPageResults.isEmpty) {
        _hasMorePages = false;
      } else {
        final List<LibraryBookProxy> searchResultsToUpdate =
            searchResults.value;
        for (final result in newPageResults) {
          final LibraryBookProxy libraryBookProxy =
              LibraryBookProxy(librarybook: result);
          searchResultsToUpdate.add(libraryBookProxy);
        }
        _searchResults.value = [...searchResultsToUpdate];
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
