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
import '../../learning_support/support_goal/support_goal_check_file.dart'
    as _i2;
import '../../learning_support/support_goal/support_goal.dart' as _i3;

abstract class SupportGoalCheck
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  SupportGoalCheck._({
    this.id,
    required this.checkId,
    required this.createdBy,
    required this.createdAt,
    required this.achieved,
    required this.comment,
    this.supportGoalCheckFiles,
    required this.supportGoalId,
    this.supportGoal,
  }) : _supportCategoryGoalGoalchecksSupportCategoryGoalId = null;

  factory SupportGoalCheck({
    int? id,
    required String checkId,
    required String createdBy,
    required DateTime createdAt,
    required int achieved,
    required String comment,
    List<_i2.SupportGoalCheckFile>? supportGoalCheckFiles,
    required int supportGoalId,
    _i3.SupportGoal? supportGoal,
  }) = _SupportGoalCheckImpl;

  factory SupportGoalCheck.fromJson(Map<String, dynamic> jsonSerialization) {
    return SupportGoalCheckImplicit._(
      id: jsonSerialization['id'] as int?,
      checkId: jsonSerialization['checkId'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      achieved: jsonSerialization['achieved'] as int,
      comment: jsonSerialization['comment'] as String,
      supportGoalCheckFiles: (jsonSerialization['supportGoalCheckFiles']
              as List?)
          ?.map((e) =>
              _i2.SupportGoalCheckFile.fromJson((e as Map<String, dynamic>)))
          .toList(),
      supportGoalId: jsonSerialization['supportGoalId'] as int,
      supportGoal: jsonSerialization['supportGoal'] == null
          ? null
          : _i3.SupportGoal.fromJson(
              (jsonSerialization['supportGoal'] as Map<String, dynamic>)),
      $_supportCategoryGoalGoalchecksSupportCategoryGoalId: jsonSerialization[
          '_supportCategoryGoalGoalchecksSupportCategoryGoalId'] as int?,
    );
  }

  static final t = SupportGoalCheckTable();

  static const db = SupportGoalCheckRepository._();

  @override
  int? id;

  String checkId;

  String createdBy;

  DateTime createdAt;

  int achieved;

  String comment;

  List<_i2.SupportGoalCheckFile>? supportGoalCheckFiles;

  int supportGoalId;

  _i3.SupportGoal? supportGoal;

  final int? _supportCategoryGoalGoalchecksSupportCategoryGoalId;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [SupportGoalCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportGoalCheck copyWith({
    int? id,
    String? checkId,
    String? createdBy,
    DateTime? createdAt,
    int? achieved,
    String? comment,
    List<_i2.SupportGoalCheckFile>? supportGoalCheckFiles,
    int? supportGoalId,
    _i3.SupportGoal? supportGoal,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'checkId': checkId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'achieved': achieved,
      'comment': comment,
      if (supportGoalCheckFiles != null)
        'supportGoalCheckFiles':
            supportGoalCheckFiles?.toJson(valueToJson: (v) => v.toJson()),
      'supportGoalId': supportGoalId,
      if (supportGoal != null) 'supportGoal': supportGoal?.toJson(),
      if (_supportCategoryGoalGoalchecksSupportCategoryGoalId != null)
        '_supportCategoryGoalGoalchecksSupportCategoryGoalId':
            _supportCategoryGoalGoalchecksSupportCategoryGoalId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'checkId': checkId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'achieved': achieved,
      'comment': comment,
      if (supportGoalCheckFiles != null)
        'supportGoalCheckFiles': supportGoalCheckFiles?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      'supportGoalId': supportGoalId,
      if (supportGoal != null) 'supportGoal': supportGoal?.toJsonForProtocol(),
    };
  }

  static SupportGoalCheckInclude include({
    _i2.SupportGoalCheckFileIncludeList? supportGoalCheckFiles,
    _i3.SupportGoalInclude? supportGoal,
  }) {
    return SupportGoalCheckInclude._(
      supportGoalCheckFiles: supportGoalCheckFiles,
      supportGoal: supportGoal,
    );
  }

  static SupportGoalCheckIncludeList includeList({
    _i1.WhereExpressionBuilder<SupportGoalCheckTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupportGoalCheckTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportGoalCheckTable>? orderByList,
    SupportGoalCheckInclude? include,
  }) {
    return SupportGoalCheckIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SupportGoalCheck.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SupportGoalCheck.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportGoalCheckImpl extends SupportGoalCheck {
  _SupportGoalCheckImpl({
    int? id,
    required String checkId,
    required String createdBy,
    required DateTime createdAt,
    required int achieved,
    required String comment,
    List<_i2.SupportGoalCheckFile>? supportGoalCheckFiles,
    required int supportGoalId,
    _i3.SupportGoal? supportGoal,
  }) : super._(
          id: id,
          checkId: checkId,
          createdBy: createdBy,
          createdAt: createdAt,
          achieved: achieved,
          comment: comment,
          supportGoalCheckFiles: supportGoalCheckFiles,
          supportGoalId: supportGoalId,
          supportGoal: supportGoal,
        );

  /// Returns a shallow copy of this [SupportGoalCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportGoalCheck copyWith({
    Object? id = _Undefined,
    String? checkId,
    String? createdBy,
    DateTime? createdAt,
    int? achieved,
    String? comment,
    Object? supportGoalCheckFiles = _Undefined,
    int? supportGoalId,
    Object? supportGoal = _Undefined,
  }) {
    return SupportGoalCheckImplicit._(
      id: id is int? ? id : this.id,
      checkId: checkId ?? this.checkId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      achieved: achieved ?? this.achieved,
      comment: comment ?? this.comment,
      supportGoalCheckFiles:
          supportGoalCheckFiles is List<_i2.SupportGoalCheckFile>?
              ? supportGoalCheckFiles
              : this.supportGoalCheckFiles?.map((e0) => e0.copyWith()).toList(),
      supportGoalId: supportGoalId ?? this.supportGoalId,
      supportGoal: supportGoal is _i3.SupportGoal?
          ? supportGoal
          : this.supportGoal?.copyWith(),
      $_supportCategoryGoalGoalchecksSupportCategoryGoalId:
          this._supportCategoryGoalGoalchecksSupportCategoryGoalId,
    );
  }
}

class SupportGoalCheckImplicit extends _SupportGoalCheckImpl {
  SupportGoalCheckImplicit._({
    int? id,
    required String checkId,
    required String createdBy,
    required DateTime createdAt,
    required int achieved,
    required String comment,
    List<_i2.SupportGoalCheckFile>? supportGoalCheckFiles,
    required int supportGoalId,
    _i3.SupportGoal? supportGoal,
    int? $_supportCategoryGoalGoalchecksSupportCategoryGoalId,
  })  : _supportCategoryGoalGoalchecksSupportCategoryGoalId =
            $_supportCategoryGoalGoalchecksSupportCategoryGoalId,
        super(
          id: id,
          checkId: checkId,
          createdBy: createdBy,
          createdAt: createdAt,
          achieved: achieved,
          comment: comment,
          supportGoalCheckFiles: supportGoalCheckFiles,
          supportGoalId: supportGoalId,
          supportGoal: supportGoal,
        );

  factory SupportGoalCheckImplicit(
    SupportGoalCheck supportGoalCheck, {
    int? $_supportCategoryGoalGoalchecksSupportCategoryGoalId,
  }) {
    return SupportGoalCheckImplicit._(
      id: supportGoalCheck.id,
      checkId: supportGoalCheck.checkId,
      createdBy: supportGoalCheck.createdBy,
      createdAt: supportGoalCheck.createdAt,
      achieved: supportGoalCheck.achieved,
      comment: supportGoalCheck.comment,
      supportGoalCheckFiles: supportGoalCheck.supportGoalCheckFiles,
      supportGoalId: supportGoalCheck.supportGoalId,
      supportGoal: supportGoalCheck.supportGoal,
      $_supportCategoryGoalGoalchecksSupportCategoryGoalId:
          $_supportCategoryGoalGoalchecksSupportCategoryGoalId,
    );
  }

  @override
  final int? _supportCategoryGoalGoalchecksSupportCategoryGoalId;
}

class SupportGoalCheckTable extends _i1.Table<int> {
  SupportGoalCheckTable({super.tableRelation})
      : super(tableName: 'support_goal_check') {
    checkId = _i1.ColumnString(
      'checkId',
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
    comment = _i1.ColumnString(
      'comment',
      this,
    );
    supportGoalId = _i1.ColumnInt(
      'supportGoalId',
      this,
    );
    $_supportCategoryGoalGoalchecksSupportCategoryGoalId = _i1.ColumnInt(
      '_supportCategoryGoalGoalchecksSupportCategoryGoalId',
      this,
    );
  }

  late final _i1.ColumnString checkId;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnInt achieved;

  late final _i1.ColumnString comment;

  _i2.SupportGoalCheckFileTable? ___supportGoalCheckFiles;

  _i1.ManyRelation<_i2.SupportGoalCheckFileTable>? _supportGoalCheckFiles;

  late final _i1.ColumnInt supportGoalId;

  _i3.SupportGoalTable? _supportGoal;

  late final _i1.ColumnInt $_supportCategoryGoalGoalchecksSupportCategoryGoalId;

  _i2.SupportGoalCheckFileTable get __supportGoalCheckFiles {
    if (___supportGoalCheckFiles != null) return ___supportGoalCheckFiles!;
    ___supportGoalCheckFiles = _i1.createRelationTable(
      relationFieldName: '__supportGoalCheckFiles',
      field: SupportGoalCheck.t.id,
      foreignField: _i2.SupportGoalCheckFile.t
          .$_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SupportGoalCheckFileTable(tableRelation: foreignTableRelation),
    );
    return ___supportGoalCheckFiles!;
  }

  _i3.SupportGoalTable get supportGoal {
    if (_supportGoal != null) return _supportGoal!;
    _supportGoal = _i1.createRelationTable(
      relationFieldName: 'supportGoal',
      field: SupportGoalCheck.t.supportGoalId,
      foreignField: _i3.SupportGoal.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SupportGoalTable(tableRelation: foreignTableRelation),
    );
    return _supportGoal!;
  }

  _i1.ManyRelation<_i2.SupportGoalCheckFileTable> get supportGoalCheckFiles {
    if (_supportGoalCheckFiles != null) return _supportGoalCheckFiles!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'supportGoalCheckFiles',
      field: SupportGoalCheck.t.id,
      foreignField: _i2.SupportGoalCheckFile.t
          .$_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SupportGoalCheckFileTable(tableRelation: foreignTableRelation),
    );
    _supportGoalCheckFiles = _i1.ManyRelation<_i2.SupportGoalCheckFileTable>(
      tableWithRelations: relationTable,
      table: _i2.SupportGoalCheckFileTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _supportGoalCheckFiles!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        checkId,
        createdBy,
        createdAt,
        achieved,
        comment,
        supportGoalId,
        $_supportCategoryGoalGoalchecksSupportCategoryGoalId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        checkId,
        createdBy,
        createdAt,
        achieved,
        comment,
        supportGoalId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'supportGoalCheckFiles') {
      return __supportGoalCheckFiles;
    }
    if (relationField == 'supportGoal') {
      return supportGoal;
    }
    return null;
  }
}

class SupportGoalCheckInclude extends _i1.IncludeObject {
  SupportGoalCheckInclude._({
    _i2.SupportGoalCheckFileIncludeList? supportGoalCheckFiles,
    _i3.SupportGoalInclude? supportGoal,
  }) {
    _supportGoalCheckFiles = supportGoalCheckFiles;
    _supportGoal = supportGoal;
  }

  _i2.SupportGoalCheckFileIncludeList? _supportGoalCheckFiles;

  _i3.SupportGoalInclude? _supportGoal;

  @override
  Map<String, _i1.Include?> get includes => {
        'supportGoalCheckFiles': _supportGoalCheckFiles,
        'supportGoal': _supportGoal,
      };

  @override
  _i1.Table<int> get table => SupportGoalCheck.t;
}

class SupportGoalCheckIncludeList extends _i1.IncludeList {
  SupportGoalCheckIncludeList._({
    _i1.WhereExpressionBuilder<SupportGoalCheckTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SupportGoalCheck.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => SupportGoalCheck.t;
}

class SupportGoalCheckRepository {
  const SupportGoalCheckRepository._();

  final attach = const SupportGoalCheckAttachRepository._();

  final attachRow = const SupportGoalCheckAttachRowRepository._();

  final detach = const SupportGoalCheckDetachRepository._();

  final detachRow = const SupportGoalCheckDetachRowRepository._();

  /// Returns a list of [SupportGoalCheck]s matching the given query parameters.
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
  Future<List<SupportGoalCheck>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportGoalCheckTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupportGoalCheckTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportGoalCheckTable>? orderByList,
    _i1.Transaction? transaction,
    SupportGoalCheckInclude? include,
  }) async {
    return session.db.find<SupportGoalCheck>(
      where: where?.call(SupportGoalCheck.t),
      orderBy: orderBy?.call(SupportGoalCheck.t),
      orderByList: orderByList?.call(SupportGoalCheck.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SupportGoalCheck] matching the given query parameters.
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
  Future<SupportGoalCheck?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportGoalCheckTable>? where,
    int? offset,
    _i1.OrderByBuilder<SupportGoalCheckTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportGoalCheckTable>? orderByList,
    _i1.Transaction? transaction,
    SupportGoalCheckInclude? include,
  }) async {
    return session.db.findFirstRow<SupportGoalCheck>(
      where: where?.call(SupportGoalCheck.t),
      orderBy: orderBy?.call(SupportGoalCheck.t),
      orderByList: orderByList?.call(SupportGoalCheck.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SupportGoalCheck] by its [id] or null if no such row exists.
  Future<SupportGoalCheck?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SupportGoalCheckInclude? include,
  }) async {
    return session.db.findById<SupportGoalCheck>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SupportGoalCheck]s in the list and returns the inserted rows.
  ///
  /// The returned [SupportGoalCheck]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SupportGoalCheck>> insert(
    _i1.Session session,
    List<SupportGoalCheck> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SupportGoalCheck>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SupportGoalCheck] and returns the inserted row.
  ///
  /// The returned [SupportGoalCheck] will have its `id` field set.
  Future<SupportGoalCheck> insertRow(
    _i1.Session session,
    SupportGoalCheck row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SupportGoalCheck>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SupportGoalCheck]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SupportGoalCheck>> update(
    _i1.Session session,
    List<SupportGoalCheck> rows, {
    _i1.ColumnSelections<SupportGoalCheckTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SupportGoalCheck>(
      rows,
      columns: columns?.call(SupportGoalCheck.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SupportGoalCheck]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SupportGoalCheck> updateRow(
    _i1.Session session,
    SupportGoalCheck row, {
    _i1.ColumnSelections<SupportGoalCheckTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SupportGoalCheck>(
      row,
      columns: columns?.call(SupportGoalCheck.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SupportGoalCheck]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SupportGoalCheck>> delete(
    _i1.Session session,
    List<SupportGoalCheck> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SupportGoalCheck>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SupportGoalCheck].
  Future<SupportGoalCheck> deleteRow(
    _i1.Session session,
    SupportGoalCheck row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SupportGoalCheck>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SupportGoalCheck>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SupportGoalCheckTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SupportGoalCheck>(
      where: where(SupportGoalCheck.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportGoalCheckTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SupportGoalCheck>(
      where: where?.call(SupportGoalCheck.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SupportGoalCheckAttachRepository {
  const SupportGoalCheckAttachRepository._();

  /// Creates a relation between this [SupportGoalCheck] and the given [SupportGoalCheckFile]s
  /// by setting each [SupportGoalCheckFile]'s foreign key `_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId` to refer to this [SupportGoalCheck].
  Future<void> supportGoalCheckFiles(
    _i1.Session session,
    SupportGoalCheck supportGoalCheck,
    List<_i2.SupportGoalCheckFile> supportGoalCheckFile, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoalCheckFile.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportGoalCheckFile.id');
    }
    if (supportGoalCheck.id == null) {
      throw ArgumentError.notNull('supportGoalCheck.id');
    }

    var $supportGoalCheckFile = supportGoalCheckFile
        .map((e) => _i2.SupportGoalCheckFileImplicit(
              e,
              $_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId:
                  supportGoalCheck.id,
            ))
        .toList();
    await session.db.update<_i2.SupportGoalCheckFile>(
      $supportGoalCheckFile,
      columns: [
        _i2.SupportGoalCheckFile.t
            .$_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId
      ],
      transaction: transaction,
    );
  }
}

class SupportGoalCheckAttachRowRepository {
  const SupportGoalCheckAttachRowRepository._();

  /// Creates a relation between the given [SupportGoalCheck] and [SupportGoal]
  /// by setting the [SupportGoalCheck]'s foreign key `supportGoalId` to refer to the [SupportGoal].
  Future<void> supportGoal(
    _i1.Session session,
    SupportGoalCheck supportGoalCheck,
    _i3.SupportGoal supportGoal, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoalCheck.id == null) {
      throw ArgumentError.notNull('supportGoalCheck.id');
    }
    if (supportGoal.id == null) {
      throw ArgumentError.notNull('supportGoal.id');
    }

    var $supportGoalCheck =
        supportGoalCheck.copyWith(supportGoalId: supportGoal.id);
    await session.db.updateRow<SupportGoalCheck>(
      $supportGoalCheck,
      columns: [SupportGoalCheck.t.supportGoalId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SupportGoalCheck] and the given [SupportGoalCheckFile]
  /// by setting the [SupportGoalCheckFile]'s foreign key `_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId` to refer to this [SupportGoalCheck].
  Future<void> supportGoalCheckFiles(
    _i1.Session session,
    SupportGoalCheck supportGoalCheck,
    _i2.SupportGoalCheckFile supportGoalCheckFile, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoalCheckFile.id == null) {
      throw ArgumentError.notNull('supportGoalCheckFile.id');
    }
    if (supportGoalCheck.id == null) {
      throw ArgumentError.notNull('supportGoalCheck.id');
    }

    var $supportGoalCheckFile = _i2.SupportGoalCheckFileImplicit(
      supportGoalCheckFile,
      $_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId:
          supportGoalCheck.id,
    );
    await session.db.updateRow<_i2.SupportGoalCheckFile>(
      $supportGoalCheckFile,
      columns: [
        _i2.SupportGoalCheckFile.t
            .$_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId
      ],
      transaction: transaction,
    );
  }
}

class SupportGoalCheckDetachRepository {
  const SupportGoalCheckDetachRepository._();

  /// Detaches the relation between this [SupportGoalCheck] and the given [SupportGoalCheckFile]
  /// by setting the [SupportGoalCheckFile]'s foreign key `_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> supportGoalCheckFiles(
    _i1.Session session,
    List<_i2.SupportGoalCheckFile> supportGoalCheckFile, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoalCheckFile.any((e) => e.id == null)) {
      throw ArgumentError.notNull('supportGoalCheckFile.id');
    }

    var $supportGoalCheckFile = supportGoalCheckFile
        .map((e) => _i2.SupportGoalCheckFileImplicit(
              e,
              $_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId: null,
            ))
        .toList();
    await session.db.update<_i2.SupportGoalCheckFile>(
      $supportGoalCheckFile,
      columns: [
        _i2.SupportGoalCheckFile.t
            .$_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId
      ],
      transaction: transaction,
    );
  }
}

class SupportGoalCheckDetachRowRepository {
  const SupportGoalCheckDetachRowRepository._();

  /// Detaches the relation between this [SupportGoalCheck] and the given [SupportGoalCheckFile]
  /// by setting the [SupportGoalCheckFile]'s foreign key `_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> supportGoalCheckFiles(
    _i1.Session session,
    _i2.SupportGoalCheckFile supportGoalCheckFile, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoalCheckFile.id == null) {
      throw ArgumentError.notNull('supportGoalCheckFile.id');
    }

    var $supportGoalCheckFile = _i2.SupportGoalCheckFileImplicit(
      supportGoalCheckFile,
      $_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId: null,
    );
    await session.db.updateRow<_i2.SupportGoalCheckFile>(
      $supportGoalCheckFile,
      columns: [
        _i2.SupportGoalCheckFile.t
            .$_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId
      ],
      transaction: transaction,
    );
  }
}
