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
import '../../book/book_tagging/book_tagging.dart' as _i2;

abstract class BookTag implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = BookTagTable();

  static const db = BookTagRepository._();

  @override
  int? id;

  String name;

  List<_i2.BookTagging>? books;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (books != null)
        'books': books?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static BookTagInclude include({_i2.BookTaggingIncludeList? books}) {
    return BookTagInclude._(books: books);
  }

  static BookTagIncludeList includeList({
    _i1.WhereExpressionBuilder<BookTagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookTagTable>? orderByList,
    BookTagInclude? include,
  }) {
    return BookTagIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookTag.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BookTag.t),
      include: include,
    );
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

class BookTagTable extends _i1.Table {
  BookTagTable({super.tableRelation}) : super(tableName: 'book_tag') {
    name = _i1.ColumnString(
      'name',
      this,
    );
  }

  late final _i1.ColumnString name;

  _i2.BookTaggingTable? ___books;

  _i1.ManyRelation<_i2.BookTaggingTable>? _books;

  _i2.BookTaggingTable get __books {
    if (___books != null) return ___books!;
    ___books = _i1.createRelationTable(
      relationFieldName: '__books',
      field: BookTag.t.id,
      foreignField: _i2.BookTagging.t.bookTagId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.BookTaggingTable(tableRelation: foreignTableRelation),
    );
    return ___books!;
  }

  _i1.ManyRelation<_i2.BookTaggingTable> get books {
    if (_books != null) return _books!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'books',
      field: BookTag.t.id,
      foreignField: _i2.BookTagging.t.bookTagId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.BookTaggingTable(tableRelation: foreignTableRelation),
    );
    _books = _i1.ManyRelation<_i2.BookTaggingTable>(
      tableWithRelations: relationTable,
      table: _i2.BookTaggingTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _books!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'books') {
      return __books;
    }
    return null;
  }
}

class BookTagInclude extends _i1.IncludeObject {
  BookTagInclude._({_i2.BookTaggingIncludeList? books}) {
    _books = books;
  }

  _i2.BookTaggingIncludeList? _books;

  @override
  Map<String, _i1.Include?> get includes => {'books': _books};

  @override
  _i1.Table get table => BookTag.t;
}

