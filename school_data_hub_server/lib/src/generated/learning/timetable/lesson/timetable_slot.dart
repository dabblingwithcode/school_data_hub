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
import '../../../learning/timetable/lesson/weekday_enum.dart' as _i2;

abstract class TimetableSlot
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  TimetableSlot._({
    this.id,
    this.day,
    this.startTime,
    this.endTime,
  });

  factory TimetableSlot({
    int? id,
    _i2.Weekday? day,
    String? startTime,
    String? endTime,
  }) = _TimetableSlotImpl;

  factory TimetableSlot.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimetableSlot(
      id: jsonSerialization['id'] as int?,
      day: jsonSerialization['day'] == null
          ? null
          : _i2.Weekday.fromJson((jsonSerialization['day'] as String)),
      startTime: jsonSerialization['startTime'] as String?,
      endTime: jsonSerialization['endTime'] as String?,
    );
  }

  static final t = TimetableSlotTable();

  static const db = TimetableSlotRepository._();

  @override
  int? id;

  _i2.Weekday? day;

  String? startTime;

  String? endTime;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [TimetableSlot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TimetableSlot copyWith({
    int? id,
    _i2.Weekday? day,
    String? startTime,
    String? endTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (day != null) 'day': day?.toJson(),
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (day != null) 'day': day?.toJson(),
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
    };
  }

  static TimetableSlotInclude include() {
    return TimetableSlotInclude._();
  }

  static TimetableSlotIncludeList includeList({
    _i1.WhereExpressionBuilder<TimetableSlotTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TimetableSlotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TimetableSlotTable>? orderByList,
    TimetableSlotInclude? include,
  }) {
    return TimetableSlotIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TimetableSlot.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TimetableSlot.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TimetableSlotImpl extends TimetableSlot {
  _TimetableSlotImpl({
    int? id,
    _i2.Weekday? day,
    String? startTime,
    String? endTime,
  }) : super._(
          id: id,
          day: day,
          startTime: startTime,
          endTime: endTime,
        );

  /// Returns a shallow copy of this [TimetableSlot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TimetableSlot copyWith({
    Object? id = _Undefined,
    Object? day = _Undefined,
    Object? startTime = _Undefined,
    Object? endTime = _Undefined,
  }) {
    return TimetableSlot(
      id: id is int? ? id : this.id,
      day: day is _i2.Weekday? ? day : this.day,
      startTime: startTime is String? ? startTime : this.startTime,
      endTime: endTime is String? ? endTime : this.endTime,
    );
  }
}

class TimetableSlotTable extends _i1.Table<int> {
  TimetableSlotTable({super.tableRelation})
      : super(tableName: 'timetable_slot') {
    day = _i1.ColumnEnum(
      'day',
      this,
      _i1.EnumSerialization.byName,
    );
    startTime = _i1.ColumnString(
      'startTime',
      this,
    );
    endTime = _i1.ColumnString(
      'endTime',
      this,
    );
  }

  late final _i1.ColumnEnum<_i2.Weekday> day;

  late final _i1.ColumnString startTime;

  late final _i1.ColumnString endTime;

  @override
  List<_i1.Column> get columns => [
        id,
        day,
        startTime,
        endTime,
      ];
}

class TimetableSlotInclude extends _i1.IncludeObject {
  TimetableSlotInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => TimetableSlot.t;
}

class TimetableSlotIncludeList extends _i1.IncludeList {
  TimetableSlotIncludeList._({
    _i1.WhereExpressionBuilder<TimetableSlotTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TimetableSlot.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => TimetableSlot.t;
}

class TimetableSlotRepository {
  const TimetableSlotRepository._();

  /// Returns a list of [TimetableSlot]s matching the given query parameters.
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
  Future<List<TimetableSlot>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TimetableSlotTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TimetableSlotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TimetableSlotTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<TimetableSlot>(
      where: where?.call(TimetableSlot.t),
      orderBy: orderBy?.call(TimetableSlot.t),
      orderByList: orderByList?.call(TimetableSlot.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [TimetableSlot] matching the given query parameters.
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
  Future<TimetableSlot?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TimetableSlotTable>? where,
    int? offset,
    _i1.OrderByBuilder<TimetableSlotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TimetableSlotTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<TimetableSlot>(
      where: where?.call(TimetableSlot.t),
      orderBy: orderBy?.call(TimetableSlot.t),
      orderByList: orderByList?.call(TimetableSlot.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [TimetableSlot] by its [id] or null if no such row exists.
  Future<TimetableSlot?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<TimetableSlot>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [TimetableSlot]s in the list and returns the inserted rows.
  ///
  /// The returned [TimetableSlot]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<TimetableSlot>> insert(
    _i1.Session session,
    List<TimetableSlot> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TimetableSlot>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [TimetableSlot] and returns the inserted row.
  ///
  /// The returned [TimetableSlot] will have its `id` field set.
  Future<TimetableSlot> insertRow(
    _i1.Session session,
    TimetableSlot row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TimetableSlot>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TimetableSlot]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TimetableSlot>> update(
    _i1.Session session,
    List<TimetableSlot> rows, {
    _i1.ColumnSelections<TimetableSlotTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TimetableSlot>(
      rows,
      columns: columns?.call(TimetableSlot.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TimetableSlot]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TimetableSlot> updateRow(
    _i1.Session session,
    TimetableSlot row, {
    _i1.ColumnSelections<TimetableSlotTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TimetableSlot>(
      row,
      columns: columns?.call(TimetableSlot.t),
      transaction: transaction,
    );
  }

  /// Deletes all [TimetableSlot]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TimetableSlot>> delete(
    _i1.Session session,
    List<TimetableSlot> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TimetableSlot>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TimetableSlot].
  Future<TimetableSlot> deleteRow(
    _i1.Session session,
    TimetableSlot row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TimetableSlot>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TimetableSlot>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TimetableSlotTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TimetableSlot>(
      where: where(TimetableSlot.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TimetableSlotTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TimetableSlot>(
      where: where?.call(TimetableSlot.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
