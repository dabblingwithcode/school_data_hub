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
import '../../../_features/learning_support/models/support_level.dart' as _i2;
import '../../../_features/pupil/models/pupil_data/pupil_data.dart' as _i3;
import '../../../_features/learning_support/models/support_category_status.dart'
    as _i4;
import '../../../_features/learning_support/models/support_goal/support_goal.dart'
    as _i5;
import '../../../_features/schoolday/models/school_semester.dart' as _i6;

abstract class LearningSupportPlan
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LearningSupportPlan._({
    this.id,
    required this.planId,
    required this.createdBy,
    required this.learningSupportLevelId,
    this.learningSupportLevel,
    required this.createdAt,
    this.comment,
    required this.pupilId,
    this.pupil,
    this.supportCategoryStatuses,
    this.supportGoals,
    required this.schoolSemesterId,
    this.schoolSemester,
  });

  factory LearningSupportPlan({
    int? id,
    required String planId,
    required String createdBy,
    required int learningSupportLevelId,
    _i2.SupportLevel? learningSupportLevel,
    required DateTime createdAt,
    String? comment,
    required int pupilId,
    _i3.PupilData? pupil,
    List<_i4.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i5.SupportGoal>? supportGoals,
    required int schoolSemesterId,
    _i6.SchoolSemester? schoolSemester,
  }) = _LearningSupportPlanImpl;

  factory LearningSupportPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return LearningSupportPlan(
      id: jsonSerialization['id'] as int?,
      planId: jsonSerialization['planId'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      learningSupportLevelId:
          jsonSerialization['learningSupportLevelId'] as int,
      learningSupportLevel: jsonSerialization['learningSupportLevel'] == null
          ? null
          : _i2.SupportLevel.fromJson((jsonSerialization['learningSupportLevel']
              as Map<String, dynamic>)),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      comment: jsonSerialization['comment'] as String?,
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i3.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      supportCategoryStatuses: (jsonSerialization['supportCategoryStatuses']
              as List?)
          ?.map((e) =>
              _i4.SupportCategoryStatus.fromJson((e as Map<String, dynamic>)))
          .toList(),
      supportGoals: (jsonSerialization['supportGoals'] as List?)
          ?.map((e) => _i5.SupportGoal.fromJson((e as Map<String, dynamic>)))
          .toList(),
      schoolSemesterId: jsonSerialization['schoolSemesterId'] as int,
      schoolSemester: jsonSerialization['schoolSemester'] == null
          ? null
          : _i6.SchoolSemester.fromJson(
              (jsonSerialization['schoolSemester'] as Map<String, dynamic>)),
    );
  }

  static final t = LearningSupportPlanTable();

  static const db = LearningSupportPlanRepository._();

  @override
  int? id;

  String planId;

  String createdBy;

  int learningSupportLevelId;

  _i2.SupportLevel? learningSupportLevel;

  DateTime createdAt;

  String? comment;

  int pupilId;

  _i3.PupilData? pupil;

  List<_i4.SupportCategoryStatus>? supportCategoryStatuses;

  List<_i5.SupportGoal>? supportGoals;

  int schoolSemesterId;

  _i6.SchoolSemester? schoolSemester;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LearningSupportPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LearningSupportPlan copyWith({
    int? id,
    String? planId,
    String? createdBy,
    int? learningSupportLevelId,
    _i2.SupportLevel? learningSupportLevel,
    DateTime? createdAt,
    String? comment,
    int? pupilId,
    _i3.PupilData? pupil,
    List<_i4.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i5.SupportGoal>? supportGoals,
    int? schoolSemesterId,
    _i6.SchoolSemester? schoolSemester,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'planId': planId,
      'createdBy': createdBy,
      'learningSupportLevelId': learningSupportLevelId,
      if (learningSupportLevel != null)
        'learningSupportLevel': learningSupportLevel?.toJson(),
      'createdAt': createdAt.toJson(),
      if (comment != null) 'comment': comment,
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      if (supportCategoryStatuses != null)
        'supportCategoryStatuses':
            supportCategoryStatuses?.toJson(valueToJson: (v) => v.toJson()),
      if (supportGoals != null)
        'supportGoals': supportGoals?.toJson(valueToJson: (v) => v.toJson()),
      'schoolSemesterId': schoolSemesterId,
      if (schoolSemester != null) 'schoolSemester': schoolSemester?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'planId': planId,
      'createdBy': createdBy,
      'learningSupportLevelId': learningSupportLevelId,
      if (learningSupportLevel != null)
        'learningSupportLevel': learningSupportLevel?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
      if (comment != null) 'comment': comment,
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
      if (supportCategoryStatuses != null)
        'supportCategoryStatuses': supportCategoryStatuses?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (supportGoals != null)
        'supportGoals':
            supportGoals?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'schoolSemesterId': schoolSemesterId,
      if (schoolSemester != null)
        'schoolSemester': schoolSemester?.toJsonForProtocol(),
    };
  }

  static LearningSupportPlanInclude include({
    _i2.SupportLevelInclude? learningSupportLevel,
    _i3.PupilDataInclude? pupil,
    _i4.SupportCategoryStatusIncludeList? supportCategoryStatuses,
    _i5.SupportGoalIncludeList? supportGoals,
    _i6.SchoolSemesterInclude? schoolSemester,
  }) {
    return LearningSupportPlanInclude._(
      learningSupportLevel: learningSupportLevel,
      pupil: pupil,
      supportCategoryStatuses: supportCategoryStatuses,
      supportGoals: supportGoals,
      schoolSemester: schoolSemester,
    );
  }

  static LearningSupportPlanIncludeList includeList({
    _i1.WhereExpressionBuilder<LearningSupportPlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LearningSupportPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LearningSupportPlanTable>? orderByList,
    LearningSupportPlanInclude? include,
  }) {
    return LearningSupportPlanIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LearningSupportPlan.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LearningSupportPlan.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LearningSupportPlanImpl extends LearningSupportPlan {
  _LearningSupportPlanImpl({
    int? id,
    required String planId,
    required String createdBy,
    required int learningSupportLevelId,
    _i2.SupportLevel? learningSupportLevel,
    required DateTime createdAt,
    String? comment,
    required int pupilId,
    _i3.PupilData? pupil,
    List<_i4.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i5.SupportGoal>? supportGoals,
    required int schoolSemesterId,
    _i6.SchoolSemester? schoolSemester,
  }) : super._(
          id: id,
          planId: planId,
          createdBy: createdBy,
          learningSupportLevelId: learningSupportLevelId,
          learningSupportLevel: learningSupportLevel,
          createdAt: createdAt,
          comment: comment,
          pupilId: pupilId,
          pupil: pupil,
          supportCategoryStatuses: supportCategoryStatuses,
          supportGoals: supportGoals,
          schoolSemesterId: schoolSemesterId,
          schoolSemester: schoolSemester,
        );

  /// Returns a shallow copy of this [LearningSupportPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LearningSupportPlan copyWith({
    Object? id = _Undefined,
    String? planId,
    String? createdBy,
    int? learningSupportLevelId,
    Object? learningSupportLevel = _Undefined,
    DateTime? createdAt,
    Object? comment = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
    Object? supportCategoryStatuses = _Undefined,
    Object? supportGoals = _Undefined,
    int? schoolSemesterId,
    Object? schoolSemester = _Undefined,
  }) {
    return LearningSupportPlan(
      id: id is int? ? id : this.id,
      planId: planId ?? this.planId,
      createdBy: createdBy ?? this.createdBy,
      learningSupportLevelId:
          learningSupportLevelId ?? this.learningSupportLevelId,
      learningSupportLevel: learningSupportLevel is _i2.SupportLevel?
          ? learningSupportLevel
          : this.learningSupportLevel?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      comment: comment is String? ? comment : this.comment,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i3.PupilData? ? pupil : this.pupil?.copyWith(),
      supportCategoryStatuses: supportCategoryStatuses
              is List<_i4.SupportCategoryStatus>?
          ? supportCategoryStatuses
          : this.supportCategoryStatuses?.map((e0) => e0.copyWith()).toList(),
      supportGoals: supportGoals is List<_i5.SupportGoal>?
          ? supportGoals
          : this.supportGoals?.map((e0) => e0.copyWith()).toList(),
      schoolSemesterId: schoolSemesterId ?? this.schoolSemesterId,
      schoolSemester: schoolSemester is _i6.SchoolSemester?
          ? schoolSemester
          : this.schoolSemester?.copyWith(),
    );
  }
}

