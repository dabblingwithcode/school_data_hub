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
import '../../../_features/workbooks/models/workbook.dart' as _i3;

abstract class PupilWorkbook
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PupilWorkbook._({
    this.id,
    required this.isbn,
    this.comment,
    required this.score,
    required this.createdBy,
    required this.createdAt,
    this.finishedAt,
    required this.pupilId,
    this.pupil,
    required this.workbookId,
    this.workbook,
  });

  factory PupilWorkbook({
    int? id,
    required int isbn,
    String? comment,
    required int score,
    required String createdBy,
    required DateTime createdAt,
    DateTime? finishedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int workbookId,
    _i3.Workbook? workbook,
  }) = _PupilWorkbookImpl;

  factory PupilWorkbook.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilWorkbook(
      id: jsonSerialization['id'] as int?,
      isbn: jsonSerialization['isbn'] as int,
      comment: jsonSerialization['comment'] as String?,
      score: jsonSerialization['score'] as int,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      finishedAt: jsonSerialization['finishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['finishedAt']),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      workbookId: jsonSerialization['workbookId'] as int,
      workbook: jsonSerialization['workbook'] == null
          ? null
          : _i3.Workbook.fromJson(
              (jsonSerialization['workbook'] as Map<String, dynamic>)),
    );
  }

  static final t = PupilWorkbookTable();

  static const db = PupilWorkbookRepository._();

  @override
  int? id;

  int isbn;

  String? comment;

  int score;

  String createdBy;

  DateTime createdAt;

  DateTime? finishedAt;

  int pupilId;

  _i2.PupilData? pupil;

  int workbookId;

  _i3.Workbook? workbook;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PupilWorkbook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilWorkbook copyWith({
    int? id,
    int? isbn,
    String? comment,
    int? score,
    String? createdBy,
    DateTime? createdAt,
    DateTime? finishedAt,
    int? pupilId,
    _i2.PupilData? pupil,
    int? workbookId,
    _i3.Workbook? workbook,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'isbn': isbn,
      if (comment != null) 'comment': comment,
      'score': score,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (finishedAt != null) 'finishedAt': finishedAt?.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'workbookId': workbookId,
      if (workbook != null) 'workbook': workbook?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'isbn': isbn,
      if (comment != null) 'comment': comment,
      'score': score,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (finishedAt != null) 'finishedAt': finishedAt?.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
      'workbookId': workbookId,
      if (workbook != null) 'workbook': workbook?.toJsonForProtocol(),
    };
  }

  static PupilWorkbookInclude include({
    _i2.PupilDataInclude? pupil,
    _i3.WorkbookInclude? workbook,
  }) {
    return PupilWorkbookInclude._(
      pupil: pupil,
      workbook: workbook,
    );
  }

  static PupilWorkbookIncludeList includeList({
    _i1.WhereExpressionBuilder<PupilWorkbookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilWorkbookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilWorkbookTable>? orderByList,
    PupilWorkbookInclude? include,
  }) {
    return PupilWorkbookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PupilWorkbook.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PupilWorkbook.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilWorkbookImpl extends PupilWorkbook {
  _PupilWorkbookImpl({
    int? id,
    required int isbn,
    String? comment,
    required int score,
    required String createdBy,
    required DateTime createdAt,
    DateTime? finishedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int workbookId,
    _i3.Workbook? workbook,
  }) : super._(
          id: id,
          isbn: isbn,
          comment: comment,
          score: score,
          createdBy: createdBy,
          createdAt: createdAt,
          finishedAt: finishedAt,
          pupilId: pupilId,
          pupil: pupil,
          workbookId: workbookId,
          workbook: workbook,
        );

  /// Returns a shallow copy of this [PupilWorkbook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilWorkbook copyWith({
    Object? id = _Undefined,
    int? isbn,
    Object? comment = _Undefined,
    int? score,
    String? createdBy,
    DateTime? createdAt,
    Object? finishedAt = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
    int? workbookId,
    Object? workbook = _Undefined,
  }) {
    return PupilWorkbook(
      id: id is int? ? id : this.id,
      isbn: isbn ?? this.isbn,
      comment: comment is String? ? comment : this.comment,
      score: score ?? this.score,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      finishedAt: finishedAt is DateTime? ? finishedAt : this.finishedAt,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      workbookId: workbookId ?? this.workbookId,
      workbook:
          workbook is _i3.Workbook? ? workbook : this.workbook?.copyWith(),
    );
  }
}

class PupilWorkbookTable extends _i1.Table<int?> {
  PupilWorkbookTable({super.tableRelation})
      : super(tableName: 'pupil_workbook') {
    isbn = _i1.ColumnInt(
      'isbn',
      this,
    );
    comment = _i1.ColumnString(
      'comment',
      this,
    );
    score = _i1.ColumnInt(
      'score',
      this,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    finishedAt = _i1.ColumnDateTime(
      'finishedAt',
      this,
    );
    pupilId = _i1.ColumnInt(
      'pupilId',
      this,
    );
    workbookId = _i1.ColumnInt(
      'workbookId',
      this,
    );
  }

  late final _i1.ColumnInt isbn;

  late final _i1.ColumnString comment;

  late final _i1.ColumnInt score;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime finishedAt;

  late final _i1.ColumnInt pupilId;

  _i2.PupilDataTable? _pupil;

  late final _i1.ColumnInt workbookId;

  _i3.WorkbookTable? _workbook;

  _i2.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: PupilWorkbook.t.pupilId,
      foreignField: _i2.PupilData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilDataTable(tableRelation: foreignTableRelation),
    );
    return _pupil!;
  }

  _i3.WorkbookTable get workbook {
    if (_workbook != null) return _workbook!;
    _workbook = _i1.createRelationTable(
      relationFieldName: 'workbook',
      field: PupilWorkbook.t.workbookId,
      foreignField: _i3.Workbook.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.WorkbookTable(tableRelation: foreignTableRelation),
    );
    return _workbook!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        isbn,
        comment,
        score,
        createdBy,
        createdAt,
        finishedAt,
        pupilId,
        workbookId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'pupil') {
      return pupil;
    }
    if (relationField == 'workbook') {
      return workbook;
    }
    return null;
  }
}

