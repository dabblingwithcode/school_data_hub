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
import '../../book/book.dart' as _i2;
import '../../book/library_book/location/library_book_location.dart' as _i3;
import '../../book/pupil_book_lending.dart' as _i4;

abstract class LibraryBook
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LibraryBook._({
    this.id,
    required this.libraryId,
    required this.bookId,
    this.book,
    required this.locationId,
    this.location,
    required this.available,
    this.lending,
  });

  factory LibraryBook({
    int? id,
    required String libraryId,
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
      libraryId: jsonSerialization['libraryId'] as String,
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

  static final t = LibraryBookTable();

  static const db = LibraryBookRepository._();

  @override
  int? id;

  String libraryId;

  int bookId;

  _i2.Book? book;

  int locationId;

  _i3.LibraryBookLocation? location;

  bool available;

  List<_i4.PupilBookLending>? lending;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LibraryBook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryBook copyWith({
    int? id,
    String? libraryId,
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
      'libraryId': libraryId,
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'libraryId': libraryId,
      'bookId': bookId,
      if (book != null) 'book': book?.toJsonForProtocol(),
      'locationId': locationId,
      if (location != null) 'location': location?.toJsonForProtocol(),
      'available': available,
      if (lending != null)
        'lending': lending?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static LibraryBookInclude include({
    _i2.BookInclude? book,
    _i3.LibraryBookLocationInclude? location,
    _i4.PupilBookLendingIncludeList? lending,
  }) {
    return LibraryBookInclude._(
      book: book,
      location: location,
      lending: lending,
    );
  }

  static LibraryBookIncludeList includeList({
    _i1.WhereExpressionBuilder<LibraryBookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookTable>? orderByList,
    LibraryBookInclude? include,
  }) {
    return LibraryBookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryBook.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LibraryBook.t),
      include: include,
    );
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
    required String libraryId,
    required int bookId,
    _i2.Book? book,
    required int locationId,
    _i3.LibraryBookLocation? location,
    required bool available,
    List<_i4.PupilBookLending>? lending,
  }) : super._(
          id: id,
          libraryId: libraryId,
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
    String? libraryId,
    int? bookId,
    Object? book = _Undefined,
    int? locationId,
    Object? location = _Undefined,
    bool? available,
    Object? lending = _Undefined,
  }) {
    return LibraryBook(
      id: id is int? ? id : this.id,
      libraryId: libraryId ?? this.libraryId,
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

class LibraryBookTable extends _i1.Table<int?> {
  LibraryBookTable({super.tableRelation}) : super(tableName: 'library_book') {
    libraryId = _i1.ColumnString(
      'libraryId',
      this,
    );
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    locationId = _i1.ColumnInt(
      'locationId',
      this,
    );
    available = _i1.ColumnBool(
      'available',
      this,
    );
  }

  late final _i1.ColumnString libraryId;

  late final _i1.ColumnInt bookId;

  _i2.BookTable? _book;

  late final _i1.ColumnInt locationId;

  _i3.LibraryBookLocationTable? _location;

  late final _i1.ColumnBool available;

  _i4.PupilBookLendingTable? ___lending;

  _i1.ManyRelation<_i4.PupilBookLendingTable>? _lending;

  _i2.BookTable get book {
    if (_book != null) return _book!;
    _book = _i1.createRelationTable(
      relationFieldName: 'book',
      field: LibraryBook.t.bookId,
      foreignField: _i2.Book.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.BookTable(tableRelation: foreignTableRelation),
    );
    return _book!;
  }

  _i3.LibraryBookLocationTable get location {
    if (_location != null) return _location!;
    _location = _i1.createRelationTable(
      relationFieldName: 'location',
      field: LibraryBook.t.locationId,
      foreignField: _i3.LibraryBookLocation.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.LibraryBookLocationTable(tableRelation: foreignTableRelation),
    );
    return _location!;
  }

  _i4.PupilBookLendingTable get __lending {
    if (___lending != null) return ___lending!;
    ___lending = _i1.createRelationTable(
      relationFieldName: '__lending',
      field: LibraryBook.t.id,
      foreignField: _i4.PupilBookLending.t.libraryBookId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.PupilBookLendingTable(tableRelation: foreignTableRelation),
    );
    return ___lending!;
  }

  _i1.ManyRelation<_i4.PupilBookLendingTable> get lending {
    if (_lending != null) return _lending!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'lending',
      field: LibraryBook.t.id,
      foreignField: _i4.PupilBookLending.t.libraryBookId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.PupilBookLendingTable(tableRelation: foreignTableRelation),
    );
    _lending = _i1.ManyRelation<_i4.PupilBookLendingTable>(
      tableWithRelations: relationTable,
      table: _i4.PupilBookLendingTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _lending!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        libraryId,
        bookId,
        locationId,
        available,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'book') {
      return book;
    }
    if (relationField == 'location') {
      return location;
    }
    if (relationField == 'lending') {
      return __lending;
    }
    return null;
  }
}

class LibraryBookInclude extends _i1.IncludeObject {
  LibraryBookInclude._({
    _i2.BookInclude? book,
    _i3.LibraryBookLocationInclude? location,
    _i4.PupilBookLendingIncludeList? lending,
  }) {
    _book = book;
    _location = location;
    _lending = lending;
  }

  _i2.BookInclude? _book;

  _i3.LibraryBookLocationInclude? _location;

  _i4.PupilBookLendingIncludeList? _lending;

  @override
  Map<String, _i1.Include?> get includes => {
        'book': _book,
        'location': _location,
        'lending': _lending,
      };

  @override
  _i1.Table<int?> get table => LibraryBook.t;
}

class LibraryBookIncludeList extends _i1.IncludeList {
  LibraryBookIncludeList._({
    _i1.WhereExpressionBuilder<LibraryBookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LibraryBook.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LibraryBook.t;
}

class LibraryBookRepository {
  const LibraryBookRepository._();

  final attach = const LibraryBookAttachRepository._();

  final attachRow = const LibraryBookAttachRowRepository._();

  final detach = const LibraryBookDetachRepository._();

  final detachRow = const LibraryBookDetachRowRepository._();

  /// Returns a list of [LibraryBook]s matching the given query parameters.
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
  Future<List<LibraryBook>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LibraryBookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookTable>? orderByList,
    _i1.Transaction? transaction,
    LibraryBookInclude? include,
  }) async {
    return session.db.find<LibraryBook>(
      where: where?.call(LibraryBook.t),
      orderBy: orderBy?.call(LibraryBook.t),
      orderByList: orderByList?.call(LibraryBook.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [LibraryBook] matching the given query parameters.
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
  Future<LibraryBook?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LibraryBookTable>? where,
    int? offset,
    _i1.OrderByBuilder<LibraryBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookTable>? orderByList,
    _i1.Transaction? transaction,
    LibraryBookInclude? include,
  }) async {
    return session.db.findFirstRow<LibraryBook>(
      where: where?.call(LibraryBook.t),
      orderBy: orderBy?.call(LibraryBook.t),
      orderByList: orderByList?.call(LibraryBook.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [LibraryBook] by its [id] or null if no such row exists.
  Future<LibraryBook?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    LibraryBookInclude? include,
  }) async {
    return session.db.findById<LibraryBook>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [LibraryBook]s in the list and returns the inserted rows.
  ///
  /// The returned [LibraryBook]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LibraryBook>> insert(
    _i1.Session session,
    List<LibraryBook> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LibraryBook>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LibraryBook] and returns the inserted row.
  ///
  /// The returned [LibraryBook] will have its `id` field set.
  Future<LibraryBook> insertRow(
    _i1.Session session,
    LibraryBook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LibraryBook>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LibraryBook]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LibraryBook>> update(
    _i1.Session session,
    List<LibraryBook> rows, {
    _i1.ColumnSelections<LibraryBookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LibraryBook>(
      rows,
      columns: columns?.call(LibraryBook.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryBook]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LibraryBook> updateRow(
    _i1.Session session,
    LibraryBook row, {
    _i1.ColumnSelections<LibraryBookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LibraryBook>(
      row,
      columns: columns?.call(LibraryBook.t),
      transaction: transaction,
    );
  }

  /// Deletes all [LibraryBook]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LibraryBook>> delete(
    _i1.Session session,
    List<LibraryBook> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LibraryBook>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LibraryBook].
  Future<LibraryBook> deleteRow(
    _i1.Session session,
    LibraryBook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LibraryBook>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LibraryBook>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LibraryBookTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LibraryBook>(
      where: where(LibraryBook.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LibraryBookTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LibraryBook>(
      where: where?.call(LibraryBook.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class LibraryBookAttachRepository {
  const LibraryBookAttachRepository._();

  /// Creates a relation between this [LibraryBook] and the given [PupilBookLending]s
  /// by setting each [PupilBookLending]'s foreign key `libraryBookId` to refer to this [LibraryBook].
  Future<void> lending(
    _i1.Session session,
    LibraryBook libraryBook,
    List<_i4.PupilBookLending> pupilBookLending, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilBookLending.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilBookLending.id');
    }
    if (libraryBook.id == null) {
      throw ArgumentError.notNull('libraryBook.id');
    }

    var $pupilBookLending = pupilBookLending
        .map((e) => e.copyWith(libraryBookId: libraryBook.id))
        .toList();
    await session.db.update<_i4.PupilBookLending>(
      $pupilBookLending,
      columns: [_i4.PupilBookLending.t.libraryBookId],
      transaction: transaction,
    );
  }
}

class LibraryBookAttachRowRepository {
  const LibraryBookAttachRowRepository._();

  /// Creates a relation between the given [LibraryBook] and [Book]
  /// by setting the [LibraryBook]'s foreign key `bookId` to refer to the [Book].
  Future<void> book(
    _i1.Session session,
    LibraryBook libraryBook,
    _i2.Book book, {
    _i1.Transaction? transaction,
  }) async {
    if (libraryBook.id == null) {
      throw ArgumentError.notNull('libraryBook.id');
    }
    if (book.id == null) {
      throw ArgumentError.notNull('book.id');
    }

    var $libraryBook = libraryBook.copyWith(bookId: book.id);
    await session.db.updateRow<LibraryBook>(
      $libraryBook,
      columns: [LibraryBook.t.bookId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [LibraryBook] and [LibraryBookLocation]
  /// by setting the [LibraryBook]'s foreign key `locationId` to refer to the [LibraryBookLocation].
  Future<void> location(
    _i1.Session session,
    LibraryBook libraryBook,
    _i3.LibraryBookLocation location, {
    _i1.Transaction? transaction,
  }) async {
    if (libraryBook.id == null) {
      throw ArgumentError.notNull('libraryBook.id');
    }
    if (location.id == null) {
      throw ArgumentError.notNull('location.id');
    }

    var $libraryBook = libraryBook.copyWith(locationId: location.id);
    await session.db.updateRow<LibraryBook>(
      $libraryBook,
      columns: [LibraryBook.t.locationId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [LibraryBook] and the given [PupilBookLending]
  /// by setting the [PupilBookLending]'s foreign key `libraryBookId` to refer to this [LibraryBook].
  Future<void> lending(
    _i1.Session session,
    LibraryBook libraryBook,
    _i4.PupilBookLending pupilBookLending, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilBookLending.id == null) {
      throw ArgumentError.notNull('pupilBookLending.id');
    }
    if (libraryBook.id == null) {
      throw ArgumentError.notNull('libraryBook.id');
    }

    var $pupilBookLending =
        pupilBookLending.copyWith(libraryBookId: libraryBook.id);
    await session.db.updateRow<_i4.PupilBookLending>(
      $pupilBookLending,
      columns: [_i4.PupilBookLending.t.libraryBookId],
      transaction: transaction,
    );
  }
}

class LibraryBookDetachRepository {
  const LibraryBookDetachRepository._();

  /// Detaches the relation between this [LibraryBook] and the given [PupilBookLending]
  /// by setting the [PupilBookLending]'s foreign key `libraryBookId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> lending(
    _i1.Session session,
    List<_i4.PupilBookLending> pupilBookLending, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilBookLending.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilBookLending.id');
    }

    var $pupilBookLending =
        pupilBookLending.map((e) => e.copyWith(libraryBookId: null)).toList();
    await session.db.update<_i4.PupilBookLending>(
      $pupilBookLending,
      columns: [_i4.PupilBookLending.t.libraryBookId],
      transaction: transaction,
    );
  }
}

class LibraryBookDetachRowRepository {
  const LibraryBookDetachRowRepository._();

  /// Detaches the relation between this [LibraryBook] and the given [PupilBookLending]
  /// by setting the [PupilBookLending]'s foreign key `libraryBookId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> lending(
    _i1.Session session,
    _i4.PupilBookLending pupilBookLending, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilBookLending.id == null) {
      throw ArgumentError.notNull('pupilBookLending.id');
    }

    var $pupilBookLending = pupilBookLending.copyWith(libraryBookId: null);
    await session.db.updateRow<_i4.PupilBookLending>(
      $pupilBookLending,
      columns: [_i4.PupilBookLending.t.libraryBookId],
      transaction: transaction,
    );
  }
}
