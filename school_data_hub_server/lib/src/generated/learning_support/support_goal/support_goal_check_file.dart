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
import '../../learning_support/support_goal/support_goal_check.dart' as _i2;

abstract class SupportGoalCheckFile
    implements _i1.TableRow, _i1.ProtocolSerialization {
  SupportGoalCheckFile._({
    this.id,
    required this.fileId,
    required this.createdBy,
    required this.createdAt,
    required this.fileUrl,
    required this.supportGoalCheckId,
    this.supportGoalCheck,
  });

  factory SupportGoalCheckFile({
    int? id,
    required String fileId,
    required String createdBy,
    required DateTime createdAt,
    required String fileUrl,
    required int supportGoalCheckId,
    _i2.SupportGoalCheck? supportGoalCheck,
  }) = _SupportGoalCheckFileImpl;

  factory SupportGoalCheckFile.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SupportGoalCheckFile(
      id: jsonSerialization['id'] as int?,
      fileId: jsonSerialization['fileId'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      fileUrl: jsonSerialization['fileUrl'] as String,
      supportGoalCheckId: jsonSerialization['supportGoalCheckId'] as int,
      supportGoalCheck: jsonSerialization['supportGoalCheck'] == null
          ? null
          : _i2.SupportGoalCheck.fromJson(
              (jsonSerialization['supportGoalCheck'] as Map<String, dynamic>)),
    );
  }

  static final t = SupportGoalCheckFileTable();

  static const db = SupportGoalCheckFileRepository._();

  @override
  int? id;

  String fileId;

  String createdBy;

  DateTime createdAt;

  String fileUrl;

  int supportGoalCheckId;

  _i2.SupportGoalCheck? supportGoalCheck;

  int? _supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId;

  @override
  _i1.Table get table => t;

  /// Returns a shallow copy of this [SupportGoalCheckFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportGoalCheckFile copyWith({
    int? id,
    String? fileId,
    String? createdBy,
    DateTime? createdAt,
    String? fileUrl,
    int? supportGoalCheckId,
    _i2.SupportGoalCheck? supportGoalCheck,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'fileId': fileId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'fileUrl': fileUrl,
      'supportGoalCheckId': supportGoalCheckId,
      if (supportGoalCheck != null)
        'supportGoalCheck': supportGoalCheck?.toJson(),
      if (_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId != null)
        '_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId':
            _supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'fileId': fileId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'fileUrl': fileUrl,
      'supportGoalCheckId': supportGoalCheckId,
      if (supportGoalCheck != null)
        'supportGoalCheck': supportGoalCheck?.toJsonForProtocol(),
    };
  }

  static SupportGoalCheckFileInclude include(
      {_i2.SupportGoalCheckInclude? supportGoalCheck}) {
    return SupportGoalCheckFileInclude._(supportGoalCheck: supportGoalCheck);
  }

  static SupportGoalCheckFileIncludeList includeList({
    _i1.WhereExpressionBuilder<SupportGoalCheckFileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupportGoalCheckFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportGoalCheckFileTable>? orderByList,
    SupportGoalCheckFileInclude? include,
  }) {
    return SupportGoalCheckFileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SupportGoalCheckFile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SupportGoalCheckFile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportGoalCheckFileImpl extends SupportGoalCheckFile {
  _SupportGoalCheckFileImpl({
    int? id,
    required String fileId,
    required String createdBy,
    required DateTime createdAt,
    required String fileUrl,
    required int supportGoalCheckId,
    _i2.SupportGoalCheck? supportGoalCheck,
  }) : super._(
          id: id,
          fileId: fileId,
          createdBy: createdBy,
          createdAt: createdAt,
          fileUrl: fileUrl,
          supportGoalCheckId: supportGoalCheckId,
          supportGoalCheck: supportGoalCheck,
        );

  /// Returns a shallow copy of this [SupportGoalCheckFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportGoalCheckFile copyWith({
    Object? id = _Undefined,
    String? fileId,
    String? createdBy,
    DateTime? createdAt,
    String? fileUrl,
    int? supportGoalCheckId,
    Object? supportGoalCheck = _Undefined,
  }) {
    return SupportGoalCheckFile(
      id: id is int? ? id : this.id,
      fileId: fileId ?? this.fileId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      fileUrl: fileUrl ?? this.fileUrl,
      supportGoalCheckId: supportGoalCheckId ?? this.supportGoalCheckId,
      supportGoalCheck: supportGoalCheck is _i2.SupportGoalCheck?
          ? supportGoalCheck
          : this.supportGoalCheck?.copyWith(),
    );
  }
}

