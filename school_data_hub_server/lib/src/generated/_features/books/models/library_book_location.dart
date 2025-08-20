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
import '../../../_features/books/models/library_book.dart' as _i2;

abstract class LibraryBookLocation
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = LibraryBookLocationTable();

  static const db = LibraryBookLocationRepository._();

  @override
  int? id;

  String location;

  List<_i2.LibraryBook>? libraryBooks;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'location': location,
      if (libraryBooks != null)
        'libraryBooks':
            libraryBooks?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static LibraryBookLocationInclude include(
      {_i2.LibraryBookIncludeList? libraryBooks}) {
    return LibraryBookLocationInclude._(libraryBooks: libraryBooks);
  }

  static LibraryBookLocationIncludeList includeList({
    _i1.WhereExpressionBuilder<LibraryBookLocationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookLocationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookLocationTable>? orderByList,
    LibraryBookLocationInclude? include,
  }) {
    return LibraryBookLocationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryBookLocation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LibraryBookLocation.t),
      include: include,
    );
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

class LibraryBookLocationTable extends _i1.Table<int?> {
  LibraryBookLocationTable({super.tableRelation})
      : super(tableName: 'library_book_location') {
    location = _i1.ColumnString(
      'location',
      this,
    );
  }

  late final _i1.ColumnString location;

  _i2.LibraryBookTable? ___libraryBooks;

  _i1.ManyRelation<_i2.LibraryBookTable>? _libraryBooks;

  _i2.LibraryBookTable get __libraryBooks {
    if (___libraryBooks != null) return ___libraryBooks!;
    ___libraryBooks = _i1.createRelationTable(
      relationFieldName: '__libraryBooks',
      field: LibraryBookLocation.t.id,
      foreignField: _i2.LibraryBook.t.locationId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.LibraryBookTable(tableRelation: foreignTableRelation),
    );
    return ___libraryBooks!;
  }

  _i1.ManyRelation<_i2.LibraryBookTable> get libraryBooks {
    if (_libraryBooks != null) return _libraryBooks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'libraryBooks',
      field: LibraryBookLocation.t.id,
      foreignField: _i2.LibraryBook.t.locationId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.LibraryBookTable(tableRelation: foreignTableRelation),
    );
    _libraryBooks = _i1.ManyRelation<_i2.LibraryBookTable>(
      tableWithRelations: relationTable,
      table: _i2.LibraryBookTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _libraryBooks!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        location,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'libraryBooks') {
      return __libraryBooks;
    }
    return null;
  }
}

class LibraryBookLocationInclude extends _i1.IncludeObject {
  LibraryBookLocationInclude._({_i2.LibraryBookIncludeList? libraryBooks}) {
    _libraryBooks = libraryBooks;
  }

  _i2.LibraryBookIncludeList? _libraryBooks;

  @override
  Map<String, _i1.Include?> get includes => {'libraryBooks': _libraryBooks};

  @override
  _i1.Table<int?> get table => LibraryBookLocation.t;
}

