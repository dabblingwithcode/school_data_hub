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
import '../pupil_data/pupil_data.dart' as _i2;
import '../learning_support/support_category.dart' as _i3;

abstract class SupportCategoryStatus
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  SupportCategoryStatus._({
    this.id,
    required this.statusId,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.comment,
    required this.fileUrl,
    required this.fileId,
    required this.pupilId,
    this.pupil,
    required this.supportCategoryId,
    this.supportCategory,
  })  : _supportCategoryCategorystatuesSupportCategoryId = null,
        _pupilDataSupportcategorystatusesPupilDataId = null;

  factory SupportCategoryStatus({
    int? id,
    required String statusId,
    required int status,
    required String createdBy,
    required DateTime createdAt,
    required String comment,
    required String fileUrl,
    required String fileId,
    required int pupilId,
    _i2.PupilData? pupil,
    required int supportCategoryId,
    _i3.SupportCategory? supportCategory,
  }) = _SupportCategoryStatusImpl;

  factory SupportCategoryStatus.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SupportCategoryStatusImplicit._(
      id: jsonSerialization['id'] as int?,
      statusId: jsonSerialization['statusId'] as String,
      status: jsonSerialization['status'] as int,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      comment: jsonSerialization['comment'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      fileId: jsonSerialization['fileId'] as String,
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
      $_supportCategoryCategorystatuesSupportCategoryId:
          jsonSerialization['_supportCategoryCategorystatuesSupportCategoryId']
              as int?,
      $_pupilDataSupportcategorystatusesPupilDataId:
          jsonSerialization['_pupilDataSupportcategorystatusesPupilDataId']
              as int?,
    );
  }

  static final t = SupportCategoryStatusTable();

  static const db = SupportCategoryStatusRepository._();

  @override
  int? id;

  String statusId;

  int status;

  String createdBy;

  DateTime createdAt;

  String comment;

  String fileUrl;

  String fileId;

  int pupilId;

  _i2.PupilData? pupil;

  int supportCategoryId;

  _i3.SupportCategory? supportCategory;

  final int? _supportCategoryCategorystatuesSupportCategoryId;

  final int? _pupilDataSupportcategorystatusesPupilDataId;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [SupportCategoryStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportCategoryStatus copyWith({
    int? id,
    String? statusId,
    int? status,
    String? createdBy,
    DateTime? createdAt,
    String? comment,
    String? fileUrl,
    String? fileId,
    int? pupilId,
    _i2.PupilData? pupil,
    int? supportCategoryId,
    _i3.SupportCategory? supportCategory,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'statusId': statusId,
      'status': status,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'comment': comment,
      'fileUrl': fileUrl,
      'fileId': fileId,
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'supportCategoryId': supportCategoryId,
      if (supportCategory != null) 'supportCategory': supportCategory?.toJson(),
      if (_supportCategoryCategorystatuesSupportCategoryId != null)
        '_supportCategoryCategorystatuesSupportCategoryId':
            _supportCategoryCategorystatuesSupportCategoryId,
      if (_pupilDataSupportcategorystatusesPupilDataId != null)
        '_pupilDataSupportcategorystatusesPupilDataId':
            _pupilDataSupportcategorystatusesPupilDataId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'statusId': statusId,
      'status': status,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'comment': comment,
      'fileUrl': fileUrl,
      'fileId': fileId,
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
      'supportCategoryId': supportCategoryId,
      if (supportCategory != null)
        'supportCategory': supportCategory?.toJsonForProtocol(),
    };
  }

  static SupportCategoryStatusInclude include({
    _i2.PupilDataInclude? pupil,
    _i3.SupportCategoryInclude? supportCategory,
  }) {
    return SupportCategoryStatusInclude._(
      pupil: pupil,
      supportCategory: supportCategory,
    );
  }

  static SupportCategoryStatusIncludeList includeList({
    _i1.WhereExpressionBuilder<SupportCategoryStatusTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupportCategoryStatusTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportCategoryStatusTable>? orderByList,
    SupportCategoryStatusInclude? include,
  }) {
    return SupportCategoryStatusIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SupportCategoryStatus.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SupportCategoryStatus.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportCategoryStatusImpl extends SupportCategoryStatus {
  _SupportCategoryStatusImpl({
    int? id,
    required String statusId,
    required int status,
    required String createdBy,
    required DateTime createdAt,
    required String comment,
    required String fileUrl,
    required String fileId,
    required int pupilId,
    _i2.PupilData? pupil,
    required int supportCategoryId,
    _i3.SupportCategory? supportCategory,
  }) : super._(
          id: id,
          statusId: statusId,
          status: status,
          createdBy: createdBy,
          createdAt: createdAt,
          comment: comment,
          fileUrl: fileUrl,
          fileId: fileId,
          pupilId: pupilId,
          pupil: pupil,
          supportCategoryId: supportCategoryId,
          supportCategory: supportCategory,
        );

  /// Returns a shallow copy of this [SupportCategoryStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportCategoryStatus copyWith({
    Object? id = _Undefined,
    String? statusId,
    int? status,
    String? createdBy,
    DateTime? createdAt,
    String? comment,
    String? fileUrl,
    String? fileId,
    int? pupilId,
    Object? pupil = _Undefined,
    int? supportCategoryId,
    Object? supportCategory = _Undefined,
  }) {
    return SupportCategoryStatusImplicit._(
      id: id is int? ? id : this.id,
      statusId: statusId ?? this.statusId,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      comment: comment ?? this.comment,
      fileUrl: fileUrl ?? this.fileUrl,
      fileId: fileId ?? this.fileId,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      supportCategoryId: supportCategoryId ?? this.supportCategoryId,
      supportCategory: supportCategory is _i3.SupportCategory?
          ? supportCategory
          : this.supportCategory?.copyWith(),
      $_supportCategoryCategorystatuesSupportCategoryId:
          this._supportCategoryCategorystatuesSupportCategoryId,
      $_pupilDataSupportcategorystatusesPupilDataId:
          this._pupilDataSupportcategorystatusesPupilDataId,
    );
  }
}

