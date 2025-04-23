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
import '../schoolday/missed_class/missed_class.dart' as _i2;
import '../schoolday/schoolday_event.dart' as _i3;
import '../schoolday/school_semester.dart' as _i4;

abstract class Schoolday
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  Schoolday._({
    this.id,
    required this.schoolday,
    this.missedClasses,
    this.schooldayEvents,
    required this.schoolSemesterId,
    this.schoolSemester,
  });

  factory Schoolday({
    int? id,
    required DateTime schoolday,
    List<_i2.MissedClass>? missedClasses,
    List<_i3.SchooldayEvent>? schooldayEvents,
    required int schoolSemesterId,
    _i4.SchoolSemester? schoolSemester,
  }) = _SchooldayImpl;

  factory Schoolday.fromJson(Map<String, dynamic> jsonSerialization) {
    return Schoolday(
      id: jsonSerialization['id'] as int?,
      schoolday:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['schoolday']),
      missedClasses: (jsonSerialization['missedClasses'] as List?)
          ?.map((e) => _i2.MissedClass.fromJson((e as Map<String, dynamic>)))
          .toList(),
      schooldayEvents: (jsonSerialization['schooldayEvents'] as List?)
          ?.map((e) => _i3.SchooldayEvent.fromJson((e as Map<String, dynamic>)))
          .toList(),
      schoolSemesterId: jsonSerialization['schoolSemesterId'] as int,
      schoolSemester: jsonSerialization['schoolSemester'] == null
          ? null
          : _i4.SchoolSemester.fromJson(
              (jsonSerialization['schoolSemester'] as Map<String, dynamic>)),
    );
  }

  static final t = SchooldayTable();

  static const db = SchooldayRepository._();

  @override
  int? id;

  DateTime schoolday;

  List<_i2.MissedClass>? missedClasses;

  List<_i3.SchooldayEvent>? schooldayEvents;

  int schoolSemesterId;

  _i4.SchoolSemester? schoolSemester;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [Schoolday]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Schoolday copyWith({
    int? id,
    DateTime? schoolday,
    List<_i2.MissedClass>? missedClasses,
    List<_i3.SchooldayEvent>? schooldayEvents,
    int? schoolSemesterId,
    _i4.SchoolSemester? schoolSemester,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'schoolday': schoolday.toJson(),
      if (missedClasses != null)
        'missedClasses': missedClasses?.toJson(valueToJson: (v) => v.toJson()),
      if (schooldayEvents != null)
        'schooldayEvents':
            schooldayEvents?.toJson(valueToJson: (v) => v.toJson()),
      'schoolSemesterId': schoolSemesterId,
      if (schoolSemester != null) 'schoolSemester': schoolSemester?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'schoolday': schoolday.toJson(),
      if (missedClasses != null)
        'missedClasses':
            missedClasses?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (schooldayEvents != null)
        'schooldayEvents':
            schooldayEvents?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'schoolSemesterId': schoolSemesterId,
      if (schoolSemester != null)
        'schoolSemester': schoolSemester?.toJsonForProtocol(),
    };
  }

  static SchooldayInclude include({
    _i2.MissedClassIncludeList? missedClasses,
    _i3.SchooldayEventIncludeList? schooldayEvents,
    _i4.SchoolSemesterInclude? schoolSemester,
  }) {
    return SchooldayInclude._(
      missedClasses: missedClasses,
      schooldayEvents: schooldayEvents,
      schoolSemester: schoolSemester,
    );
  }

  static SchooldayIncludeList includeList({
    _i1.WhereExpressionBuilder<SchooldayTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SchooldayTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchooldayTable>? orderByList,
    SchooldayInclude? include,
  }) {
    return SchooldayIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Schoolday.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Schoolday.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SchooldayImpl extends Schoolday {
  _SchooldayImpl({
    int? id,
    required DateTime schoolday,
    List<_i2.MissedClass>? missedClasses,
    List<_i3.SchooldayEvent>? schooldayEvents,
    required int schoolSemesterId,
    _i4.SchoolSemester? schoolSemester,
  }) : super._(
          id: id,
          schoolday: schoolday,
          missedClasses: missedClasses,
          schooldayEvents: schooldayEvents,
          schoolSemesterId: schoolSemesterId,
          schoolSemester: schoolSemester,
        );

  /// Returns a shallow copy of this [Schoolday]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Schoolday copyWith({
    Object? id = _Undefined,
    DateTime? schoolday,
    Object? missedClasses = _Undefined,
    Object? schooldayEvents = _Undefined,
    int? schoolSemesterId,
    Object? schoolSemester = _Undefined,
  }) {
    return Schoolday(
      id: id is int? ? id : this.id,
      schoolday: schoolday ?? this.schoolday,
      missedClasses: missedClasses is List<_i2.MissedClass>?
          ? missedClasses
          : this.missedClasses?.map((e0) => e0.copyWith()).toList(),
      schooldayEvents: schooldayEvents is List<_i3.SchooldayEvent>?
          ? schooldayEvents
          : this.schooldayEvents?.map((e0) => e0.copyWith()).toList(),
      schoolSemesterId: schoolSemesterId ?? this.schoolSemesterId,
      schoolSemester: schoolSemester is _i4.SchoolSemester?
          ? schoolSemester
          : this.schoolSemester?.copyWith(),
    );
  }
}

