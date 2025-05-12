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
import '../../../book/library_book/library_book.dart' as _i2;

abstract class LibraryBookLocation implements _i1.SerializableModel {
  LibraryBookLocation._({
    this.id,
    required this.location,
    this.libraryBooks,
  });

  factory LibraryBookLocation({
    int? id,
    required String location,
    List<_i2.LibraryBook>? libraryBooks,
  }) = _LibraryBookLocationImpl;

  factory LibraryBookLocation.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryBookLocation(
      id: jsonSerialization['id'] as int?,
      location: jsonSerialization['location'] as String,
      libraryBooks: (jsonSerialization['libraryBooks'] as List?)
          ?.map((e) => _i2.LibraryBook.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String location;

  List<_i2.LibraryBook>? libraryBooks;

  /// Returns a shallow copy of this [LibraryBookLocation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryBookLocation copyWith({
    int? id,
    String? location,
    List<_i2.LibraryBook>? libraryBooks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'location': location,
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

class _LibraryBookLocationImpl extends LibraryBookLocation {
  _LibraryBookLocationImpl({
    int? id,
    required String location,
    List<_i2.LibraryBook>? libraryBooks,
  }) : super._(
          id: id,
          location: location,
          libraryBooks: libraryBooks,
        );

  /// Returns a shallow copy of this [LibraryBookLocation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryBookLocation copyWith({
    Object? id = _Undefined,
    String? location,
    Object? libraryBooks = _Undefined,
  }) {
    return LibraryBookLocation(
      id: id is int? ? id : this.id,
      location: location ?? this.location,
      libraryBooks: libraryBooks is List<_i2.LibraryBook>?
          ? libraryBooks
          : this.libraryBooks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
