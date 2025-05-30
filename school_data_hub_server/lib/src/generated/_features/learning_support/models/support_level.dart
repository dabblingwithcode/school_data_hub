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
import '../../../_features/learning_support/models/learning_support_plan.dart'
    as _i3;

abstract class SupportLevel
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SupportLevel._({
    this.id,
    required this.level,
    required this.comment,
    required this.createdAt,
    required this.createdBy,
    required this.pupilId,
    this.pupil,
    this.learningSupportPlans,
  });

  factory SupportLevel({
    int? id,
    required int level,
    required String comment,
    required DateTime createdAt,
    required String createdBy,
    required int pupilId,
    _i2.PupilData? pupil,
    List<_i3.LearningSupportPlan>? learningSupportPlans,
  }) = _SupportLevelImpl;

  factory SupportLevel.fromJson(Map<String, dynamic> jsonSerialization) {
    return SupportLevel(
      id: jsonSerialization['id'] as int?,
      level: jsonSerialization['level'] as int,
      comment: jsonSerialization['comment'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      createdBy: jsonSerialization['createdBy'] as String,
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      learningSupportPlans: (jsonSerialization['learningSupportPlans'] as List?)
          ?.map((e) =>
              _i3.LearningSupportPlan.fromJson((e as Map<String, dynamic>)))
          .toList(),
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

  int pupilId;

  _i2.PupilData? pupil;

  List<_i3.LearningSupportPlan>? learningSupportPlans;

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
    int? pupilId,
    _i2.PupilData? pupil,
    List<_i3.LearningSupportPlan>? learningSupportPlans,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'level': level,
      'comment': comment,
      'createdAt': createdAt.toJson(),
      'createdBy': createdBy,
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      if (learningSupportPlans != null)
        'learningSupportPlans':
            learningSupportPlans?.toJson(valueToJson: (v) => v.toJson()),
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
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
      if (learningSupportPlans != null)
        'learningSupportPlans': learningSupportPlans?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static SupportLevelInclude include({
    _i2.PupilDataInclude? pupil,
    _i3.LearningSupportPlanIncludeList? learningSupportPlans,
  }) {
    return SupportLevelInclude._(
      pupil: pupil,
      learningSupportPlans: learningSupportPlans,
    );
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
    required int pupilId,
    _i2.PupilData? pupil,
    List<_i3.LearningSupportPlan>? learningSupportPlans,
  }) : super._(
          id: id,
          level: level,
          comment: comment,
          createdAt: createdAt,
          createdBy: createdBy,
          pupilId: pupilId,
          pupil: pupil,
          learningSupportPlans: learningSupportPlans,
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
    int? pupilId,
    Object? pupil = _Undefined,
    Object? learningSupportPlans = _Undefined,
  }) {
    return SupportLevel(
      id: id is int? ? id : this.id,
      level: level ?? this.level,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      learningSupportPlans:
          learningSupportPlans is List<_i3.LearningSupportPlan>?
              ? learningSupportPlans
              : this.learningSupportPlans?.map((e0) => e0.copyWith()).toList(),
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
    pupilId = _i1.ColumnInt(
      'pupilId',
      this,
    );
  }

  late final _i1.ColumnInt level;

  late final _i1.ColumnString comment;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnInt pupilId;

  _i2.PupilDataTable? _pupil;

  _i3.LearningSupportPlanTable? ___learningSupportPlans;

  _i1.ManyRelation<_i3.LearningSupportPlanTable>? _learningSupportPlans;

  _i2.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: SupportLevel.t.pupilId,
      foreignField: _i2.PupilData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilDataTable(tableRelation: foreignTableRelation),
    );
    return _pupil!;
  }

  _i3.LearningSupportPlanTable get __learningSupportPlans {
    if (___learningSupportPlans != null) return ___learningSupportPlans!;
    ___learningSupportPlans = _i1.createRelationTable(
      relationFieldName: '__learningSupportPlans',
      field: SupportLevel.t.id,
      foreignField: _i3.LearningSupportPlan.t.learningSupportLevelId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.LearningSupportPlanTable(tableRelation: foreignTableRelation),
    );
    return ___learningSupportPlans!;
  }

  _i1.ManyRelation<_i3.LearningSupportPlanTable> get learningSupportPlans {
    if (_learningSupportPlans != null) return _learningSupportPlans!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'learningSupportPlans',
      field: SupportLevel.t.id,
      foreignField: _i3.LearningSupportPlan.t.learningSupportLevelId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.LearningSupportPlanTable(tableRelation: foreignTableRelation),
    );
    _learningSupportPlans = _i1.ManyRelation<_i3.LearningSupportPlanTable>(
      tableWithRelations: relationTable,
      table: _i3.LearningSupportPlanTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _learningSupportPlans!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        level,
        comment,
        createdAt,
        createdBy,
        pupilId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'pupil') {
      return pupil;
    }
    if (relationField == 'learningSupportPlans') {
      return __learningSupportPlans;
    }
    return null;
  }
}