class PupilWorkbookInclude extends _i1.IncludeObject {
  PupilWorkbookInclude._({
    _i2.PupilDataInclude? pupil,
    _i3.WorkbookInclude? workbook,
  }) {
    _pupil = pupil;
    _workbook = workbook;
  }

  _i2.PupilDataInclude? _pupil;

  _i3.WorkbookInclude? _workbook;

  @override
  Map<String, _i1.Include?> get includes => {
        'pupil': _pupil,
        'workbook': _workbook,
      };

  @override
  _i1.Table<int?> get table => PupilWorkbook.t;
}

class PupilWorkbookIncludeList extends _i1.IncludeList {
  PupilWorkbookIncludeList._({
    _i1.WhereExpressionBuilder<PupilWorkbookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PupilWorkbook.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PupilWorkbook.t;
}

class PupilWorkbookRepository {
  const PupilWorkbookRepository._();

  final attachRow = const PupilWorkbookAttachRowRepository._();

  /// Returns a list of [PupilWorkbook]s matching the given query parameters.
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
  Future<List<PupilWorkbook>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilWorkbookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PupilWorkbookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilWorkbookTable>? orderByList,
    _i1.Transaction? transaction,
    PupilWorkbookInclude? include,
  }) async {
    return session.db.find<PupilWorkbook>(
      where: where?.call(PupilWorkbook.t),
      orderBy: orderBy?.call(PupilWorkbook.t),
      orderByList: orderByList?.call(PupilWorkbook.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PupilWorkbook] matching the given query parameters.
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
  Future<PupilWorkbook?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilWorkbookTable>? where,
    int? offset,
    _i1.OrderByBuilder<PupilWorkbookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PupilWorkbookTable>? orderByList,
    _i1.Transaction? transaction,
    PupilWorkbookInclude? include,
  }) async {
    return session.db.findFirstRow<PupilWorkbook>(
      where: where?.call(PupilWorkbook.t),
      orderBy: orderBy?.call(PupilWorkbook.t),
      orderByList: orderByList?.call(PupilWorkbook.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PupilWorkbook] by its [id] or null if no such row exists.
  Future<PupilWorkbook?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PupilWorkbookInclude? include,
  }) async {
    return session.db.findById<PupilWorkbook>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PupilWorkbook]s in the list and returns the inserted rows.
  ///
  /// The returned [PupilWorkbook]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PupilWorkbook>> insert(
    _i1.Session session,
    List<PupilWorkbook> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PupilWorkbook>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PupilWorkbook] and returns the inserted row.
  ///
  /// The returned [PupilWorkbook] will have its `id` field set.
  Future<PupilWorkbook> insertRow(
    _i1.Session session,
    PupilWorkbook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PupilWorkbook>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PupilWorkbook]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PupilWorkbook>> update(
    _i1.Session session,
    List<PupilWorkbook> rows, {
    _i1.ColumnSelections<PupilWorkbookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PupilWorkbook>(
      rows,
      columns: columns?.call(PupilWorkbook.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PupilWorkbook]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PupilWorkbook> updateRow(
    _i1.Session session,
    PupilWorkbook row, {
    _i1.ColumnSelections<PupilWorkbookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PupilWorkbook>(
      row,
      columns: columns?.call(PupilWorkbook.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PupilWorkbook]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PupilWorkbook>> delete(
    _i1.Session session,
    List<PupilWorkbook> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PupilWorkbook>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PupilWorkbook].
  Future<PupilWorkbook> deleteRow(
    _i1.Session session,
    PupilWorkbook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PupilWorkbook>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PupilWorkbook>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PupilWorkbookTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PupilWorkbook>(
      where: where(PupilWorkbook.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PupilWorkbookTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PupilWorkbook>(
      where: where?.call(PupilWorkbook.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PupilWorkbookAttachRowRepository {
  const PupilWorkbookAttachRowRepository._();

  /// Creates a relation between the given [PupilWorkbook] and [PupilData]
  /// by setting the [PupilWorkbook]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    PupilWorkbook pupilWorkbook,
    _i2.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilWorkbook.id == null) {
      throw ArgumentError.notNull('pupilWorkbook.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $pupilWorkbook = pupilWorkbook.copyWith(pupilId: pupil.id);
    await session.db.updateRow<PupilWorkbook>(
      $pupilWorkbook,
      columns: [PupilWorkbook.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PupilWorkbook] and [Workbook]
  /// by setting the [PupilWorkbook]'s foreign key `workbookId` to refer to the [Workbook].
  Future<void> workbook(
    _i1.Session session,
    PupilWorkbook pupilWorkbook,
    _i3.Workbook workbook, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilWorkbook.id == null) {
      throw ArgumentError.notNull('pupilWorkbook.id');
    }
    if (workbook.id == null) {
      throw ArgumentError.notNull('workbook.id');
    }

    var $pupilWorkbook = pupilWorkbook.copyWith(workbookId: workbook.id);
    await session.db.updateRow<PupilWorkbook>(
      $pupilWorkbook,
      columns: [PupilWorkbook.t.workbookId],
      transaction: transaction,
    );
  }
}
