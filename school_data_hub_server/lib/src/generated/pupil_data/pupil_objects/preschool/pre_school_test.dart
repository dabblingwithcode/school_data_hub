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
import '../../../shared/document.dart' as _i2;

abstract class PreSchoolTest
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PreSchoolTest._({
    this.id,
    this.careNeedsIntensity,
    this.preSchoolTestDocuments,
  });

  factory PreSchoolTest({
    int? id,
    int? careNeedsIntensity,
    List<_i2.HubDocument>? preSchoolTestDocuments,
  }) = _PreSchoolTestImpl;

  factory PreSchoolTest.fromJson(Map<String, dynamic> jsonSerialization) {
    return PreSchoolTest(
      id: jsonSerialization['id'] as int?,
      careNeedsIntensity: jsonSerialization['careNeedsIntensity'] as int?,
      preSchoolTestDocuments: (jsonSerialization['preSchoolTestDocuments']
              as List?)
          ?.map((e) => _i2.HubDocument.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = PreSchoolTestTable();

  static const db = PreSchoolTestRepository._();

  @override
  int? id;

  int? careNeedsIntensity;

  List<_i2.HubDocument>? preSchoolTestDocuments;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PreSchoolTest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PreSchoolTest copyWith({
    int? id,
    int? careNeedsIntensity,
    List<_i2.HubDocument>? preSchoolTestDocuments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (careNeedsIntensity != null) 'careNeedsIntensity': careNeedsIntensity,
      if (preSchoolTestDocuments != null)
        'preSchoolTestDocuments':
            preSchoolTestDocuments?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (careNeedsIntensity != null) 'careNeedsIntensity': careNeedsIntensity,
      if (preSchoolTestDocuments != null)
        'preSchoolTestDocuments': preSchoolTestDocuments?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static PreSchoolTestInclude include(
      {_i2.HubDocumentIncludeList? preSchoolTestDocuments}) {
    return PreSchoolTestInclude._(
        preSchoolTestDocuments: preSchoolTestDocuments);
  }

  static PreSchoolTestIncludeList includeList({
    _i1.WhereExpressionBuilder<PreSchoolTestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PreSchoolTestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PreSchoolTestTable>? orderByList,
    PreSchoolTestInclude? include,
  }) {
    return PreSchoolTestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PreSchoolTest.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PreSchoolTest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PreSchoolTestImpl extends PreSchoolTest {
  _PreSchoolTestImpl({
    int? id,
    int? careNeedsIntensity,
    List<_i2.HubDocument>? preSchoolTestDocuments,
  }) : super._(
          id: id,
          careNeedsIntensity: careNeedsIntensity,
          preSchoolTestDocuments: preSchoolTestDocuments,
        );

  /// Returns a shallow copy of this [PreSchoolTest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PreSchoolTest copyWith({
    Object? id = _Undefined,
    Object? careNeedsIntensity = _Undefined,
    Object? preSchoolTestDocuments = _Undefined,
  }) {
    return PreSchoolTest(
      id: id is int? ? id : this.id,
      careNeedsIntensity: careNeedsIntensity is int?
          ? careNeedsIntensity
          : this.careNeedsIntensity,
      preSchoolTestDocuments: preSchoolTestDocuments is List<_i2.HubDocument>?
          ? preSchoolTestDocuments
          : this.preSchoolTestDocuments?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class PreSchoolTestTable extends _i1.Table<int?> {
  PreSchoolTestTable({super.tableRelation})
      : super(tableName: 'pre_school_test') {
    careNeedsIntensity = _i1.ColumnInt(
      'careNeedsIntensity',
      this,
    );
  }

  late final _i1.ColumnInt careNeedsIntensity;

  _i2.HubDocumentTable? ___preSchoolTestDocuments;

  _i1.ManyRelation<_i2.HubDocumentTable>? _preSchoolTestDocuments;

  _i2.HubDocumentTable get __preSchoolTestDocuments {
    if (___preSchoolTestDocuments != null) return ___preSchoolTestDocuments!;
    ___preSchoolTestDocuments = _i1.createRelationTable(
      relationFieldName: '__preSchoolTestDocuments',
      field: PreSchoolTest.t.id,
      foreignField: _i2
          .HubDocument.t.$_preSchoolTestPreschooltestdocumentsPreSchoolTestId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    return ___preSchoolTestDocuments!;
  }

  _i1.ManyRelation<_i2.HubDocumentTable> get preSchoolTestDocuments {
    if (_preSchoolTestDocuments != null) return _preSchoolTestDocuments!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'preSchoolTestDocuments',
      field: PreSchoolTest.t.id,
      foreignField: _i2
          .HubDocument.t.$_preSchoolTestPreschooltestdocumentsPreSchoolTestId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.HubDocumentTable(tableRelation: foreignTableRelation),
    );
    _preSchoolTestDocuments = _i1.ManyRelation<_i2.HubDocumentTable>(
      tableWithRelations: relationTable,
      table: _i2.HubDocumentTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _preSchoolTestDocuments!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        careNeedsIntensity,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'preSchoolTestDocuments') {
      return __preSchoolTestDocuments;
    }
    return null;
  }
}

class PreSchoolTestInclude extends _i1.IncludeObject {
  PreSchoolTestInclude._({_i2.HubDocumentIncludeList? preSchoolTestDocuments}) {
    _preSchoolTestDocuments = preSchoolTestDocuments;
  }

  _i2.HubDocumentIncludeList? _preSchoolTestDocuments;

  @override
  Map<String, _i1.Include?> get includes =>
      {'preSchoolTestDocuments': _preSchoolTestDocuments};

  @override
  _i1.Table<int?> get table => PreSchoolTest.t;
}

class PreSchoolTestIncludeList extends _i1.IncludeList {
  PreSchoolTestIncludeList._({
    _i1.WhereExpressionBuilder<PreSchoolTestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PreSchoolTest.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PreSchoolTest.t;
}

class PreSchoolTestRepository {
  const PreSchoolTestRepository._();

  final attach = const PreSchoolTestAttachRepository._();

  final attachRow = const PreSchoolTestAttachRowRepository._();

  final detach = const PreSchoolTestDetachRepository._();

  final detachRow = const PreSchoolTestDetachRowRepository._();

  /// Returns a list of [PreSchoolTest]s matching the given query parameters.
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
  Future<List<PreSchoolTest>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PreSchoolTestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PreSchoolTestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PreSchoolTestTable>? orderByList,
    _i1.Transaction? transaction,
    PreSchoolTestInclude? include,
  }) async {
    return session.db.find<PreSchoolTest>(
      where: where?.call(PreSchoolTest.t),
      orderBy: orderBy?.call(PreSchoolTest.t),
      orderByList: orderByList?.call(PreSchoolTest.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PreSchoolTest] matching the given query parameters.
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
  Future<PreSchoolTest?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PreSchoolTestTable>? where,
    int? offset,
    _i1.OrderByBuilder<PreSchoolTestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PreSchoolTestTable>? orderByList,
    _i1.Transaction? transaction,
    PreSchoolTestInclude? include,
  }) async {
    return session.db.findFirstRow<PreSchoolTest>(
      where: where?.call(PreSchoolTest.t),
      orderBy: orderBy?.call(PreSchoolTest.t),
      orderByList: orderByList?.call(PreSchoolTest.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PreSchoolTest] by its [id] or null if no such row exists.
  Future<PreSchoolTest?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PreSchoolTestInclude? include,
  }) async {
    return session.db.findById<PreSchoolTest>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PreSchoolTest]s in the list and returns the inserted rows.
  ///
  /// The returned [PreSchoolTest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PreSchoolTest>> insert(
    _i1.Session session,
    List<PreSchoolTest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PreSchoolTest>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PreSchoolTest] and returns the inserted row.
  ///
  /// The returned [PreSchoolTest] will have its `id` field set.
  Future<PreSchoolTest> insertRow(
    _i1.Session session,
    PreSchoolTest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PreSchoolTest>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PreSchoolTest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PreSchoolTest>> update(
    _i1.Session session,
    List<PreSchoolTest> rows, {
    _i1.ColumnSelections<PreSchoolTestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PreSchoolTest>(
      rows,
      columns: columns?.call(PreSchoolTest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PreSchoolTest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PreSchoolTest> updateRow(
    _i1.Session session,
    PreSchoolTest row, {
    _i1.ColumnSelections<PreSchoolTestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PreSchoolTest>(
      row,
      columns: columns?.call(PreSchoolTest.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PreSchoolTest]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PreSchoolTest>> delete(
    _i1.Session session,
    List<PreSchoolTest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PreSchoolTest>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PreSchoolTest].
  Future<PreSchoolTest> deleteRow(
    _i1.Session session,
    PreSchoolTest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PreSchoolTest>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PreSchoolTest>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PreSchoolTestTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PreSchoolTest>(
      where: where(PreSchoolTest.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PreSchoolTestTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PreSchoolTest>(
      where: where?.call(PreSchoolTest.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PreSchoolTestAttachRepository {
  const PreSchoolTestAttachRepository._();

  /// Creates a relation between this [PreSchoolTest] and the given [HubDocument]s
  /// by setting each [HubDocument]'s foreign key `_preSchoolTestPreschooltestdocumentsPreSchoolTestId` to refer to this [PreSchoolTest].
  Future<void> preSchoolTestDocuments(
    _i1.Session session,
    PreSchoolTest preSchoolTest,
    List<_i2.HubDocument> hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.any((e) => e.id == null)) {
      throw ArgumentError.notNull('hubDocument.id');
    }
    if (preSchoolTest.id == null) {
      throw ArgumentError.notNull('preSchoolTest.id');
    }

    var $hubDocument = hubDocument
        .map((e) => _i2.HubDocumentImplicit(
              e,
              $_preSchoolTestPreschooltestdocumentsPreSchoolTestId:
                  preSchoolTest.id,
            ))
        .toList();
    await session.db.update<_i2.HubDocument>(
      $hubDocument,
      columns: [
        _i2.HubDocument.t.$_preSchoolTestPreschooltestdocumentsPreSchoolTestId
      ],
      transaction: transaction,
    );
  }
}

class PreSchoolTestAttachRowRepository {
  const PreSchoolTestAttachRowRepository._();

  /// Creates a relation between this [PreSchoolTest] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_preSchoolTestPreschooltestdocumentsPreSchoolTestId` to refer to this [PreSchoolTest].
  Future<void> preSchoolTestDocuments(
    _i1.Session session,
    PreSchoolTest preSchoolTest,
    _i2.HubDocument hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.id == null) {
      throw ArgumentError.notNull('hubDocument.id');
    }
    if (preSchoolTest.id == null) {
      throw ArgumentError.notNull('preSchoolTest.id');
    }

    var $hubDocument = _i2.HubDocumentImplicit(
      hubDocument,
      $_preSchoolTestPreschooltestdocumentsPreSchoolTestId: preSchoolTest.id,
    );
    await session.db.updateRow<_i2.HubDocument>(
      $hubDocument,
      columns: [
        _i2.HubDocument.t.$_preSchoolTestPreschooltestdocumentsPreSchoolTestId
      ],
      transaction: transaction,
    );
  }
}

class PreSchoolTestDetachRepository {
  const PreSchoolTestDetachRepository._();

  /// Detaches the relation between this [PreSchoolTest] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_preSchoolTestPreschooltestdocumentsPreSchoolTestId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> preSchoolTestDocuments(
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
              $_preSchoolTestPreschooltestdocumentsPreSchoolTestId: null,
            ))
        .toList();
    await session.db.update<_i2.HubDocument>(
      $hubDocument,
      columns: [
        _i2.HubDocument.t.$_preSchoolTestPreschooltestdocumentsPreSchoolTestId
      ],
      transaction: transaction,
    );
  }
}

class PreSchoolTestDetachRowRepository {
  const PreSchoolTestDetachRowRepository._();

  /// Detaches the relation between this [PreSchoolTest] and the given [HubDocument]
  /// by setting the [HubDocument]'s foreign key `_preSchoolTestPreschooltestdocumentsPreSchoolTestId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> preSchoolTestDocuments(
    _i1.Session session,
    _i2.HubDocument hubDocument, {
    _i1.Transaction? transaction,
  }) async {
    if (hubDocument.id == null) {
      throw ArgumentError.notNull('hubDocument.id');
    }

    var $hubDocument = _i2.HubDocumentImplicit(
      hubDocument,
      $_preSchoolTestPreschooltestdocumentsPreSchoolTestId: null,
    );
    await session.db.updateRow<_i2.HubDocument>(
      $hubDocument,
      columns: [
        _i2.HubDocument.t.$_preSchoolTestPreschooltestdocumentsPreSchoolTestId
      ],
      transaction: transaction,
    );
  }
}
