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
import '../workbook/pupil_workbook.dart' as _i2;

abstract class Workbook
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Workbook._({
    this.id,
    required this.isbn,
    required this.name,
    required this.subject,
    required this.level,
    required this.amount,
    required this.imageId,
    required this.imageUrl,
    this.assignedPupils,
  });

  factory Workbook({
    int? id,
    required int isbn,
    required String name,
    required String subject,
    required String level,
    required int amount,
    required String imageId,
    required String imageUrl,
    List<_i2.PupilWorkbook>? assignedPupils,
  }) = _WorkbookImpl;

  factory Workbook.fromJson(Map<String, dynamic> jsonSerialization) {
    return Workbook(
      id: jsonSerialization['id'] as int?,
      isbn: jsonSerialization['isbn'] as int,
      name: jsonSerialization['name'] as String,
      subject: jsonSerialization['subject'] as String,
      level: jsonSerialization['level'] as String,
      amount: jsonSerialization['amount'] as int,
      imageId: jsonSerialization['imageId'] as String,
      imageUrl: jsonSerialization['imageUrl'] as String,
      assignedPupils: (jsonSerialization['assignedPupils'] as List?)
          ?.map((e) => _i2.PupilWorkbook.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = WorkbookTable();

  static const db = WorkbookRepository._();

  @override
  int? id;

  int isbn;

  String name;

  String subject;

  String level;

  int amount;

  String imageId;

  String imageUrl;

  List<_i2.PupilWorkbook>? assignedPupils;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Workbook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Workbook copyWith({
    int? id,
    int? isbn,
    String? name,
    String? subject,
    String? level,
    int? amount,
    String? imageId,
    String? imageUrl,
    List<_i2.PupilWorkbook>? assignedPupils,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'isbn': isbn,
      'name': name,
      'subject': subject,
      'level': level,
      'amount': amount,
      'imageId': imageId,
      'imageUrl': imageUrl,
      if (assignedPupils != null)
        'assignedPupils':
            assignedPupils?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'isbn': isbn,
      'name': name,
      'subject': subject,
      'level': level,
      'amount': amount,
      'imageId': imageId,
      'imageUrl': imageUrl,
      if (assignedPupils != null)
        'assignedPupils':
            assignedPupils?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static WorkbookInclude include(
      {_i2.PupilWorkbookIncludeList? assignedPupils}) {
    return WorkbookInclude._(assignedPupils: assignedPupils);
  }

  static WorkbookIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkbookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkbookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkbookTable>? orderByList,
    WorkbookInclude? include,
  }) {
    return WorkbookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Workbook.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Workbook.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkbookImpl extends Workbook {
  _WorkbookImpl({
    int? id,
    required int isbn,
    required String name,
    required String subject,
    required String level,
    required int amount,
    required String imageId,
    required String imageUrl,
    List<_i2.PupilWorkbook>? assignedPupils,
  }) : super._(
          id: id,
          isbn: isbn,
          name: name,
          subject: subject,
          level: level,
          amount: amount,
          imageId: imageId,
          imageUrl: imageUrl,
          assignedPupils: assignedPupils,
        );

  /// Returns a shallow copy of this [Workbook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Workbook copyWith({
    Object? id = _Undefined,
    int? isbn,
    String? name,
    String? subject,
    String? level,
    int? amount,
    String? imageId,
    String? imageUrl,
    Object? assignedPupils = _Undefined,
  }) {
    return Workbook(
      id: id is int? ? id : this.id,
      isbn: isbn ?? this.isbn,
      name: name ?? this.name,
      subject: subject ?? this.subject,
      level: level ?? this.level,
      amount: amount ?? this.amount,
      imageId: imageId ?? this.imageId,
      imageUrl: imageUrl ?? this.imageUrl,
      assignedPupils: assignedPupils is List<_i2.PupilWorkbook>?
          ? assignedPupils
          : this.assignedPupils?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class WorkbookTable extends _i1.Table<int?> {
  WorkbookTable({super.tableRelation}) : super(tableName: 'workbook') {
    isbn = _i1.ColumnInt(
      'isbn',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    subject = _i1.ColumnString(
      'subject',
      this,
    );
    level = _i1.ColumnString(
      'level',
      this,
    );
    amount = _i1.ColumnInt(
      'amount',
      this,
    );
    imageId = _i1.ColumnString(
      'imageId',
      this,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
  }

  late final _i1.ColumnInt isbn;

  late final _i1.ColumnString name;

  late final _i1.ColumnString subject;

  late final _i1.ColumnString level;

  late final _i1.ColumnInt amount;

  late final _i1.ColumnString imageId;

  late final _i1.ColumnString imageUrl;

  _i2.PupilWorkbookTable? ___assignedPupils;

  _i1.ManyRelation<_i2.PupilWorkbookTable>? _assignedPupils;

  _i2.PupilWorkbookTable get __assignedPupils {
    if (___assignedPupils != null) return ___assignedPupils!;
    ___assignedPupils = _i1.createRelationTable(
      relationFieldName: '__assignedPupils',
      field: Workbook.t.id,
      foreignField: _i2.PupilWorkbook.t.workbookId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilWorkbookTable(tableRelation: foreignTableRelation),
    );
    return ___assignedPupils!;
  }

  _i1.ManyRelation<_i2.PupilWorkbookTable> get assignedPupils {
    if (_assignedPupils != null) return _assignedPupils!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'assignedPupils',
      field: Workbook.t.id,
      foreignField: _i2.PupilWorkbook.t.workbookId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilWorkbookTable(tableRelation: foreignTableRelation),
    );
    _assignedPupils = _i1.ManyRelation<_i2.PupilWorkbookTable>(
      tableWithRelations: relationTable,
      table: _i2.PupilWorkbookTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _assignedPupils!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        isbn,
        name,
        subject,
        level,
        amount,
        imageId,
        imageUrl,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'assignedPupils') {
      return __assignedPupils;
    }
    return null;
  }
}

class WorkbookInclude extends _i1.IncludeObject {
  WorkbookInclude._({_i2.PupilWorkbookIncludeList? assignedPupils}) {
    _assignedPupils = assignedPupils;
  }

  _i2.PupilWorkbookIncludeList? _assignedPupils;

  @override
  Map<String, _i1.Include?> get includes => {'assignedPupils': _assignedPupils};

  @override
  _i1.Table<int?> get table => Workbook.t;
}

class WorkbookIncludeList extends _i1.IncludeList {
  WorkbookIncludeList._({
    _i1.WhereExpressionBuilder<WorkbookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Workbook.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Workbook.t;
}

class WorkbookRepository {
  const WorkbookRepository._();

  final attach = const WorkbookAttachRepository._();

  final attachRow = const WorkbookAttachRowRepository._();

  /// Returns a list of [Workbook]s matching the given query parameters.
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
  Future<List<Workbook>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkbookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkbookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkbookTable>? orderByList,
    _i1.Transaction? transaction,
    WorkbookInclude? include,
  }) async {
    return session.db.find<Workbook>(
      where: where?.call(Workbook.t),
      orderBy: orderBy?.call(Workbook.t),
      orderByList: orderByList?.call(Workbook.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Workbook] matching the given query parameters.
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
  Future<Workbook?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkbookTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkbookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkbookTable>? orderByList,
    _i1.Transaction? transaction,
    WorkbookInclude? include,
  }) async {
    return session.db.findFirstRow<Workbook>(
      where: where?.call(Workbook.t),
      orderBy: orderBy?.call(Workbook.t),
      orderByList: orderByList?.call(Workbook.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Workbook] by its [id] or null if no such row exists.
  Future<Workbook?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    WorkbookInclude? include,
  }) async {
    return session.db.findById<Workbook>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Workbook]s in the list and returns the inserted rows.
  ///
  /// The returned [Workbook]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Workbook>> insert(
    _i1.Session session,
    List<Workbook> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Workbook>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Workbook] and returns the inserted row.
  ///
  /// The returned [Workbook] will have its `id` field set.
  Future<Workbook> insertRow(
    _i1.Session session,
    Workbook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Workbook>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Workbook]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Workbook>> update(
    _i1.Session session,
    List<Workbook> rows, {
    _i1.ColumnSelections<WorkbookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Workbook>(
      rows,
      columns: columns?.call(Workbook.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Workbook]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Workbook> updateRow(
    _i1.Session session,
    Workbook row, {
    _i1.ColumnSelections<WorkbookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Workbook>(
      row,
      columns: columns?.call(Workbook.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Workbook]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Workbook>> delete(
    _i1.Session session,
    List<Workbook> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Workbook>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Workbook].
  Future<Workbook> deleteRow(
    _i1.Session session,
    Workbook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Workbook>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Workbook>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<WorkbookTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Workbook>(
      where: where(Workbook.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkbookTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Workbook>(
      where: where?.call(Workbook.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class WorkbookAttachRepository {
  const WorkbookAttachRepository._();

  /// Creates a relation between this [Workbook] and the given [PupilWorkbook]s
  /// by setting each [PupilWorkbook]'s foreign key `workbookId` to refer to this [Workbook].
  Future<void> assignedPupils(
    _i1.Session session,
    Workbook workbook,
    List<_i2.PupilWorkbook> pupilWorkbook, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilWorkbook.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pupilWorkbook.id');
    }
    if (workbook.id == null) {
      throw ArgumentError.notNull('workbook.id');
    }

    var $pupilWorkbook =
        pupilWorkbook.map((e) => e.copyWith(workbookId: workbook.id)).toList();
    await session.db.update<_i2.PupilWorkbook>(
      $pupilWorkbook,
      columns: [_i2.PupilWorkbook.t.workbookId],
      transaction: transaction,
    );
  }
}

class WorkbookAttachRowRepository {
  const WorkbookAttachRowRepository._();

  /// Creates a relation between this [Workbook] and the given [PupilWorkbook]
  /// by setting the [PupilWorkbook]'s foreign key `workbookId` to refer to this [Workbook].
  Future<void> assignedPupils(
    _i1.Session session,
    Workbook workbook,
    _i2.PupilWorkbook pupilWorkbook, {
    _i1.Transaction? transaction,
  }) async {
    if (pupilWorkbook.id == null) {
      throw ArgumentError.notNull('pupilWorkbook.id');
    }
    if (workbook.id == null) {
      throw ArgumentError.notNull('workbook.id');
    }

    var $pupilWorkbook = pupilWorkbook.copyWith(workbookId: workbook.id);
    await session.db.updateRow<_i2.PupilWorkbook>(
      $pupilWorkbook,
      columns: [_i2.PupilWorkbook.t.workbookId],
      transaction: transaction,
    );
  }
}
