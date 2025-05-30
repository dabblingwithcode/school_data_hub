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
import '../../../_features/pupil/models/pupil_data/pupil_data.dart' as _i2;
import '../../../_features/books/models/library_book.dart' as _i3;
import '../../../_shared/models/hub_document.dart' as _i4;

abstract class PupilBookLending
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PupilBookLending._({
    this.id,
    required this.lendingId,
    this.status,
    required this.score,
    required this.lentAt,
    required this.lentBy,
    this.returnedAt,
    this.receivedBy,
    required this.pupilId,
    this.pupil,
    required this.isbn,
    required this.libraryBookId,
    this.libraryBook,
    this.pupilBookLendingFiles,
  });

  factory PupilBookLending({
    int? id,
    required String lendingId,
    String? status,
    required int score,
    required DateTime lentAt,
    required String lentBy,
    DateTime? returnedAt,
    String? receivedBy,
    required int pupilId,
    _i2.PupilData? pupil,
    required int isbn,
    required int libraryBookId,
    _i3.LibraryBook? libraryBook,
    List<_i4.HubDocument>? pupilBookLendingFiles,
  }) = _PupilBookLendingImpl;

  factory PupilBookLending.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilBookLending(
      id: jsonSerialization['id'] as int?,
      lendingId: jsonSerialization['lendingId'] as String,
      status: jsonSerialization['status'] as String?,
      score: jsonSerialization['score'] as int,
      lentAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lentAt']),
      lentBy: jsonSerialization['lentBy'] as String,
      returnedAt: jsonSerialization['returnedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['returnedAt']),
      receivedBy: jsonSerialization['receivedBy'] as String?,
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      isbn: jsonSerialization['isbn'] as int,
      libraryBookId: jsonSerialization['libraryBookId'] as int,
      libraryBook: jsonSerialization['libraryBook'] == null
          ? null
          : _i3.LibraryBook.fromJson(
              (jsonSerialization['libraryBook'] as Map<String, dynamic>)),
      pupilBookLendingFiles: (jsonSerialization['pupilBookLendingFiles']
              as List?)
          ?.map((e) => _i4.HubDocument.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = PupilBookLendingTable();

  static const db = PupilBookLendingRepository._();

  @override
  int? id;

  String lendingId;

  String? status;

  int score;

  DateTime lentAt;

  String lentBy;

  DateTime? returnedAt;

  String? receivedBy;

  int pupilId;

  _i2.PupilData? pupil;

  int isbn;

  int libraryBookId;

  _i3.LibraryBook? libraryBook;

  List<_i4.HubDocument>? pupilBookLendingFiles;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PupilBookLending]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilBookLending copyWith({
    int? id,
    String? lendingId,
    String? status,
    int? score,
    DateTime? lentAt,
    String? lentBy,
    DateTime? returnedAt,
    String? receivedBy,
    int? pupilId,
    _i2.PupilData? pupil,
    int? isbn,
    int? libraryBookId,
    _i3.LibraryBook? libraryBook,
    List<_i4.HubDocument>? pupilBookLendingFiles,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'lendingId': lendingId,
      if (status != null) 'status': status,
      'score': score,
      'lentAt': lentAt.toJson(),
      'lentBy': lentBy,
      if (returnedAt != null) 'returnedAt': returnedAt?.toJson(),
      if (receivedBy != null) 'receivedBy': receivedBy,
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'isbn': isbn,
      'libraryBookId': libraryBookId,
      if (libraryBook != null) 'libraryBook': libraryBook?.toJson(),
      if (pupilBookLendingFiles != null)
        'pupilBookLendingFiles':
            pupilBookLendingFiles?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'lendingId': lendingId,
      if (status != null) 'status': status,
      'score': score,
      'lentAt': lentAt.toJson(),
      'lentBy': lentBy,
      if (returnedAt != null) 'returnedAt': returnedAt?.toJson(),
      if (receivedBy != null) 'receivedBy': receivedBy,
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
      'isbn': isbn,
      'libraryBookId': libraryBookId,
      if (libraryBook != null) 'libraryBook': libraryBook?.toJsonForProtocol(),
      if (pupilBookLendingFiles != null)
        'pupilBookLendingFiles': pupilBookLendingFiles?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static PupilBookLendingInclude include({
    _i2.PupilDataInclude? pupil,
    _i3.LibraryBookInclude? libraryBook,
    _i4.HubDocumentIncludeList? pupilBookLendingFiles,
  }) {
    return PupilBookLendingInclude._(
      pupil: pupil,
      libraryBook: libraryBook,
      pupilBookLendingFiles: pupilBookLendingFiles,
    );
  }

  static PupilBookLendingIncludeList includeList({
    _i1.WhereExpressionBuilder<PupilBookLendingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilBookLendingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilBookLendingTable>? orderByList,
    PupilBookLendingInclude? include,
  }) {
    return PupilBookLendingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PupilBookLending.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PupilBookLending.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilBookLendingImpl extends PupilBookLending {
  _PupilBookLendingImpl({
    int? id,
    required String lendingId,
    String? status,
    required int score,
    required DateTime lentAt,
    required String lentBy,
    DateTime? returnedAt,
    String? receivedBy,
    required int pupilId,
    _i2.PupilData? pupil,
    required int isbn,
    required int libraryBookId,
    _i3.LibraryBook? libraryBook,
    List<_i4.HubDocument>? pupilBookLendingFiles,
  }) : super._(
          id: id,
          lendingId: lendingId,
          status: status,
          score: score,
          lentAt: lentAt,
          lentBy: lentBy,
          returnedAt: returnedAt,
          receivedBy: receivedBy,
          pupilId: pupilId,
          pupil: pupil,
          isbn: isbn,
          libraryBookId: libraryBookId,
          libraryBook: libraryBook,
          pupilBookLendingFiles: pupilBookLendingFiles,
        );

  /// Returns a shallow copy of this [PupilBookLending]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilBookLending copyWith({
    Object? id = _Undefined,
    String? lendingId,
    Object? status = _Undefined,
    int? score,
    DateTime? lentAt,
    String? lentBy,
    Object? returnedAt = _Undefined,
    Object? receivedBy = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
    int? isbn,
    int? libraryBookId,
    Object? libraryBook = _Undefined,
    Object? pupilBookLendingFiles = _Undefined,
  }) {
    return PupilBookLending(
      id: id is int? ? id : this.id,
      lendingId: lendingId ?? this.lendingId,
      status: status is String? ? status : this.status,
      score: score ?? this.score,
      lentAt: lentAt ?? this.lentAt,
      lentBy: lentBy ?? this.lentBy,
      returnedAt: returnedAt is DateTime? ? returnedAt : this.returnedAt,
      receivedBy: receivedBy is String? ? receivedBy : this.receivedBy,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      isbn: isbn ?? this.isbn,
      libraryBookId: libraryBookId ?? this.libraryBookId,
      libraryBook: libraryBook is _i3.LibraryBook?
          ? libraryBook
          : this.libraryBook?.copyWith(),
      pupilBookLendingFiles: pupilBookLendingFiles is List<_i4.HubDocument>?
          ? pupilBookLendingFiles
          : this.pupilBookLendingFiles?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class PupilBookLendingTable extends _i1.Table<int?> {
  PupilBookLendingTable({super.tableRelation})
      : super(tableName: 'pupil_book_lending') {
    lendingId = _i1.ColumnString(
      'lendingId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    score = _i1.ColumnInt(
      'score',
      this,
    );
    lentAt = _i1.ColumnDateTime(
      'lentAt',
      this,
    );
    lentBy = _i1.ColumnString(
      'lentBy',
      this,
    );
    returnedAt = _i1.ColumnDateTime(
      'returnedAt',
      this,
    );
    receivedBy = _i1.ColumnString(
      'receivedBy',
      this,
    );
    pupilId = _i1.ColumnInt(
      'pupilId',
      this,
    );
    isbn = _i1.ColumnInt(
      'isbn',
      this,
    );
    libraryBookId = _i1.ColumnInt(
      'libraryBookId',
      this,
    );
  }

  late final _i1.ColumnString lendingId;

  late final _i1.ColumnString status;

  late final _i1.ColumnInt score;

  late final _i1.ColumnDateTime lentAt;

  late final _i1.ColumnString lentBy;

  late final _i1.ColumnDateTime returnedAt;

  late final _i1.ColumnString receivedBy;

  late final _i1.ColumnInt pupilId;

  _i2.PupilDataTable? _pupil;

  late final _i1.ColumnInt isbn;

  late final _i1.ColumnInt libraryBookId;

  _i3.LibraryBookTable? _libraryBook;

  _i4.HubDocumentTable? ___pupilBookLendingFiles;

  _i1.ManyRelation<_i4.HubDocumentTable>? _pupilBookLendingFiles;

  _i2.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: PupilBookLending.t.pupilId,
      foreignField: _i2.PupilData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilDataTable(tableRelation: foreignTableRelation),
    );
    return _pupil!;
  }

  _i3.LibraryBookTable get libraryBook {
    if (_libraryBook != null) return _libraryBook!;
    _libraryBook = _i1.createRelationTable(
      relationFieldName: 'libraryBook',
      field: PupilBookLending.t.libraryBookId,
      foreignField: _i3.LibraryBook.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.LibraryBookTable(tableRelation: foreignTableRelation),
    );
    return _libraryBook!;
  }

  _i4.HubDocumentTable get __pupilBookLendingFiles {
    if (___pupilBookLendingFiles != null) return ___pupilBookLendingFiles!;
    ___pupilBookLendingFiles = _i1.createRelationTable(
      relationFieldName: '__pupilBookLendingFiles',
      field: PupilBookLending.t.id,
      foreignField: _i4.HubDocument.t
          .$_pupilBookLendingPupilbooklendingfilesPupilBookLendingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    return ___pupilBookLendingFiles!;
  }

  _i1.ManyRelation<_i4.HubDocumentTable> get pupilBookLendingFiles {
    if (_pupilBookLendingFiles != null) return _pupilBookLendingFiles!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'pupilBookLendingFiles',
      field: PupilBookLending.t.id,
      foreignField: _i4.HubDocument.t
          .$_pupilBookLendingPupilbooklendingfilesPupilBookLendingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    _pupilBookLendingFiles = _i1.ManyRelation<_i4.HubDocumentTable>(
      tableWithRelations: relationTable,
      table: _i4.HubDocumentTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _pupilBookLendingFiles!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        lendingId,
        status,
        score,
        lentAt,
        lentBy,
        returnedAt,
        receivedBy,
        pupilId,
        isbn,
        libraryBookId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'pupil') {
      return pupil;
    }
    if (relationField == 'libraryBook') {
      return libraryBook;
    }
    if (relationField == 'pupilBookLendingFiles') {
      return __pupilBookLendingFiles;
    }
    return null;
  }
}

class PupilBookLendingInclude extends _i1.IncludeObject {
  PupilBookLendingInclude._({
    _i2.PupilDataInclude? pupil,
    _i3.LibraryBookInclude? libraryBook,
    _i4.HubDocumentIncludeList? pupilBookLendingFiles,
  }) {
    _pupil = pupil;
    _libraryBook = libraryBook;
    _pupilBookLendingFiles = pupilBookLendingFiles;
  }

  _i2.PupilDataInclude? _pupil;

  _i3.LibraryBookInclude? _libraryBook;

  _i4.HubDocumentIncludeList? _pupilBookLendingFiles;

  @override
  Map<String, _i1.Include?> get includes => {
        'pupil': _pupil,
        'libraryBook': _libraryBook,
        'pupilBookLendingFiles': _pupilBookLendingFiles,
      };

  @override
  _i1.Table<int?> get table => PupilBookLending.t;
}

class PupilBookLendingIncludeList extends _i1.IncludeList {
  PupilBookLendingIncludeList._({
    _i1.WhereExpressionBuilder<PupilBookLendingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PupilBookLending.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PupilBookLending.t;
}

class PupilBookLendingRepository {
  const PupilBookLendingRepository._();

  final attach = const PupilBookLendingAttachRepository._();

  final attachRow = const PupilBookLendingAttachRowRepository._();

  final detach = const PupilBookLendingDetachRepository._();

  final detachRow = const PupilBookLendingDetachRowRepository._();

  /// Returns a list of [PupilBookLending]s matching the given query parameters.
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
  Future<List<PupilBookLending>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilBookLendingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilBookLendingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilBookLendingTable>? orderByList,
    _i1.Transaction? transaction,
    PupilBookLendingInclude? include,
  }) async {
    return session.db.find<PupilBookLending>(
      where: where?.call(PupilBookLending.t),
      orderBy: orderBy?.call(PupilBookLending.t),
      orderByList: orderByList?.call(PupilBookLending.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PupilBookLending] matching the given query parameters.
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
  Future<PupilBookLending?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilBookLendingTable>? where,
    int? offset,
    _i1.OrderByBuilder<PupilBookLendingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilBookLendingTable>? orderByList,
    _i1.Transaction? transaction,
    PupilBookLendingInclude? include,
  }) async {
    return session.db.findFirstRow<PupilBookLending>(
      where: where?.call(PupilBookLending.t),
      orderBy: orderBy?.call(PupilBookLending.t),
      orderByList: orderByList?.call(PupilBookLending.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PupilBookLending] by its [id] or null if no such row exists.
  Future<PupilBookLending?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PupilBookLendingInclude? include,
  }) async {
    return session.db.findById<PupilBookLending>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PupilBookLending]s in the list and returns the inserted rows.
  ///
  /// The returned [PupilBookLending]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PupilBookLending>> insert(
    _i1.Session session,
    List<PupilBookLending> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PupilBookLending>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PupilBookLending] and returns the inserted row.
  ///
  /// The returned [PupilBookLending] will have its `id` field set.
  Future<PupilBookLending> insertRow(
    _i1.Session session,
    PupilBookLending row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PupilBookLending>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PupilBookLending]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PupilBookLending>> update(
    _i1.Session session,
    List<PupilBookLending> rows, {
    _i1.ColumnSelections<PupilBookLendingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PupilBookLending>(
      rows,
      columns: columns?.call(PupilBookLending.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PupilBookLending]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PupilBookLending> updateRow(
    _i1.Session session,
    PupilBookLending row, {
    _i1.ColumnSelections<PupilBookLendingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PupilBookLending>(
      row,
      columns: columns?.call(PupilBookLending.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PupilBookLending]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PupilBookLending>> delete(
    _i1.Session session,
    List<PupilBookLending> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PupilBookLending>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PupilBookLending].
  Future<PupilBookLending> deleteRow(
    _i1.Session session,
    PupilBookLending row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PupilBookLending>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PupilBookLending>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PupilBookLendingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PupilBookLending>(
      where: where(PupilBookLending.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilBookLendingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PupilBookLending>(
      where: where?.call(PupilBookLending.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PupilBookLendingAttachRepository {
  const PupilBookLendingAttachRepository._();

  /// Creates a relation between this [PupilBookLending] and the given [HubDocument]s
  /// by setting each [HubDocument]'s foreign key `_pupilBookLendingPupilbooklendingfilesPupilBookLendingId` to refer to this [PupilBookLending].
  Future<void> pupilBookLendingFiles(
    _i1.Session session,
    PupilBookLending pupilBookLending,
    List<_i4.HubDocument> hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.any((e) => e.id == null)) {
      throw ArgumentError.notNull('hubDocument.id');
    }
    if (pupilBookLending.id == null) {
      throw ArgumentError.notNull('pupilBookLending.id');
    }

    var $hubDocument = hubDocument
        .map((e) => _i4.HubDocumentImplicit(
              e,
              $_pupilBookLendingPupilbooklendingfilesPupilBookLendingId:
                  pupilBookLending.id,
            ))
        .toList();
    await session.db.update<_i4.HubDocument>(
      $hubDocument,
      columns: [
        _i4.HubDocument.t
            .$_pupilBookLendingPupilbooklendingfilesPupilBookLendingId
      ],
      transaction: transaction,
    );
  }
}

class PupilBookLendingAttachRowRepository {
  const PupilBookLendingAttachRowRepository._();

  /// Creates a relation between the given [PupilBookLending] and [PupilData]
  /// by setting the [PupilBookLending]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    PupilBookLending pupilBookLending,
    _i2.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilBookLending.id == null) {
      throw ArgumentError.notNull('pupilBookLending.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $pupilBookLending = pupilBookLending.copyWith(pupilId: pupil.id);
    await session.db.updateRow<PupilBookLending>(
      $pupilBookLending,
      columns: [PupilBookLending.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PupilBookLending] and [LibraryBook]
  /// by setting the [PupilBookLending]'s foreign key `libraryBookId` to refer to the [LibraryBook].
  Future<void> libraryBook(
    _i1.Session session,
    PupilBookLending pupilBookLending,
    _i3.LibraryBook libraryBook, {
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
    await session.db.updateRow<PupilBookLending>(
      $pupilBookLending,
      columns: [PupilBookLending.t.libraryBookId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [PupilBookLending] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_pupilBookLendingPupilbooklendingfilesPupilBookLendingId` to refer to this [PupilBookLending].
  Future<void> pupilBookLendingFiles(
    _i1.Session session,
    PupilBookLending pupilBookLending,
    _i4.HubDocument hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.id == null) {
      throw ArgumentError.notNull('hubDocument.id');
    }
    if (pupilBookLending.id == null) {
      throw ArgumentError.notNull('pupilBookLending.id');
    }

    var $hubDocument = _i4.HubDocumentImplicit(
      hubDocument,
      $_pupilBookLendingPupilbooklendingfilesPupilBookLendingId:
          pupilBookLending.id,
    );
    await session.db.updateRow<_i4.HubDocument>(
      $hubDocument,
      columns: [
        _i4.HubDocument.t
            .$_pupilBookLendingPupilbooklendingfilesPupilBookLendingId
      ],
      transaction: transaction,
    );
  }
}

class PupilBookLendingDetachRepository {
  const PupilBookLendingDetachRepository._();

  /// Detaches the relation between this [PupilBookLending] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_pupilBookLendingPupilbooklendingfilesPupilBookLendingId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> pupilBookLendingFiles(
    _i1.Session session,
    List<_i4.HubDocument> hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.any((e) => e.id == null)) {
      throw ArgumentError.notNull('hubDocument.id');
    }

    var $hubDocument = hubDocument
        .map((e) => _i4.HubDocumentImplicit(
              e,
              $_pupilBookLendingPupilbooklendingfilesPupilBookLendingId: null,
            ))
        .toList();
    await session.db.update<_i4.HubDocument>(
      $hubDocument,
      columns: [
        _i4.HubDocument.t
            .$_pupilBookLendingPupilbooklendingfilesPupilBookLendingId
      ],
      transaction: transaction,
    );
  }
}

class PupilBookLendingDetachRowRepository {
  const PupilBookLendingDetachRowRepository._();

  /// Detaches the relation between this [PupilBookLending] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_pupilBookLendingPupilbooklendingfilesPupilBookLendingId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> pupilBookLendingFiles(
    _i1.Session session,
    _i4.HubDocument hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.id == null) {
      throw ArgumentError.notNull('hubDocument.id');
    }

    var $hubDocument = _i4.HubDocumentImplicit(
      hubDocument,
      $_pupilBookLendingPupilbooklendingfilesPupilBookLendingId: null,
    );
    await session.db.updateRow<_i4.HubDocument>(
      $hubDocument,
      columns: [
        _i4.HubDocument.t
            .$_pupilBookLendingPupilbooklendingfilesPupilBookLendingId
      ],
      transaction: transaction,
    );
  }
}