class SupportCategoryStatusImplicit extends _SupportCategoryStatusImpl {
  SupportCategoryStatusImplicit._({
    int? id,
    required String statusId,
    required int status,
    required String createdBy,
    required DateTime createdAt,
    required String comment,
    required String fileUrl,
    required String fileId,
    required int pupilId,
    _i2.PupilData? pupil,
    required int supportCategoryId,
    _i3.SupportCategory? supportCategory,
    int? $_supportCategoryCategorystatuesSupportCategoryId,
    int? $_pupilDataSupportcategorystatusesPupilDataId,
  })  : _supportCategoryCategorystatuesSupportCategoryId =
            $_supportCategoryCategorystatuesSupportCategoryId,
        _pupilDataSupportcategorystatusesPupilDataId =
            $_pupilDataSupportcategorystatusesPupilDataId,
        super(
          id: id,
          statusId: statusId,
          status: status,
          createdBy: createdBy,
          createdAt: createdAt,
          comment: comment,
          fileUrl: fileUrl,
          fileId: fileId,
          pupilId: pupilId,
          pupil: pupil,
          supportCategoryId: supportCategoryId,
          supportCategory: supportCategory,
        );

  factory SupportCategoryStatusImplicit(
    SupportCategoryStatus supportCategoryStatus, {
    int? $_supportCategoryCategorystatuesSupportCategoryId,
    int? $_pupilDataSupportcategorystatusesPupilDataId,
  }) {
    return SupportCategoryStatusImplicit._(
      id: supportCategoryStatus.id,
      statusId: supportCategoryStatus.statusId,
      status: supportCategoryStatus.status,
      createdBy: supportCategoryStatus.createdBy,
      createdAt: supportCategoryStatus.createdAt,
      comment: supportCategoryStatus.comment,
      fileUrl: supportCategoryStatus.fileUrl,
      fileId: supportCategoryStatus.fileId,
      pupilId: supportCategoryStatus.pupilId,
      pupil: supportCategoryStatus.pupil,
      supportCategoryId: supportCategoryStatus.supportCategoryId,
      supportCategory: supportCategoryStatus.supportCategory,
      $_supportCategoryCategorystatuesSupportCategoryId:
          $_supportCategoryCategorystatuesSupportCategoryId,
      $_pupilDataSupportcategorystatusesPupilDataId:
          $_pupilDataSupportcategorystatusesPupilDataId,
    );
  }