class SchooldayTable extends _i1.Table<int> {
  SchooldayTable({super.tableRelation}) : super(tableName: 'schoolday') {
    schoolday = _i1.ColumnDateTime(
      'schoolday',
      this,
    );
    schoolSemesterId = _i1.ColumnInt(
      'schoolSemesterId',
      this,
    );
  }

  late final _i1.ColumnDateTime schoolday;

  _i2.MissedClassTable? ___missedClasses;

  _i1.ManyRelation<_i2.MissedClassTable>? _missedClasses;

  _i3.SchooldayEventTable? ___schooldayEvents;

  _i1.ManyRelation<_i3.SchooldayEventTable>? _schooldayEvents;

  late final _i1.ColumnInt schoolSemesterId;

  _i4.SchoolSemesterTable? _schoolSemester;

  _i2.MissedClassTable get __missedClasses {
    if (___missedClasses != null) return ___missedClasses!;
    ___missedClasses = _i1.createRelationTable(
      relationFieldName: '__missedClasses',
      field: Schoolday.t.id,
      foreignField: _i2.MissedClass.t.schooldayId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.MissedClassTable(tableRelation: foreignTableRelation),
    );
    return ___missedClasses!;
  }

  _i3.SchooldayEventTable get __schooldayEvents {
    if (___schooldayEvents != null) return ___schooldayEvents!;
    ___schooldayEvents = _i1.createRelationTable(
      relationFieldName: '__schooldayEvents',
      field: Schoolday.t.id,
      foreignField: _i3.SchooldayEvent.t.schooldayId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SchooldayEventTable(tableRelation: foreignTableRelation),
    );
    return ___schooldayEvents!;
  }

  _i4.SchoolSemesterTable get schoolSemester {
    if (_schoolSemester != null) return _schoolSemester!;
    _schoolSemester = _i1.createRelationTable(
      relationFieldName: 'schoolSemester',
      field: Schoolday.t.schoolSemesterId,
      foreignField: _i4.SchoolSemester.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SchoolSemesterTable(tableRelation: foreignTableRelation),
    );
    return _schoolSemester!;
  }

  _i1.ManyRelation<_i2.MissedClassTable> get missedClasses {
    if (_missedClasses != null) return _missedClasses!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'missedClasses',
      field: Schoolday.t.id,
      foreignField: _i2.MissedClass.t.schooldayId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.MissedClassTable(tableRelation: foreignTableRelation),
    );
    _missedClasses = _i1.ManyRelation<_i2.MissedClassTable>(
      tableWithRelations: relationTable,
      table: _i2.MissedClassTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _missedClasses!;
  }

  _i1.ManyRelation<_i3.SchooldayEventTable> get schooldayEvents {
    if (_schooldayEvents != null) return _schooldayEvents!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'schooldayEvents',
      field: Schoolday.t.id,
      foreignField: _i3.SchooldayEvent.t.schooldayId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SchooldayEventTable(tableRelation: foreignTableRelation),
    );
    _schooldayEvents = _i1.ManyRelation<_i3.SchooldayEventTable>(
      tableWithRelations: relationTable,
      table: _i3.SchooldayEventTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _schooldayEvents!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        schoolday,
        schoolSemesterId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'missedClasses') {
      return __missedClasses;
    }
    if (relationField == 'schooldayEvents') {
      return __schooldayEvents;
    }
    if (relationField == 'schoolSemester') {
      return schoolSemester;
    }
    return null;
  }
}

class SchooldayInclude extends _i1.IncludeObject {
  SchooldayInclude._({
    _i2.MissedClassIncludeList? missedClasses,
    _i3.SchooldayEventIncludeList? schooldayEvents,
    _i4.SchoolSemesterInclude? schoolSemester,
  }) {
    _missedClasses = missedClasses;
    _schooldayEvents = schooldayEvents;
    _schoolSemester = schoolSemester;
  }

