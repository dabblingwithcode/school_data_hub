import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/books/data/book_api_service.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:watch_it/watch_it.dart';

class BookManager {
  final _bookApiService = BookApiService();

  final _notificationService = di<NotificationService>();

  final _libraryBookProxies = ValueNotifier<List<LibraryBookProxy>>([]);
  ValueListenable<List<LibraryBookProxy>> get libraryBookProxies =>
      _libraryBookProxies;

  final _isbnLibraryBooksMap = ValueNotifier<Map<int, List<LibraryBookProxy>>>(
    {},
  );
  ValueListenable<Map<int, List<LibraryBookProxy>>> get isbnLibraryBooksMap =>
      _isbnLibraryBooksMap;

  final _locations = ValueNotifier<List<LibraryBookLocation>>([]);
  ValueListenable<List<LibraryBookLocation>> get locations => _locations;

  final _bookTags = ValueNotifier<List<BookTag>>([]);
  ValueListenable<List<BookTag>> get bookTags => _bookTags;

  List<BookTag> selectedTags = []; // Liste für ausgewählte Buch-Tags

  final _lastSelectedLocation = ValueNotifier<LibraryBookLocation>(
    LibraryBookLocation(location: 'Bitte auswählen'),
  );
  ValueListenable<LibraryBookLocation> get lastLocationValue =>
      _lastSelectedLocation;

  ValueListenable<List<LibraryBookProxy>> get searchResults => _searchResults;
  final _searchResults = ValueNotifier<List<LibraryBookProxy>>([]);

  final _bookStats = ValueNotifier<LibraryBookStatsDto?>(null);
  ValueListenable<LibraryBookStatsDto?> get bookStats => _bookStats;

  BookManager();

  void dispose() {
    _libraryBookProxies.dispose();
    _isbnLibraryBooksMap.dispose();
    _locations.dispose();
    _bookTags.dispose();
    _lastSelectedLocation.dispose();
    _searchResults.dispose();
    _bookStats.dispose();

    return;
  }
  //  final session = di<HubSessionManager>().credentials.value;

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
    await fetchLibraryBooks();
    await fetchBookStats();

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

  void _refreshLibraryBookProxyCollections(List<LibraryBook> libraryBooks) {
    final List<LibraryBookProxy> libraryBookProxies = [];
    for (LibraryBook libraryBook in libraryBooks) {
      LibraryBookProxy libraryBookProxy = LibraryBookProxy(
        librarybook: libraryBook,
      );
      // 1. Add the libraryBookProxy to the collection

      libraryBookProxies.add(libraryBookProxy);
      // 2. Add the libraryBookProxy to the isbnLibraryBooksMap
      if (_isbnLibraryBooksMap.value.containsKey(libraryBook.book!.isbn)) {
        // Check if the libraryBookProxy already exists in the list
        final existingLibraryBookProxy = _isbnLibraryBooksMap
            .value[libraryBook.book!.isbn]!
            .where((p) => p.libraryId == libraryBookProxy.libraryId);
        if (existingLibraryBookProxy.isNotEmpty) {
          // If it exists, remove it from the list
          _isbnLibraryBooksMap.value[libraryBook.book!.isbn]!.removeWhere(
            (p) => p.libraryId == libraryBookProxy.libraryId,
          );
        }
        // Add the new libraryBookProxy to the list
        _isbnLibraryBooksMap.value[libraryBook.book!.isbn]!.add(
          libraryBookProxy,
        );
      } else {
        _isbnLibraryBooksMap.value[libraryBook.book!.isbn] = [libraryBookProxy];
      }
    }
    // 3. Sort the collection
    libraryBookProxies.sort((a, b) => a.title.compareTo(b.title));
    // 4. Update the libraryBookProxies value
    _libraryBookProxies.value = libraryBookProxies;
  }

  void _addLibraryBookProxyToCollections(LibraryBook libraryBook) {
    final LibraryBookProxy libraryBookProxy = LibraryBookProxy(
      librarybook: libraryBook,
    );
    final List<LibraryBookProxy> libraryBookProxies = _libraryBookProxies.value
        .toList();
    libraryBookProxies.add(libraryBookProxy);
    _libraryBookProxies.value = libraryBookProxies;
    _isbnLibraryBooksMap.value[libraryBook.book!.isbn] = libraryBookProxies;
  }

