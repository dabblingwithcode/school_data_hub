import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/domain/env_manager.dart';
import 'package:schuldaten_hub/common/domain/models/enums.dart';
import 'package:schuldaten_hub/common/services/api/api_client.dart';
import 'package:schuldaten_hub/common/services/api/api_settings.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_service.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/logger.dart';
import 'package:schuldaten_hub/features/books/domain/models/book.dart';
import 'package:schuldaten_hub/features/books/domain/models/book_dto.dart'
    as book_dto;

class BookApiService {
  final ApiClient _client = locator<ApiClient>();

  final _notificationService = locator<NotificationService>();

  String _baseUrl() {
    return locator<EnvManager>().env!.serverUrl;
  }

  // - BOOK TAGS - //

  final _bookTagsUrl = '/books/tags';

  Future<List<BookTag>> getBookTags() async {
    _notificationService.apiRunning(true);

    final Response response = await _client.get(
      '${_baseUrl()}$_bookTagsUrl',
      options: _client.hubOptions,
    );

    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Laden der Buchtags');

      throw ApiException('Failed to fetch book tags', response.statusCode);
    }

    final List<BookTag> bookTags = (response.data as List)
        .map((e) => BookTag.fromJson(e as Map<String, dynamic>))
        .toList();

    return bookTags;
  }

  final _postBookTagUrl = '/books/tags/new';

  Future<List<BookTag>> postBookTag(String tag) async {
    final data = jsonEncode({"tag": tag});

    _notificationService.apiRunning(true);

    final Response response = await _client.post(
      '${_baseUrl()}$_postBookTagUrl',
      data: data,
      options: _client.hubOptions,
    );

    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Erstellen des Buchtags');

      throw ApiException('Failed to post book tag', response.statusCode);
    }

    final List<BookTag> bookTags = (response.data as List)
        .map((e) => BookTag.fromJson(e as Map<String, dynamic>))
        .toList();

    return bookTags;
  }

  final _deleteBookTagUrl = '/books/tags';

  Future<List<BookTag>> deleteBookTag(String tag) async {
    final data = jsonEncode({"tag": tag});

    _notificationService.apiRunning(true);

    final Response response = await _client.delete(
      '${_baseUrl()}$_deleteBookTagUrl',
      data: data,
      options: _client.hubOptions,
    );

    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen des Buchtags');

      throw ApiException('Failed to delete book tag', response.statusCode);
    }

    final List<BookTag> bookTags = (response.data as List)
        .map((e) => BookTag.fromJson(e as Map<String, dynamic>))
        .toList();

    return bookTags;
  }

  // - BOOK LOCATIONS - //

  final _bookLocationsUrl = '/library_books/locations';

  Future<List<String>> getBookLocations() async {
    _notificationService.apiRunning(true);
    final getBookLocationsUrl = '${_baseUrl()}$_bookLocationsUrl';
    final Response response = await _client.get(
      getBookLocationsUrl,
      options: _client.hubOptions,
    );

    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Laden der Buchstandorte');

      throw ApiException('Failed to fetch book locations', response.statusCode);
    }

    final List<String> bookLocations = (response.data as List)
        .map((e) => (e as Map<String, dynamic>)['location'].toString())
        .toList();

    return bookLocations;
  }

  final _newBookLocationUrl = '/library_books/locations/new';

  Future<List<String>> postBookLocation(String location) async {
    final data = jsonEncode({"location": location});

    _notificationService.apiRunning(true);

    final Response response = await _client.post(
      '${_baseUrl()}$_newBookLocationUrl',
      data: data,
      options: _client.hubOptions,
    );

    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Erstellen des Buchstandorts');

      throw ApiException('Failed to post book location', response.statusCode);
    }

    final List<String> bookLocations = (response.data as List)
        .map((e) => (e as Map<String, dynamic>)['location'].toString())
        .toList();

    return bookLocations;
  }

  Future<List<String>> deleteBookLocation(String location) async {
    final data = jsonEncode({"location": location});

    _notificationService.apiRunning(true);

    final Response response = await _client.delete(
      '${_baseUrl()}$_bookLocationsUrl',
      data: data,
      options: _client.hubOptions,
    );

    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen des Buchstandorts');

      throw ApiException('Failed to delete book location', response.statusCode);
    }

    final List<String> bookLocations =
        (response.data as List).map((e) => e.toString()).toList();

    return bookLocations;
  }

  // - BOOKS - //

  final _getBooksUrl = '/library_books/all';

  Future<List<BookProxy>> getLibraryBooks() async {
    _notificationService.apiRunning(true);

    final Response response = await _client.get(
      '${_baseUrl()}$_getBooksUrl',
      options: _client.hubOptions,
    );

    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Laden der Bücher');

      throw ApiException('Failed to fetch books', response.statusCode);
    }
    if (response.data == []) {
      return [];
    }
    final List<BookProxy> books =
        (response.data as List).map((e) => BookProxy.fromJson(e)).toList();

    return books;
  }

  String _getBookData(int isbn) => '/books/$isbn';

  Future<book_dto.BookDTO> getBookData(int isbn) async {
    _notificationService.apiRunning(true);

    final Response response = await _client.get(
      '${_baseUrl()}${_getBookData(isbn)}',
      options: _client.hubOptions,
    );

    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Laden des Buches');

      throw ApiException('Failed to fetch a book', response.statusCode);
    }

    final book_dto.BookDTO book = book_dto.BookDTO.fromJson(response.data);

    return book;
  }

  static const _postLibraryBookUrl = '/library_books/new';

  Future<BookProxy> postLibraryBook({
    required int isbn,
    required String bookId,
    required String location,
  }) async {
    final data = jsonEncode({
      "book_id": bookId,
      "book_isbn": isbn,
      "location": location,
    });

    _notificationService.apiRunning(true);
    final Response response = await _client.post(
      '${_baseUrl()}$_postLibraryBookUrl',
      data: data,
      options: _client.hubOptions,
    );
    logger.d('${response.statusCode} ${response.data}');
    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Erstellen des Buches');

      throw ApiException('Failed to post book', response.statusCode);
    }

    BookProxy newBook = BookProxy.fromJson(response.data);

    return newBook;
  }

  String _patchBook(String bookId) {
    return '/books/$bookId';
  }

  Future<BookProxy> patchBookData({
    required int isbn,
    String? title,
    String? author,
    String? description,
    String? location,
    String? readingLevel,
    List<BookTag>? bookTags,
  }) async {
    final data = jsonEncode({
      if (author != null) "author": author,
      if (description != null) "description": description,
      if (location != null) "location": location,
      if (readingLevel != null) "reading_level": readingLevel,
      if (title != null) "title": title,
      if (bookTags != null) "book_tags": bookTags,
    });

    _notificationService.apiRunning(true);

    final Response response = await _client.patch(
      '${_baseUrl()}$_patchBook((bookId))',
      data: data,
      options: _client.hubOptions,
    );

    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Aktualisieren des Buches');

      throw ApiException('Failed to update a book', response.statusCode);
    }

    final BookProxy updatedBook = BookProxy.fromJson(response.data);

    return updatedBook;
  }

  //- post book image

  String _patchBookWithImageUrl(int isbn) {
    return '/books/$isbn/file';
  }

  Future<BookProxy> patchBookImage(File imageFile, int isbn) async {
    final encryptedFile = await customEncrypter.encryptFile(imageFile);

    String fileName = encryptedFile.path.split('/').last;

    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        encryptedFile.path,
        filename: fileName,
      ),
    });

    _notificationService.apiRunning(true);
    final Response response = await _client.patch(
      '${_baseUrl()}$_patchBookWithImageUrl(bookId)',
      data: formData,
      options: _client.hubOptions,
    );
    _notificationService.apiRunning(false);

    // Handle errors.
    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Hochladen des Bildes');

      throw ApiException('Failed to upload book image', response.statusCode);
    }

    final BookProxy book = BookProxy.fromJson(response.data);

    return book;
  }

  static String getBookImageUrl(int isbn) {
    return '/books/$isbn/file';
  }

  Future<File> getBookImage(int isbn) async {
    final options =
        _client.hubOptions.copyWith(responseType: ResponseType.bytes);

    _notificationService.apiRunning(true);

    final Response response = await _client
        .get('${_baseUrl()}${getBookImageUrl(isbn)}', options: options);
    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Laden des Bildes');

      throw ApiException('Failed to fetch book image', response.statusCode);
    }

    final encryptedBytes = Uint8List.fromList(response.data!);
    final decryptedBytes = customEncrypter.decryptTheseBytes(encryptedBytes);

    final tempDir = await Directory.systemTemp.createTemp();
    final file = File('${tempDir.path}/$isbn.png');
    await file.writeAsBytes(decryptedBytes);

    return file;
  }

  //- delete library book

  static String deleteLibraryBookUrl(String bookId) {
    return '/library_books/$bookId';
  }

  Future<bool> deleteLibraryBook(String bookId) async {
    _notificationService.apiRunning(true);

    final Response response = await _client.delete(
      '${_baseUrl()}${BookApiService.deleteLibraryBookUrl(bookId)}',
      options: _client.hubOptions,
    );
    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Löschen des Buches');

      throw ApiException('Failed to delete a book', response.statusCode);
    }

    return true;
  }

  //- get library book by id

  String _getLibraryBookById(String bookId) {
    return '/books/$bookId';
  }

  Future<BookProxy> getLibraryBookById(String bookId) async {
    _notificationService.apiRunning(true);

    final Response response = await _client.get(
      '${_baseUrl()}${_getLibraryBookById(bookId)}',
      options: _client.hubOptions,
    );
    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Fehler beim Laden des Buches');

      throw ApiException('Failed to fetch a book', response.statusCode);
    }

    final BookProxy book = BookProxy.fromJson(response.data);

    return book;
  }


  Future<List<BookProxy>> searchBooks({
    String? title,
    String? author,
    String? keywords,
    String? location,
    String? readingLevel,
    String? borrowStatus,
    int? page,
    int? perPage,
  }) async {
    final Map<String, dynamic> queryParams = {};
    if (title?.isNotEmpty == true) queryParams['title'] = title;
    if (author?.isNotEmpty == true) queryParams['author'] = author;
    if (keywords?.isNotEmpty == true) queryParams['keywords'] = keywords;
    if (location?.isNotEmpty == true) queryParams['location'] = location;
    if (readingLevel?.isNotEmpty == true) queryParams['reading_level'] = readingLevel;
    if (borrowStatus?.isNotEmpty == true) queryParams['borrow_status'] = borrowStatus;
    queryParams['page'] = page;
    queryParams['per_page'] = perPage;

    final String searchUrl = '${_baseUrl()}/library_books/search';

    _notificationService.apiRunning(true);
    final Response response = await _client.get(
      searchUrl,
      queryParameters: queryParams,
      options: _client.hubOptions,
    );
    _notificationService.apiRunning(false);

    if (response.statusCode != 200) {
      _notificationService.showSnackBar(
          NotificationType.error,
          'Fehler bei der Suche'
      );
      throw ApiException('Failed to search books', response.statusCode);
    }

    final List<BookProxy> books = (response.data as List)
        .map((e) => BookProxy.fromJson(e))
        .toList();

    return books;
  }
}


