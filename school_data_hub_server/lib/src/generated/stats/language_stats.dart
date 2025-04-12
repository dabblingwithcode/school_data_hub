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
import '../pupil_data/pupil_objects/communication/language.dart' as _i2;

abstract class LanguageStats
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  LanguageStats._({
    this.id,
    this.languages,
  });

  factory LanguageStats({
    int? id,
    Set<_i2.Language>? languages,
  }) = _LanguageStatsImpl;

  factory LanguageStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return LanguageStats(
      id: jsonSerialization['id'] as int?,
      languages: jsonSerialization['languages'] == null
          ? null
          : _i1.SetJsonExtension.fromJson(
              (jsonSerialization['languages'] as List),
              itemFromJson: (e) =>
                  _i2.Language.fromJson((e as Map<String, dynamic>))),
    );
  }

  static final t = LanguageStatsTable();

  static const db = LanguageStatsRepository._();

  @override
  int? id;

  Set<_i2.Language>? languages;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [LanguageStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LanguageStats copyWith({
    int? id,
    Set<_i2.Language>? languages,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (languages != null)
        'languages': languages?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (languages != null)
        'languages':
            languages?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static LanguageStatsInclude include() {
    return LanguageStatsInclude._();
  }

  static LanguageStatsIncludeList includeList({
    _i1.WhereExpressionBuilder<LanguageStatsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LanguageStatsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LanguageStatsTable>? orderByList,
    LanguageStatsInclude? include,
  }) {
    return LanguageStatsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LanguageStats.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LanguageStats.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LanguageStatsImpl extends LanguageStats {
  _LanguageStatsImpl({
    int? id,
    Set<_i2.Language>? languages,
  }) : super._(
          id: id,
          languages: languages,
        );

  /// Returns a shallow copy of this [LanguageStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LanguageStats copyWith({
    Object? id = _Undefined,
    Object? languages = _Undefined,
  }) {
    return LanguageStats(
      id: id is int? ? id : this.id,
      languages: languages is Set<_i2.Language>?
          ? languages
          : this.languages?.map((e0) => e0.copyWith()).toSet(),
    );
  }
}

class LanguageStatsTable extends _i1.Table<int> {
  LanguageStatsTable({super.tableRelation})
      : super(tableName: 'language_stats') {
    languages = _i1.ColumnSerializable(
      'languages',
      this,
    );
  }

  late final _i1.ColumnSerializable languages;

  @override
  List<_i1.Column> get columns => [
        id,
        languages,
      ];
}

class LanguageStatsInclude extends _i1.IncludeObject {
  LanguageStatsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => LanguageStats.t;
}

class LanguageStatsIncludeList extends _i1.IncludeList {
  LanguageStatsIncludeList._({
    _i1.WhereExpressionBuilder<LanguageStatsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LanguageStats.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => LanguageStats.t;
}

class LanguageStatsRepository {
  const LanguageStatsRepository._();

  /// Returns a list of [LanguageStats]s matching the given query parameters.
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
  Future<List<LanguageStats>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LanguageStatsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LanguageStatsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LanguageStatsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<LanguageStats>(
      where: where?.call(LanguageStats.t),
      orderBy: orderBy?.call(LanguageStats.t),
      orderByList: orderByList?.call(LanguageStats.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [LanguageStats] matching the given query parameters.
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
  Future<LanguageStats?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LanguageStatsTable>? where,
    int? offset,
    _i1.OrderByBuilder<LanguageStatsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LanguageStatsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<LanguageStats>(
      where: where?.call(LanguageStats.t),
      orderBy: orderBy?.call(LanguageStats.t),
      orderByList: orderByList?.call(LanguageStats.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [LanguageStats] by its [id] or null if no such row exists.
  Future<LanguageStats?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<LanguageStats>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [LanguageStats]s in the list and returns the inserted rows.
  ///
  /// The returned [LanguageStats]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LanguageStats>> insert(
    _i1.Session session,
    List<LanguageStats> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LanguageStats>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LanguageStats] and returns the inserted row.
  ///
  /// The returned [LanguageStats] will have its `id` field set.
  Future<LanguageStats> insertRow(
    _i1.Session session,
    LanguageStats row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LanguageStats>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LanguageStats]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LanguageStats>> update(
    _i1.Session session,
    List<LanguageStats> rows, {
    _i1.ColumnSelections<LanguageStatsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LanguageStats>(
      rows,
      columns: columns?.call(LanguageStats.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LanguageStats]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LanguageStats> updateRow(
    _i1.Session session,
    LanguageStats row, {
    _i1.ColumnSelections<LanguageStatsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LanguageStats>(
      row,
      columns: columns?.call(LanguageStats.t),
      transaction: transaction,
    );
  }

  /// Deletes all [LanguageStats]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LanguageStats>> delete(
    _i1.Session session,
    List<LanguageStats> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LanguageStats>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LanguageStats].
  Future<LanguageStats> deleteRow(
    _i1.Session session,
    LanguageStats row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LanguageStats>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LanguageStats>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LanguageStatsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LanguageStats>(
      where: where(LanguageStats.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LanguageStatsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LanguageStats>(
      where: where?.call(LanguageStats.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
