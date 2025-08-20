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
import '../../../../_features/books/models/book_tagging/book_tagging.dart'
    as _i2;

abstract class BookTag implements _i1.SerializableModel {
  BookTag._({
    this.id,
    required this.name,
    this.books,
  });

  factory BookTag({
    int? id,
    required String name,
    List<_i2.BookTagging>? books,
  }) = _BookTagImpl;

  factory BookTag.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookTag(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      books: (jsonSerialization['books'] as List?)
          ?.map((e) => _i2.BookTagging.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  List<_i2.BookTagging>? books;

  /// Returns a shallow copy of this [BookTag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookTag copyWith({
    int? id,
    String? name,
    List<_i2.BookTagging>? books,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (books != null) 'books': books?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookTagImpl extends BookTag {
  _BookTagImpl({
    int? id,
    required String name,
    List<_i2.BookTagging>? books,
  }) : super._(
          id: id,
          name: name,
          books: books,
        );

  /// Returns a shallow copy of this [BookTag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookTag copyWith({
    Object? id = _Undefined,
    String? name,
    Object? books = _Undefined,
  }) {
    return BookTag(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      books: books is List<_i2.BookTagging>?
          ? books
          : this.books?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