class SupportLevelInclude extends _i1.IncludeObject {
  SupportLevelInclude._({
    _i2.PupilDataInclude? pupil,
    _i3.LearningSupportPlanIncludeList? learningSupportPlans,
  }) {
    _pupil = pupil;
    _learningSupportPlans = learningSupportPlans;
  }

  _i2.PupilDataInclude? _pupil;

  _i3.LearningSupportPlanIncludeList? _learningSupportPlans;

  @override
  Map<String, _i1.Include?> get includes => {
        'pupil': _pupil,
        'learningSupportPlans': _learningSupportPlans,
      };

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

  final attach = const SupportLevelAttachRepository._();

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

class SupportLevelAttachRepository {
  const SupportLevelAttachRepository._();

  /// Creates a relation between this [SupportLevel] and the given [LearningSupportPlan]s
  /// by setting each [LearningSupportPlan]'s foreign key `learningSupportLevelId` to refer to this [SupportLevel].
  Future<void> learningSupportPlans(
    _i1.Session session,
    SupportLevel supportLevel,
    List<_i3.LearningSupportPlan> learningSupportPlan, {
    _i1.Transaction? transaction,
  }) async {
    if (learningSupportPlan.any((e) => e.id == null)) {
      throw ArgumentError.notNull('learningSupportPlan.id');
    }
    if (supportLevel.id == null) {
      throw ArgumentError.notNull('supportLevel.id');
    }

    var $learningSupportPlan = learningSupportPlan
        .map((e) => e.copyWith(learningSupportLevelId: supportLevel.id))
        .toList();
    await session.db.update<_i3.LearningSupportPlan>(
      $learningSupportPlan,
      columns: [_i3.LearningSupportPlan.t.learningSupportLevelId],
      transaction: transaction,
    );
  }
}

class SupportLevelAttachRowRepository {
  const SupportLevelAttachRowRepository._();

  /// Creates a relation between the given [SupportLevel] and [PupilData]
  /// by setting the [SupportLevel]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    SupportLevel supportLevel,
    _i2.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (supportLevel.id == null) {
      throw ArgumentError.notNull('supportLevel.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $supportLevel = supportLevel.copyWith(pupilId: pupil.id);
    await session.db.updateRow<SupportLevel>(
      $supportLevel,
      columns: [SupportLevel.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SupportLevel] and the given [LearningSupportPlan]
  /// by setting the [LearningSupportPlan]'s foreign key `learningSupportLevelId` to refer to this [SupportLevel].
  Future<void> learningSupportPlans(
    _i1.Session session,
    SupportLevel supportLevel,
    _i3.LearningSupportPlan learningSupportPlan, {
    _i1.Transaction? transaction,
  }) async {
    if (learningSupportPlan.id == null) {
      throw ArgumentError.notNull('learningSupportPlan.id');
    }
    if (supportLevel.id == null) {
      throw ArgumentError.notNull('supportLevel.id');
    }

    var $learningSupportPlan =
        learningSupportPlan.copyWith(learningSupportLevelId: supportLevel.id);
    await session.db.updateRow<_i3.LearningSupportPlan>(
      $learningSupportPlan,
      columns: [_i3.LearningSupportPlan.t.learningSupportLevelId],
      transaction: transaction,
    );
  }
}