  @override
  final int? _supportCategoryCategorystatuesSupportCategoryId;

  @override
  final int? _pupilDataSupportcategorystatusesPupilDataId;
}

class SupportCategoryStatusTable extends _i1.Table<int> {
  SupportCategoryStatusTable({super.tableRelation})
      : super(tableName: 'support_category_status') {
    statusId = _i1.ColumnString(
      'statusId',
      this,
    );
    status = _i1.ColumnInt(
      'status',
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
    comment = _i1.ColumnString(
      'comment',
      this,
    );
    fileUrl = _i1.ColumnString(
      'fileUrl',
      this,
    );
    fileId = _i1.ColumnString(
      'fileId',
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
    $_supportCategoryCategorystatuesSupportCategoryId = _i1.ColumnInt(
      '_supportCategoryCategorystatuesSupportCategoryId',
      this,
    );
    $_pupilDataSupportcategorystatusesPupilDataId = _i1.ColumnInt(
      '_pupilDataSupportcategorystatusesPupilDataId',
      this,
    );
  }

  late final _i1.ColumnString statusId;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString comment;

  late final _i1.ColumnString fileUrl;

  late final _i1.ColumnString fileId;

  late final _i1.ColumnInt pupilId;

  _i2.PupilDataTable? _pupil;

  late final _i1.ColumnInt supportCategoryId;

  _i3.SupportCategoryTable? _supportCategory;

  late final _i1.ColumnInt $_supportCategoryCategorystatuesSupportCategoryId;

  late final _i1.ColumnInt $_pupilDataSupportcategorystatusesPupilDataId;

  _i2.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: SupportCategoryStatus.t.pupilId,
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
      field: SupportCategoryStatus.t.supportCategoryId,
      foreignField: _i3.SupportCategory.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SupportCategoryTable(tableRelation: foreignTableRelation),
    );
    return _supportCategory!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        statusId,
        status,
        createdBy,
        createdAt,
        comment,
        fileUrl,
        fileId,
        pupilId,
        supportCategoryId,
        $_supportCategoryCategorystatuesSupportCategoryId,
        $_pupilDataSupportcategorystatusesPupilDataId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        statusId,
        status,
        createdBy,
        createdAt,
        comment,
        fileUrl,
        fileId,
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
    return null;
  }
}

class SupportCategoryStatusInclude extends _i1.IncludeObject {
  SupportCategoryStatusInclude._({
    _i2.PupilDataInclude? pupil,
    _i3.SupportCategoryInclude? supportCategory,
  }) {
    _pupil = pupil;
    _supportCategory = supportCategory;
  }

  _i2.PupilDataInclude? _pupil;

  _i3.SupportCategoryInclude? _supportCategory;

  @override
  Map<String, _i1.Include?> get includes => {
        'pupil': _pupil,
        'supportCategory': _supportCategory,
      };

  @override
  _i1.Table<int> get table => SupportCategoryStatus.t;
}

