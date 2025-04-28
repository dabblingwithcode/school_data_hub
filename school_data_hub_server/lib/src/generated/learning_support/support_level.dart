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
import '../pupil_data/pupil_data.dart' as _i2;

/// support level class
abstract class SupportLevel
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SupportLevel._({
    this.id,
    required this.level,
    required this.comment,
    required this.createdAt,
    required this.createdBy,
    required this.pupilIdId,
    this.pupilId,
  });

  factory SupportLevel({
    int? id,
    required int level,
    required String comment,
    required DateTime createdAt,
    required String createdBy,
    required int pupilIdId,
    _i2.PupilData? pupilId,
  }) = _SupportLevelImpl;

  factory SupportLevel.fromJson(Map<String, dynamic> jsonSerialization) {
    return SupportLevel(
      id: jsonSerialization['id'] as int?,
      level: jsonSerialization['level'] as int,
      comment: jsonSerialization['comment'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      createdBy: jsonSerialization['createdBy'] as String,
      pupilIdId: jsonSerialization['pupilIdId'] as int,
      pupilId: jsonSerialization['pupilId'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupilId'] as Map<String, dynamic>)),
    );
  }

  static final t = SupportLevelTable();

  static const db = SupportLevelRepository._();

  @override
  int? id;

  int level;

  String comment;

  DateTime createdAt;

  String createdBy;

  int pupilIdId;

  _i2.PupilData? pupilId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SupportLevel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportLevel copyWith({
    int? id,
    int? level,
    String? comment,
    DateTime? createdAt,
    String? createdBy,
    int? pupilIdId,
    _i2.PupilData? pupilId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'level': level,
      'comment': comment,
      'createdAt': createdAt.toJson(),
      'createdBy': createdBy,
      'pupilIdId': pupilIdId,
      if (pupilId != null) 'pupilId': pupilId?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'level': level,
      'comment': comment,
      'createdAt': createdAt.toJson(),
      'createdBy': createdBy,
      'pupilIdId': pupilIdId,
      if (pupilId != null) 'pupilId': pupilId?.toJsonForProtocol(),
    };
  }

  static SupportLevelInclude include({_i2.PupilDataInclude? pupilId}) {
    return SupportLevelInclude._(pupilId: pupilId);
  }

  static SupportLevelIncludeList includeList({
    _i1.WhereExpressionBuilder<SupportLevelTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupportLevelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportLevelTable>? orderByList,
    SupportLevelInclude? include,
  }) {
    return SupportLevelIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SupportLevel.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SupportLevel.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportLevelImpl extends SupportLevel {
  _SupportLevelImpl({
    int? id,
    required int level,
    required String comment,
    required DateTime createdAt,
    required String createdBy,
    required int pupilIdId,
    _i2.PupilData? pupilId,
  }) : super._(
          id: id,
          level: level,
          comment: comment,
          createdAt: createdAt,
          createdBy: createdBy,
          pupilIdId: pupilIdId,
          pupilId: pupilId,
        );

  /// Returns a shallow copy of this [SupportLevel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportLevel copyWith({
    Object? id = _Undefined,
    int? level,
    String? comment,
    DateTime? createdAt,
    String? createdBy,
    int? pupilIdId,
    Object? pupilId = _Undefined,
  }) {
    return SupportLevel(
      id: id is int? ? id : this.id,
      level: level ?? this.level,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      pupilIdId: pupilIdId ?? this.pupilIdId,
      pupilId: pupilId is _i2.PupilData? ? pupilId : this.pupilId?.copyWith(),
    );
  }
}

class SupportLevelTable extends _i1.Table<int?> {
  SupportLevelTable({super.tableRelation}) : super(tableName: 'support_level') {
    level = _i1.ColumnInt(
      'level',
      this,
    );
    comment = _i1.ColumnString(
      'comment',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    pupilIdId = _i1.ColumnInt(
      'pupilIdId',
      this,
    );
  }

  late final _i1.ColumnInt level;

  late final _i1.ColumnString comment;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnInt pupilIdId;

  _i2.PupilDataTable? _pupilId;

  _i2.PupilDataTable get pupilId {
    if (_pupilId != null) return _pupilId!;
    _pupilId = _i1.createRelationTable(
      relationFieldName: 'pupilId',
      field: SupportLevel.t.pupilIdId,
      foreignField: _i2.PupilData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilDataTable(tableRelation: foreignTableRelation),
    );
    return _pupilId!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        level,
        comment,
        createdAt,
        createdBy,
        pupilIdId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'pupilId') {
      return pupilId;
    }
    return null;
  }
}

class SupportLevelInclude extends _i1.IncludeObject {
  SupportLevelInclude._({_i2.PupilDataInclude? pupilId}) {
    _pupilId = pupilId;
  }

  _i2.PupilDataInclude? _pupilId;

  @override
  Map<String, _i1.Include?> get includes => {'pupilId': _pupilId};

  @override
  _i1.Table<int?> get table => SupportLevel.t;
}

class SupportLevelIncludeList extends _i1.IncludeList {
  SupportLevelIncludeList._({
    _i1.WhereExpressionBuilder<SupportLevelTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SupportLevel.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SupportLevel.t;
}

class SupportLevelRepository {
  const SupportLevelRepository._();

  final attachRow = const SupportLevelAttachRowRepository._();

  /// Returns a list of [SupportLevel]s matching the given query parameters.
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
  Future<List<SupportLevel>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportLevelTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupportLevelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportLevelTable>? orderByList,
    _i1.Transaction? transaction,
    SupportLevelInclude? include,
  }) async {
    return session.db.find<SupportLevel>(
      where: where?.call(SupportLevel.t),
      orderBy: orderBy?.call(SupportLevel.t),
      orderByList: orderByList?.call(SupportLevel.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SupportLevel] matching the given query parameters.
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
  Future<SupportLevel?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportLevelTable>? where,
    int? offset,
    _i1.OrderByBuilder<SupportLevelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportLevelTable>? orderByList,
    _i1.Transaction? transaction,
    SupportLevelInclude? include,
  }) async {
    return session.db.findFirstRow<SupportLevel>(
      where: where?.call(SupportLevel.t),
      orderBy: orderBy?.call(SupportLevel.t),
      orderByList: orderByList?.call(SupportLevel.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SupportLevel] by its [id] or null if no such row exists.
  Future<SupportLevel?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SupportLevelInclude? include,
  }) async {
    return session.db.findById<SupportLevel>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SupportLevel]s in the list and returns the inserted rows.
  ///
  /// The returned [SupportLevel]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SupportLevel>> insert(
    _i1.Session session,
    List<SupportLevel> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SupportLevel>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SupportLevel] and returns the inserted row.
  ///
  /// The returned [SupportLevel] will have its `id` field set.
  Future<SupportLevel> insertRow(
    _i1.Session session,
    SupportLevel row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SupportLevel>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SupportLevel]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SupportLevel>> update(
    _i1.Session session,
    List<SupportLevel> rows, {
    _i1.ColumnSelections<SupportLevelTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SupportLevel>(
      rows,
      columns: columns?.call(SupportLevel.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SupportLevel]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SupportLevel> updateRow(
    _i1.Session session,
    SupportLevel row, {
    _i1.ColumnSelections<SupportLevelTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SupportLevel>(
      row,
      columns: columns?.call(SupportLevel.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SupportLevel]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SupportLevel>> delete(
    _i1.Session session,
    List<SupportLevel> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SupportLevel>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SupportLevel].
  Future<SupportLevel> deleteRow(
    _i1.Session session,
    SupportLevel row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SupportLevel>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SupportLevel>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SupportLevelTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SupportLevel>(
      where: where(SupportLevel.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportLevelTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SupportLevel>(
      where: where?.call(SupportLevel.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SupportLevelAttachRowRepository {
  const SupportLevelAttachRowRepository._();

  /// Creates a relation between the given [SupportLevel] and [PupilData]
  /// by setting the [SupportLevel]'s foreign key `pupilIdId` to refer to the [PupilData].
  Future<void> pupilId(
    _i1.Session session,
    SupportLevel supportLevel,
    _i2.PupilData pupilId, {
    _i1.Transaction? transaction,
  }) async {
    if (supportLevel.id == null) {
      throw ArgumentError.notNull('supportLevel.id');
    }
    if (pupilId.id == null) {
      throw ArgumentError.notNull('pupilId.id');
    }

    var $supportLevel = supportLevel.copyWith(pupilIdId: pupilId.id);
    await session.db.updateRow<SupportLevel>(
      $supportLevel,
      columns: [SupportLevel.t.pupilIdId],
      transaction: transaction,
    );
  }
}
