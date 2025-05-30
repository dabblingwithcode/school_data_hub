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
import '../../../_shared/models/hub_document.dart' as _i2;
import '../../../_features/pupil/models/pupil_data/pupil_data.dart' as _i3;
import '../../../_features/learning_support/models/support_category.dart'
    as _i4;
import '../../../_features/learning_support/models/learning_support_plan.dart'
    as _i5;

abstract class SupportCategoryStatus
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SupportCategoryStatus._({
    this.id,
    required this.score,
    required this.createdBy,
    required this.createdAt,
    required this.comment,
    this.documents,
    required this.pupilId,
    this.pupil,
    required this.supportCategoryId,
    this.supportCategory,
    required this.learningSupportPlanId,
    this.learningSupportPlan,
  })  : _learningSupportPlanSupportcategorystatusesLearningSupporfb7bId = null,
        _supportCategoryCategorystatuesSupportCategoryId = null,
        _pupilDataSupportcategorystatusesPupilDataId = null;

  factory SupportCategoryStatus({
    int? id,
    required int score,
    required String createdBy,
    required DateTime createdAt,
    required String comment,
    List<_i2.HubDocument>? documents,
    required int pupilId,
    _i3.PupilData? pupil,
    required int supportCategoryId,
    _i4.SupportCategory? supportCategory,
    required int learningSupportPlanId,
    _i5.LearningSupportPlan? learningSupportPlan,
  }) = _SupportCategoryStatusImpl;

  factory SupportCategoryStatus.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SupportCategoryStatusImplicit._(
      id: jsonSerialization['id'] as int?,
      score: jsonSerialization['score'] as int,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      comment: jsonSerialization['comment'] as String,
      documents: (jsonSerialization['documents'] as List?)
          ?.map((e) => _i2.HubDocument.fromJson((e as Map<String, dynamic>)))
          .toList(),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i3.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      supportCategoryId: jsonSerialization['supportCategoryId'] as int,
      supportCategory: jsonSerialization['supportCategory'] == null
          ? null
          : _i4.SupportCategory.fromJson(
              (jsonSerialization['supportCategory'] as Map<String, dynamic>)),
      learningSupportPlanId: jsonSerialization['learningSupportPlanId'] as int,
      learningSupportPlan: jsonSerialization['learningSupportPlan'] == null
          ? null
          : _i5.LearningSupportPlan.fromJson(
              (jsonSerialization['learningSupportPlan']
                  as Map<String, dynamic>)),
      $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId:
          jsonSerialization[
                  '_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId']
              as int?,
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

  int score;

  String createdBy;

  DateTime createdAt;

  String comment;

  List<_i2.HubDocument>? documents;

  int pupilId;

  _i3.PupilData? pupil;

  int supportCategoryId;

  _i4.SupportCategory? supportCategory;

  int learningSupportPlanId;

  _i5.LearningSupportPlan? learningSupportPlan;

  final int? _learningSupportPlanSupportcategorystatusesLearningSupporfb7bId;

  final int? _supportCategoryCategorystatuesSupportCategoryId;

  final int? _pupilDataSupportcategorystatusesPupilDataId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SupportCategoryStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportCategoryStatus copyWith({
    int? id,
    int? score,
    String? createdBy,
    DateTime? createdAt,
    String? comment,
    List<_i2.HubDocument>? documents,
    int? pupilId,
    _i3.PupilData? pupil,
    int? supportCategoryId,
    _i4.SupportCategory? supportCategory,
    int? learningSupportPlanId,
    _i5.LearningSupportPlan? learningSupportPlan,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'score': score,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'comment': comment,
      if (documents != null)
        'documents': documents?.toJson(valueToJson: (v) => v.toJson()),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'supportCategoryId': supportCategoryId,
      if (supportCategory != null) 'supportCategory': supportCategory?.toJson(),
      'learningSupportPlanId': learningSupportPlanId,
      if (learningSupportPlan != null)
        'learningSupportPlan': learningSupportPlan?.toJson(),
      if (_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId !=
          null)
        '_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId':
            _learningSupportPlanSupportcategorystatusesLearningSupporfb7bId,
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
      'score': score,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'comment': comment,
      if (documents != null)
        'documents':
            documents?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJsonForProtocol(),
      'supportCategoryId': supportCategoryId,
      if (supportCategory != null)
        'supportCategory': supportCategory?.toJsonForProtocol(),
      'learningSupportPlanId': learningSupportPlanId,
      if (learningSupportPlan != null)
        'learningSupportPlan': learningSupportPlan?.toJsonForProtocol(),
    };
  }

  static SupportCategoryStatusInclude include({
    _i2.HubDocumentIncludeList? documents,
    _i3.PupilDataInclude? pupil,
    _i4.SupportCategoryInclude? supportCategory,
    _i5.LearningSupportPlanInclude? learningSupportPlan,
  }) {
    return SupportCategoryStatusInclude._(
      documents: documents,
      pupil: pupil,
      supportCategory: supportCategory,
      learningSupportPlan: learningSupportPlan,
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
    required int score,
    required String createdBy,
    required DateTime createdAt,
    required String comment,
    List<_i2.HubDocument>? documents,
    required int pupilId,
    _i3.PupilData? pupil,
    required int supportCategoryId,
    _i4.SupportCategory? supportCategory,
    required int learningSupportPlanId,
    _i5.LearningSupportPlan? learningSupportPlan,
  }) : super._(
          id: id,
          score: score,
          createdBy: createdBy,
          createdAt: createdAt,
          comment: comment,
          documents: documents,
          pupilId: pupilId,
          pupil: pupil,
          supportCategoryId: supportCategoryId,
          supportCategory: supportCategory,
          learningSupportPlanId: learningSupportPlanId,
          learningSupportPlan: learningSupportPlan,
        );

  /// Returns a shallow copy of this [SupportCategoryStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportCategoryStatus copyWith({
    Object? id = _Undefined,
    int? score,
    String? createdBy,
    DateTime? createdAt,
    String? comment,
    Object? documents = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
    int? supportCategoryId,
    Object? supportCategory = _Undefined,
    int? learningSupportPlanId,
    Object? learningSupportPlan = _Undefined,
  }) {
    return SupportCategoryStatusImplicit._(
      id: id is int? ? id : this.id,
      score: score ?? this.score,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      comment: comment ?? this.comment,
      documents: documents is List<_i2.HubDocument>?
          ? documents
          : this.documents?.map((e0) => e0.copyWith()).toList(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i3.PupilData? ? pupil : this.pupil?.copyWith(),
      supportCategoryId: supportCategoryId ?? this.supportCategoryId,
      supportCategory: supportCategory is _i4.SupportCategory?
          ? supportCategory
          : this.supportCategory?.copyWith(),
      learningSupportPlanId:
          learningSupportPlanId ?? this.learningSupportPlanId,
      learningSupportPlan: learningSupportPlan is _i5.LearningSupportPlan?
          ? learningSupportPlan
          : this.learningSupportPlan?.copyWith(),
      $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId:
          this._learningSupportPlanSupportcategorystatusesLearningSupporfb7bId,
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
    required int score,
    required String createdBy,
    required DateTime createdAt,
    required String comment,
    List<_i2.HubDocument>? documents,
    required int pupilId,
    _i3.PupilData? pupil,
    required int supportCategoryId,
    _i4.SupportCategory? supportCategory,
    required int learningSupportPlanId,
    _i5.LearningSupportPlan? learningSupportPlan,
    int? $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId,
    int? $_supportCategoryCategorystatuesSupportCategoryId,
    int? $_pupilDataSupportcategorystatusesPupilDataId,
  })  : _learningSupportPlanSupportcategorystatusesLearningSupporfb7bId =
            $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId,
        _supportCategoryCategorystatuesSupportCategoryId =
            $_supportCategoryCategorystatuesSupportCategoryId,
        _pupilDataSupportcategorystatusesPupilDataId =
            $_pupilDataSupportcategorystatusesPupilDataId,
        super(
          id: id,
          score: score,
          createdBy: createdBy,
          createdAt: createdAt,
          comment: comment,
          documents: documents,
          pupilId: pupilId,
          pupil: pupil,
          supportCategoryId: supportCategoryId,
          supportCategory: supportCategory,
          learningSupportPlanId: learningSupportPlanId,
          learningSupportPlan: learningSupportPlan,
        );

  factory SupportCategoryStatusImplicit(
    SupportCategoryStatus supportCategoryStatus, {
    int? $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId,
    int? $_supportCategoryCategorystatuesSupportCategoryId,
    int? $_pupilDataSupportcategorystatusesPupilDataId,
  }) {
    return SupportCategoryStatusImplicit._(
      id: supportCategoryStatus.id,
      score: supportCategoryStatus.score,
      createdBy: supportCategoryStatus.createdBy,
      createdAt: supportCategoryStatus.createdAt,
      comment: supportCategoryStatus.comment,
      documents: supportCategoryStatus.documents,
      pupilId: supportCategoryStatus.pupilId,
      pupil: supportCategoryStatus.pupil,
      supportCategoryId: supportCategoryStatus.supportCategoryId,
      supportCategory: supportCategoryStatus.supportCategory,
      learningSupportPlanId: supportCategoryStatus.learningSupportPlanId,
      learningSupportPlan: supportCategoryStatus.learningSupportPlan,
      $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId:
          $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId,
      $_supportCategoryCategorystatuesSupportCategoryId:
          $_supportCategoryCategorystatuesSupportCategoryId,
      $_pupilDataSupportcategorystatusesPupilDataId:
          $_pupilDataSupportcategorystatusesPupilDataId,
    );
  }

  @override
  final int? _learningSupportPlanSupportcategorystatusesLearningSupporfb7bId;

  @override
  final int? _supportCategoryCategorystatuesSupportCategoryId;

  @override
  final int? _pupilDataSupportcategorystatusesPupilDataId;
}

