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
import '../book/book.dart' as _i2;
import '../book/location/library_book_location.dart' as _i3;
import '../book/pupil_book_lending.dart' as _i4;

abstract class LibraryBook implements _i1.SerializableModel {
  LibraryBook._({
    this.id,
    required this.bookId,
    this.book,
    required this.locationId,
    this.location,
    required this.available,
    this.lending,
  });

  factory LibraryBook({
    int? id,
    required int bookId,
    _i2.Book? book,
    required int locationId,
    _i3.LibraryBookLocation? location,
    required bool available,
    List<_i4.PupilBookLending>? lending,
  }) = _LibraryBookImpl;

  factory LibraryBook.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryBook(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      book: jsonSerialization['book'] == null
          ? null
          : _i2.Book.fromJson(
              (jsonSerialization['book'] as Map<String, dynamic>)),
      locationId: jsonSerialization['locationId'] as int,
      location: jsonSerialization['location'] == null
          ? null
          : _i3.LibraryBookLocation.fromJson(
              (jsonSerialization['location'] as Map<String, dynamic>)),
      available: jsonSerialization['available'] as bool,
      lending: (jsonSerialization['lending'] as List?)
          ?.map(
              (e) => _i4.PupilBookLending.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int bookId;

  _i2.Book? book;

  int locationId;

  _i3.LibraryBookLocation? location;

  bool available;

  List<_i4.PupilBookLending>? lending;

  /// Returns a shallow copy of this [LibraryBook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryBook copyWith({
    int? id,
    int? bookId,
    _i2.Book? book,
    int? locationId,
    _i3.LibraryBookLocation? location,
    bool? available,
    List<_i4.PupilBookLending>? lending,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'bookId': bookId,
      if (book != null) 'book': book?.toJson(),
      'locationId': locationId,
      if (location != null) 'location': location?.toJson(),
      'available': available,
      if (lending != null)
        'lending': lending?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LibraryBookImpl extends LibraryBook {
  _LibraryBookImpl({
    int? id,
    required int bookId,
    _i2.Book? book,
    required int locationId,
    _i3.LibraryBookLocation? location,
    required bool available,
    List<_i4.PupilBookLending>? lending,
  }) : super._(
          id: id,
          bookId: bookId,
          book: book,
          locationId: locationId,
          location: location,
          available: available,
          lending: lending,
        );

  /// Returns a shallow copy of this [LibraryBook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryBook copyWith({
    Object? id = _Undefined,
    int? bookId,
    Object? book = _Undefined,
    int? locationId,
    Object? location = _Undefined,
    bool? available,
    Object? lending = _Undefined,
  }) {
    return LibraryBook(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      book: book is _i2.Book? ? book : this.book?.copyWith(),
      locationId: locationId ?? this.locationId,
      location: location is _i3.LibraryBookLocation?
          ? location
          : this.location?.copyWith(),
      available: available ?? this.available,
      lending: lending is List<_i4.PupilBookLending>?
          ? lending
          : this.lending?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