  _i2.MissedClassIncludeList? _missedClasses;

  _i3.SchooldayEventIncludeList? _schooldayEvents;

  _i4.SchoolSemesterInclude? _schoolSemester;

  @override
  Map<String, _i1.Include?> get includes => {
        'missedClasses': _missedClasses,
        'schooldayEvents': _schooldayEvents,
        'schoolSemester': _schoolSemester,
      };

  @override
  _i1.Table<int> get table => Schoolday.t;
}

class SchooldayIncludeList extends _i1.IncludeList {
  SchooldayIncludeList._({
    _i1.WhereExpressionBuilder<SchooldayTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Schoolday.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => Schoolday.t;
}

class SchooldayRepository {
  const SchooldayRepository._();

  final attach = const SchooldayAttachRepository._();

  final attachRow = const SchooldayAttachRowRepository._();

  final detach = const SchooldayDetachRepository._();

  final detachRow = const SchooldayDetachRowRepository._();

  /// Returns a list of [Schoolday]s matching the given query parameters.
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
  Future<List<Schoolday>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchooldayTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SchooldayTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchooldayTable>? orderByList,
    _i1.Transaction? transaction,
    SchooldayInclude? include,
  }) async {
    return session.db.find<Schoolday>(
      where: where?.call(Schoolday.t),
      orderBy: orderBy?.call(Schoolday.t),
      orderByList: orderByList?.call(Schoolday.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Schoolday] matching the given query parameters.
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
  Future<Schoolday?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchooldayTable>? where,
    int? offset,
    _i1.OrderByBuilder<SchooldayTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SchooldayTable>? orderByList,
    _i1.Transaction? transaction,
    SchooldayInclude? include,
  }) async {
    return session.db.findFirstRow<Schoolday>(
      where: where?.call(Schoolday.t),
      orderBy: orderBy?.call(Schoolday.t),
      orderByList: orderByList?.call(Schoolday.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Schoolday] by its [id] or null if no such row exists.
  Future<Schoolday?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SchooldayInclude? include,
  }) async {
    return session.db.findById<Schoolday>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Schoolday]s in the list and returns the inserted rows.
  ///
  /// The returned [Schoolday]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Schoolday>> insert(
    _i1.Session session,
    List<Schoolday> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Schoolday>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Schoolday] and returns the inserted row.
  ///
  /// The returned [Schoolday] will have its `id` field set.
  Future<Schoolday> insertRow(
    _i1.Session session,
    Schoolday row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Schoolday>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Schoolday]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Schoolday>> update(
    _i1.Session session,
    List<Schoolday> rows, {
    _i1.ColumnSelections<SchooldayTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Schoolday>(
      rows,
      columns: columns?.call(Schoolday.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Schoolday]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Schoolday> updateRow(
    _i1.Session session,
    Schoolday row, {
    _i1.ColumnSelections<SchooldayTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Schoolday>(
      row,
      columns: columns?.call(Schoolday.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Schoolday]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Schoolday>> delete(
    _i1.Session session,
    List<Schoolday> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Schoolday>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Schoolday].
  Future<Schoolday> deleteRow(
    _i1.Session session,
    Schoolday row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Schoolday>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Schoolday>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SchooldayTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Schoolday>(
      where: where(Schoolday.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SchooldayTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Schoolday>(
      where: where?.call(Schoolday.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SchooldayAttachRepository {
  const SchooldayAttachRepository._();

  /// Creates a relation between this [Schoolday] and the given [MissedClass]s
  /// by setting each [MissedClass]'s foreign key `schooldayId` to refer to this [Schoolday].
  Future<void> missedClasses(
    _i1.Session session,
    Schoolday schoolday,
    List<_i2.MissedClass> missedClass, {
    _i1.Transaction? transaction,
  }) async {
    if (missedClass.any((e) => e.id == null)) {
      throw ArgumentError.notNull('missedClass.id');
    }
    if (schoolday.id == null) {
      throw ArgumentError.notNull('schoolday.id');
    }

    var $missedClass =
        missedClass.map((e) => e.copyWith(schooldayId: schoolday.id)).toList();
    await session.db.update<_i2.MissedClass>(
      $missedClass,
      columns: [_i2.MissedClass.t.schooldayId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Schoolday] and the given [SchooldayEvent]s
  /// by setting each [SchooldayEvent]'s foreign key `schooldayId` to refer to this [Schoolday].
  Future<void> schooldayEvents(
    _i1.Session session,
    Schoolday schoolday,
    List<_i3.SchooldayEvent> schooldayEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldayEvent.any((e) => e.id == null)) {
      throw ArgumentError.notNull('schooldayEvent.id');
    }
    if (schoolday.id == null) {
      throw ArgumentError.notNull('schoolday.id');
    }

    var $schooldayEvent = schooldayEvent
        .map((e) => e.copyWith(schooldayId: schoolday.id))
        .toList();
    await session.db.update<_i3.SchooldayEvent>(
      $schooldayEvent,
      columns: [_i3.SchooldayEvent.t.schooldayId],
      transaction: transaction,
    );
  }
}

class SchooldayAttachRowRepository {
  const SchooldayAttachRowRepository._();

  /// Creates a relation between the given [Schoolday] and [SchoolSemester]
  /// by setting the [Schoolday]'s foreign key `schoolSemesterId` to refer to the [SchoolSemester].
  Future<void> schoolSemester(
    _i1.Session session,
    Schoolday schoolday,
    _i4.SchoolSemester schoolSemester, {
    _i1.Transaction? transaction,
  }) async {
    if (schoolday.id == null) {
      throw ArgumentError.notNull('schoolday.id');
    }
    if (schoolSemester.id == null) {
      throw ArgumentError.notNull('schoolSemester.id');
    }

    var $schoolday = schoolday.copyWith(schoolSemesterId: schoolSemester.id);
    await session.db.updateRow<Schoolday>(
      $schoolday,
      columns: [Schoolday.t.schoolSemesterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Schoolday] and the given [MissedClass]
  /// by setting the [MissedClass]'s foreign key `schooldayId` to refer to this [Schoolday].
  Future<void> missedClasses(
    _i1.Session session,
    Schoolday schoolday,
    _i2.MissedClass missedClass, {
    _i1.Transaction? transaction,
  }) async {
    if (missedClass.id == null) {
      throw ArgumentError.notNull('missedClass.id');
    }
    if (schoolday.id == null) {
      throw ArgumentError.notNull('schoolday.id');
    }

    var $missedClass = missedClass.copyWith(schooldayId: schoolday.id);
    await session.db.updateRow<_i2.MissedClass>(
      $missedClass,
      columns: [_i2.MissedClass.t.schooldayId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Schoolday] and the given [SchooldayEvent]
  /// by setting the [SchooldayEvent]'s foreign key `schooldayId` to refer to this [Schoolday].
  Future<void> schooldayEvents(
    _i1.Session session,
    Schoolday schoolday,
    _i3.SchooldayEvent schooldayEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldayEvent.id == null) {
      throw ArgumentError.notNull('schooldayEvent.id');
    }
    if (schoolday.id == null) {
      throw ArgumentError.notNull('schoolday.id');
    }

    var $schooldayEvent = schooldayEvent.copyWith(schooldayId: schoolday.id);
    await session.db.updateRow<_i3.SchooldayEvent>(
      $schooldayEvent,
      columns: [_i3.SchooldayEvent.t.schooldayId],
      transaction: transaction,
    );
  }
}

class SchooldayDetachRepository {
  const SchooldayDetachRepository._();

  /// Detaches the relation between this [Schoolday] and the given [SchooldayEvent]
  /// by setting the [SchooldayEvent]'s foreign key `schooldayId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> schooldayEvents(
    _i1.Session session,
    List<_i3.SchooldayEvent> schooldayEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldayEvent.any((e) => e.id == null)) {
      throw ArgumentError.notNull('schooldayEvent.id');
    }

    var $schooldayEvent =
        schooldayEvent.map((e) => e.copyWith(schooldayId: null)).toList();
    await session.db.update<_i3.SchooldayEvent>(
      $schooldayEvent,
      columns: [_i3.SchooldayEvent.t.schooldayId],
      transaction: transaction,
    );
  }
}

class SchooldayDetachRowRepository {
  const SchooldayDetachRowRepository._();

  /// Detaches the relation between this [Schoolday] and the given [SchooldayEvent]
  /// by setting the [SchooldayEvent]'s foreign key `schooldayId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> schooldayEvents(
    _i1.Session session,
    _i3.SchooldayEvent schooldayEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (schooldayEvent.id == null) {
      throw ArgumentError.notNull('schooldayEvent.id');
    }

    var $schooldayEvent = schooldayEvent.copyWith(schooldayId: null);
    await session.db.updateRow<_i3.SchooldayEvent>(
      $schooldayEvent,
      columns: [_i3.SchooldayEvent.t.schooldayId],
      transaction: transaction,
    );
  }
}