  void _updateLibraryBookProxyInCollections(LibraryBook libraryBook) {
    final LibraryBookProxy libraryBookProxy = LibraryBookProxy(
      librarybook: libraryBook,
    );
    final List<LibraryBookProxy> libraryBookProxies = _libraryBookProxies.value
        .toList();
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
    LibraryBookProxy libraryBookProxy,
  ) {
    final List<LibraryBookProxy> libraryBookProxies = _libraryBookProxies.value
        .toList();
    libraryBookProxies.removeWhere(
      (p) => p.libraryId == libraryBookProxy.libraryId,
    );
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

  Future<void> fetchBookStats() async {
    final stats = await _bookApiService.fetchBookStats();
    if (stats != null) {
      _bookStats.value = stats;
    }
  }

  LibraryBookProxy? getLibraryBookById(int? libraryBookId) {
    if (libraryBookId == null) return null;
    return _libraryBookProxies.value.firstWhereOrNull(
      (element) => element.id == libraryBookId,
    );
  }

  List<LibraryBookProxy> getLibraryBooksByIsbn(int isbn) {
    return _isbnLibraryBooksMap.value[isbn] ?? [];
  }

  LibraryBookProxy? getLibraryBookByLibraryId(int id) {
    return _libraryBookProxies.value.firstWhereOrNull(
      (element) => element.id == id,
    );
  }

  //- Repository calls

  //- BOOK TAGS

  Future<void> fetchBookTags() async {
    final List<BookTag>? responseTags = await _bookApiService.fetchBookTags();
    if (responseTags == null) {
      return;
    }
    responseTags.sort((a, b) => a.name.compareTo(b.name));
    _bookTags.value = responseTags;
  }

  Future<void> postBookTag(String tag) async {
    final BookTag? responseTag = await _bookApiService.postBookTag(tag);
    if (responseTag == null) {
      return;
    }

    _bookTags.value = [
      ..._bookTags.value,
      responseTag,
    ].sorted((a, b) => a.name.compareTo(b.name));
  }

  Future<void> updateBookTag(BookTag tag) async {
    final BookTag? updatedTag = await _bookApiService.updateBookTag(tag);
    if (updatedTag == null) {
      return;
    }
    final List<BookTag> updatedTags = _bookTags.value.toList();
    final index = updatedTags.indexWhere((t) => t.id == tag.id);
    if (index != -1) {
      updatedTags[index] = updatedTag;
      _bookTags.value = updatedTags.sorted((a, b) => a.name.compareTo(b.name));
    }
  }

  Future<void> deleteBookTag(BookTag tag) async {
    final success = await _bookApiService.deleteBookTag(tag);
    if (success == null) {
      return;
    }
    _bookTags.value = _bookTags.value.where((t) => t != tag).toList();
  }

  //- BOOK LOCATIONS

  Future<void> fetchLocations() async {
    final List<LibraryBookLocation>? responseLocations = await _bookApiService
        .fetchBookLocations();
    if (responseLocations == null) {
      return;
    }
    _locations.value = responseLocations;
  }

  Future<void> postLocation(String locationName) async {
    final newLocation = LibraryBookLocation(location: locationName);
    final LibraryBookLocation? responseLocation = await _bookApiService
        .postBookLocation(newLocation);
    if (responseLocation == null) {
      return;
    }
    _locations.value = [..._locations.value, responseLocation];
  }

  Future<void> deleteLocation(LibraryBookLocation location) async {
    final bool? success = await _bookApiService.deleteBookLocation(location);
    if (success == null) {
      return;
    }

    _locations.value = _locations.value
        .where((loc) => loc.location != location.location)
        .toList();
  }

  void setLastLocationValue(LibraryBookLocation location) {
    _lastSelectedLocation.value = location;
  }

  //- LIBRARY BOOKS

  Future<void> fetchLibraryBooks() async {
    final List<LibraryBook>? responseBooks = await _bookApiService
        .fetchLibraryBooks();
    if (responseBooks == null) {
      return;
    }
    _refreshLibraryBookProxyCollections(responseBooks);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Bücher erfolgreich geladen',
    );
  }

