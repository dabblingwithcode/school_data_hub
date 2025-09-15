/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../_features/books/models/library_book_location.dart' as _i2;
import '../../../_features/books/models/book_tagging/book_tag.dart' as _i3;

abstract class LibraryBookQuery
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LibraryBookQuery._({
    this.title,
    this.author,
    this.location,
    this.keywords,
    this.readingLevel,
    this.tags,
    this.borrowStatus,
    required this.page,
    required this.perPage,
  });

  factory LibraryBookQuery({
    String? title,
    String? author,
    _i2.LibraryBookLocation? location,
    String? keywords,
    String? readingLevel,
    List<_i3.BookTag>? tags,
    bool? borrowStatus,
    required int page,
    required int perPage,
  }) = _LibraryBookQueryImpl;

  factory LibraryBookQuery.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryBookQuery(
      title: jsonSerialization['title'] as String?,
      author: jsonSerialization['author'] as String?,
      location: jsonSerialization['location'] == null
          ? null
          : _i2.LibraryBookLocation.fromJson(
              (jsonSerialization['location'] as Map<String, dynamic>)),
      keywords: jsonSerialization['keywords'] as String?,
      readingLevel: jsonSerialization['readingLevel'] as String?,
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => _i3.BookTag.fromJson((e as Map<String, dynamic>)))
          .toList(),
      borrowStatus: jsonSerialization['borrowStatus'] as bool?,
      page: jsonSerialization['page'] as int,
      perPage: jsonSerialization['perPage'] as int,
    );
  }

  String? title;

  String? author;

  _i2.LibraryBookLocation? location;

  String? keywords;

  String? readingLevel;

  List<_i3.BookTag>? tags;

  bool? borrowStatus;

  int page;

  int perPage;

  /// Returns a shallow copy of this [LibraryBookQuery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryBookQuery copyWith({
    String? title,
    String? author,
    _i2.LibraryBookLocation? location,
    String? keywords,
    String? readingLevel,
    List<_i3.BookTag>? tags,
    bool? borrowStatus,
    int? page,
    int? perPage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (location != null) 'location': location?.toJson(),
      if (keywords != null) 'keywords': keywords,
      if (readingLevel != null) 'readingLevel': readingLevel,
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (borrowStatus != null) 'borrowStatus': borrowStatus,
      'page': page,
      'perPage': perPage,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (location != null) 'location': location?.toJsonForProtocol(),
      if (keywords != null) 'keywords': keywords,
      if (readingLevel != null) 'readingLevel': readingLevel,
      if (tags != null)
        'tags': tags?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (borrowStatus != null) 'borrowStatus': borrowStatus,
      'page': page,
      'perPage': perPage,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LibraryBookQueryImpl extends LibraryBookQuery {
  _LibraryBookQueryImpl({
    String? title,
    String? author,
    _i2.LibraryBookLocation? location,
    String? keywords,
    String? readingLevel,
    List<_i3.BookTag>? tags,
    bool? borrowStatus,
    required int page,
    required int perPage,
  }) : super._(
          title: title,
          author: author,
          location: location,
          keywords: keywords,
          readingLevel: readingLevel,
          tags: tags,
          borrowStatus: borrowStatus,
          page: page,
          perPage: perPage,
        );

  /// Returns a shallow copy of this [LibraryBookQuery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryBookQuery copyWith({
    Object? title = _Undefined,
    Object? author = _Undefined,
    Object? location = _Undefined,
    Object? keywords = _Undefined,
    Object? readingLevel = _Undefined,
    Object? tags = _Undefined,
    Object? borrowStatus = _Undefined,
    int? page,
    int? perPage,
  }) {
    return LibraryBookQuery(
      title: title is String? ? title : this.title,
      author: author is String? ? author : this.author,
      location: location is _i2.LibraryBookLocation?
          ? location
          : this.location?.copyWith(),
      keywords: keywords is String? ? keywords : this.keywords,
      readingLevel: readingLevel is String? ? readingLevel : this.readingLevel,
      tags: tags is List<_i3.BookTag>?
          ? tags
          : this.tags?.map((e0) => e0.copyWith()).toList(),
      borrowStatus: borrowStatus is bool? ? borrowStatus : this.borrowStatus,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }
}