class LearningSupportPlanTable extends _i1.Table<int?> {
  LearningSupportPlanTable({super.tableRelation})
      : super(tableName: 'learning_support_plan') {
    planId = _i1.ColumnString(
      'planId',
      this,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    learningSupportLevelId = _i1.ColumnInt(
      'learningSupportLevelId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    comment = _i1.ColumnString(
      'comment',
      this,
    );
    pupilId = _i1.ColumnInt(
      'pupilId',
      this,
    );
    schoolSemesterId = _i1.ColumnInt(
      'schoolSemesterId',
      this,
    );
  }

  late final _i1.ColumnString planId;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnInt learningSupportLevelId;

  _i2.SupportLevelTable? _learningSupportLevel;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString comment;

  late final _i1.ColumnInt pupilId;

  _i3.PupilDataTable? _pupil;

  _i4.SupportCategoryStatusTable? ___supportCategoryStatuses;

  _i1.ManyRelation<_i4.SupportCategoryStatusTable>? _supportCategoryStatuses;

  _i5.SupportGoalTable? ___supportGoals;

  _i1.ManyRelation<_i5.SupportGoalTable>? _supportGoals;

  late final _i1.ColumnInt schoolSemesterId;

  _i6.SchoolSemesterTable? _schoolSemester;

  _i2.SupportLevelTable get learningSupportLevel {
    if (_learningSupportLevel != null) return _learningSupportLevel!;
    _learningSupportLevel = _i1.createRelationTable(
      relationFieldName: 'learningSupportLevel',
      field: LearningSupportPlan.t.learningSupportLevelId,
      foreignField: _i2.SupportLevel.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SupportLevelTable(tableRelation: foreignTableRelation),
    );
    return _learningSupportLevel!;
  }

  _i3.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: LearningSupportPlan.t.pupilId,
      foreignField: _i3.PupilData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PupilDataTable(tableRelation: foreignTableRelation),
    );
    return _pupil!;
  }

  _i4.SupportCategoryStatusTable get __supportCategoryStatuses {
    if (___supportCategoryStatuses != null) return ___supportCategoryStatuses!;
    ___supportCategoryStatuses = _i1.createRelationTable(
      relationFieldName: '__supportCategoryStatuses',
      field: LearningSupportPlan.t.id,
      foreignField: _i4.SupportCategoryStatus.t
          .$_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SupportCategoryStatusTable(tableRelation: foreignTableRelation),
    );
    return ___supportCategoryStatuses!;
  }

  _i5.SupportGoalTable get __supportGoals {
    if (___supportGoals != null) return ___supportGoals!;
    ___supportGoals = _i1.createRelationTable(
      relationFieldName: '__supportGoals',
      field: LearningSupportPlan.t.id,
      foreignField: _i5
          .SupportGoal.t.$_learningSupportPlanSupportgoalsLearningSupportPlanId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.SupportGoalTable(tableRelation: foreignTableRelation),
    );
    return ___supportGoals!;
  }

  _i6.SchoolSemesterTable get schoolSemester {
    if (_schoolSemester != null) return _schoolSemester!;
    _schoolSemester = _i1.createRelationTable(
      relationFieldName: 'schoolSemester',
      field: LearningSupportPlan.t.schoolSemesterId,
      foreignField: _i6.SchoolSemester.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.SchoolSemesterTable(tableRelation: foreignTableRelation),
    );
    return _schoolSemester!;
  }

  _i1.ManyRelation<_i4.SupportCategoryStatusTable> get supportCategoryStatuses {
    if (_supportCategoryStatuses != null) return _supportCategoryStatuses!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'supportCategoryStatuses',
      field: LearningSupportPlan.t.id,
      foreignField: _i4.SupportCategoryStatus.t
          .$_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SupportCategoryStatusTable(tableRelation: foreignTableRelation),
    );
    _supportCategoryStatuses = _i1.ManyRelation<_i4.SupportCategoryStatusTable>(
      tableWithRelations: relationTable,
      table: _i4.SupportCategoryStatusTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _supportCategoryStatuses!;
  }

  _i1.ManyRelation<_i5.SupportGoalTable> get supportGoals {
    if (_supportGoals != null) return _supportGoals!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'supportGoals',
      field: LearningSupportPlan.t.id,
      foreignField: _i5
          .SupportGoal.t.$_learningSupportPlanSupportgoalsLearningSupportPlanId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.SupportGoalTable(tableRelation: foreignTableRelation),
    );
    _supportGoals = _i1.ManyRelation<_i5.SupportGoalTable>(
      tableWithRelations: relationTable,
      table: _i5.SupportGoalTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _supportGoals!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        planId,
        createdBy,
        learningSupportLevelId,
        createdAt,
        comment,
        pupilId,
        schoolSemesterId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'learningSupportLevel') {
      return learningSupportLevel;
    }
    if (relationField == 'pupil') {
      return pupil;
    }
    if (relationField == 'supportCategoryStatuses') {
      return __supportCategoryStatuses;
    }
    if (relationField == 'supportGoals') {
      return __supportGoals;
    }
    if (relationField == 'schoolSemester') {
      return schoolSemester;
    }
    return null;
  }
}