class SupportCategoryStatusTable extends _i1.Table<int?> {
  SupportCategoryStatusTable({super.tableRelation})
      : super(tableName: 'support_category_status') {
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
    comment = _i1.ColumnString(
      'comment',
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
    learningSupportPlanId = _i1.ColumnInt(
      'learningSupportPlanId',
      this,
    );
    $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId =
        _i1.ColumnInt(
      '_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId',
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

  late final _i1.ColumnInt score;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString comment;

  _i2.HubDocumentTable? ___documents;

  _i1.ManyRelation<_i2.HubDocumentTable>? _documents;

  late final _i1.ColumnInt pupilId;

  _i3.PupilDataTable? _pupil;

  late final _i1.ColumnInt supportCategoryId;

  _i4.SupportCategoryTable? _supportCategory;

  late final _i1.ColumnInt learningSupportPlanId;

  _i5.LearningSupportPlanTable? _learningSupportPlan;

  late final _i1.ColumnInt
      $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId;

  late final _i1.ColumnInt $_supportCategoryCategorystatuesSupportCategoryId;

  late final _i1.ColumnInt $_pupilDataSupportcategorystatusesPupilDataId;

  _i2.HubDocumentTable get __documents {
    if (___documents != null) return ___documents!;
    ___documents = _i1.createRelationTable(
      relationFieldName: '__documents',
      field: SupportCategoryStatus.t.id,
      foreignField: _i2.HubDocument.t
          .$_supportCategoryStatusDocumentsSupportCategoryStatusId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    return ___documents!;
  }

  _i3.PupilDataTable get pupil {
    if (_pupil != null) return _pupil!;
    _pupil = _i1.createRelationTable(
      relationFieldName: 'pupil',
      field: SupportCategoryStatus.t.pupilId,
      foreignField: _i3.PupilData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PupilDataTable(tableRelation: foreignTableRelation),
    );
    return _pupil!;
  }

  _i4.SupportCategoryTable get supportCategory {
    if (_supportCategory != null) return _supportCategory!;
    _supportCategory = _i1.createRelationTable(
      relationFieldName: 'supportCategory',
      field: SupportCategoryStatus.t.supportCategoryId,
      foreignField: _i4.SupportCategory.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SupportCategoryTable(tableRelation: foreignTableRelation),
    );
    return _supportCategory!;
  }

  _i5.LearningSupportPlanTable get learningSupportPlan {
    if (_learningSupportPlan != null) return _learningSupportPlan!;
    _learningSupportPlan = _i1.createRelationTable(
      relationFieldName: 'learningSupportPlan',
      field: SupportCategoryStatus.t.learningSupportPlanId,
      foreignField: _i5.LearningSupportPlan.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.LearningSupportPlanTable(tableRelation: foreignTableRelation),
    );
    return _learningSupportPlan!;
  }

  _i1.ManyRelation<_i2.HubDocumentTable> get documents {
    if (_documents != null) return _documents!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'documents',
      field: SupportCategoryStatus.t.id,
      foreignField: _i2.HubDocument.t
          .$_supportCategoryStatusDocumentsSupportCategoryStatusId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    _documents = _i1.ManyRelation<_i2.HubDocumentTable>(
      tableWithRelations: relationTable,
      table: _i2.HubDocumentTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _documents!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        score,
        createdBy,
        createdAt,
        comment,
        pupilId,
        supportCategoryId,
        learningSupportPlanId,
        $_learningSupportPlanSupportcategorystatusesLearningSupporfb7bId,
        $_supportCategoryCategorystatuesSupportCategoryId,
        $_pupilDataSupportcategorystatusesPupilDataId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        score,
        createdBy,
        createdAt,
        comment,
        pupilId,
        supportCategoryId,
        learningSupportPlanId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'documents') {
      return __documents;
    }
    if (relationField == 'pupil') {
      return pupil;
    }
    if (relationField == 'supportCategory') {
      return supportCategory;
    }
    if (relationField == 'learningSupportPlan') {
      return learningSupportPlan;
    }
    return null;
  }
}

class SupportCategoryStatusInclude extends _i1.IncludeObject {
  SupportCategoryStatusInclude._({
    _i2.HubDocumentIncludeList? documents,
    _i3.PupilDataInclude? pupil,
    _i4.SupportCategoryInclude? supportCategory,
    _i5.LearningSupportPlanInclude? learningSupportPlan,
  }) {
    _documents = documents;
    _pupil = pupil;
    _supportCategory = supportCategory;
    _learningSupportPlan = learningSupportPlan;
  }

  _i2.HubDocumentIncludeList? _documents;

  _i3.PupilDataInclude? _pupil;

  _i4.SupportCategoryInclude? _supportCategory;

  _i5.LearningSupportPlanInclude? _learningSupportPlan;

  @override
  Map<String, _i1.Include?> get includes => {
        'documents': _documents,
        'pupil': _pupil,
        'supportCategory': _supportCategory,
        'learningSupportPlan': _learningSupportPlan,
      };

  @override
  _i1.Table<int?> get table => SupportCategoryStatus.t;
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
  _i1.Table<int?> get table => SupportCategoryStatus.t;
}

class SupportCategoryStatusRepository {
  const SupportCategoryStatusRepository._();

  final attach = const SupportCategoryStatusAttachRepository._();

  final attachRow = const SupportCategoryStatusAttachRowRepository._();

  final detach = const SupportCategoryStatusDetachRepository._();

  final detachRow = const SupportCategoryStatusDetachRowRepository._();

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

class SupportCategoryStatusAttachRepository {
  const SupportCategoryStatusAttachRepository._();

  /// Creates a relation between this [SupportCategoryStatus] and the given [HubDocument]s
  /// by setting each [HubDocument]'s foreign key `_supportCategoryStatusDocumentsSupportCategoryStatusId` to refer to this [SupportCategoryStatus].
  Future<void> documents(
    _i1.Session session,
    SupportCategoryStatus supportCategoryStatus,
    List<_i2.HubDocument> hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.any((e) => e.id == null)) {
      throw ArgumentError.notNull('hubDocument.id');
    }
    if (supportCategoryStatus.id == null) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }

    var $hubDocument = hubDocument
        .map((e) => _i2.HubDocumentImplicit(
              e,
              $_supportCategoryStatusDocumentsSupportCategoryStatusId:
                  supportCategoryStatus.id,
            ))
        .toList();
    await session.db.update<_i2.HubDocument>(
      $hubDocument,
      columns: [
        _i2.HubDocument.t
            .$_supportCategoryStatusDocumentsSupportCategoryStatusId
      ],
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
    _i3.PupilData pupil, {
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
    _i4.SupportCategory supportCategory, {
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

  /// Creates a relation between the given [SupportCategoryStatus] and [LearningSupportPlan]
  /// by setting the [SupportCategoryStatus]'s foreign key `learningSupportPlanId` to refer to the [LearningSupportPlan].
  Future<void> learningSupportPlan(
    _i1.Session session,
    SupportCategoryStatus supportCategoryStatus,
    _i5.LearningSupportPlan learningSupportPlan, {
    _i1.Transaction? transaction,
  }) async {
    if (supportCategoryStatus.id == null) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }
    if (learningSupportPlan.id == null) {
      throw ArgumentError.notNull('learningSupportPlan.id');
    }

    var $supportCategoryStatus = supportCategoryStatus.copyWith(
        learningSupportPlanId: learningSupportPlan.id);
    await session.db.updateRow<SupportCategoryStatus>(
      $supportCategoryStatus,
      columns: [SupportCategoryStatus.t.learningSupportPlanId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SupportCategoryStatus] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_supportCategoryStatusDocumentsSupportCategoryStatusId` to refer to this [SupportCategoryStatus].
  Future<void> documents(
    _i1.Session session,
    SupportCategoryStatus supportCategoryStatus,
    _i2.HubDocument hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.id == null) {
      throw ArgumentError.notNull('hubDocument.id');
    }
    if (supportCategoryStatus.id == null) {
      throw ArgumentError.notNull('supportCategoryStatus.id');
    }

    var $hubDocument = _i2.HubDocumentImplicit(
      hubDocument,
      $_supportCategoryStatusDocumentsSupportCategoryStatusId:
          supportCategoryStatus.id,
    );
    await session.db.updateRow<_i2.HubDocument>(
      $hubDocument,
      columns: [
        _i2.HubDocument.t
            .$_supportCategoryStatusDocumentsSupportCategoryStatusId
      ],
      transaction: transaction,
    );
  }
}

class SupportCategoryStatusDetachRepository {
  const SupportCategoryStatusDetachRepository._();

  /// Detaches the relation between this [SupportCategoryStatus] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_supportCategoryStatusDocumentsSupportCategoryStatusId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> documents(
    _i1.Session session,
    List<_i2.HubDocument> hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.any((e) => e.id == null)) {
      throw ArgumentError.notNull('hubDocument.id');
    }

    var $hubDocument = hubDocument
        .map((e) => _i2.HubDocumentImplicit(
              e,
              $_supportCategoryStatusDocumentsSupportCategoryStatusId: null,
            ))
        .toList();
    await session.db.update<_i2.HubDocument>(
      $hubDocument,
      columns: [
        _i2.HubDocument.t
            .$_supportCategoryStatusDocumentsSupportCategoryStatusId
      ],
      transaction: transaction,
    );
  }
}

class SupportCategoryStatusDetachRowRepository {
  const SupportCategoryStatusDetachRowRepository._();

  /// Detaches the relation between this [SupportCategoryStatus] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_supportCategoryStatusDocumentsSupportCategoryStatusId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> documents(
    _i1.Session session,
    _i2.HubDocument hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.id == null) {
      throw ArgumentError.notNull('hubDocument.id');
    }

    var $hubDocument = _i2.HubDocumentImplicit(
      hubDocument,
      $_supportCategoryStatusDocumentsSupportCategoryStatusId: null,
    );
    await session.db.updateRow<_i2.HubDocument>(
      $hubDocument,
      columns: [
        _i2.HubDocument.t
            .$_supportCategoryStatusDocumentsSupportCategoryStatusId
      ],
      transaction: transaction,
    );
  }
}