class SupportGoalCheckFileImplicit extends _SupportGoalCheckFileImpl {
  SupportGoalCheckFileImplicit._({
    int? id,
    required String fileId,
    required String createdBy,
    required DateTime createdAt,
    required String fileUrl,
    required int supportGoalCheckId,
    _i2.SupportGoalCheck? supportGoalCheck,
    this.$_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId,
  }) : super(
          id: id,
          fileId: fileId,
          createdBy: createdBy,
          createdAt: createdAt,
          fileUrl: fileUrl,
          supportGoalCheckId: supportGoalCheckId,
          supportGoalCheck: supportGoalCheck,
        );

  factory SupportGoalCheckFileImplicit(
    SupportGoalCheckFile supportGoalCheckFile, {
    int? $_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId,
  }) {
    return SupportGoalCheckFileImplicit._(
      id: supportGoalCheckFile.id,
      fileId: supportGoalCheckFile.fileId,
      createdBy: supportGoalCheckFile.createdBy,
      createdAt: supportGoalCheckFile.createdAt,
      fileUrl: supportGoalCheckFile.fileUrl,
      supportGoalCheckId: supportGoalCheckFile.supportGoalCheckId,
      supportGoalCheck: supportGoalCheckFile.supportGoalCheck,
      $_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId:
          $_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId,
    );
  }

  int? $_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId;

  @override
  Map<String, dynamic> toJson() {
    var jsonMap = super.toJson();
    jsonMap.addAll({
      '_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId':
          $_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId
    });
    return jsonMap;
  }
}

class SupportGoalCheckFileTable extends _i1.Table {
  SupportGoalCheckFileTable({super.tableRelation})
      : super(tableName: 'support_goal_check_file') {
    fileId = _i1.ColumnString(
      'fileId',
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
    fileUrl = _i1.ColumnString(
      'fileUrl',
      this,
    );
    supportGoalCheckId = _i1.ColumnInt(
      'supportGoalCheckId',
      this,
    );
    $_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId = _i1.ColumnInt(
      '_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId',
      this,
    );
  }

  late final _i1.ColumnString fileId;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString fileUrl;

  late final _i1.ColumnInt supportGoalCheckId;

  _i2.SupportGoalCheckTable? _supportGoalCheck;

  late final _i1.ColumnInt
      $_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId;

  _i2.SupportGoalCheckTable get supportGoalCheck {
    if (_supportGoalCheck != null) return _supportGoalCheck!;
    _supportGoalCheck = _i1.createRelationTable(
      relationFieldName: 'supportGoalCheck',
      field: SupportGoalCheckFile.t.supportGoalCheckId,
      foreignField: _i2.SupportGoalCheck.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SupportGoalCheckTable(tableRelation: foreignTableRelation),
    );
    return _supportGoalCheck!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        fileId,
        createdBy,
        createdAt,
        fileUrl,
        supportGoalCheckId,
        $_supportGoalCheckSupportgoalcheckfilesSupportGoalCheckId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'supportGoalCheck') {
      return supportGoalCheck;
    }
    return null;
  }
}

class SupportGoalCheckFileInclude extends _i1.IncludeObject {
  SupportGoalCheckFileInclude._(
      {_i2.SupportGoalCheckInclude? supportGoalCheck}) {
    _supportGoalCheck = supportGoalCheck;
  }

  _i2.SupportGoalCheckInclude? _supportGoalCheck;

  @override
  Map<String, _i1.Include?> get includes =>
      {'supportGoalCheck': _supportGoalCheck};

  @override
  _i1.Table get table => SupportGoalCheckFile.t;
}

