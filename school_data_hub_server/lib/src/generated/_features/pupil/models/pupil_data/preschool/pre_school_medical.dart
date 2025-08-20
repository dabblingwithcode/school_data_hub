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
import '../../../../../_features/pupil/models/pupil_data/preschool/pre_school_medical_status.dart'
    as _i2;
import '../../../../../_shared/models/hub_document.dart' as _i3;

abstract class PreSchoolMedical
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PreSchoolMedical._({
    this.id,
    this.preschoolMedicalStatus,
    this.preschoolMedicalFiles,
    required this.createdBy,
    required this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory PreSchoolMedical({
    int? id,
    _i2.PreSchoolMedicalStatus? preschoolMedicalStatus,
    List<_i3.HubDocument>? preschoolMedicalFiles,
    required String createdBy,
    required DateTime createdAt,
    String? updatedBy,
    DateTime? updatedAt,
  }) = _PreSchoolMedicalImpl;

  factory PreSchoolMedical.fromJson(Map<String, dynamic> jsonSerialization) {
    return PreSchoolMedical(
      id: jsonSerialization['id'] as int?,
      preschoolMedicalStatus:
          jsonSerialization['preschoolMedicalStatus'] == null
              ? null
              : _i2.PreSchoolMedicalStatus.fromJson(
                  (jsonSerialization['preschoolMedicalStatus'] as String)),
      preschoolMedicalFiles: (jsonSerialization['preschoolMedicalFiles']
              as List?)
          ?.map((e) => _i3.HubDocument.fromJson((e as Map<String, dynamic>)))
          .toList(),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedBy: jsonSerialization['updatedBy'] as String?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = PreSchoolMedicalTable();

  static const db = PreSchoolMedicalRepository._();

  @override
  int? id;

  _i2.PreSchoolMedicalStatus? preschoolMedicalStatus;

  List<_i3.HubDocument>? preschoolMedicalFiles;

  String createdBy;

  DateTime createdAt;

  String? updatedBy;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PreSchoolMedical]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PreSchoolMedical copyWith({
    int? id,
    _i2.PreSchoolMedicalStatus? preschoolMedicalStatus,
    List<_i3.HubDocument>? preschoolMedicalFiles,
    String? createdBy,
    DateTime? createdAt,
    String? updatedBy,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (preschoolMedicalStatus != null)
        'preschoolMedicalStatus': preschoolMedicalStatus?.toJson(),
      if (preschoolMedicalFiles != null)
        'preschoolMedicalFiles':
            preschoolMedicalFiles?.toJson(valueToJson: (v) => v.toJson()),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (updatedBy != null) 'updatedBy': updatedBy,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (preschoolMedicalStatus != null)
        'preschoolMedicalStatus': preschoolMedicalStatus?.toJson(),
      if (preschoolMedicalFiles != null)
        'preschoolMedicalFiles': preschoolMedicalFiles?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (updatedBy != null) 'updatedBy': updatedBy,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static PreSchoolMedicalInclude include(
      {_i3.HubDocumentIncludeList? preschoolMedicalFiles}) {
    return PreSchoolMedicalInclude._(
        preschoolMedicalFiles: preschoolMedicalFiles);
  }

  static PreSchoolMedicalIncludeList includeList({
    _i1.WhereExpressionBuilder<PreSchoolMedicalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PreSchoolMedicalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PreSchoolMedicalTable>? orderByList,
    PreSchoolMedicalInclude? include,
  }) {
    return PreSchoolMedicalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PreSchoolMedical.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PreSchoolMedical.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PreSchoolMedicalImpl extends PreSchoolMedical {
  _PreSchoolMedicalImpl({
    int? id,
    _i2.PreSchoolMedicalStatus? preschoolMedicalStatus,
    List<_i3.HubDocument>? preschoolMedicalFiles,
    required String createdBy,
    required DateTime createdAt,
    String? updatedBy,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          preschoolMedicalStatus: preschoolMedicalStatus,
          preschoolMedicalFiles: preschoolMedicalFiles,
          createdBy: createdBy,
          createdAt: createdAt,
          updatedBy: updatedBy,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [PreSchoolMedical]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PreSchoolMedical copyWith({
    Object? id = _Undefined,
    Object? preschoolMedicalStatus = _Undefined,
    Object? preschoolMedicalFiles = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    Object? updatedBy = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return PreSchoolMedical(
      id: id is int? ? id : this.id,
      preschoolMedicalStatus:
          preschoolMedicalStatus is _i2.PreSchoolMedicalStatus?
              ? preschoolMedicalStatus
              : this.preschoolMedicalStatus,
      preschoolMedicalFiles: preschoolMedicalFiles is List<_i3.HubDocument>?
          ? preschoolMedicalFiles
          : this.preschoolMedicalFiles?.map((e0) => e0.copyWith()).toList(),
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedBy: updatedBy is String? ? updatedBy : this.updatedBy,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class PreSchoolMedicalTable extends _i1.Table<int?> {
  PreSchoolMedicalTable({super.tableRelation})
      : super(tableName: 'pre_school_medical') {
    preschoolMedicalStatus = _i1.ColumnEnum(
      'preschoolMedicalStatus',
      this,
      _i1.EnumSerialization.byName,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedBy = _i1.ColumnString(
      'updatedBy',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final _i1.ColumnEnum<_i2.PreSchoolMedicalStatus> preschoolMedicalStatus;

  _i3.HubDocumentTable? ___preschoolMedicalFiles;

  _i1.ManyRelation<_i3.HubDocumentTable>? _preschoolMedicalFiles;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString updatedBy;

  late final _i1.ColumnDateTime updatedAt;

  _i3.HubDocumentTable get __preschoolMedicalFiles {
    if (___preschoolMedicalFiles != null) return ___preschoolMedicalFiles!;
    ___preschoolMedicalFiles = _i1.createRelationTable(
      relationFieldName: '__preschoolMedicalFiles',
      field: PreSchoolMedical.t.id,
      foreignField: _i3.HubDocument.t
          .$_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    return ___preschoolMedicalFiles!;
  }

  _i1.ManyRelation<_i3.HubDocumentTable> get preschoolMedicalFiles {
    if (_preschoolMedicalFiles != null) return _preschoolMedicalFiles!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'preschoolMedicalFiles',
      field: PreSchoolMedical.t.id,
      foreignField: _i3.HubDocument.t
          .$_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    _preschoolMedicalFiles = _i1.ManyRelation<_i3.HubDocumentTable>(
      tableWithRelations: relationTable,
      table: _i3.HubDocumentTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _preschoolMedicalFiles!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        preschoolMedicalStatus,
        createdBy,
        createdAt,
        updatedBy,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'preschoolMedicalFiles') {
      return __preschoolMedicalFiles;
    }
    return null;
  }
}

class PreSchoolMedicalInclude extends _i1.IncludeObject {
  PreSchoolMedicalInclude._(
      {_i3.HubDocumentIncludeList? preschoolMedicalFiles}) {
    _preschoolMedicalFiles = preschoolMedicalFiles;
  }

  _i3.HubDocumentIncludeList? _preschoolMedicalFiles;

  @override
  Map<String, _i1.Include?> get includes =>
      {'preschoolMedicalFiles': _preschoolMedicalFiles};

  @override
  _i1.Table<int?> get table => PreSchoolMedical.t;
}

class PreSchoolMedicalIncludeList extends _i1.IncludeList {
  PreSchoolMedicalIncludeList._({
    _i1.WhereExpressionBuilder<PreSchoolMedicalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PreSchoolMedical.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PreSchoolMedical.t;
}

class PreSchoolMedicalRepository {
  const PreSchoolMedicalRepository._();

  final attach = const PreSchoolMedicalAttachRepository._();

  final attachRow = const PreSchoolMedicalAttachRowRepository._();

  final detach = const PreSchoolMedicalDetachRepository._();

  final detachRow = const PreSchoolMedicalDetachRowRepository._();

  /// Returns a list of [PreSchoolMedical]s matching the given query parameters.
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
  Future<List<PreSchoolMedical>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PreSchoolMedicalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PreSchoolMedicalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PreSchoolMedicalTable>? orderByList,
    _i1.Transaction? transaction,
    PreSchoolMedicalInclude? include,
  }) async {
    return session.db.find<PreSchoolMedical>(
      where: where?.call(PreSchoolMedical.t),
      orderBy: orderBy?.call(PreSchoolMedical.t),
      orderByList: orderByList?.call(PreSchoolMedical.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PreSchoolMedical] matching the given query parameters.
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
  Future<PreSchoolMedical?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PreSchoolMedicalTable>? where,
    int? offset,
    _i1.OrderByBuilder<PreSchoolMedicalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PreSchoolMedicalTable>? orderByList,
    _i1.Transaction? transaction,
    PreSchoolMedicalInclude? include,
  }) async {
    return session.db.findFirstRow<PreSchoolMedical>(
      where: where?.call(PreSchoolMedical.t),
      orderBy: orderBy?.call(PreSchoolMedical.t),
      orderByList: orderByList?.call(PreSchoolMedical.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PreSchoolMedical] by its [id] or null if no such row exists.
  Future<PreSchoolMedical?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PreSchoolMedicalInclude? include,
  }) async {
    return session.db.findById<PreSchoolMedical>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PreSchoolMedical]s in the list and returns the inserted rows.
  ///
  /// The returned [PreSchoolMedical]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PreSchoolMedical>> insert(
    _i1.Session session,
    List<PreSchoolMedical> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PreSchoolMedical>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PreSchoolMedical] and returns the inserted row.
  ///
  /// The returned [PreSchoolMedical] will have its `id` field set.
  Future<PreSchoolMedical> insertRow(
    _i1.Session session,
    PreSchoolMedical row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PreSchoolMedical>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PreSchoolMedical]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PreSchoolMedical>> update(
    _i1.Session session,
    List<PreSchoolMedical> rows, {
    _i1.ColumnSelections<PreSchoolMedicalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PreSchoolMedical>(
      rows,
      columns: columns?.call(PreSchoolMedical.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PreSchoolMedical]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PreSchoolMedical> updateRow(
    _i1.Session session,
    PreSchoolMedical row, {
    _i1.ColumnSelections<PreSchoolMedicalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PreSchoolMedical>(
      row,
      columns: columns?.call(PreSchoolMedical.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PreSchoolMedical]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PreSchoolMedical>> delete(
    _i1.Session session,
    List<PreSchoolMedical> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PreSchoolMedical>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PreSchoolMedical].
  Future<PreSchoolMedical> deleteRow(
    _i1.Session session,
    PreSchoolMedical row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PreSchoolMedical>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PreSchoolMedical>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PreSchoolMedicalTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PreSchoolMedical>(
      where: where(PreSchoolMedical.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PreSchoolMedicalTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PreSchoolMedical>(
      where: where?.call(PreSchoolMedical.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PreSchoolMedicalAttachRepository {
  const PreSchoolMedicalAttachRepository._();

  /// Creates a relation between this [PreSchoolMedical] and the given [HubDocument]s
  /// by setting each [HubDocument]'s foreign key `_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId` to refer to this [PreSchoolMedical].
  Future<void> preschoolMedicalFiles(
    _i1.Session session,
    PreSchoolMedical preSchoolMedical,
    List<_i3.HubDocument> hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.any((e) => e.id == null)) {
      throw ArgumentError.notNull('hubDocument.id');
    }
    if (preSchoolMedical.id == null) {
      throw ArgumentError.notNull('preSchoolMedical.id');
    }

    var $hubDocument = hubDocument
        .map((e) => _i3.HubDocumentImplicit(
              e,
              $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId:
                  preSchoolMedical.id,
            ))
        .toList();
    await session.db.update<_i3.HubDocument>(
      $hubDocument,
      columns: [
        _i3.HubDocument.t
            .$_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId
      ],
      transaction: transaction,
    );
  }
}

class PreSchoolMedicalAttachRowRepository {
  const PreSchoolMedicalAttachRowRepository._();

  /// Creates a relation between this [PreSchoolMedical] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId` to refer to this [PreSchoolMedical].
  Future<void> preschoolMedicalFiles(
    _i1.Session session,
    PreSchoolMedical preSchoolMedical,
    _i3.HubDocument hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.id == null) {
      throw ArgumentError.notNull('hubDocument.id');
    }
    if (preSchoolMedical.id == null) {
      throw ArgumentError.notNull('preSchoolMedical.id');
    }

    var $hubDocument = _i3.HubDocumentImplicit(
      hubDocument,
      $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId:
          preSchoolMedical.id,
    );
    await session.db.updateRow<_i3.HubDocument>(
      $hubDocument,
      columns: [
        _i3.HubDocument.t
            .$_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId
      ],
      transaction: transaction,
    );
  }
}

class PreSchoolMedicalDetachRepository {
  const PreSchoolMedicalDetachRepository._();

  /// Detaches the relation between this [PreSchoolMedical] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> preschoolMedicalFiles(
    _i1.Session session,
    List<_i3.HubDocument> hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.any((e) => e.id == null)) {
      throw ArgumentError.notNull('hubDocument.id');
    }

    var $hubDocument = hubDocument
        .map((e) => _i3.HubDocumentImplicit(
              e,
              $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId: null,
            ))
        .toList();
    await session.db.update<_i3.HubDocument>(
      $hubDocument,
      columns: [
        _i3.HubDocument.t
            .$_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId
      ],
      transaction: transaction,
    );
  }
}

class PreSchoolMedicalDetachRowRepository {
  const PreSchoolMedicalDetachRowRepository._();

  /// Detaches the relation between this [PreSchoolMedical] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> preschoolMedicalFiles(
    _i1.Session session,
    _i3.HubDocument hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.id == null) {
      throw ArgumentError.notNull('hubDocument.id');
    }

    var $hubDocument = _i3.HubDocumentImplicit(
      hubDocument,
      $_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId: null,
    );
    await session.db.updateRow<_i3.HubDocument>(
      $hubDocument,
      columns: [
        _i3.HubDocument.t
            .$_preSchoolMedicalPreschoolmedicalfilesPreSchoolMedicalId
      ],
      transaction: transaction,
    );
  }
}
