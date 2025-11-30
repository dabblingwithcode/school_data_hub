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

abstract class LibraryBookStatsDto implements _i1.SerializableModel {
  LibraryBookStatsDto._({
    required this.totalCatalogedBooks,
    required this.totalBooksWithReadingLevel1,
    required this.booksWithReadingLevel2,
    required this.booksWithReadingLevel3,
    required this.totalLibraryBooks,
    required this.totalReadBooks,
    required this.actuallyBorrowedBooks,
  });

  factory LibraryBookStatsDto({
    required int totalCatalogedBooks,
    required int totalBooksWithReadingLevel1,
    required int booksWithReadingLevel2,
    required int booksWithReadingLevel3,
    required int totalLibraryBooks,
    required int totalReadBooks,
    required int actuallyBorrowedBooks,
  }) = _LibraryBookStatsDtoImpl;

  factory LibraryBookStatsDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryBookStatsDto(
      totalCatalogedBooks: jsonSerialization['totalCatalogedBooks'] as int,
      totalBooksWithReadingLevel1:
          jsonSerialization['totalBooksWithReadingLevel1'] as int,
      booksWithReadingLevel2:
          jsonSerialization['booksWithReadingLevel2'] as int,
      booksWithReadingLevel3:
          jsonSerialization['booksWithReadingLevel3'] as int,
      totalLibraryBooks: jsonSerialization['totalLibraryBooks'] as int,
      totalReadBooks: jsonSerialization['totalReadBooks'] as int,
      actuallyBorrowedBooks: jsonSerialization['actuallyBorrowedBooks'] as int,
    );
  }

  int totalCatalogedBooks;

  int totalBooksWithReadingLevel1;

  int booksWithReadingLevel2;

  int booksWithReadingLevel3;

  int totalLibraryBooks;

  int totalReadBooks;

  int actuallyBorrowedBooks;

  /// Returns a shallow copy of this [LibraryBookStatsDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryBookStatsDto copyWith({
    int? totalCatalogedBooks,
    int? totalBooksWithReadingLevel1,
    int? booksWithReadingLevel2,
    int? booksWithReadingLevel3,
    int? totalLibraryBooks,
    int? totalReadBooks,
    int? actuallyBorrowedBooks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'totalCatalogedBooks': totalCatalogedBooks,
      'totalBooksWithReadingLevel1': totalBooksWithReadingLevel1,
      'booksWithReadingLevel2': booksWithReadingLevel2,
      'booksWithReadingLevel3': booksWithReadingLevel3,
      'totalLibraryBooks': totalLibraryBooks,
      'totalReadBooks': totalReadBooks,
      'actuallyBorrowedBooks': actuallyBorrowedBooks,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _LibraryBookStatsDtoImpl extends LibraryBookStatsDto {
  _LibraryBookStatsDtoImpl({
    required int totalCatalogedBooks,
    required int totalBooksWithReadingLevel1,
    required int booksWithReadingLevel2,
    required int booksWithReadingLevel3,
    required int totalLibraryBooks,
    required int totalReadBooks,
    required int actuallyBorrowedBooks,
  }) : super._(
          totalCatalogedBooks: totalCatalogedBooks,
          totalBooksWithReadingLevel1: totalBooksWithReadingLevel1,
          booksWithReadingLevel2: booksWithReadingLevel2,
          booksWithReadingLevel3: booksWithReadingLevel3,
          totalLibraryBooks: totalLibraryBooks,
          totalReadBooks: totalReadBooks,
          actuallyBorrowedBooks: actuallyBorrowedBooks,
        );

  /// Returns a shallow copy of this [LibraryBookStatsDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryBookStatsDto copyWith({
    int? totalCatalogedBooks,
    int? totalBooksWithReadingLevel1,
    int? booksWithReadingLevel2,
    int? booksWithReadingLevel3,
    int? totalLibraryBooks,
    int? totalReadBooks,
    int? actuallyBorrowedBooks,
  }) {
    return LibraryBookStatsDto(
      totalCatalogedBooks: totalCatalogedBooks ?? this.totalCatalogedBooks,
      totalBooksWithReadingLevel1:
          totalBooksWithReadingLevel1 ?? this.totalBooksWithReadingLevel1,
      booksWithReadingLevel2:
          booksWithReadingLevel2 ?? this.booksWithReadingLevel2,
      booksWithReadingLevel3:
          booksWithReadingLevel3 ?? this.booksWithReadingLevel3,
      totalLibraryBooks: totalLibraryBooks ?? this.totalLibraryBooks,
      totalReadBooks: totalReadBooks ?? this.totalReadBooks,
      actuallyBorrowedBooks:
          actuallyBorrowedBooks ?? this.actuallyBorrowedBooks,
    );
  }
}
