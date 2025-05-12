/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../book/book_tagging/book_tagging.dart' as _i2;
import '../book/library_book/library_book.dart' as _i3;

abstract class Book implements _i1.SerializableModel {
  Book._({
    this.id,
    required this.isbn,
    required this.title,
    required this.author,
    required this.description,
    required this.readingLevel,
    required this.imageId,
    required this.imageUrl,
    this.tags,
    this.libraryBooks,
  });

  factory Book({
    int? id,
    required int isbn,
    required String title,
    required String author,
    required String description,
    required String readingLevel,
    required String imageId,
    required String imageUrl,
    List<_i2.BookTagging>? tags,
    List<_i3.LibraryBook>? libraryBooks,
  }) = _BookImpl;

  factory Book.fromJson(Map<String, dynamic> jsonSerialization) {
    return Book(
      id: jsonSerialization['id'] as int?,
      isbn: jsonSerialization['isbn'] as int,
      title: jsonSerialization['title'] as String,
      author: jsonSerialization['author'] as String,
      description: jsonSerialization['description'] as String,
      readingLevel: jsonSerialization['readingLevel'] as String,
      imageId: jsonSerialization['imageId'] as String,
      imageUrl: jsonSerialization['imageUrl'] as String,
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => _i2.BookTagging.fromJson((e as Map<String, dynamic>)))
          .toList(),
      libraryBooks: (jsonSerialization['libraryBooks'] as List?)
          ?.map((e) => _i3.LibraryBook.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int isbn;

  String title;

  String author;

  String description;

  String readingLevel;

  String imageId;

  String imageUrl;

  List<_i2.BookTagging>? tags;

  List<_i3.LibraryBook>? libraryBooks;

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Book copyWith({
    int? id,
    int? isbn,
    String? title,
    String? author,
    String? description,
    String? readingLevel,
    String? imageId,
    String? imageUrl,
    List<_i2.BookTagging>? tags,
    List<_i3.LibraryBook>? libraryBooks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'isbn': isbn,
      'title': title,
      'author': author,
      'description': description,
      'readingLevel': readingLevel,
      'imageId': imageId,
      'imageUrl': imageUrl,
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (libraryBooks != null)
        'libraryBooks': libraryBooks?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookImpl extends Book {
  _BookImpl({
    int? id,
    required int isbn,
    required String title,
    required String author,
    required String description,
    required String readingLevel,
    required String imageId,
    required String imageUrl,
    List<_i2.BookTagging>? tags,
    List<_i3.LibraryBook>? libraryBooks,
  }) : super._(
          id: id,
          isbn: isbn,
          title: title,
          author: author,
          description: description,
          readingLevel: readingLevel,
          imageId: imageId,
          imageUrl: imageUrl,
          tags: tags,
          libraryBooks: libraryBooks,
        );

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Book copyWith({
    Object? id = _Undefined,
    int? isbn,
    String? title,
    String? author,
    String? description,
    String? readingLevel,
    String? imageId,
    String? imageUrl,
    Object? tags = _Undefined,
    Object? libraryBooks = _Undefined,
  }) {
    return Book(
      id: id is int? ? id : this.id,
      isbn: isbn ?? this.isbn,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      readingLevel: readingLevel ?? this.readingLevel,
      imageId: imageId ?? this.imageId,
      imageUrl: imageUrl ?? this.imageUrl,
      tags: tags is List<_i2.BookTagging>?
          ? tags
          : this.tags?.map((e0) => e0.copyWith()).toList(),
      libraryBooks: libraryBooks is List<_i3.LibraryBook>?
          ? libraryBooks
          : this.libraryBooks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