class BookTagIncludeList extends _i1.IncludeList {
  BookTagIncludeList._({
    _i1.WhereExpressionBuilder<BookTagTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookTag.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => BookTag.t;
}

class BookTagRepository {
  const BookTagRepository._();

  final attach = const BookTagAttachRepository._();

  final attachRow = const BookTagAttachRowRepository._();

  final detach = const BookTagDetachRepository._();

  final detachRow = const BookTagDetachRowRepository._();

  /// Returns a list of [BookTag]s matching the given query parameters.
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
  Future<List<BookTag>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookTagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookTagTable>? orderByList,
    _i1.Transaction? transaction,
    BookTagInclude? include,
  }) async {
    return session.db.find<BookTag>(
      where: where?.call(BookTag.t),
      orderBy: orderBy?.call(BookTag.t),
      orderByList: orderByList?.call(BookTag.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [BookTag] matching the given query parameters.
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
  Future<BookTag?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookTagTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookTagTable>? orderByList,
    _i1.Transaction? transaction,
    BookTagInclude? include,
  }) async {
    return session.db.findFirstRow<BookTag>(
      where: where?.call(BookTag.t),
      orderBy: orderBy?.call(BookTag.t),
      orderByList: orderByList?.call(BookTag.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [BookTag] by its [id] or null if no such row exists.
  Future<BookTag?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    BookTagInclude? include,
  }) async {
    return session.db.findById<BookTag>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [BookTag]s in the list and returns the inserted rows.
  ///
  /// The returned [BookTag]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<BookTag>> insert(
    _i1.Session session,
    List<BookTag> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<BookTag>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [BookTag] and returns the inserted row.
  ///
  /// The returned [BookTag] will have its `id` field set.
  Future<BookTag> insertRow(
    _i1.Session session,
    BookTag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookTag>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BookTag]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BookTag>> update(
    _i1.Session session,
    List<BookTag> rows, {
    _i1.ColumnSelections<BookTagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BookTag>(
      rows,
      columns: columns?.call(BookTag.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookTag]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookTag> updateRow(
    _i1.Session session,
    BookTag row, {
    _i1.ColumnSelections<BookTagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookTag>(
      row,
      columns: columns?.call(BookTag.t),
      transaction: transaction,
    );
  }

  /// Deletes all [BookTag]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BookTag>> delete(
    _i1.Session session,
    List<BookTag> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BookTag>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BookTag].
  Future<BookTag> deleteRow(
    _i1.Session session,
    BookTag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookTag>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BookTag>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BookTagTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BookTag>(
      where: where(BookTag.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookTagTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BookTag>(
      where: where?.call(BookTag.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class BookTagAttachRepository {
  const BookTagAttachRepository._();

  /// Creates a relation between this [BookTag] and the given [BookTagging]s
  /// by setting each [BookTagging]'s foreign key `bookTagId` to refer to this [BookTag].
  Future<void> books(
    _i1.Session session,
    BookTag bookTag,
    List<_i2.BookTagging> bookTagging, {
    _i1.Transaction? transaction,
  }) async {
    if (bookTagging.any((e) => e.id == null)) {
      throw ArgumentError.notNull('bookTagging.id');
    }
    if (bookTag.id == null) {
      throw ArgumentError.notNull('bookTag.id');
    }

    var $bookTagging =
        bookTagging.map((e) => e.copyWith(bookTagId: bookTag.id)).toList();
    await session.db.update<_i2.BookTagging>(
      $bookTagging,
      columns: [_i2.BookTagging.t.bookTagId],
      transaction: transaction,
    );
  }
}

class BookTagAttachRowRepository {
  const BookTagAttachRowRepository._();

  /// Creates a relation between this [BookTag] and the given [BookTagging]
  /// by setting the [BookTagging]'s foreign key `bookTagId` to refer to this [BookTag].
  Future<void> books(
    _i1.Session session,
    BookTag bookTag,
    _i2.BookTagging bookTagging, {
    _i1.Transaction? transaction,
  }) async {
    if (bookTagging.id == null) {
      throw ArgumentError.notNull('bookTagging.id');
    }
    if (bookTag.id == null) {
      throw ArgumentError.notNull('bookTag.id');
    }

    var $bookTagging = bookTagging.copyWith(bookTagId: bookTag.id);
    await session.db.updateRow<_i2.BookTagging>(
      $bookTagging,
      columns: [_i2.BookTagging.t.bookTagId],
      transaction: transaction,
    );
  }
}

class BookTagDetachRepository {
  const BookTagDetachRepository._();

  /// Detaches the relation between this [BookTag] and the given [BookTagging]
  /// by setting the [BookTagging]'s foreign key `bookTagId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> books(
    _i1.Session session,
    List<_i2.BookTagging> bookTagging, {
    _i1.Transaction? transaction,
  }) async {
    if (bookTagging.any((e) => e.id == null)) {
      throw ArgumentError.notNull('bookTagging.id');
    }

    var $bookTagging =
        bookTagging.map((e) => e.copyWith(bookTagId: null)).toList();
    await session.db.update<_i2.BookTagging>(
      $bookTagging,
      columns: [_i2.BookTagging.t.bookTagId],
      transaction: transaction,
    );
  }
}

class BookTagDetachRowRepository {
  const BookTagDetachRowRepository._();

  /// Detaches the relation between this [BookTag] and the given [BookTagging]
  /// by setting the [BookTagging]'s foreign key `bookTagId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> books(
    _i1.Session session,
    _i2.BookTagging bookTagging, {
    _i1.Transaction? transaction,
  }) async {
    if (bookTagging.id == null) {
      throw ArgumentError.notNull('bookTagging.id');
    }

    var $bookTagging = bookTagging.copyWith(bookTagId: null);
    await session.db.updateRow<_i2.BookTagging>(
      $bookTagging,
      columns: [_i2.BookTagging.t.bookTagId],
      transaction: transaction,
    );
  }
}