  Future<void> postLibraryBook({
    required int isbn,
    required String libraryId,
    required LibraryBookLocation location,
  }) async {
    final LibraryBook? responseBook = await _bookApiService.postLibraryBook(
      isbn: isbn,
      bookId: libraryId,
      location: location,
    );
    if (responseBook == null) {
      return;
    }
    _addLibraryBookProxyToCollections(responseBook);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Buch erfolgreich zur Bibliothek hinzugefügt',
    );
  }

  Future<void> updateLibraryBookAndBookProperties({
    required int isbn,
    required String libraryId,
    String? title,
    String? author,
    String? description,
    String? readingLevel,
    LibraryBookLocation? location,
    List<BookTag>? tags,
  }) async {
    final LibraryBook? updatedbook = await _bookApiService
        .updateLibraryBookAndRelatedBook(
          isbn: isbn,
          libraryId: libraryId,
          title: title,
          author: author,
          description: description,
          readingLevel: readingLevel,
          location: location,
          tags: tags,
        );
    if (updatedbook == null) {
      return;
    }
    _updateLibraryBookProxyInCollections(updatedbook);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Arbeitsheft erfolgreich aktualisiert',
    );
  }

  Future<void> deleteLibraryBook(LibraryBookProxy libraryBookProxy) async {
    final bool? success = await _bookApiService.deleteLibraryBook(
      libraryBookProxy.id,
    );
    if (success == null) {
      return;
    }
    _removeLibraryBookProxyFromCollection(libraryBookProxy);
  }

  //- BOOKS

  Future<void> updateBookTags(int isbn, List<BookTag> tags) async {
    final Book? updatedBook = await _bookApiService.updateBookTags(isbn, tags);
    if (updatedBook == null) {
      return;
    }
    List<LibraryBook> updatedLibraryBooks = [];
    for (final libraryBookProxy in _libraryBookProxies.value) {
      if (libraryBookProxy.isbn == isbn) {
        final taggedLibraryBook = libraryBookProxy.librarybook.copyWith(
          book: updatedBook,
        );
        updatedLibraryBooks.add(taggedLibraryBook);
      }
    }
    for (final updatedLibraryBook in updatedLibraryBooks) {
      _updateLibraryBookProxyInCollections(updatedLibraryBook);
    }
  }

  Future<void> searchBooks({
    String? title,
    String? author,
    String? keywords,
    LibraryBookLocation? location,
    String? readingLevel,
    bool? available,
    List<BookTag>? tags,
  }) async {
    _currentPage = 1;
    _isLoadingMore = false;
    _hasMorePages = true;
    try {
      final List<LibraryBook>? results = await _bookApiService.searchBooks(
        title: title?.isNotEmpty == true ? title : null,
        author: author?.isNotEmpty == true ? author : null,
        keywords: keywords?.isNotEmpty == true ? keywords : null,
        location: location ?? null,
        readingLevel: readingLevel?.isNotEmpty == true ? readingLevel : null,
        available: available ?? null,
        tags: tags,
        page: _currentPage,
        perPage: _perPage,
      );
      if (results == null) {
        return;
      }
      final searchResults = <LibraryBookProxy>[];
      for (final result in results) {
        final LibraryBookProxy libraryBookProxy = LibraryBookProxy(
          librarybook: result,
        );
        // Check if this libraryId already exists to prevent duplicates
        if (!searchResults.any(
          (existing) => existing.libraryId == libraryBookProxy.libraryId,
        )) {
          searchResults.add(libraryBookProxy);
        }
      }
      _searchResults.value = searchResults;

      _notificationService.showSnackBar(
        NotificationType.success,
        'Suchergebnisse aktualisiert',
      );
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler bei der Suche: $e',
      );
    }
  }

  Future<void> loadNextPage({
    String? title,
    String? author,
    String? keywords,
    LibraryBookLocation? location,
    String? readingLevel,
    bool? available,
    List<BookTag>? tags,
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
        tags: tags,
        page: _currentPage,
        perPage: _perPage,
      );
      if (newPageResults == null) {
        return;
      }
      if (newPageResults.isEmpty) {
        _hasMorePages = false;
      } else {
        final List<LibraryBookProxy> searchResultsToUpdate = _searchResults
            .value
            .toList(); // Create a copy
        for (final result in newPageResults) {
          final LibraryBookProxy libraryBookProxy = LibraryBookProxy(
            librarybook: result,
          );
          // Check if this libraryId already exists to prevent duplicates
          if (!searchResultsToUpdate.any(
            (existing) => existing.libraryId == libraryBookProxy.libraryId,
          )) {
            searchResultsToUpdate.add(libraryBookProxy);
          }
        }
        _searchResults.value = searchResultsToUpdate;
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