class LearningSupportPlanInclude extends _i1.IncludeObject {
  LearningSupportPlanInclude._({
    _i2.SupportLevelInclude? learningSupportLevel,
    _i3.PupilDataInclude? pupil,
    _i4.SupportCategoryStatusIncludeList? supportCategoryStatuses,
    _i5.SupportGoalIncludeList? supportGoals,
    _i6.SchoolSemesterInclude? schoolSemester,
  }) {
    _learningSupportLevel = learningSupportLevel;
    _pupil = pupil;
    _supportCategoryStatuses = supportCategoryStatuses;
    _supportGoals = supportGoals;
    _schoolSemester = schoolSemester;
  }

  _i2.SupportLevelInclude? _learningSupportLevel;

  _i3.PupilDataInclude? _pupil;

  _i4.SupportCategoryStatusIncludeList? _supportCategoryStatuses;

  _i5.SupportGoalIncludeList? _supportGoals;

  _i6.SchoolSemesterInclude? _schoolSemester;

  @override
  Map<String, _i1.Include?> get includes => {
        'learningSupportLevel': _learningSupportLevel,
        'pupil': _pupil,
        'supportCategoryStatuses': _supportCategoryStatuses,
        'supportGoals': _supportGoals,
        'schoolSemester': _schoolSemester,
      };