class SupportCategoryStatusIncludeList extends _i1.IncludeList {
  SupportCategoryStatusIncludeList._({
    _i1.WhereExpressionBuilder<SupportCategoryStatusTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SupportCategoryStatus.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => SupportCategoryStatus.t;
}

class SupportCategoryStatusRepository {
  const SupportCategoryStatusRepository._();

  final attachRow = const SupportCategoryStatusAttachRowRepository._();

  /// Returns a list of [SupportCategoryStatus]s matching the given query parameters.
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
  Future<List<SupportCategoryStatus>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportCategoryStatusTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupportCategoryStatusTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportCategoryStatusTable>? orderByList,
    _i1.Transaction? transaction,
    SupportCategoryStatusInclude? include,
  }) async {
    return session.db.find<SupportCategoryStatus>(
      where: where?.call(SupportCategoryStatus.t),
      orderBy: orderBy?.call(SupportCategoryStatus.t),
      orderByList: orderByList?.call(SupportCategoryStatus.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SupportCategoryStatus] matching the given query parameters.
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
  Future<SupportCategoryStatus?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportCategoryStatusTable>? where,
    int? offset,
    _i1.OrderByBuilder<SupportCategoryStatusTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupportCategoryStatusTable>? orderByList,
    _i1.Transaction? transaction,
    SupportCategoryStatusInclude? include,
  }) async {
    return session.db.findFirstRow<SupportCategoryStatus>(
      where: where?.call(SupportCategoryStatus.t),
      orderBy: orderBy?.call(SupportCategoryStatus.t),
      orderByList: orderByList?.call(SupportCategoryStatus.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SupportCategoryStatus] by its [id] or null if no such row exists.
  Future<SupportCategoryStatus?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SupportCategoryStatusInclude? include,
  }) async {
    return session.db.findById<SupportCategoryStatus>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SupportCategoryStatus]s in the list and returns the inserted rows.
  ///
  /// The returned [SupportCategoryStatus]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SupportCategoryStatus>> insert(
    _i1.Session session,
    List<SupportCategoryStatus> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SupportCategoryStatus>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SupportCategoryStatus] and returns the inserted row.
  ///
  /// The returned [SupportCategoryStatus] will have its `id` field set.
  Future<SupportCategoryStatus> insertRow(
    _i1.Session session,
    SupportCategoryStatus row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SupportCategoryStatus>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SupportCategoryStatus]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SupportCategoryStatus>> update(
    _i1.Session session,
    List<SupportCategoryStatus> rows, {
    _i1.ColumnSelections<SupportCategoryStatusTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SupportCategoryStatus>(
      rows,
      columns: columns?.call(SupportCategoryStatus.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SupportCategoryStatus]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SupportCategoryStatus> updateRow(
    _i1.Session session,
    SupportCategoryStatus row, {
    _i1.ColumnSelections<SupportCategoryStatusTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SupportCategoryStatus>(
      row,
      columns: columns?.call(SupportCategoryStatus.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SupportCategoryStatus]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SupportCategoryStatus>> delete(
    _i1.Session session,
    List<SupportCategoryStatus> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SupportCategoryStatus>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SupportCategoryStatus].
  Future<SupportCategoryStatus> deleteRow(
    _i1.Session session,
    SupportCategoryStatus row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SupportCategoryStatus>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SupportCategoryStatus>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SupportCategoryStatusTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SupportCategoryStatus>(
      where: where(SupportCategoryStatus.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SupportCategoryStatusTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SupportCategoryStatus>(
      where: where?.call(SupportCategoryStatus.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SupportCategoryStatusAttachRowRepository {
  const SupportCategoryStatusAttachRowRepository._();

  /// Creates a relation between the given [SupportCategoryStatus] and [PupilData]
  /// by setting the [SupportCategoryStatus]'s foreign key `pupilId` to refer to the [PupilData].
  Future<void> pupil(
    _i1.Session session,
    SupportCategoryStatus supportCategoryStatus,
    _i2.PupilData pupil, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.id == null) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }
    if (pupil.id == null) {
      throw ArgumentError.notNull('pupil.id');
    }

    var $supportCategoryStatus =
        supportCategoryStatus.copyWith(pupilId: pupil.id);
    await session.db.updateRow<SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [SupportCategoryStatus.t.pupilId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [SupportCategoryStatus] and [SupportCategory]
  /// by setting the [SupportCategoryStatus]'s foreign key `supportCategoryId` to refer to the [SupportCategory].
  Future<void> supportCategory(
    _i1.Session session,
    SupportCategoryStatus supportCategoryStatus,
    _i3.SupportCategory supportCategory, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.id == null) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }
    if (supportCategory.id == null) {
      throw ArgumentError.notNull('supportCategory.id');
    }

    var $supportCategoryStatus =
        supportCategoryStatus.copyWith(supportCategoryId: supportCategory.id);
    await session.db.updateRow<SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [SupportCategoryStatus.t.supportCategoryId],
      transaction: transaction,
    );
  }
}
