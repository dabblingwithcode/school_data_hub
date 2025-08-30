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
import '../../../_features/schoolday/models/school_semester.dart' as _i2;
import '../../../_features/timetable/models/scheduled_lesson/scheduled_lesson.dart'
    as _i3;
import '../../../_features/timetable/models/scheduled_lesson/timetable_slot.dart'
    as _i4;
import 'package:school_data_hub_server/src/generated/protocol.dart' as _i5;

abstract class Timetable
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Timetable._({
    this.id,
    required this.active,
    required this.startsAt,
    this.endsAt,
    required this.name,
    required this.schoolSemesterId,
    this.schoolSemester,
    this.scheduledLessons,
    this.timetableSlots,
    required this.createdBy,
    required this.createdAt,
    this.modified,
  });

  factory Timetable({
    int? id,
    required bool active,
    required DateTime startsAt,
    DateTime? endsAt,
    required String name,
    required int schoolSemesterId,
    _i2.SchoolSemester? schoolSemester,
    List<_i3.ScheduledLesson>? scheduledLessons,
    List<_i4.TimetableSlot>? timetableSlots,
    required String createdBy,
    required DateTime createdAt,
    List<({String modifiedBy, DateTime modifiedAt})>? modified,
  }) = _TimetableImpl;

  factory Timetable.fromJson(Map<String, dynamic> jsonSerialization) {
    return Timetable(
      id: jsonSerialization['id'] as int?,
      active: jsonSerialization['active'] as bool,
      startsAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startsAt']),
      endsAt: jsonSerialization['endsAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      name: jsonSerialization['name'] as String,
      schoolSemesterId: jsonSerialization['schoolSemesterId'] as int,
      schoolSemester: jsonSerialization['schoolSemester'] == null
          ? null
          : _i2.SchoolSemester.fromJson(
              (jsonSerialization['schoolSemester'] as Map<String, dynamic>)),
      scheduledLessons: (jsonSerialization['scheduledLessons'] as List?)
          ?.map(
              (e) => _i3.ScheduledLesson.fromJson((e as Map<String, dynamic>)))
          .toList(),
      timetableSlots: (jsonSerialization['timetableSlots'] as List?)
          ?.map((e) => _i4.TimetableSlot.fromJson((e as Map<String, dynamic>)))
          .toList(),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      modified: (jsonSerialization['modified'] as List?)
          ?.map((e) => _i5.Protocol()
              .deserialize<({String modifiedBy, DateTime modifiedAt})>(
                  (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = TimetableTable();

  static const db = TimetableRepository._();

  @override
  int? id;

  bool active;

  DateTime startsAt;

  DateTime? endsAt;

  String name;

  int schoolSemesterId;

  _i2.SchoolSemester? schoolSemester;

  List<_i3.ScheduledLesson>? scheduledLessons;

  List<_i4.TimetableSlot>? timetableSlots;

  String createdBy;

  DateTime createdAt;

  List<({String modifiedBy, DateTime modifiedAt})>? modified;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Timetable]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Timetable copyWith({
    int? id,
    bool? active,
    DateTime? startsAt,
    DateTime? endsAt,
    String? name,
    int? schoolSemesterId,
    _i2.SchoolSemester? schoolSemester,
    List<_i3.ScheduledLesson>? scheduledLessons,
    List<_i4.TimetableSlot>? timetableSlots,
    String? createdBy,
    DateTime? createdAt,
    List<({String modifiedBy, DateTime modifiedAt})>? modified,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'active': active,
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      'name': name,
      'schoolSemesterId': schoolSemesterId,
      if (schoolSemester != null) 'schoolSemester': schoolSemester?.toJson(),
      if (scheduledLessons != null)
        'scheduledLessons':
            scheduledLessons?.toJson(valueToJson: (v) => v.toJson()),
      if (timetableSlots != null)
        'timetableSlots':
            timetableSlots?.toJson(valueToJson: (v) => v.toJson()),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (modified != null)
        'modified': _i5.mapRecordContainingContainerToJson(modified!),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'active': active,
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      'name': name,
      'schoolSemesterId': schoolSemesterId,
      if (schoolSemester != null)
        'schoolSemester': schoolSemester?.toJsonForProtocol(),
      if (scheduledLessons != null)
        'scheduledLessons':
            scheduledLessons?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (timetableSlots != null)
        'timetableSlots':
            timetableSlots?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (modified != null)
        'modified': _i5.mapRecordContainingContainerToJson(modified!),
    };
  }

  static TimetableInclude include({
    _i2.SchoolSemesterInclude? schoolSemester,
    _i3.ScheduledLessonIncludeList? scheduledLessons,
    _i4.TimetableSlotIncludeList? timetableSlots,
  }) {
    return TimetableInclude._(
      schoolSemester: schoolSemester,
      scheduledLessons: scheduledLessons,
      timetableSlots: timetableSlots,
    );
  }

  static TimetableIncludeList includeList({
    _i1.WhereExpressionBuilder<TimetableTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TimetableTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TimetableTable>? orderByList,
    TimetableInclude? include,
  }) {
    return TimetableIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Timetable.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Timetable.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TimetableImpl extends Timetable {
  _TimetableImpl({
    int? id,
    required bool active,
    required DateTime startsAt,
    DateTime? endsAt,
    required String name,
    required int schoolSemesterId,
    _i2.SchoolSemester? schoolSemester,
    List<_i3.ScheduledLesson>? scheduledLessons,
    List<_i4.TimetableSlot>? timetableSlots,
    required String createdBy,
    required DateTime createdAt,
    List<({String modifiedBy, DateTime modifiedAt})>? modified,
  }) : super._(
          id: id,
          active: active,
          startsAt: startsAt,
          endsAt: endsAt,
          name: name,
          schoolSemesterId: schoolSemesterId,
          schoolSemester: schoolSemester,
          scheduledLessons: scheduledLessons,
          timetableSlots: timetableSlots,
          createdBy: createdBy,
          createdAt: createdAt,
          modified: modified,
        );

  /// Returns a shallow copy of this [Timetable]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Timetable copyWith({
    Object? id = _Undefined,
    bool? active,
    DateTime? startsAt,
    Object? endsAt = _Undefined,
    String? name,
    int? schoolSemesterId,
    Object? schoolSemester = _Undefined,
    Object? scheduledLessons = _Undefined,
    Object? timetableSlots = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    Object? modified = _Undefined,
  }) {
    return Timetable(
      id: id is int? ? id : this.id,
      active: active ?? this.active,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt is DateTime? ? endsAt : this.endsAt,
      name: name ?? this.name,
      schoolSemesterId: schoolSemesterId ?? this.schoolSemesterId,
      schoolSemester: schoolSemester is _i2.SchoolSemester?
          ? schoolSemester
          : this.schoolSemester?.copyWith(),
      scheduledLessons: scheduledLessons is List<_i3.ScheduledLesson>?
          ? scheduledLessons
          : this.scheduledLessons?.map((e0) => e0.copyWith()).toList(),
      timetableSlots: timetableSlots is List<_i4.TimetableSlot>?
          ? timetableSlots
          : this.timetableSlots?.map((e0) => e0.copyWith()).toList(),
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modified: modified is List<({String modifiedBy, DateTime modifiedAt})>?
          ? modified
          : this
              .modified
              ?.map((e0) => (
                    modifiedBy: e0.modifiedBy,
                    modifiedAt: e0.modifiedAt,
                  ))
              .toList(),
    );
  }
}

class TimetableTable extends _i1.Table<int?> {
  TimetableTable({super.tableRelation}) : super(tableName: 'timetable') {
    active = _i1.ColumnBool(
      'active',
      this,
    );
    startsAt = _i1.ColumnDateTime(
      'startsAt',
      this,
    );
    endsAt = _i1.ColumnDateTime(
      'endsAt',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    schoolSemesterId = _i1.ColumnInt(
      'schoolSemesterId',
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
    modified = _i1.ColumnSerializable(
      'modified',
      this,
    );
  }

  late final _i1.ColumnBool active;

  late final _i1.ColumnDateTime startsAt;

  late final _i1.ColumnDateTime endsAt;

  late final _i1.ColumnString name;

  late final _i1.ColumnInt schoolSemesterId;

  _i2.SchoolSemesterTable? _schoolSemester;

  _i3.ScheduledLessonTable? ___scheduledLessons;

  _i1.ManyRelation<_i3.ScheduledLessonTable>? _scheduledLessons;

  _i4.TimetableSlotTable? ___timetableSlots;

  _i1.ManyRelation<_i4.TimetableSlotTable>? _timetableSlots;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnSerializable modified;

  _i2.SchoolSemesterTable get schoolSemester {
    if (_schoolSemester != null) return _schoolSemester!;
    _schoolSemester = _i1.createRelationTable(
      relationFieldName: 'schoolSemester',
      field: Timetable.t.schoolSemesterId,
      foreignField: _i2.SchoolSemester.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SchoolSemesterTable(tableRelation: foreignTableRelation),
    );
    return _schoolSemester!;
  }

  _i3.ScheduledLessonTable get __scheduledLessons {
    if (___scheduledLessons != null) return ___scheduledLessons!;
    ___scheduledLessons = _i1.createRelationTable(
      relationFieldName: '__scheduledLessons',
      field: Timetable.t.id,
      foreignField: _i3.ScheduledLesson.t.timetableId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ScheduledLessonTable(tableRelation: foreignTableRelation),
    );
    return ___scheduledLessons!;
  }

  _i4.TimetableSlotTable get __timetableSlots {
    if (___timetableSlots != null) return ___timetableSlots!;
    ___timetableSlots = _i1.createRelationTable(
      relationFieldName: '__timetableSlots',
      field: Timetable.t.id,
      foreignField: _i4.TimetableSlot.t.timetableId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.TimetableSlotTable(tableRelation: foreignTableRelation),
    );
    return ___timetableSlots!;
  }

  _i1.ManyRelation<_i3.ScheduledLessonTable> get scheduledLessons {
    if (_scheduledLessons != null) return _scheduledLessons!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'scheduledLessons',
      field: Timetable.t.id,
      foreignField: _i3.ScheduledLesson.t.timetableId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ScheduledLessonTable(tableRelation: foreignTableRelation),
    );
    _scheduledLessons = _i1.ManyRelation<_i3.ScheduledLessonTable>(
      tableWithRelations: relationTable,
      table: _i3.ScheduledLessonTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _scheduledLessons!;
  }

  _i1.ManyRelation<_i4.TimetableSlotTable> get timetableSlots {
    if (_timetableSlots != null) return _timetableSlots!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'timetableSlots',
      field: Timetable.t.id,
      foreignField: _i4.TimetableSlot.t.timetableId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.TimetableSlotTable(tableRelation: foreignTableRelation),
    );
    _timetableSlots = _i1.ManyRelation<_i4.TimetableSlotTable>(
      tableWithRelations: relationTable,
      table: _i4.TimetableSlotTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _timetableSlots!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        active,
        startsAt,
        endsAt,
        name,
        schoolSemesterId,
        createdBy,
        createdAt,
        modified,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'schoolSemester') {
      return schoolSemester;
    }
    if (relationField == 'scheduledLessons') {
      return __scheduledLessons;
    }
    if (relationField == 'timetableSlots') {
      return __timetableSlots;
    }
    return null;
  }
}

class TimetableInclude extends _i1.IncludeObject {
  TimetableInclude._({
    _i2.SchoolSemesterInclude? schoolSemester,
    _i3.ScheduledLessonIncludeList? scheduledLessons,
    _i4.TimetableSlotIncludeList? timetableSlots,
  }) {
    _schoolSemester = schoolSemester;
    _scheduledLessons = scheduledLessons;
    _timetableSlots = timetableSlots;
  }

  _i2.SchoolSemesterInclude? _schoolSemester;

  _i3.ScheduledLessonIncludeList? _scheduledLessons;

  _i4.TimetableSlotIncludeList? _timetableSlots;

  @override
  Map<String, _i1.Include?> get includes => {
        'schoolSemester': _schoolSemester,
        'scheduledLessons': _scheduledLessons,
        'timetableSlots': _timetableSlots,
      };

  @override
  _i1.Table<int?> get table => Timetable.t;
}

class TimetableIncludeList extends _i1.IncludeList {
  TimetableIncludeList._({
    _i1.WhereExpressionBuilder<TimetableTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Timetable.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Timetable.t;
}

class TimetableRepository {
  const TimetableRepository._();

  final attach = const TimetableAttachRepository._();

  final attachRow = const TimetableAttachRowRepository._();

  /// Returns a list of [Timetable]s matching the given query parameters.
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
  Future<List<Timetable>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TimetableTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TimetableTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TimetableTable>? orderByList,
    _i1.Transaction? transaction,
    TimetableInclude? include,
  }) async {
    return session.db.find<Timetable>(
      where: where?.call(Timetable.t),
      orderBy: orderBy?.call(Timetable.t),
      orderByList: orderByList?.call(Timetable.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Timetable] matching the given query parameters.
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
  Future<Timetable?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TimetableTable>? where,
    int? offset,
    _i1.OrderByBuilder<TimetableTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TimetableTable>? orderByList,
    _i1.Transaction? transaction,
    TimetableInclude? include,
  }) async {
    return session.db.findFirstRow<Timetable>(
      where: where?.call(Timetable.t),
      orderBy: orderBy?.call(Timetable.t),
      orderByList: orderByList?.call(Timetable.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Timetable] by its [id] or null if no such row exists.
  Future<Timetable?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    TimetableInclude? include,
  }) async {
    return session.db.findById<Timetable>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Timetable]s in the list and returns the inserted rows.
  ///
  /// The returned [Timetable]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Timetable>> insert(
    _i1.Session session,
    List<Timetable> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Timetable>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Timetable] and returns the inserted row.
  ///
  /// The returned [Timetable] will have its `id` field set.
  Future<Timetable> insertRow(
    _i1.Session session,
    Timetable row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Timetable>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Timetable]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Timetable>> update(
    _i1.Session session,
    List<Timetable> rows, {
    _i1.ColumnSelections<TimetableTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Timetable>(
      rows,
      columns: columns?.call(Timetable.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Timetable]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Timetable> updateRow(
    _i1.Session session,
    Timetable row, {
    _i1.ColumnSelections<TimetableTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Timetable>(
      row,
      columns: columns?.call(Timetable.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Timetable]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Timetable>> delete(
    _i1.Session session,
    List<Timetable> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Timetable>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Timetable].
  Future<Timetable> deleteRow(
    _i1.Session session,
    Timetable row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Timetable>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Timetable>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TimetableTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Timetable>(
      where: where(Timetable.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TimetableTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Timetable>(
      where: where?.call(Timetable.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class TimetableAttachRepository {
  const TimetableAttachRepository._();

  /// Creates a relation between this [Timetable] and the given [ScheduledLesson]s
  /// by setting each [ScheduledLesson]'s foreign key `timetableId` to refer to this [Timetable].
  Future<void> scheduledLessons(
    _i1.Session session,
    Timetable timetable,
    List<_i3.ScheduledLesson> scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.any((e) => e.id == null)) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }
    if (timetable.id == null) {
      throw ArgumentError.notNull('timetable.id');
    }

    var $scheduledLesson = scheduledLesson
        .map((e) => e.copyWith(timetableId: timetable.id))
        .toList();
    await session.db.update<_i3.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i3.ScheduledLesson.t.timetableId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Timetable] and the given [TimetableSlot]s
  /// by setting each [TimetableSlot]'s foreign key `timetableId` to refer to this [Timetable].
  Future<void> timetableSlots(
    _i1.Session session,
    Timetable timetable,
    List<_i4.TimetableSlot> timetableSlot, {
    _i1.Transaction? transaction,
  }) async {
    if (timetableSlot.any((e) => e.id == null)) {
      throw ArgumentError.notNull('timetableSlot.id');
    }
    if (timetable.id == null) {
      throw ArgumentError.notNull('timetable.id');
    }

    var $timetableSlot = timetableSlot
        .map((e) => e.copyWith(timetableId: timetable.id))
        .toList();
    await session.db.update<_i4.TimetableSlot>(
      $timetableSlot,
      columns: [_i4.TimetableSlot.t.timetableId],
      transaction: transaction,
    );
  }
}

class TimetableAttachRowRepository {
  const TimetableAttachRowRepository._();

  /// Creates a relation between the given [Timetable] and [SchoolSemester]
  /// by setting the [Timetable]'s foreign key `schoolSemesterId` to refer to the [SchoolSemester].
  Future<void> schoolSemester(
    _i1.Session session,
    Timetable timetable,
    _i2.SchoolSemester schoolSemester, {
    _i1.Transaction? transaction,
  }) async {
    if (timetable.id == null) {
      throw ArgumentError.notNull('timetable.id');
    }
    if (schoolSemester.id == null) {
      throw ArgumentError.notNull('schoolSemester.id');
    }

    var $timetable = timetable.copyWith(schoolSemesterId: schoolSemester.id);
    await session.db.updateRow<Timetable>(
      $timetable,
      columns: [Timetable.t.schoolSemesterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Timetable] and the given [ScheduledLesson]
  /// by setting the [ScheduledLesson]'s foreign key `timetableId` to refer to this [Timetable].
  Future<void> scheduledLessons(
    _i1.Session session,
    Timetable timetable,
    _i3.ScheduledLesson scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.id == null) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }
    if (timetable.id == null) {
      throw ArgumentError.notNull('timetable.id');
    }

    var $scheduledLesson = scheduledLesson.copyWith(timetableId: timetable.id);
    await session.db.updateRow<_i3.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i3.ScheduledLesson.t.timetableId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Timetable] and the given [TimetableSlot]
  /// by setting the [TimetableSlot]'s foreign key `timetableId` to refer to this [Timetable].
  Future<void> timetableSlots(
    _i1.Session session,
    Timetable timetable,
    _i4.TimetableSlot timetableSlot, {
    _i1.Transaction? transaction,
  }) async {
    if (timetableSlot.id == null) {
      throw ArgumentError.notNull('timetableSlot.id');
    }
    if (timetable.id == null) {
      throw ArgumentError.notNull('timetable.id');
    }

    var $timetableSlot = timetableSlot.copyWith(timetableId: timetable.id);
    await session.db.updateRow<_i4.TimetableSlot>(
      $timetableSlot,
      columns: [_i4.TimetableSlot.t.timetableId],
      transaction: transaction,
    );
  }
}
