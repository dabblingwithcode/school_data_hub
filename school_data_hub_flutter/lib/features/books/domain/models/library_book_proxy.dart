import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class LibraryBookProxy with ChangeNotifier {
  LibraryBook _librarybook;

  LibraryBookProxy({required LibraryBook librarybook})
    : _librarybook = librarybook;

  void updateLibraryBook(LibraryBook librarybook) {
    _librarybook = librarybook;

    notifyListeners();
  }

  //LibraryBook get librarybook => _librarybook;

  //Book get book => _librarybook.book!;

  // librarybook properties

  LibraryBook get librarybook => _librarybook;

  Book get book => _librarybook.book!;

  String get libraryId => _librarybook.libraryId;

  int get id => _librarybook.id!;

  LibraryBookLocation get location => _librarybook.location!;

  bool get available => _librarybook.available;

  // book properties

  int get bookId => _librarybook.book!.id!;

  int get isbn => _librarybook.book!.isbn;

  String get title => _librarybook.book!.title;

  String get author => _librarybook.book!.author;

  String get description => _librarybook.book!.description;

  String? get readingLevel => _librarybook.book!.readingLevel;

  String get imagePath => _librarybook.book!.imagePath;

  List<BookTag> get bookTags {
    final taggingList = _librarybook.book!.tags;

    final tags = <BookTag>[];

    if (taggingList == null) {
      return [];
    }

    for (final tagging in taggingList) {
      tags.add(tagging.bookTag!);
    }

    return tags;
  }
}
