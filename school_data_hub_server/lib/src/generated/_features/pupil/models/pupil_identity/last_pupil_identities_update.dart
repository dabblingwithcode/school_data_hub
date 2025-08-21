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

abstract class LastPupilIdentiesUpdate
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LastPupilIdentiesUpdate._({
    this.id,
    this.date,
  });

  factory LastPupilIdentiesUpdate({
    int? id,
    DateTime? date,
  }) = _LastPupilIdentiesUpdateImpl;

  factory LastPupilIdentiesUpdate.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return LastPupilIdentiesUpdate(
      id: jsonSerialization['id'] as int?,
      date: jsonSerialization['date'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
    );
  }

  static final t = LastPupilIdentiesUpdateTable();

  static const db = LastPupilIdentiesUpdateRepository._();

  @override
  int? id;

  DateTime? date;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LastPupilIdentiesUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LastPupilIdentiesUpdate copyWith({
    int? id,
    DateTime? date,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (date != null) 'date': date?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (date != null) 'date': date?.toJson(),
    };
  }

  static LastPupilIdentiesUpdateInclude include() {
    return LastPupilIdentiesUpdateInclude._();
  }

  static LastPupilIdentiesUpdateIncludeList includeList({
    _i1.WhereExpressionBuilder<LastPupilIdentiesUpdateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LastPupilIdentiesUpdateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LastPupilIdentiesUpdateTable>? orderByList,
    LastPupilIdentiesUpdateInclude? include,
  }) {
    return LastPupilIdentiesUpdateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LastPupilIdentiesUpdate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LastPupilIdentiesUpdate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LastPupilIdentiesUpdateImpl extends LastPupilIdentiesUpdate {
  _LastPupilIdentiesUpdateImpl({
    int? id,
    DateTime? date,
  }) : super._(
          id: id,
          date: date,
        );

  /// Returns a shallow copy of this [LastPupilIdentiesUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LastPupilIdentiesUpdate copyWith({
    Object? id = _Undefined,
    Object? date = _Undefined,
  }) {
    return LastPupilIdentiesUpdate(
      id: id is int? ? id : this.id,
      date: date is DateTime? ? date : this.date,
    );
  }
}

class LastPupilIdentiesUpdateTable extends _i1.Table<int?> {
  LastPupilIdentiesUpdateTable({super.tableRelation})
      : super(tableName: 'last_pupil_identities_update') {
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
  }

  late final _i1.ColumnDateTime date;

  @override
  List<_i1.Column> get columns => [
        id,
        date,
      ];
}

class LastPupilIdentiesUpdateInclude extends _i1.IncludeObject {
  LastPupilIdentiesUpdateInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => LastPupilIdentiesUpdate.t;
}

class LastPupilIdentiesUpdateIncludeList extends _i1.IncludeList {
  LastPupilIdentiesUpdateIncludeList._({
    _i1.WhereExpressionBuilder<LastPupilIdentiesUpdateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LastPupilIdentiesUpdate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LastPupilIdentiesUpdate.t;
}

class LastPupilIdentiesUpdateRepository {
  const LastPupilIdentiesUpdateRepository._();

  /// Returns a list of [LastPupilIdentiesUpdate]s matching the given query parameters.
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
  Future<List<LastPupilIdentiesUpdate>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LastPupilIdentiesUpdateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LastPupilIdentiesUpdateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LastPupilIdentiesUpdateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<LastPupilIdentiesUpdate>(
      where: where?.call(LastPupilIdentiesUpdate.t),
      orderBy: orderBy?.call(LastPupilIdentiesUpdate.t),
      orderByList: orderByList?.call(LastPupilIdentiesUpdate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [LastPupilIdentiesUpdate] matching the given query parameters.
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
  Future<LastPupilIdentiesUpdate?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LastPupilIdentiesUpdateTable>? where,
    int? offset,
    _i1.OrderByBuilder<LastPupilIdentiesUpdateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LastPupilIdentiesUpdateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<LastPupilIdentiesUpdate>(
      where: where?.call(LastPupilIdentiesUpdate.t),
      orderBy: orderBy?.call(LastPupilIdentiesUpdate.t),
      orderByList: orderByList?.call(LastPupilIdentiesUpdate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [LastPupilIdentiesUpdate] by its [id] or null if no such row exists.
  Future<LastPupilIdentiesUpdate?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<LastPupilIdentiesUpdate>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [LastPupilIdentiesUpdate]s in the list and returns the inserted rows.
  ///
  /// The returned [LastPupilIdentiesUpdate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LastPupilIdentiesUpdate>> insert(
    _i1.Session session,
    List<LastPupilIdentiesUpdate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LastPupilIdentiesUpdate>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LastPupilIdentiesUpdate] and returns the inserted row.
  ///
  /// The returned [LastPupilIdentiesUpdate] will have its `id` field set.
  Future<LastPupilIdentiesUpdate> insertRow(
    _i1.Session session,
    LastPupilIdentiesUpdate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LastPupilIdentiesUpdate>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LastPupilIdentiesUpdate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LastPupilIdentiesUpdate>> update(
    _i1.Session session,
    List<LastPupilIdentiesUpdate> rows, {
    _i1.ColumnSelections<LastPupilIdentiesUpdateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LastPupilIdentiesUpdate>(
      rows,
      columns: columns?.call(LastPupilIdentiesUpdate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LastPupilIdentiesUpdate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LastPupilIdentiesUpdate> updateRow(
    _i1.Session session,
    LastPupilIdentiesUpdate row, {
    _i1.ColumnSelections<LastPupilIdentiesUpdateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LastPupilIdentiesUpdate>(
      row,
      columns: columns?.call(LastPupilIdentiesUpdate.t),
      transaction: transaction,
    );
  }

  /// Deletes all [LastPupilIdentiesUpdate]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LastPupilIdentiesUpdate>> delete(
    _i1.Session session,
    List<LastPupilIdentiesUpdate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LastPupilIdentiesUpdate>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LastPupilIdentiesUpdate].
  Future<LastPupilIdentiesUpdate> deleteRow(
    _i1.Session session,
    LastPupilIdentiesUpdate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LastPupilIdentiesUpdate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LastPupilIdentiesUpdate>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LastPupilIdentiesUpdateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LastPupilIdentiesUpdate>(
      where: where(LastPupilIdentiesUpdate.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LastPupilIdentiesUpdateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LastPupilIdentiesUpdate>(
      where: where?.call(LastPupilIdentiesUpdate.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
