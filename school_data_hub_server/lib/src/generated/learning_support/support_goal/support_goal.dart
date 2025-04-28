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
import '../../pupil_data/pupil_data.dart' as _i2;
import '../../learning_support/support_category.dart' as _i3;
import '../../learning_support/support_goal/support_goal_check.dart' as _i4;

abstract class SupportGoal
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SupportGoal._({
    this.id,
    required this.goalId,
    required this.createdBy,
    required this.createdAt,
    required this.achieved,
    required this.achievedAt,
    required this.description,
    required this.strategies,
    required this.pupilId,
    this.pupil,
    required this.supportCategoryId,
    this.supportCategory,
    this.goalChecks,
  })  : _supportCategoryCategorygoalsSupportCategoryId = null,
        _pupilDataSupportgoalsPupilDataId = null;

  factory SupportGoal({
    int? id,
    required String goalId,
    required String createdBy,
    required DateTime createdAt,
    required int achieved,
    required DateTime achievedAt,
    required String description,
    required List<String> strategies,
    required int pupilId,
    _i2.PupilData? pupil,
    required int supportCategoryId,
    _i3.SupportCategory? supportCategory,
    List<_i4.SupportGoalCheck>? goalChecks,
  }) = _SupportGoalImpl;

  factory SupportGoal.fromJson(Map<String, dynamic> jsonSerialization) {
    return SupportGoalImplicit._(
      id: jsonSerialization['id'] as int?,
      goalId: jsonSerialization['goalId'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      achieved: jsonSerialization['achieved'] as int,
      achievedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['achievedAt']),
      description: jsonSerialization['description'] as String,
      strategies: (jsonSerialization['strategies'] as List)
          .map((e) => e as String)
          .toList(),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      supportCategoryId: jsonSerialization['supportCategoryId'] as int,
      supportCategory: jsonSerialization['supportCategory'] == null
          ? null
          : _i3.SupportCategory.fromJson(
              (jsonSerialization['supportCategory'] as Map<String, dynamic>)),
      goalChecks: (jsonSerialization['goalChecks'] as List?)
          ?.map(
              (e) => _i4.SupportGoalCheck.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $_supportCategoryCategorygoalsSupportCategoryId:
          jsonSerialization['_supportCategoryCategorygoalsSupportCategoryId']
              as int?,
      $_pupilDataSupportgoalsPupilDataId:
          jsonSerialization['_pupilDataSupportgoalsPupilDataId'] as int?,
    );
  }

  static final t = SupportGoalTable();

  static const db = SupportGoalRepository._();

  @override
  int? id;

  String goalId;

  String createdBy;

  DateTime createdAt;

  int achieved;

  DateTime achievedAt;

  String description;

  List<String> strategies;

  int pupilId;

  _i2.PupilData? pupil;

  int supportCategoryId;

  _i3.SupportCategory? supportCategory;

  List<_i4.SupportGoalCheck>? goalChecks;

  final int? _supportCategoryCategorygoalsSupportCategoryId;

  final int? _pupilDataSupportgoalsPupilDataId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SupportGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportGoal copyWith({
    int? id,
    String? goalId,
    String? createdBy,
    DateTime? createdAt,
    int? achieved,
    DateTime? achievedAt,
    String? description,
    List<String>? strategies,
    int? pupilId,
    _i2.PupilData? pupil,
    int? supportCategoryId,
    _i3.SupportCategory? supportCategory,
    List<_i4.SupportGoalCheck>? goalChecks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'goalId': goalId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'achieved': achieved,
      'achievedAt': achievedAt.toJson(),
      'description': description,
      'strategies': strategies.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'supportCategoryId': supportCategoryId,
      if (supportCategory != null) 'supportCategory': supportCategory?.toJson(),
      if (goalChecks != null)
        'goalChecks': goalChecks?.toJson(valueToJson: (v) => v.toJson()),
      if (_supportCategoryCategorygoalsSupportCategoryId != null)
        '_supportCategoryCategorygoalsSupportCategoryId':
            _supportCategoryCategorygoalsSupportCategoryId,
      if (_pupilDataSupportgoalsPupilDataId != null)
        '_pupilDataSupportgoalsPupilDataId': _pupilDataSupportgoalsPupilDataId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'goalId': goalId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'achieved': achieved,
      'achievedAt': achievedAt.toJson(),
      'description': description,
      'strategies': strategies.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
      'supportCategoryId': supportCategoryId,
      if (supportCategory != null)
        'supportCategory': supportCategory?.toJsonForProtocol(),
      if (goalChecks != null)
        'goalChecks':
            goalChecks?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static SupportGoalInclude include({
    _i2.PupilDataInclude? pupil,
    _i3.SupportCategoryInclude? supportCategory,
    _i4.SupportGoalCheckIncludeList? goalChecks,
  }) {
    return SupportGoalInclude._(
      pupil: pupil,
      supportCategory: supportCategory,
      goalChecks: goalChecks,
    );
  }

  static SupportGoalIncludeList includeList({
    _i1.WhereExpressionBuilder<SupportGoalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupportGoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportGoalTable>? orderByList,
    SupportGoalInclude? include,
  }) {
    return SupportGoalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SupportGoal.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SupportGoal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportGoalImpl extends SupportGoal {
  _SupportGoalImpl({
    int? id,
    required String goalId,
    required String createdBy,
    required DateTime createdAt,
    required int achieved,
    required DateTime achievedAt,
    required String description,
    required List<String> strategies,
    required int pupilId,
    _i2.PupilData? pupil,
    required int supportCategoryId,
    _i3.SupportCategory? supportCategory,
    List<_i4.SupportGoalCheck>? goalChecks,
  }) : super._(
          id: id,
          goalId: goalId,
          createdBy: createdBy,
          createdAt: createdAt,
          achieved: achieved,
          achievedAt: achievedAt,
          description: description,
          strategies: strategies,
          pupilId: pupilId,
          pupil: pupil,
          supportCategoryId: supportCategoryId,
          supportCategory: supportCategory,
          goalChecks: goalChecks,
        );

  /// Returns a shallow copy of this [SupportGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportGoal copyWith({
    Object? id = _Undefined,
    String? goalId,
    String? createdBy,
    DateTime? createdAt,
    int? achieved,
    DateTime? achievedAt,
    String? description,
    List<String>? strategies,
    int? pupilId,
    Object? pupil = _Undefined,
    int? supportCategoryId,
    Object? supportCategory = _Undefined,
    Object? goalChecks = _Undefined,
  }) {
    return SupportGoalImplicit._(
      id: id is int? ? id : this.id,
      goalId: goalId ?? this.goalId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      achieved: achieved ?? this.achieved,
      achievedAt: achievedAt ?? this.achievedAt,
      description: description ?? this.description,
      strategies: strategies ?? this.strategies.map((e0) => e0).toList(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      supportCategoryId: supportCategoryId ?? this.supportCategoryId,
      supportCategory: supportCategory is _i3.SupportCategory?
          ? supportCategory
          : this.supportCategory?.copyWith(),
      goalChecks: goalChecks is List<_i4.SupportGoalCheck>?
          ? goalChecks
          : this.goalChecks?.map((e0) => e0.copyWith()).toList(),
      $_supportCategoryCategorygoalsSupportCategoryId:
          this._supportCategoryCategorygoalsSupportCategoryId,
      $_pupilDataSupportgoalsPupilDataId:
          this._pupilDataSupportgoalsPupilDataId,
    );
  }
}

class SupportGoalImplicit extends _SupportGoalImpl {
  SupportGoalImplicit._({
    int? id,
    required String goalId,
    required String createdBy,
    required DateTime createdAt,
    required int achieved,
    required DateTime achievedAt,
    required String description,
    required List<String> strategies,
    required int pupilId,
    _i2.PupilData? pupil,
    required int supportCategoryId,
    _i3.SupportCategory? supportCategory,
    List<_i4.SupportGoalCheck>? goalChecks,
    int? $_supportCategoryCategorygoalsSupportCategoryId,
    int? $_pupilDataSupportgoalsPupilDataId,
  })  : _supportCategoryCategorygoalsSupportCategoryId =
            $_supportCategoryCategorygoalsSupportCategoryId,
        _pupilDataSupportgoalsPupilDataId = $_pupilDataSupportgoalsPupilDataId,
        super(
          id: id,
          goalId: goalId,
          createdBy: createdBy,
          createdAt: createdAt,
          achieved: achieved,
          achievedAt: achievedAt,
          description: description,
          strategies: strategies,
          pupilId: pupilId,
          pupil: pupil,
          supportCategoryId: supportCategoryId,
          supportCategory: supportCategory,
          goalChecks: goalChecks,
        );

  factory SupportGoalImplicit(
    SupportGoal supportGoal, {
    int? $_supportCategoryCategorygoalsSupportCategoryId,
    int? $_pupilDataSupportgoalsPupilDataId,
  }) {
    return SupportGoalImplicit._(
      id: supportGoal.id,
      goalId: supportGoal.goalId,
      createdBy: supportGoal.createdBy,
      createdAt: supportGoal.createdAt,
      achieved: supportGoal.achieved,
      achievedAt: supportGoal.achievedAt,
      description: supportGoal.description,
      strategies: supportGoal.strategies,
      pupilId: supportGoal.pupilId,
      pupil: supportGoal.pupil,
      supportCategoryId: supportGoal.supportCategoryId,
      supportCategory: supportGoal.supportCategory,
      goalChecks: supportGoal.goalChecks,
      $_supportCategoryCategorygoalsSupportCategoryId:
          $_supportCategoryCategorygoalsSupportCategoryId,
      $_pupilDataSupportgoalsPupilDataId: $_pupilDataSupportgoalsPupilDataId,
    );
  }

  @override
  final int? _supportCategoryCategorygoalsSupportCategoryId;

  @override
  final int? _pupilDataSupportgoalsPupilDataId;
}

class SupportGoalTable extends _i1.Table<int?> {
  SupportGoalTable({super.tableRelation})
      : super(tableName: 'support_category_goal') {
    goalId = _i1.ColumnString(
      'goalId',
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
    achieved = _i1.ColumnInt(
      'achieved',
      this,
    );
    achievedAt = _i1.ColumnDateTime(
      'achievedAt',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    strategies = _i1.ColumnSerializable(
      'strategies',
      this,
    );
    pupilId = _i1.ColumnInt(
      'pupilId',
      this,
    );
    supportCategoryId = _i1.ColumnInt(
      'supportCategoryId',
      this,
    );
    $_supportCategoryCategorygoalsSupportCategoryId = _i1.ColumnInt(
      '_supportCategoryCategorygoalsSupportCategoryId',
      this,
    );
    $_pupilDataSupportgoalsPupilDataId = _i1.ColumnInt(
      '_pupilDataSupportgoalsPupilDataId',
      this,
    );
  }

  late final _i1.ColumnString goalId;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnInt achieved;

  late final _i1.ColumnDateTime achievedAt;

  late final _i1.ColumnString description;

  late final _i1.ColumnSerializable strategies;

  late final _i1.ColumnInt pupilId;

  _i2.PupilDataTable? _pupil;

  late final _i1.ColumnInt supportCategoryId;

  _i3.SupportCategoryTable? _supportCategory;

  _i4.SupportGoalCheckTable? ___goalChecks;

  _i1.ManyRelation<_i4.SupportGoalCheckTable>? _goalChecks;

  late final _i1.ColumnInt $_supportCategoryCategorygoalsSupportCategoryId;

  late final _i1.ColumnInt $_pupilDataSupportgoalsPupilDataId;

  _i2.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: SupportGoal.t.pupilId,
      foreignField: _i2.PupilData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PupilDataTable(tableRelation: foreignTableRelation),
    );
    return _pupil!;
  }

  _i3.SupportCategoryTable get supportCategory {
    if (_supportCategory != null) return _supportCategory!;
    _supportCategory = _i1.createRelationTable(
      relationFieldName: 'supportCategory',
      field: SupportGoal.t.supportCategoryId,
      foreignField: _i3.SupportCategory.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SupportCategoryTable(tableRelation: foreignTableRelation),
    );
    return _supportCategory!;
  }

  _i4.SupportGoalCheckTable get __goalChecks {
    if (___goalChecks != null) return ___goalChecks!;
    ___goalChecks = _i1.createRelationTable(
      relationFieldName: '__goalChecks',
      field: SupportGoal.t.id,
      foreignField: _i4.SupportGoalCheck.t
          .$_supportCategoryGoalGoalchecksSupportCategoryGoalId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SupportGoalCheckTable(tableRelation: foreignTableRelation),
    );
    return ___goalChecks!;
  }

  _i1.ManyRelation<_i4.SupportGoalCheckTable> get goalChecks {
    if (_goalChecks != null) return _goalChecks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'goalChecks',
      field: SupportGoal.t.id,
      foreignField: _i4.SupportGoalCheck.t
          .$_supportCategoryGoalGoalchecksSupportCategoryGoalId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SupportGoalCheckTable(tableRelation: foreignTableRelation),
    );
    _goalChecks = _i1.ManyRelation<_i4.SupportGoalCheckTable>(
      tableWithRelations: relationTable,
      table: _i4.SupportGoalCheckTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _goalChecks!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        goalId,
        createdBy,
        createdAt,
        achieved,
        achievedAt,
        description,
        strategies,
        pupilId,
        supportCategoryId,
        $_supportCategoryCategorygoalsSupportCategoryId,
        $_pupilDataSupportgoalsPupilDataId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        goalId,
        createdBy,
        createdAt,
        achieved,
        achievedAt,
        description,
        strategies,
        pupilId,
        supportCategoryId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'pupil') {
      return pupil;
    }
    if (relationField == 'supportCategory') {
      return supportCategory;
    }
    if (relationField == 'goalChecks') {
      return __goalChecks;
    }
    return null;
  }
}

class SupportGoalInclude extends _i1.IncludeObject {
  SupportGoalInclude._({
    _i2.PupilDataInclude? pupil,
    _i3.SupportCategoryInclude? supportCategory,
    _i4.SupportGoalCheckIncludeList? goalChecks,
  }) {
    _pupil = pupil;
    _supportCategory = supportCategory;
    _goalChecks = goalChecks;
  }

  _i2.PupilDataInclude? _pupil;

  _i3.SupportCategoryInclude? _supportCategory;

  _i4.SupportGoalCheckIncludeList? _goalChecks;

  @override
  Map<String, _i1.Include?> get includes => {
        'pupil': _pupil,
        'supportCategory': _supportCategory,
        'goalChecks': _goalChecks,
      };

  @override
  _i1.Table<int?> get table => SupportGoal.t;
}

class SupportGoalIncludeList extends _i1.IncludeList {
  SupportGoalIncludeList._({
    _i1.WhereExpressionBuilder<SupportGoalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SupportGoal.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SupportGoal.t;
}

class SupportGoalRepository {
  const SupportGoalRepository._();

  final attach = const SupportGoalAttachRepository._();

  final attachRow = const SupportGoalAttachRowRepository._();

  final detach = const SupportGoalDetachRepository._();

  final detachRow = const SupportGoalDetachRowRepository._();

  /// Returns a list of [SupportGoal]s matching the given query parameters.
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
  Future<List<SupportGoal>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportGoalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupportGoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportGoalTable>? orderByList,
    _i1.Transaction? transaction,
    SupportGoalInclude? include,
  }) async {
    return session.db.find<SupportGoal>(
      where: where?.call(SupportGoal.t),
      orderBy: orderBy?.call(SupportGoal.t),
      orderByList: orderByList?.call(SupportGoal.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SupportGoal] matching the given query parameters.
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
  Future<SupportGoal?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportGoalTable>? where,
    int? offset,
    _i1.OrderByBuilder<SupportGoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportGoalTable>? orderByList,
    _i1.Transaction? transaction,
    SupportGoalInclude? include,
  }) async {
    return session.db.findFirstRow<SupportGoal>(
      where: where?.call(SupportGoal.t),
      orderBy: orderBy?.call(SupportGoal.t),
      orderByList: orderByList?.call(SupportGoal.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SupportGoal] by its [id] or null if no such row exists.
  Future<SupportGoal?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SupportGoalInclude? include,
  }) async {
    return session.db.findById<SupportGoal>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SupportGoal]s in the list and returns the inserted rows.
  ///
  /// The returned [SupportGoal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SupportGoal>> insert(
    _i1.Session session,
    List<SupportGoal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SupportGoal>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SupportGoal] and returns the inserted row.
  ///
  /// The returned [SupportGoal] will have its `id` field set.
  Future<SupportGoal> insertRow(
    _i1.Session session,
    SupportGoal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SupportGoal>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SupportGoal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SupportGoal>> update(
    _i1.Session session,
    List<SupportGoal> rows, {
    _i1.ColumnSelections<SupportGoalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SupportGoal>(
      rows,
      columns: columns?.call(SupportGoal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SupportGoal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SupportGoal> updateRow(
    _i1.Session session,
    SupportGoal row, {
    _i1.ColumnSelections<SupportGoalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SupportGoal>(
      row,
      columns: columns?.call(SupportGoal.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SupportGoal]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SupportGoal>> delete(
    _i1.Session session,
    List<SupportGoal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SupportGoal>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SupportGoal].
  Future<SupportGoal> deleteRow(
    _i1.Session session,
    SupportGoal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SupportGoal>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SupportGoal>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SupportGoalTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SupportGoal>(
      where: where(SupportGoal.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportGoalTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SupportGoal>(
      where: where?.call(SupportGoal.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SupportGoalAttachRepository {
  const SupportGoalAttachRepository._();

  /// Creates a relation between this [SupportGoal] and the given [SupportGoalCheck]s
  /// by setting each [SupportGoalCheck]'s foreign key `_supportCategoryGoalGoalchecksSupportCategoryGoalId` to refer to this [SupportGoal].
  Future<void> goalChecks(
    _i1.Session session,
    SupportGoal supportGoal,
    List<_i4.SupportGoalCheck> supportGoalCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoalCheck.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportGoalCheck.id');
    }
    if (supportGoal.id == null) {
      throw ArgumentError.notNull('supportGoal.id');
    }

    var $supportGoalCheck = supportGoalCheck
        .map((e) => _i4.SupportGoalCheckImplicit(
              e,
              $_supportCategoryGoalGoalchecksSupportCategoryGoalId:
                  supportGoal.id,
            ))
        .toList();
    await session.db.update<_i4.SupportGoalCheck>(
      $supportGoalCheck,
      columns: [
        _i4.SupportGoalCheck.t
            .$_supportCategoryGoalGoalchecksSupportCategoryGoalId
      ],
      transaction: transaction,
    );
  }
}

class SupportGoalAttachRowRepository {
  const SupportGoalAttachRowRepository._();

  /// Creates a relation between the given [SupportGoal] and [PupilData]
  /// by setting the [SupportGoal]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    SupportGoal supportGoal,
    _i2.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.id == null) {
      throw ArgumentError.notNull('supportGoal.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $supportGoal = supportGoal.copyWith(pupilId: pupil.id);
    await session.db.updateRow<SupportGoal>(
      $supportGoal,
      columns: [SupportGoal.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [SupportGoal] and [SupportCategory]
  /// by setting the [SupportGoal]'s foreign key `supportCategoryId` to refer to the [SupportCategory].
  Future<void> supportCategory(
    _i1.Session session,
    SupportGoal supportGoal,
    _i3.SupportCategory supportCategory, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.id == null) {
      throw ArgumentError.notNull('supportGoal.id');
    }
    if (supportCategory.id == null) {
      throw ArgumentError.notNull('supportCategory.id');
    }

    var $supportGoal =
        supportGoal.copyWith(supportCategoryId: supportCategory.id);
    await session.db.updateRow<SupportGoal>(
      $supportGoal,
      columns: [SupportGoal.t.supportCategoryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SupportGoal] and the given [SupportGoalCheck]
  /// by setting the [SupportGoalCheck]'s foreign key `_supportCategoryGoalGoalchecksSupportCategoryGoalId` to refer to this [SupportGoal].
  Future<void> goalChecks(
    _i1.Session session,
    SupportGoal supportGoal,
    _i4.SupportGoalCheck supportGoalCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoalCheck.id == null) {
      throw ArgumentError.notNull('supportGoalCheck.id');
    }
    if (supportGoal.id == null) {
      throw ArgumentError.notNull('supportGoal.id');
    }

    var $supportGoalCheck = _i4.SupportGoalCheckImplicit(
      supportGoalCheck,
      $_supportCategoryGoalGoalchecksSupportCategoryGoalId: supportGoal.id,
    );
    await session.db.updateRow<_i4.SupportGoalCheck>(
      $supportGoalCheck,
      columns: [
        _i4.SupportGoalCheck.t
            .$_supportCategoryGoalGoalchecksSupportCategoryGoalId
      ],
      transaction: transaction,
    );
  }
}

class SupportGoalDetachRepository {
  const SupportGoalDetachRepository._();

  /// Detaches the relation between this [SupportGoal] and the given [SupportGoalCheck]
  /// by setting the [SupportGoalCheck]'s foreign key `_supportCategoryGoalGoalchecksSupportCategoryGoalId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> goalChecks(
    _i1.Session session,
    List<_i4.SupportGoalCheck> supportGoalCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoalCheck.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportGoalCheck.id');
    }

    var $supportGoalCheck = supportGoalCheck
        .map((e) => _i4.SupportGoalCheckImplicit(
              e,
              $_supportCategoryGoalGoalchecksSupportCategoryGoalId: null,
            ))
        .toList();
    await session.db.update<_i4.SupportGoalCheck>(
      $supportGoalCheck,
      columns: [
        _i4.SupportGoalCheck.t
            .$_supportCategoryGoalGoalchecksSupportCategoryGoalId
      ],
      transaction: transaction,
    );
  }
}

class SupportGoalDetachRowRepository {
  const SupportGoalDetachRowRepository._();

  /// Detaches the relation between this [SupportGoal] and the given [SupportGoalCheck]
  /// by setting the [SupportGoalCheck]'s foreign key `_supportCategoryGoalGoalchecksSupportCategoryGoalId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> goalChecks(
    _i1.Session session,
    _i4.SupportGoalCheck supportGoalCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoalCheck.id == null) {
      throw ArgumentError.notNull('supportGoalCheck.id');
    }

    var $supportGoalCheck = _i4.SupportGoalCheckImplicit(
      supportGoalCheck,
      $_supportCategoryGoalGoalchecksSupportCategoryGoalId: null,
    );
    await session.db.updateRow<_i4.SupportGoalCheck>(
      $supportGoalCheck,
      columns: [
        _i4.SupportGoalCheck.t
            .$_supportCategoryGoalGoalchecksSupportCategoryGoalId
      ],
      transaction: transaction,
    );
  }
}
