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
import '../../../../_features/timetable/models/scheduled_lesson/weekday_enum.dart'
    as _i2;
import '../../../../_features/timetable/models/timetable.dart' as _i3;

abstract class TimetableSlot
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TimetableSlot._({
    this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.timetableId,
    this.timetable,
  });

  factory TimetableSlot({
    int? id,
    required _i2.Weekday day,
    required String startTime,
    required String endTime,
    required int timetableId,
    _i3.Timetable? timetable,
  }) = _TimetableSlotImpl;

  factory TimetableSlot.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimetableSlot(
      id: jsonSerialization['id'] as int?,
      day: _i2.Weekday.fromJson((jsonSerialization['day'] as String)),
      startTime: jsonSerialization['startTime'] as String,
      endTime: jsonSerialization['endTime'] as String,
      timetableId: jsonSerialization['timetableId'] as int,
      timetable: jsonSerialization['timetable'] == null
          ? null
          : _i3.Timetable.fromJson(
              (jsonSerialization['timetable'] as Map<String, dynamic>)),
    );
  }

  static final t = TimetableSlotTable();

  static const db = TimetableSlotRepository._();

  @override
  int? id;

  _i2.Weekday day;

  String startTime;

  String endTime;

  int timetableId;

  _i3.Timetable? timetable;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TimetableSlot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TimetableSlot copyWith({
    int? id,
    _i2.Weekday? day,
    String? startTime,
    String? endTime,
    int? timetableId,
    _i3.Timetable? timetable,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'day': day.toJson(),
      'startTime': startTime,
      'endTime': endTime,
      'timetableId': timetableId,
      if (timetable != null) 'timetable': timetable?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'day': day.toJson(),
      'startTime': startTime,
      'endTime': endTime,
      'timetableId': timetableId,
      if (timetable != null) 'timetable': timetable?.toJsonForProtocol(),
    };
  }

  static TimetableSlotInclude include({_i3.TimetableInclude? timetable}) {
    return TimetableSlotInclude._(timetable: timetable);
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
    required _i2.Weekday day,
    required String startTime,
    required String endTime,
    required int timetableId,
    _i3.Timetable? timetable,
  }) : super._(
          id: id,
          day: day,
          startTime: startTime,
          endTime: endTime,
          timetableId: timetableId,
          timetable: timetable,
        );

  /// Returns a shallow copy of this [TimetableSlot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TimetableSlot copyWith({
    Object? id = _Undefined,
    _i2.Weekday? day,
    String? startTime,
    String? endTime,
    int? timetableId,
    Object? timetable = _Undefined,
  }) {
    return TimetableSlot(
      id: id is int? ? id : this.id,
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timetableId: timetableId ?? this.timetableId,
      timetable:
          timetable is _i3.Timetable? ? timetable : this.timetable?.copyWith(),
    );
  }
}

class TimetableSlotTable extends _i1.Table<int?> {
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
    timetableId = _i1.ColumnInt(
      'timetableId',
      this,
    );
  }

  late final _i1.ColumnEnum<_i2.Weekday> day;

  late final _i1.ColumnString startTime;

  late final _i1.ColumnString endTime;

  late final _i1.ColumnInt timetableId;

  _i3.TimetableTable? _timetable;

  _i3.TimetableTable get timetable {
    if (_timetable != null) return _timetable!;
    _timetable = _i1.createRelationTable(
      relationFieldName: 'timetable',
      field: TimetableSlot.t.timetableId,
      foreignField: _i3.Timetable.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.TimetableTable(tableRelation: foreignTableRelation),
    );
    return _timetable!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        day,
        startTime,
        endTime,
        timetableId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'timetable') {
      return timetable;
    }
    return null;
  }
}

class TimetableSlotInclude extends _i1.IncludeObject {
  TimetableSlotInclude._({_i3.TimetableInclude? timetable}) {
    _timetable = timetable;
  }

  _i3.TimetableInclude? _timetable;

  @override
  Map<String, _i1.Include?> get includes => {'timetable': _timetable};

  @override
  _i1.Table<int?> get table => TimetableSlot.t;
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
  _i1.Table<int?> get table => TimetableSlot.t;
}

class TimetableSlotRepository {
  const TimetableSlotRepository._();

  final attachRow = const TimetableSlotAttachRowRepository._();

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
    TimetableSlotInclude? include,
  }) async {
    return session.db.find<TimetableSlot>(
      where: where?.call(TimetableSlot.t),
      orderBy: orderBy?.call(TimetableSlot.t),
      orderByList: orderByList?.call(TimetableSlot.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    TimetableSlotInclude? include,
  }) async {
    return session.db.findFirstRow<TimetableSlot>(
      where: where?.call(TimetableSlot.t),
      orderBy: orderBy?.call(TimetableSlot.t),
      orderByList: orderByList?.call(TimetableSlot.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [TimetableSlot] by its [id] or null if no such row exists.
  Future<TimetableSlot?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    TimetableSlotInclude? include,
  }) async {
    return session.db.findById<TimetableSlot>(
      id,
      transaction: transaction,
      include: include,
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

class TimetableSlotAttachRowRepository {
  const TimetableSlotAttachRowRepository._();

  /// Creates a relation between the given [TimetableSlot] and [Timetable]
  /// by setting the [TimetableSlot]'s foreign key `timetableId` to refer to the [Timetable].
  Future<void> timetable(
    _i1.Session session,
    TimetableSlot timetableSlot,
    _i3.Timetable timetable, {
    _i1.Transaction? transaction,
  }) async {
    if (timetableSlot.id == null) {
      throw ArgumentError.notNull('timetableSlot.id');
    }
    if (timetable.id == null) {
      throw ArgumentError.notNull('timetable.id');
    }

    var $timetableSlot = timetableSlot.copyWith(timetableId: timetable.id);
    await session.db.updateRow<TimetableSlot>(
      $timetableSlot,
      columns: [TimetableSlot.t.timetableId],
      transaction: transaction,
    );
  }
}