  @override
  _i1.Table<int?> get table => LearningSupportPlan.t;
}

class LearningSupportPlanIncludeList extends _i1.IncludeList {
  LearningSupportPlanIncludeList._({
    _i1.WhereExpressionBuilder<LearningSupportPlanTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LearningSupportPlan.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LearningSupportPlan.t;
}

class LearningSupportPlanRepository {
  const LearningSupportPlanRepository._();

  final attach = const LearningSupportPlanAttachRepository._();

  final attachRow = const LearningSupportPlanAttachRowRepository._();

  final detach = const LearningSupportPlanDetachRepository._();

  final detachRow = const LearningSupportPlanDetachRowRepository._();

  /// Returns a list of [LearningSupportPlan]s matching the given query parameters.
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
  Future<List<LearningSupportPlan>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LearningSupportPlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LearningSupportPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LearningSupportPlanTable>? orderByList,
    _i1.Transaction? transaction,
    LearningSupportPlanInclude? include,
  }) async {
    return session.db.find<LearningSupportPlan>(
      where: where?.call(LearningSupportPlan.t),
      orderBy: orderBy?.call(LearningSupportPlan.t),
      orderByList: orderByList?.call(LearningSupportPlan.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [LearningSupportPlan] matching the given query parameters.
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
  Future<LearningSupportPlan?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LearningSupportPlanTable>? where,
    int? offset,
    _i1.OrderByBuilder<LearningSupportPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LearningSupportPlanTable>? orderByList,
    _i1.Transaction? transaction,
    LearningSupportPlanInclude? include,
  }) async {
    return session.db.findFirstRow<LearningSupportPlan>(
      where: where?.call(LearningSupportPlan.t),
      orderBy: orderBy?.call(LearningSupportPlan.t),
      orderByList: orderByList?.call(LearningSupportPlan.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [LearningSupportPlan] by its [id] or null if no such row exists.
  Future<LearningSupportPlan?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    LearningSupportPlanInclude? include,
  }) async {
    return session.db.findById<LearningSupportPlan>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [LearningSupportPlan]s in the list and returns the inserted rows.
  ///
  /// The returned [LearningSupportPlan]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LearningSupportPlan>> insert(
    _i1.Session session,
    List<LearningSupportPlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LearningSupportPlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LearningSupportPlan] and returns the inserted row.
  ///
  /// The returned [LearningSupportPlan] will have its `id` field set.
  Future<LearningSupportPlan> insertRow(
    _i1.Session session,
    LearningSupportPlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LearningSupportPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LearningSupportPlan]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LearningSupportPlan>> update(
    _i1.Session session,
    List<LearningSupportPlan> rows, {
    _i1.ColumnSelections<LearningSupportPlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LearningSupportPlan>(
      rows,
      columns: columns?.call(LearningSupportPlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LearningSupportPlan]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LearningSupportPlan> updateRow(
    _i1.Session session,
    LearningSupportPlan row, {
    _i1.ColumnSelections<LearningSupportPlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LearningSupportPlan>(
      row,
      columns: columns?.call(LearningSupportPlan.t),
      transaction: transaction,
    );
  }

  /// Deletes all [LearningSupportPlan]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LearningSupportPlan>> delete(
    _i1.Session session,
    List<LearningSupportPlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LearningSupportPlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LearningSupportPlan].
  Future<LearningSupportPlan> deleteRow(
    _i1.Session session,
    LearningSupportPlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LearningSupportPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LearningSupportPlan>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LearningSupportPlanTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LearningSupportPlan>(
      where: where(LearningSupportPlan.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LearningSupportPlanTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LearningSupportPlan>(
      where: where?.call(LearningSupportPlan.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class LearningSupportPlanAttachRepository {
  const LearningSupportPlanAttachRepository._();

  /// Creates a relation between this [LearningSupportPlan] and the given [SupportCategoryStatus]s
  /// by setting each [SupportCategoryStatus]'s foreign key `_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId` to refer to this [LearningSupportPlan].
  Future<void> supportCategoryStatuses(
    _i1.Session session,
    LearningSupportPlan learningSupportPlan,
    List<_i4.SupportCategoryStatus> supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }
    if (learningSupportPlan.id == null) {
      throw ArgumentError.notNull('learningSupportPlan.id');
    }

    var $supportCategoryStatus = supportCategoryStatus
        .map((e) => _i4.SupportCategoryStatusImplicit(
              e,
              $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId:
                  learningSupportPlan.id,
            ))
        .toList();
    await session.db.update<_i4.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i4.SupportCategoryStatus.t
            .$_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId
      ],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [LearningSupportPlan] and the given [SupportGoal]s
  /// by setting each [SupportGoal]'s foreign key `_learningSupportPlanSupportgoalsLearningSupportPlanId` to refer to this [LearningSupportPlan].
  Future<void> supportGoals(
    _i1.Session session,
    LearningSupportPlan learningSupportPlan,
    List<_i5.SupportGoal> supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportGoal.id');
    }
    if (learningSupportPlan.id == null) {
      throw ArgumentError.notNull('learningSupportPlan.id');
    }

    var $supportGoal = supportGoal
        .map((e) => _i5.SupportGoalImplicit(
              e,
              $_learningSupportPlanSupportgoalsLearningSupportPlanId:
                  learningSupportPlan.id,
            ))
        .toList();
    await session.db.update<_i5.SupportGoal>(
      $supportGoal,
      columns: [
        _i5.SupportGoal.t.$_learningSupportPlanSupportgoalsLearningSupportPlanId
      ],
      transaction: transaction,
    );
  }
}

class LearningSupportPlanAttachRowRepository {
  const LearningSupportPlanAttachRowRepository._();

  /// Creates a relation between the given [LearningSupportPlan] and [SupportLevel]
  /// by setting the [LearningSupportPlan]'s foreign key `learningSupportLevelId` to refer to the [SupportLevel].
  Future<void> learningSupportLevel(
    _i1.Session session,
    LearningSupportPlan learningSupportPlan,
    _i2.SupportLevel learningSupportLevel, {
    _i1.Transaction? transaction,
  }) async {
    if (learningSupportPlan.id == null) {
      throw ArgumentError.notNull('learningSupportPlan.id');
    }
    if (learningSupportLevel.id == null) {
      throw ArgumentError.notNull('learningSupportLevel.id');
    }

    var $learningSupportPlan = learningSupportPlan.copyWith(
        learningSupportLevelId: learningSupportLevel.id);
    await session.db.updateRow<LearningSupportPlan>(
      $learningSupportPlan,
      columns: [LearningSupportPlan.t.learningSupportLevelId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [LearningSupportPlan] and [PupilData]
  /// by setting the [LearningSupportPlan]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    LearningSupportPlan learningSupportPlan,
    _i3.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (learningSupportPlan.id == null) {
      throw ArgumentError.notNull('learningSupportPlan.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $learningSupportPlan = learningSupportPlan.copyWith(pupilId: pupil.id);
    await session.db.updateRow<LearningSupportPlan>(
      $learningSupportPlan,
      columns: [LearningSupportPlan.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [LearningSupportPlan] and [SchoolSemester]
  /// by setting the [LearningSupportPlan]'s foreign key `schoolSemesterId` to refer to the [SchoolSemester].
  Future<void> schoolSemester(
    _i1.Session session,
    LearningSupportPlan learningSupportPlan,
    _i6.SchoolSemester schoolSemester, {
    _i1.Transaction? transaction,
  }) async {
    if (learningSupportPlan.id == null) {
      throw ArgumentError.notNull('learningSupportPlan.id');
    }
    if (schoolSemester.id == null) {
      throw ArgumentError.notNull('schoolSemester.id');
    }

    var $learningSupportPlan =
        learningSupportPlan.copyWith(schoolSemesterId: schoolSemester.id);
    await session.db.updateRow<LearningSupportPlan>(
      $learningSupportPlan,
      columns: [LearningSupportPlan.t.schoolSemesterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [LearningSupportPlan] and the given [SupportCategoryStatus]
  /// by setting the [SupportCategoryStatus]'s foreign key `_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId` to refer to this [LearningSupportPlan].
  Future<void> supportCategoryStatuses(
    _i1.Session session,
    LearningSupportPlan learningSupportPlan,
    _i4.SupportCategoryStatus supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.id == null) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }
    if (learningSupportPlan.id == null) {
      throw ArgumentError.notNull('learningSupportPlan.id');
    }

    var $supportCategoryStatus = _i4.SupportCategoryStatusImplicit(
      supportCategoryStatus,
      $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId:
          learningSupportPlan.id,
    );
    await session.db.updateRow<_i4.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i4.SupportCategoryStatus.t
            .$_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId
      ],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [LearningSupportPlan] and the given [SupportGoal]
  /// by setting the [SupportGoal]'s foreign key `_learningSupportPlanSupportgoalsLearningSupportPlanId` to refer to this [LearningSupportPlan].
  Future<void> supportGoals(
    _i1.Session session,
    LearningSupportPlan learningSupportPlan,
    _i5.SupportGoal supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.id == null) {
      throw ArgumentError.notNull('supportGoal.id');
    }
    if (learningSupportPlan.id == null) {
      throw ArgumentError.notNull('learningSupportPlan.id');
    }

    var $supportGoal = _i5.SupportGoalImplicit(
      supportGoal,
      $_learningSupportPlanSupportgoalsLearningSupportPlanId:
          learningSupportPlan.id,
    );
    await session.db.updateRow<_i5.SupportGoal>(
      $supportGoal,
      columns: [
        _i5.SupportGoal.t.$_learningSupportPlanSupportgoalsLearningSupportPlanId
      ],
      transaction: transaction,
    );
  }
}

class LearningSupportPlanDetachRepository {
  const LearningSupportPlanDetachRepository._();

  /// Detaches the relation between this [LearningSupportPlan] and the given [SupportCategoryStatus]
  /// by setting the [SupportCategoryStatus]'s foreign key `_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> supportCategoryStatuses(
    _i1.Session session,
    List<_i4.SupportCategoryStatus> supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }

    var $supportCategoryStatus = supportCategoryStatus
        .map((e) => _i4.SupportCategoryStatusImplicit(
              e,
              $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId:
                  null,
            ))
        .toList();
    await session.db.update<_i4.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i4.SupportCategoryStatus.t
            .$_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId
      ],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [LearningSupportPlan] and the given [SupportGoal]
  /// by setting the [SupportGoal]'s foreign key `_learningSupportPlanSupportgoalsLearningSupportPlanId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> supportGoals(
    _i1.Session session,
    List<_i5.SupportGoal> supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportGoal.id');
    }

    var $supportGoal = supportGoal
        .map((e) => _i5.SupportGoalImplicit(
              e,
              $_learningSupportPlanSupportgoalsLearningSupportPlanId: null,
            ))
        .toList();
    await session.db.update<_i5.SupportGoal>(
      $supportGoal,
      columns: [
        _i5.SupportGoal.t.$_learningSupportPlanSupportgoalsLearningSupportPlanId
      ],
      transaction: transaction,
    );
  }
}

class LearningSupportPlanDetachRowRepository {
  const LearningSupportPlanDetachRowRepository._();

  /// Detaches the relation between this [LearningSupportPlan] and the given [SupportCategoryStatus]
  /// by setting the [SupportCategoryStatus]'s foreign key `_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> supportCategoryStatuses(
    _i1.Session session,
    _i4.SupportCategoryStatus supportCategoryStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.id == null) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }

    var $supportCategoryStatus = _i4.SupportCategoryStatusImplicit(
      supportCategoryStatus,
      $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId: null,
    );
    await session.db.updateRow<_i4.SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [
        _i4.SupportCategoryStatus.t
            .$_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId
      ],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [LearningSupportPlan] and the given [SupportGoal]
  /// by setting the [SupportGoal]'s foreign key `_learningSupportPlanSupportgoalsLearningSupportPlanId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> supportGoals(
    _i1.Session session,
    _i5.SupportGoal supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoal.id == null) {
      throw ArgumentError.notNull('supportGoal.id');
    }

    var $supportGoal = _i5.SupportGoalImplicit(
      supportGoal,
      $_learningSupportPlanSupportgoalsLearningSupportPlanId: null,
    );
    await session.db.updateRow<_i5.SupportGoal>(
      $supportGoal,
      columns: [
        _i5.SupportGoal.t.$_learningSupportPlanSupportgoalsLearningSupportPlanId
      ],
      transaction: transaction,
    );
  }
}
