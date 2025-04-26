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

abstract class HubDocument
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  HubDocument._({
    this.id,
    required this.documentId,
    this.documentPath,
    required this.createdBy,
    required this.createdAt,
  })  : _competenceCheckDocumentsCompetenceCheckId = null,
        _competenceGoalDocumentsCompetenceGoalId = null,
        _preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId = null,
        _preSchoolTestPreschooltestdocumentsPreSchoolTestId = null;

  factory HubDocument({
    int? id,
    required String documentId,
    String? documentPath,
    required String createdBy,
    required DateTime createdAt,
  }) = _HubDocumentImpl;

  factory HubDocument.fromJson(Map<String, dynamic> jsonSerialization) {
    return HubDocumentImplicit._(
      id: jsonSerialization['id'] as int?,
      documentId: jsonSerialization['documentId'] as String,
      documentPath: jsonSerialization['documentPath'] as String?,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      $_competenceCheckDocumentsCompetenceCheckId:
          jsonSerialization['_competenceCheckDocumentsCompetenceCheckId']
              as int?,
      $_competenceGoalDocumentsCompetenceGoalId:
          jsonSerialization['_competenceGoalDocumentsCompetenceGoalId'] as int?,
      $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId:
          jsonSerialization[
                  '_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId']
              as int?,
      $_preSchoolTestPreschooltestdocumentsPreSchoolTestId: jsonSerialization[
          '_preSchoolTestPreschooltestdocumentsPreSchoolTestId'] as int?,
    );
  }

  static final t = HubDocumentTable();

  static const db = HubDocumentRepository._();

  @override
  int? id;

  String documentId;

  String? documentPath;

  String createdBy;

  DateTime createdAt;

  final int? _competenceCheckDocumentsCompetenceCheckId;

  final int? _competenceGoalDocumentsCompetenceGoalId;

  final int? _preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId;

  final int? _preSchoolTestPreschooltestdocumentsPreSchoolTestId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [HubDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HubDocument copyWith({
    int? id,
    String? documentId,
    String? documentPath,
    String? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'documentId': documentId,
      if (documentPath != null) 'documentPath': documentPath,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (_competenceCheckDocumentsCompetenceCheckId != null)
        '_competenceCheckDocumentsCompetenceCheckId':
            _competenceCheckDocumentsCompetenceCheckId,
      if (_competenceGoalDocumentsCompetenceGoalId != null)
        '_competenceGoalDocumentsCompetenceGoalId':
            _competenceGoalDocumentsCompetenceGoalId,
      if (_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId != null)
        '_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId':
            _preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId,
      if (_preSchoolTestPreschooltestdocumentsPreSchoolTestId != null)
        '_preSchoolTestPreschooltestdocumentsPreSchoolTestId':
            _preSchoolTestPreschooltestdocumentsPreSchoolTestId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'documentId': documentId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
    };
  }

  static HubDocumentInclude include() {
    return HubDocumentInclude._();
  }

  static HubDocumentIncludeList includeList({
    _i1.WhereExpressionBuilder<HubDocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<HubDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<HubDocumentTable>? orderByList,
    HubDocumentInclude? include,
  }) {
    return HubDocumentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(HubDocument.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(HubDocument.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HubDocumentImpl extends HubDocument {
  _HubDocumentImpl({
    int? id,
    required String documentId,
    String? documentPath,
    required String createdBy,
    required DateTime createdAt,
  }) : super._(
          id: id,
          documentId: documentId,
          documentPath: documentPath,
          createdBy: createdBy,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [HubDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HubDocument copyWith({
    Object? id = _Undefined,
    String? documentId,
    Object? documentPath = _Undefined,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return HubDocumentImplicit._(
      id: id is int? ? id : this.id,
      documentId: documentId ?? this.documentId,
      documentPath: documentPath is String? ? documentPath : this.documentPath,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      $_competenceCheckDocumentsCompetenceCheckId:
          this._competenceCheckDocumentsCompetenceCheckId,
      $_competenceGoalDocumentsCompetenceGoalId:
          this._competenceGoalDocumentsCompetenceGoalId,
      $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId:
          this._preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId,
      $_preSchoolTestPreschooltestdocumentsPreSchoolTestId:
          this._preSchoolTestPreschooltestdocumentsPreSchoolTestId,
    );
  }
}

class HubDocumentImplicit extends _HubDocumentImpl {
  HubDocumentImplicit._({
    int? id,
    required String documentId,
    String? documentPath,
    required String createdBy,
    required DateTime createdAt,
    int? $_competenceCheckDocumentsCompetenceCheckId,
    int? $_competenceGoalDocumentsCompetenceGoalId,
    int? $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId,
    int? $_preSchoolTestPreschooltestdocumentsPreSchoolTestId,
  })  : _competenceCheckDocumentsCompetenceCheckId =
            $_competenceCheckDocumentsCompetenceCheckId,
        _competenceGoalDocumentsCompetenceGoalId =
            $_competenceGoalDocumentsCompetenceGoalId,
        _preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId =
            $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId,
        _preSchoolTestPreschooltestdocumentsPreSchoolTestId =
            $_preSchoolTestPreschooltestdocumentsPreSchoolTestId,
        super(
          id: id,
          documentId: documentId,
          documentPath: documentPath,
          createdBy: createdBy,
          createdAt: createdAt,
        );

  factory HubDocumentImplicit(
    HubDocument hubDocument, {
    int? $_competenceCheckDocumentsCompetenceCheckId,
    int? $_competenceGoalDocumentsCompetenceGoalId,
    int? $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId,
    int? $_preSchoolTestPreschooltestdocumentsPreSchoolTestId,
  }) {
    return HubDocumentImplicit._(
      id: hubDocument.id,
      documentId: hubDocument.documentId,
      documentPath: hubDocument.documentPath,
      createdBy: hubDocument.createdBy,
      createdAt: hubDocument.createdAt,
      $_competenceCheckDocumentsCompetenceCheckId:
          $_competenceCheckDocumentsCompetenceCheckId,
      $_competenceGoalDocumentsCompetenceGoalId:
          $_competenceGoalDocumentsCompetenceGoalId,
      $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId:
          $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId,
      $_preSchoolTestPreschooltestdocumentsPreSchoolTestId:
          $_preSchoolTestPreschooltestdocumentsPreSchoolTestId,
    );
  }

  @override
  final int? _competenceCheckDocumentsCompetenceCheckId;

  @override
  final int? _competenceGoalDocumentsCompetenceGoalId;

  @override
  final int? _preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId;

  @override
  final int? _preSchoolTestPreschooltestdocumentsPreSchoolTestId;
}

class HubDocumentTable extends _i1.Table<int?> {
  HubDocumentTable({super.tableRelation}) : super(tableName: 'hub_document') {
    documentId = _i1.ColumnString(
      'documentId',
      this,
    );
    documentPath = _i1.ColumnString(
      'documentPath',
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
    $_competenceCheckDocumentsCompetenceCheckId = _i1.ColumnInt(
      '_competenceCheckDocumentsCompetenceCheckId',
      this,
    );
    $_competenceGoalDocumentsCompetenceGoalId = _i1.ColumnInt(
      '_competenceGoalDocumentsCompetenceGoalId',
      this,
    );
    $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId = _i1.ColumnInt(
      '_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId',
      this,
    );
    $_preSchoolTestPreschooltestdocumentsPreSchoolTestId = _i1.ColumnInt(
      '_preSchoolTestPreschooltestdocumentsPreSchoolTestId',
      this,
    );
  }

  late final _i1.ColumnString documentId;

  late final _i1.ColumnString documentPath;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnInt $_competenceCheckDocumentsCompetenceCheckId;

  late final _i1.ColumnInt $_competenceGoalDocumentsCompetenceGoalId;

  late final _i1.ColumnInt
      $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId;

  late final _i1.ColumnInt $_preSchoolTestPreschooltestdocumentsPreSchoolTestId;

  @override
  List<_i1.Column> get columns => [
        id,
        documentId,
        documentPath,
        createdBy,
        createdAt,
        $_competenceCheckDocumentsCompetenceCheckId,
        $_competenceGoalDocumentsCompetenceGoalId,
        $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId,
        $_preSchoolTestPreschooltestdocumentsPreSchoolTestId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        documentId,
        documentPath,
        createdBy,
        createdAt,
      ];
}

class HubDocumentInclude extends _i1.IncludeObject {
  HubDocumentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => HubDocument.t;
}

class HubDocumentIncludeList extends _i1.IncludeList {
  HubDocumentIncludeList._({
    _i1.WhereExpressionBuilder<HubDocumentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(HubDocument.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => HubDocument.t;
}

class HubDocumentRepository {
  const HubDocumentRepository._();

  /// Returns a list of [HubDocument]s matching the given query parameters.
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
  Future<List<HubDocument>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<HubDocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<HubDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<HubDocumentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<HubDocument>(
      where: where?.call(HubDocument.t),
      orderBy: orderBy?.call(HubDocument.t),
      orderByList: orderByList?.call(HubDocument.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [HubDocument] matching the given query parameters.
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
  Future<HubDocument?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<HubDocumentTable>? where,
    int? offset,
    _i1.OrderByBuilder<HubDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<HubDocumentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<HubDocument>(
      where: where?.call(HubDocument.t),
      orderBy: orderBy?.call(HubDocument.t),
      orderByList: orderByList?.call(HubDocument.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [HubDocument] by its [id] or null if no such row exists.
  Future<HubDocument?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<HubDocument>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [HubDocument]s in the list and returns the inserted rows.
  ///
  /// The returned [HubDocument]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<HubDocument>> insert(
    _i1.Session session,
    List<HubDocument> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<HubDocument>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [HubDocument] and returns the inserted row.
  ///
  /// The returned [HubDocument] will have its `id` field set.
  Future<HubDocument> insertRow(
    _i1.Session session,
    HubDocument row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<HubDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [HubDocument]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<HubDocument>> update(
    _i1.Session session,
    List<HubDocument> rows, {
    _i1.ColumnSelections<HubDocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<HubDocument>(
      rows,
      columns: columns?.call(HubDocument.t),
      transaction: transaction,
    );
  }

  /// Updates a single [HubDocument]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<HubDocument> updateRow(
    _i1.Session session,
    HubDocument row, {
    _i1.ColumnSelections<HubDocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<HubDocument>(
      row,
      columns: columns?.call(HubDocument.t),
      transaction: transaction,
    );
  }

  /// Deletes all [HubDocument]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<HubDocument>> delete(
    _i1.Session session,
    List<HubDocument> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<HubDocument>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [HubDocument].
  Future<HubDocument> deleteRow(
    _i1.Session session,
    HubDocument row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<HubDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<HubDocument>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<HubDocumentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<HubDocument>(
      where: where(HubDocument.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<HubDocumentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<HubDocument>(
      where: where?.call(HubDocument.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
