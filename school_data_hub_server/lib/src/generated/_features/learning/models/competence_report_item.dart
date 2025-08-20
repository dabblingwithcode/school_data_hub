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
import '../../../_features/learning/models/competence_report_check.dart' as _i2;

abstract class CompetenceReportItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CompetenceReportItem._({
    this.id,
    required this.publicId,
    this.parentItem,
    required this.name,
    this.level,
    this.order,
    this.competenceReportchecks,
  });

  factory CompetenceReportItem({
    int? id,
    required int publicId,
    int? parentItem,
    required String name,
    List<String>? level,
    int? order,
    List<_i2.CompetenceReportCheck>? competenceReportchecks,
  }) = _CompetenceReportItemImpl;

  factory CompetenceReportItem.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CompetenceReportItem(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as int,
      parentItem: jsonSerialization['parentItem'] as int?,
      name: jsonSerialization['name'] as String,
      level: (jsonSerialization['level'] as List?)
          ?.map((e) => e as String)
          .toList(),
      order: jsonSerialization['order'] as int?,
      competenceReportchecks: (jsonSerialization['competenceReportchecks']
              as List?)
          ?.map((e) =>
              _i2.CompetenceReportCheck.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = CompetenceReportItemTable();

  static const db = CompetenceReportItemRepository._();

  @override
  int? id;

  int publicId;

  int? parentItem;

  String name;

  List<String>? level;

  int? order;

  List<_i2.CompetenceReportCheck>? competenceReportchecks;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CompetenceReportItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompetenceReportItem copyWith({
    int? id,
    int? publicId,
    int? parentItem,
    String? name,
    List<String>? level,
    int? order,
    List<_i2.CompetenceReportCheck>? competenceReportchecks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      if (parentItem != null) 'parentItem': parentItem,
      'name': name,
      if (level != null) 'level': level?.toJson(),
      if (order != null) 'order': order,
      if (competenceReportchecks != null)
        'competenceReportchecks':
            competenceReportchecks?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      if (parentItem != null) 'parentItem': parentItem,
      'name': name,
      if (level != null) 'level': level?.toJson(),
      if (order != null) 'order': order,
      if (competenceReportchecks != null)
        'competenceReportchecks': competenceReportchecks?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static CompetenceReportItemInclude include(
      {_i2.CompetenceReportCheckIncludeList? competenceReportchecks}) {
    return CompetenceReportItemInclude._(
        competenceReportchecks: competenceReportchecks);
  }

  static CompetenceReportItemIncludeList includeList({
    _i1.WhereExpressionBuilder<CompetenceReportItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceReportItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceReportItemTable>? orderByList,
    CompetenceReportItemInclude? include,
  }) {
    return CompetenceReportItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CompetenceReportItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CompetenceReportItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetenceReportItemImpl extends CompetenceReportItem {
  _CompetenceReportItemImpl({
    int? id,
    required int publicId,
    int? parentItem,
    required String name,
    List<String>? level,
    int? order,
    List<_i2.CompetenceReportCheck>? competenceReportchecks,
  }) : super._(
          id: id,
          publicId: publicId,
          parentItem: parentItem,
          name: name,
          level: level,
          order: order,
          competenceReportchecks: competenceReportchecks,
        );

  /// Returns a shallow copy of this [CompetenceReportItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompetenceReportItem copyWith({
    Object? id = _Undefined,
    int? publicId,
    Object? parentItem = _Undefined,
    String? name,
    Object? level = _Undefined,
    Object? order = _Undefined,
    Object? competenceReportchecks = _Undefined,
  }) {
    return CompetenceReportItem(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      parentItem: parentItem is int? ? parentItem : this.parentItem,
      name: name ?? this.name,
      level:
          level is List<String>? ? level : this.level?.map((e0) => e0).toList(),
      order: order is int? ? order : this.order,
      competenceReportchecks: competenceReportchecks
              is List<_i2.CompetenceReportCheck>?
          ? competenceReportchecks
          : this.competenceReportchecks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class CompetenceReportItemTable extends _i1.Table<int?> {
  CompetenceReportItemTable({super.tableRelation})
      : super(tableName: 'competence_report_item') {
    publicId = _i1.ColumnInt(
      'publicId',
      this,
    );
    parentItem = _i1.ColumnInt(
      'parentItem',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    level = _i1.ColumnSerializable(
      'level',
      this,
    );
    order = _i1.ColumnInt(
      'order',
      this,
    );
  }

  late final _i1.ColumnInt publicId;

  late final _i1.ColumnInt parentItem;

  late final _i1.ColumnString name;

  late final _i1.ColumnSerializable level;

  late final _i1.ColumnInt order;

  _i2.CompetenceReportCheckTable? ___competenceReportchecks;

  _i1.ManyRelation<_i2.CompetenceReportCheckTable>? _competenceReportchecks;

  _i2.CompetenceReportCheckTable get __competenceReportchecks {
    if (___competenceReportchecks != null) return ___competenceReportchecks!;
    ___competenceReportchecks = _i1.createRelationTable(
      relationFieldName: '__competenceReportchecks',
      field: CompetenceReportItem.t.id,
      foreignField: _i2.CompetenceReportCheck.t.competenceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CompetenceReportCheckTable(tableRelation: foreignTableRelation),
    );
    return ___competenceReportchecks!;
  }

  _i1.ManyRelation<_i2.CompetenceReportCheckTable> get competenceReportchecks {
    if (_competenceReportchecks != null) return _competenceReportchecks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'competenceReportchecks',
      field: CompetenceReportItem.t.id,
      foreignField: _i2.CompetenceReportCheck.t.competenceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CompetenceReportCheckTable(tableRelation: foreignTableRelation),
    );
    _competenceReportchecks = _i1.ManyRelation<_i2.CompetenceReportCheckTable>(
      tableWithRelations: relationTable,
      table: _i2.CompetenceReportCheckTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _competenceReportchecks!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        publicId,
        parentItem,
        name,
        level,
        order,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'competenceReportchecks') {
      return __competenceReportchecks;
    }
    return null;
  }
}

class CompetenceReportItemInclude extends _i1.IncludeObject {
  CompetenceReportItemInclude._(
      {_i2.CompetenceReportCheckIncludeList? competenceReportchecks}) {
    _competenceReportchecks = competenceReportchecks;
  }

  _i2.CompetenceReportCheckIncludeList? _competenceReportchecks;

  @override
  Map<String, _i1.Include?> get includes =>
      {'competenceReportchecks': _competenceReportchecks};

  @override
  _i1.Table<int?> get table => CompetenceReportItem.t;
}

class CompetenceReportItemIncludeList extends _i1.IncludeList {
  CompetenceReportItemIncludeList._({
    _i1.WhereExpressionBuilder<CompetenceReportItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CompetenceReportItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CompetenceReportItem.t;
}

class CompetenceReportItemRepository {
  const CompetenceReportItemRepository._();

  final attach = const CompetenceReportItemAttachRepository._();

  final attachRow = const CompetenceReportItemAttachRowRepository._();

  /// Returns a list of [CompetenceReportItem]s matching the given query parameters.
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
  Future<List<CompetenceReportItem>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceReportItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetenceReportItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceReportItemTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceReportItemInclude? include,
  }) async {
    return session.db.find<CompetenceReportItem>(
      where: where?.call(CompetenceReportItem.t),
      orderBy: orderBy?.call(CompetenceReportItem.t),
      orderByList: orderByList?.call(CompetenceReportItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CompetenceReportItem] matching the given query parameters.
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
  Future<CompetenceReportItem?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceReportItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<CompetenceReportItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetenceReportItemTable>? orderByList,
    _i1.Transaction? transaction,
    CompetenceReportItemInclude? include,
  }) async {
    return session.db.findFirstRow<CompetenceReportItem>(
      where: where?.call(CompetenceReportItem.t),
      orderBy: orderBy?.call(CompetenceReportItem.t),
      orderByList: orderByList?.call(CompetenceReportItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CompetenceReportItem] by its [id] or null if no such row exists.
  Future<CompetenceReportItem?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CompetenceReportItemInclude? include,
  }) async {
    return session.db.findById<CompetenceReportItem>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CompetenceReportItem]s in the list and returns the inserted rows.
  ///
  /// The returned [CompetenceReportItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CompetenceReportItem>> insert(
    _i1.Session session,
    List<CompetenceReportItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CompetenceReportItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CompetenceReportItem] and returns the inserted row.
  ///
  /// The returned [CompetenceReportItem] will have its `id` field set.
  Future<CompetenceReportItem> insertRow(
    _i1.Session session,
    CompetenceReportItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CompetenceReportItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CompetenceReportItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CompetenceReportItem>> update(
    _i1.Session session,
    List<CompetenceReportItem> rows, {
    _i1.ColumnSelections<CompetenceReportItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CompetenceReportItem>(
      rows,
      columns: columns?.call(CompetenceReportItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CompetenceReportItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CompetenceReportItem> updateRow(
    _i1.Session session,
    CompetenceReportItem row, {
    _i1.ColumnSelections<CompetenceReportItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CompetenceReportItem>(
      row,
      columns: columns?.call(CompetenceReportItem.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CompetenceReportItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CompetenceReportItem>> delete(
    _i1.Session session,
    List<CompetenceReportItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CompetenceReportItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CompetenceReportItem].
  Future<CompetenceReportItem> deleteRow(
    _i1.Session session,
    CompetenceReportItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CompetenceReportItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CompetenceReportItem>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CompetenceReportItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CompetenceReportItem>(
      where: where(CompetenceReportItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CompetenceReportItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CompetenceReportItem>(
      where: where?.call(CompetenceReportItem.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CompetenceReportItemAttachRepository {
  const CompetenceReportItemAttachRepository._();

  /// Creates a relation between this [CompetenceReportItem] and the given [CompetenceReportCheck]s
  /// by setting each [CompetenceReportCheck]'s foreign key `competenceId` to refer to this [CompetenceReportItem].
  Future<void> competenceReportchecks(
    _i1.Session session,
    CompetenceReportItem competenceReportItem,
    List<_i2.CompetenceReportCheck> competenceReportCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReportCheck.any((e) => e.id == null)) {
      throw ArgumentError.notNull('competenceReportCheck.id');
    }
    if (competenceReportItem.id == null) {
      throw ArgumentError.notNull('competenceReportItem.id');
    }

    var $competenceReportCheck = competenceReportCheck
        .map((e) => e.copyWith(competenceId: competenceReportItem.id))
        .toList();
    await session.db.update<_i2.CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [_i2.CompetenceReportCheck.t.competenceId],
      transaction: transaction,
    );
  }
}

class CompetenceReportItemAttachRowRepository {
  const CompetenceReportItemAttachRowRepository._();

  /// Creates a relation between this [CompetenceReportItem] and the given [CompetenceReportCheck]
  /// by setting the [CompetenceReportCheck]'s foreign key `competenceId` to refer to this [CompetenceReportItem].
  Future<void> competenceReportchecks(
    _i1.Session session,
    CompetenceReportItem competenceReportItem,
    _i2.CompetenceReportCheck competenceReportCheck, {
    _i1.Transaction? transaction,
  }) async {
    if (competenceReportCheck.id == null) {
      throw ArgumentError.notNull('competenceReportCheck.id');
    }
    if (competenceReportItem.id == null) {
      throw ArgumentError.notNull('competenceReportItem.id');
    }

    var $competenceReportCheck =
        competenceReportCheck.copyWith(competenceId: competenceReportItem.id);
    await session.db.updateRow<_i2.CompetenceReportCheck>(
      $competenceReportCheck,
      columns: [_i2.CompetenceReportCheck.t.competenceId],
      transaction: transaction,
    );
  }
}
