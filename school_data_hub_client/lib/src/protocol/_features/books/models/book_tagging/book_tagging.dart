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
import '../../../../_features/books/models/book.dart' as _i2;
import '../../../../_features/books/models/book_tagging/book_tag.dart' as _i3;

abstract class BookTagging implements _i1.SerializableModel {
  BookTagging._({
    this.id,
    required this.bookId,
    this.book,
    required this.bookTagId,
    this.bookTag,
  });

  factory BookTagging({
    int? id,
    required int bookId,
    _i2.Book? book,
    required int bookTagId,
    _i3.BookTag? bookTag,
  }) = _BookTaggingImpl;

  factory BookTagging.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookTagging(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      book: jsonSerialization['book'] == null
          ? null
          : _i2.Book.fromJson(
              (jsonSerialization['book'] as Map<String, dynamic>)),
      bookTagId: jsonSerialization['bookTagId'] as int,
      bookTag: jsonSerialization['bookTag'] == null
          ? null
          : _i3.BookTag.fromJson(
              (jsonSerialization['bookTag'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int bookId;

  _i2.Book? book;

  int bookTagId;

  _i3.BookTag? bookTag;

  /// Returns a shallow copy of this [BookTagging]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookTagging copyWith({
    int? id,
    int? bookId,
    _i2.Book? book,
    int? bookTagId,
    _i3.BookTag? bookTag,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'bookId': bookId,
      if (book != null) 'book': book?.toJson(),
      'bookTagId': bookTagId,
      if (bookTag != null) 'bookTag': bookTag?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookTaggingImpl extends BookTagging {
  _BookTaggingImpl({
    int? id,
    required int bookId,
    _i2.Book? book,
    required int bookTagId,
    _i3.BookTag? bookTag,
  }) : super._(
          id: id,
          bookId: bookId,
          book: book,
          bookTagId: bookTagId,
          bookTag: bookTag,
        );

  /// Returns a shallow copy of this [BookTagging]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookTagging copyWith({
    Object? id = _Undefined,
    int? bookId,
    Object? book = _Undefined,
    int? bookTagId,
    Object? bookTag = _Undefined,
  }) {
    return BookTagging(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      book: book is _i2.Book? ? book : this.book?.copyWith(),
      bookTagId: bookTagId ?? this.bookTagId,
      bookTag: bookTag is _i3.BookTag? ? bookTag : this.bookTag?.copyWith(),
    );
  }
}
