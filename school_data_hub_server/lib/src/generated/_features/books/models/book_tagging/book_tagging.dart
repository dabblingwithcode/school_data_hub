/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../../_features/books/models/book.dart' as _i2;
import '../../../../_features/books/models/book_tagging/book_tag.dart' as _i3;

abstract class BookTagging
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = BookTaggingTable();

  static const db = BookTaggingRepository._();

  @override
  int? id;

  int bookId;

  _i2.Book? book;

  int bookTagId;

  _i3.BookTag? bookTag;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'bookId': bookId,
      if (book != null) 'book': book?.toJsonForProtocol(),
      'bookTagId': bookTagId,
      if (bookTag != null) 'bookTag': bookTag?.toJsonForProtocol(),
    };
  }

  static BookTaggingInclude include({
    _i2.BookInclude? book,
    _i3.BookTagInclude? bookTag,
  }) {
    return BookTaggingInclude._(
      book: book,
      bookTag: bookTag,
    );
  }

  static BookTaggingIncludeList includeList({
    _i1.WhereExpressionBuilder<BookTaggingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookTaggingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookTaggingTable>? orderByList,
    BookTaggingInclude? include,
  }) {
    return BookTaggingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookTagging.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BookTagging.t),
      include: include,
    );
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

class BookTaggingTable extends _i1.Table<int?> {
  BookTaggingTable({super.tableRelation}) : super(tableName: 'book_tagging') {
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    bookTagId = _i1.ColumnInt(
      'bookTagId',
      this,
    );
  }

  late final _i1.ColumnInt bookId;

  _i2.BookTable? _book;

  late final _i1.ColumnInt bookTagId;

  _i3.BookTagTable? _bookTag;

  _i2.BookTable get book {
    if (_book != null) return _book!;
    _book = _i1.createRelationTable(
      relationFieldName: 'book',
      field: BookTagging.t.bookId,
      foreignField: _i2.Book.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.BookTable(tableRelation: foreignTableRelation),
    );
    return _book!;
  }

  _i3.BookTagTable get bookTag {
    if (_bookTag != null) return _bookTag!;
    _bookTag = _i1.createRelationTable(
      relationFieldName: 'bookTag',
      field: BookTagging.t.bookTagId,
      foreignField: _i3.BookTag.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.BookTagTable(tableRelation: foreignTableRelation),
    );
    return _bookTag!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        bookId,
        bookTagId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'book') {
      return book;
    }
    if (relationField == 'bookTag') {
      return bookTag;
    }
    return null;
  }
}

class BookTaggingInclude extends _i1.IncludeObject {
  BookTaggingInclude._({
    _i2.BookInclude? book,
    _i3.BookTagInclude? bookTag,
  }) {
    _book = book;
    _bookTag = bookTag;
  }

  _i2.BookInclude? _book;

  _i3.BookTagInclude? _bookTag;

  @override
  Map<String, _i1.Include?> get includes => {
        'book': _book,
        'bookTag': _bookTag,
      };

  @override
  _i1.Table<int?> get table => BookTagging.t;
}

class BookTaggingIncludeList extends _i1.IncludeList {
  BookTaggingIncludeList._({
    _i1.WhereExpressionBuilder<BookTaggingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookTagging.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BookTagging.t;
}

class BookTaggingRepository {
  const BookTaggingRepository._();

  final attachRow = const BookTaggingAttachRowRepository._();

  /// Returns a list of [BookTagging]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<BookTagging>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookTaggingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookTaggingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookTaggingTable>? orderByList,
    _i1.Transaction? transaction,
    BookTaggingInclude? include,
  }) async {
    return session.db.find<BookTagging>(
      where: where?.call(BookTagging.t),
      orderBy: orderBy?.call(BookTagging.t),
      orderByList: orderByList?.call(BookTagging.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [BookTagging] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<BookTagging?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookTaggingTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookTaggingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookTaggingTable>? orderByList,
    _i1.Transaction? transaction,
    BookTaggingInclude? include,
  }) async {
    return session.db.findFirstRow<BookTagging>(
      where: where?.call(BookTagging.t),
      orderBy: orderBy?.call(BookTagging.t),
      orderByList: orderByList?.call(BookTagging.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [BookTagging] by its [id] or null if no such row exists.
  Future<BookTagging?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    BookTaggingInclude? include,
  }) async {
    return session.db.findById<BookTagging>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [BookTagging]s in the list and returns the inserted rows.
  ///
  /// The returned [BookTagging]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<BookTagging>> insert(
    _i1.Session session,
    List<BookTagging> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<BookTagging>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [BookTagging] and returns the inserted row.
  ///
  /// The returned [BookTagging] will have its `id` field set.
  Future<BookTagging> insertRow(
    _i1.Session session,
    BookTagging row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookTagging>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BookTagging]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BookTagging>> update(
    _i1.Session session,
    List<BookTagging> rows, {
    _i1.ColumnSelections<BookTaggingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BookTagging>(
      rows,
      columns: columns?.call(BookTagging.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookTagging]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookTagging> updateRow(
    _i1.Session session,
    BookTagging row, {
    _i1.ColumnSelections<BookTaggingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookTagging>(
      row,
      columns: columns?.call(BookTagging.t),
      transaction: transaction,
    );
  }

  /// Deletes all [BookTagging]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BookTagging>> delete(
    _i1.Session session,
    List<BookTagging> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BookTagging>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BookTagging].
  Future<BookTagging> deleteRow(
    _i1.Session session,
    BookTagging row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookTagging>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BookTagging>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BookTaggingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BookTagging>(
      where: where(BookTagging.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookTaggingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BookTagging>(
      where: where?.call(BookTagging.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class BookTaggingAttachRowRepository {
  const BookTaggingAttachRowRepository._();

  /// Creates a relation between the given [BookTagging] and [Book]
  /// by setting the [BookTagging]'s foreign key `bookId` to refer to the [Book].
  Future<void> book(
    _i1.Session session,
    BookTagging bookTagging,
    _i2.Book book, {
    _i1.Transaction? transaction,
  }) async {
    if (bookTagging.id == null) {
      throw ArgumentError.notNull('bookTagging.id');
    }
    if (book.id == null) {
      throw ArgumentError.notNull('book.id');
    }

    var $bookTagging = bookTagging.copyWith(bookId: book.id);
    await session.db.updateRow<BookTagging>(
      $bookTagging,
      columns: [BookTagging.t.bookId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [BookTagging] and [BookTag]
  /// by setting the [BookTagging]'s foreign key `bookTagId` to refer to the [BookTag].
  Future<void> bookTag(
    _i1.Session session,
    BookTagging bookTagging,
    _i3.BookTag bookTag, {
    _i1.Transaction? transaction,
  }) async {
    if (bookTagging.id == null) {
      throw ArgumentError.notNull('bookTagging.id');
    }
    if (bookTag.id == null) {
      throw ArgumentError.notNull('bookTag.id');
    }

    var $bookTagging = bookTagging.copyWith(bookTagId: bookTag.id);
    await session.db.updateRow<BookTagging>(
      $bookTagging,
      columns: [BookTagging.t.bookTagId],
      transaction: transaction,
    );
  }
}