class SupportGoalCheckFileIncludeList extends _i1.IncludeList {
  SupportGoalCheckFileIncludeList._({
    _i1.WhereExpressionBuilder<SupportGoalCheckFileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SupportGoalCheckFile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => SupportGoalCheckFile.t;
}

class SupportGoalCheckFileRepository {
  const SupportGoalCheckFileRepository._();

  final attachRow = const SupportGoalCheckFileAttachRowRepository._();

  /// Returns a list of [SupportGoalCheckFile]s matching the given query parameters.
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
  Future<List<SupportGoalCheckFile>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportGoalCheckFileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupportGoalCheckFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportGoalCheckFileTable>? orderByList,
    _i1.Transaction? transaction,
    SupportGoalCheckFileInclude? include,
  }) async {
    return session.db.find<SupportGoalCheckFile>(
      where: where?.call(SupportGoalCheckFile.t),
      orderBy: orderBy?.call(SupportGoalCheckFile.t),
      orderByList: orderByList?.call(SupportGoalCheckFile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SupportGoalCheckFile] matching the given query parameters.
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
  Future<SupportGoalCheckFile?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportGoalCheckFileTable>? where,
    int? offset,
    _i1.OrderByBuilder<SupportGoalCheckFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportGoalCheckFileTable>? orderByList,
    _i1.Transaction? transaction,
    SupportGoalCheckFileInclude? include,
  }) async {
    return session.db.findFirstRow<SupportGoalCheckFile>(
      where: where?.call(SupportGoalCheckFile.t),
      orderBy: orderBy?.call(SupportGoalCheckFile.t),
      orderByList: orderByList?.call(SupportGoalCheckFile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SupportGoalCheckFile] by its [id] or null if no such row exists.
  Future<SupportGoalCheckFile?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SupportGoalCheckFileInclude? include,
  }) async {
    return session.db.findById<SupportGoalCheckFile>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SupportGoalCheckFile]s in the list and returns the inserted rows.
  ///
  /// The returned [SupportGoalCheckFile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SupportGoalCheckFile>> insert(
    _i1.Session session,
    List<SupportGoalCheckFile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SupportGoalCheckFile>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SupportGoalCheckFile] and returns the inserted row.
  ///
  /// The returned [SupportGoalCheckFile] will have its `id` field set.
  Future<SupportGoalCheckFile> insertRow(
    _i1.Session session,
    SupportGoalCheckFile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SupportGoalCheckFile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SupportGoalCheckFile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SupportGoalCheckFile>> update(
    _i1.Session session,
    List<SupportGoalCheckFile> rows, {
    _i1.ColumnSelections<SupportGoalCheckFileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SupportGoalCheckFile>(
      rows,
      columns: columns?.call(SupportGoalCheckFile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SupportGoalCheckFile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SupportGoalCheckFile> updateRow(
    _i1.Session session,
    SupportGoalCheckFile row, {
    _i1.ColumnSelections<SupportGoalCheckFileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SupportGoalCheckFile>(
      row,
      columns: columns?.call(SupportGoalCheckFile.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SupportGoalCheckFile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SupportGoalCheckFile>> delete(
    _i1.Session session,
    List<SupportGoalCheckFile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SupportGoalCheckFile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SupportGoalCheckFile].
  Future<SupportGoalCheckFile> deleteRow(
    _i1.Session session,
    SupportGoalCheckFile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SupportGoalCheckFile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SupportGoalCheckFile>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SupportGoalCheckFileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SupportGoalCheckFile>(
      where: where(SupportGoalCheckFile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportGoalCheckFileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SupportGoalCheckFile>(
      where: where?.call(SupportGoalCheckFile.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SupportGoalCheckFileAttachRowRepository {
  const SupportGoalCheckFileAttachRowRepository._();

  /// Creates a relation between the given [SupportGoalCheckFile] and [SupportGoalCheck]
  /// by setting the [SupportGoalCheckFile]'s foreign key `supportGoalCheckId` to refer to the [SupportGoalCheck].
  Future<void> supportGoalCheck(
    _i1.Session session,
    SupportGoalCheckFile supportGoalCheckFile,
    _i2.SupportGoalCheck supportGoalCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (supportGoalCheckFile.id == null) {
      throw ArgumentError.notNull('supportGoalCheckFile.id');
    }
    if (supportGoalCheck.id == null) {
      throw ArgumentError.notNull('supportGoalCheck.id');
    }

    var $supportGoalCheckFile =
        supportGoalCheckFile.copyWith(supportGoalCheckId: supportGoalCheck.id);
    await session.db.updateRow<SupportGoalCheckFile>(
      $supportGoalCheckFile,
      columns: [SupportGoalCheckFile.t.supportGoalCheckId],
      transaction: transaction,
    );
  }
}