class LibraryBookLocationIncludeList extends _i1.IncludeList {
  LibraryBookLocationIncludeList._({
    _i1.WhereExpressionBuilder<LibraryBookLocationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LibraryBookLocation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LibraryBookLocation.t;
}

class LibraryBookLocationRepository {
  const LibraryBookLocationRepository._();

  final attach = const LibraryBookLocationAttachRepository._();

  final attachRow = const LibraryBookLocationAttachRowRepository._();

  /// Returns a list of [LibraryBookLocation]s matching the given query parameters.
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
  Future<List<LibraryBookLocation>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LibraryBookLocationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookLocationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookLocationTable>? orderByList,
    _i1.Transaction? transaction,
    LibraryBookLocationInclude? include,
  }) async {
    return session.db.find<LibraryBookLocation>(
      where: where?.call(LibraryBookLocation.t),
      orderBy: orderBy?.call(LibraryBookLocation.t),
      orderByList: orderByList?.call(LibraryBookLocation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [LibraryBookLocation] matching the given query parameters.
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
  Future<LibraryBookLocation?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LibraryBookLocationTable>? where,
    int? offset,
    _i1.OrderByBuilder<LibraryBookLocationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookLocationTable>? orderByList,
    _i1.Transaction? transaction,
    LibraryBookLocationInclude? include,
  }) async {
    return session.db.findFirstRow<LibraryBookLocation>(
      where: where?.call(LibraryBookLocation.t),
      orderBy: orderBy?.call(LibraryBookLocation.t),
      orderByList: orderByList?.call(LibraryBookLocation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [LibraryBookLocation] by its [id] or null if no such row exists.
  Future<LibraryBookLocation?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    LibraryBookLocationInclude? include,
  }) async {
    return session.db.findById<LibraryBookLocation>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [LibraryBookLocation]s in the list and returns the inserted rows.
  ///
  /// The returned [LibraryBookLocation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LibraryBookLocation>> insert(
    _i1.Session session,
    List<LibraryBookLocation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LibraryBookLocation>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LibraryBookLocation] and returns the inserted row.
  ///
  /// The returned [LibraryBookLocation] will have its `id` field set.
  Future<LibraryBookLocation> insertRow(
    _i1.Session session,
    LibraryBookLocation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LibraryBookLocation>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LibraryBookLocation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LibraryBookLocation>> update(
    _i1.Session session,
    List<LibraryBookLocation> rows, {
    _i1.ColumnSelections<LibraryBookLocationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LibraryBookLocation>(
      rows,
      columns: columns?.call(LibraryBookLocation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryBookLocation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LibraryBookLocation> updateRow(
    _i1.Session session,
    LibraryBookLocation row, {
    _i1.ColumnSelections<LibraryBookLocationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LibraryBookLocation>(
      row,
      columns: columns?.call(LibraryBookLocation.t),
      transaction: transaction,
    );
  }

  /// Deletes all [LibraryBookLocation]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LibraryBookLocation>> delete(
    _i1.Session session,
    List<LibraryBookLocation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LibraryBookLocation>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LibraryBookLocation].
  Future<LibraryBookLocation> deleteRow(
    _i1.Session session,
    LibraryBookLocation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LibraryBookLocation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LibraryBookLocation>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LibraryBookLocationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LibraryBookLocation>(
      where: where(LibraryBookLocation.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LibraryBookLocationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LibraryBookLocation>(
      where: where?.call(LibraryBookLocation.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class LibraryBookLocationAttachRepository {
  const LibraryBookLocationAttachRepository._();

  /// Creates a relation between this [LibraryBookLocation] and the given [LibraryBook]s
  /// by setting each [LibraryBook]'s foreign key `locationId` to refer to this [LibraryBookLocation].
  Future<void> libraryBooks(
    _i1.Session session,
    LibraryBookLocation libraryBookLocation,
    List<_i2.LibraryBook> libraryBook, {
    _i1.Transaction? transaction,
  }) async {
    if (libraryBook.any((e) => e.id == null)) {
      throw ArgumentError.notNull('libraryBook.id');
    }
    if (libraryBookLocation.id == null) {
      throw ArgumentError.notNull('libraryBookLocation.id');
    }

    var $libraryBook = libraryBook
        .map((e) => e.copyWith(locationId: libraryBookLocation.id))
        .toList();
    await session.db.update<_i2.LibraryBook>(
      $libraryBook,
      columns: [_i2.LibraryBook.t.locationId],
      transaction: transaction,
    );
  }
}

class LibraryBookLocationAttachRowRepository {
  const LibraryBookLocationAttachRowRepository._();

  /// Creates a relation between this [LibraryBookLocation] and the given [LibraryBook]
  /// by setting the [LibraryBook]'s foreign key `locationId` to refer to this [LibraryBookLocation].
  Future<void> libraryBooks(
    _i1.Session session,
    LibraryBookLocation libraryBookLocation,
    _i2.LibraryBook libraryBook, {
    _i1.Transaction? transaction,
  }) async {
    if (libraryBook.id == null) {
      throw ArgumentError.notNull('libraryBook.id');
    }
    if (libraryBookLocation.id == null) {
      throw ArgumentError.notNull('libraryBookLocation.id');
    }

    var $libraryBook = libraryBook.copyWith(locationId: libraryBookLocation.id);
    await session.db.updateRow<_i2.LibraryBook>(
      $libraryBook,
      columns: [_i2.LibraryBook.t.locationId],
      transaction: transaction,
    );
  }
}
