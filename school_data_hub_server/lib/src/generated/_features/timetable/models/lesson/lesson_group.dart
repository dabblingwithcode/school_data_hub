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
import '../../../../_features/timetable/models/timetable.dart' as _i2;
import '../../../../_features/timetable/models/scheduled_lesson/scheduled_lesson.dart'
    as _i3;
import '../../../../_features/timetable/models/scheduled_lesson/lesson_group_membership.dart'
    as _i4;

abstract class LessonGroup
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LessonGroup._({
    this.id,
    required this.publicId,
    required this.name,
    this.color,
    required this.timetableId,
    this.timetable,
    required this.createdBy,
    required this.createdAt,
    this.modifiedBy,
    this.modifiedAt,
    this.scheduledLessons,
    this.memberships,
  });

  factory LessonGroup({
    int? id,
    required String publicId,
    required String name,
    String? color,
    required int timetableId,
    _i2.Timetable? timetable,
    required String createdBy,
    required DateTime createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
    List<_i3.ScheduledLesson>? scheduledLessons,
    List<_i4.ScheduledLessonGroupMembership>? memberships,
  }) = _LessonGroupImpl;

  factory LessonGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return LessonGroup(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as String,
      name: jsonSerialization['name'] as String,
      color: jsonSerialization['color'] as String?,
      timetableId: jsonSerialization['timetableId'] as int,
      timetable: jsonSerialization['timetable'] == null
          ? null
          : _i2.Timetable.fromJson(
              (jsonSerialization['timetable'] as Map<String, dynamic>)),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      modifiedBy: jsonSerialization['modifiedBy'] as String?,
      modifiedAt: jsonSerialization['modifiedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['modifiedAt']),
      scheduledLessons: (jsonSerialization['scheduledLessons'] as List?)
          ?.map(
              (e) => _i3.ScheduledLesson.fromJson((e as Map<String, dynamic>)))
          .toList(),
      memberships: (jsonSerialization['memberships'] as List?)
          ?.map((e) => _i4.ScheduledLessonGroupMembership.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = LessonGroupTable();

  static const db = LessonGroupRepository._();

  @override
  int? id;

  String publicId;

  String name;

  String? color;

  int timetableId;

  _i2.Timetable? timetable;

  String createdBy;

  DateTime createdAt;

  String? modifiedBy;

  DateTime? modifiedAt;

  List<_i3.ScheduledLesson>? scheduledLessons;

  List<_i4.ScheduledLessonGroupMembership>? memberships;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LessonGroup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LessonGroup copyWith({
    int? id,
    String? publicId,
    String? name,
    String? color,
    int? timetableId,
    _i2.Timetable? timetable,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
    List<_i3.ScheduledLesson>? scheduledLessons,
    List<_i4.ScheduledLessonGroupMembership>? memberships,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      'name': name,
      if (color != null) 'color': color,
      'timetableId': timetableId,
      if (timetable != null) 'timetable': timetable?.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (modifiedBy != null) 'modifiedBy': modifiedBy,
      if (modifiedAt != null) 'modifiedAt': modifiedAt?.toJson(),
      if (scheduledLessons != null)
        'scheduledLessons':
            scheduledLessons?.toJson(valueToJson: (v) => v.toJson()),
      if (memberships != null)
        'memberships': memberships?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      'name': name,
      if (color != null) 'color': color,
      'timetableId': timetableId,
      if (timetable != null) 'timetable': timetable?.toJsonForProtocol(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (modifiedBy != null) 'modifiedBy': modifiedBy,
      if (modifiedAt != null) 'modifiedAt': modifiedAt?.toJson(),
      if (scheduledLessons != null)
        'scheduledLessons':
            scheduledLessons?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (memberships != null)
        'memberships':
            memberships?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static LessonGroupInclude include({
    _i2.TimetableInclude? timetable,
    _i3.ScheduledLessonIncludeList? scheduledLessons,
    _i4.ScheduledLessonGroupMembershipIncludeList? memberships,
  }) {
    return LessonGroupInclude._(
      timetable: timetable,
      scheduledLessons: scheduledLessons,
      memberships: memberships,
    );
  }

  static LessonGroupIncludeList includeList({
    _i1.WhereExpressionBuilder<LessonGroupTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonGroupTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonGroupTable>? orderByList,
    LessonGroupInclude? include,
  }) {
    return LessonGroupIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LessonGroup.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LessonGroup.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LessonGroupImpl extends LessonGroup {
  _LessonGroupImpl({
    int? id,
    required String publicId,
    required String name,
    String? color,
    required int timetableId,
    _i2.Timetable? timetable,
    required String createdBy,
    required DateTime createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
    List<_i3.ScheduledLesson>? scheduledLessons,
    List<_i4.ScheduledLessonGroupMembership>? memberships,
  }) : super._(
          id: id,
          publicId: publicId,
          name: name,
          color: color,
          timetableId: timetableId,
          timetable: timetable,
          createdBy: createdBy,
          createdAt: createdAt,
          modifiedBy: modifiedBy,
          modifiedAt: modifiedAt,
          scheduledLessons: scheduledLessons,
          memberships: memberships,
        );

  /// Returns a shallow copy of this [LessonGroup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LessonGroup copyWith({
    Object? id = _Undefined,
    String? publicId,
    String? name,
    Object? color = _Undefined,
    int? timetableId,
    Object? timetable = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    Object? modifiedBy = _Undefined,
    Object? modifiedAt = _Undefined,
    Object? scheduledLessons = _Undefined,
    Object? memberships = _Undefined,
  }) {
    return LessonGroup(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      color: color is String? ? color : this.color,
      timetableId: timetableId ?? this.timetableId,
      timetable:
          timetable is _i2.Timetable? ? timetable : this.timetable?.copyWith(),
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedBy: modifiedBy is String? ? modifiedBy : this.modifiedBy,
      modifiedAt: modifiedAt is DateTime? ? modifiedAt : this.modifiedAt,
      scheduledLessons: scheduledLessons is List<_i3.ScheduledLesson>?
          ? scheduledLessons
          : this.scheduledLessons?.map((e0) => e0.copyWith()).toList(),
      memberships: memberships is List<_i4.ScheduledLessonGroupMembership>?
          ? memberships
          : this.memberships?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class LessonGroupTable extends _i1.Table<int?> {
  LessonGroupTable({super.tableRelation}) : super(tableName: 'lesson_group') {
    publicId = _i1.ColumnString(
      'publicId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    color = _i1.ColumnString(
      'color',
      this,
    );
    timetableId = _i1.ColumnInt(
      'timetableId',
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
    modifiedBy = _i1.ColumnString(
      'modifiedBy',
      this,
    );
    modifiedAt = _i1.ColumnDateTime(
      'modifiedAt',
      this,
    );
  }

  late final _i1.ColumnString publicId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString color;

  late final _i1.ColumnInt timetableId;

  _i2.TimetableTable? _timetable;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString modifiedBy;

  late final _i1.ColumnDateTime modifiedAt;

  _i3.ScheduledLessonTable? ___scheduledLessons;

  _i1.ManyRelation<_i3.ScheduledLessonTable>? _scheduledLessons;

  _i4.ScheduledLessonGroupMembershipTable? ___memberships;

  _i1.ManyRelation<_i4.ScheduledLessonGroupMembershipTable>? _memberships;

  _i2.TimetableTable get timetable {
    if (_timetable != null) return _timetable!;
    _timetable = _i1.createRelationTable(
      relationFieldName: 'timetable',
      field: LessonGroup.t.timetableId,
      foreignField: _i2.Timetable.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TimetableTable(tableRelation: foreignTableRelation),
    );
    return _timetable!;
  }

  _i3.ScheduledLessonTable get __scheduledLessons {
    if (___scheduledLessons != null) return ___scheduledLessons!;
    ___scheduledLessons = _i1.createRelationTable(
      relationFieldName: '__scheduledLessons',
      field: LessonGroup.t.id,
      foreignField: _i3.ScheduledLesson.t.lessonGroupId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ScheduledLessonTable(tableRelation: foreignTableRelation),
    );
    return ___scheduledLessons!;
  }

  _i4.ScheduledLessonGroupMembershipTable get __memberships {
    if (___memberships != null) return ___memberships!;
    ___memberships = _i1.createRelationTable(
      relationFieldName: '__memberships',
      field: LessonGroup.t.id,
      foreignField: _i4.ScheduledLessonGroupMembership.t.lessonGroupId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ScheduledLessonGroupMembershipTable(
              tableRelation: foreignTableRelation),
    );
    return ___memberships!;
  }

  _i1.ManyRelation<_i3.ScheduledLessonTable> get scheduledLessons {
    if (_scheduledLessons != null) return _scheduledLessons!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'scheduledLessons',
      field: LessonGroup.t.id,
      foreignField: _i3.ScheduledLesson.t.lessonGroupId,
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

  _i1.ManyRelation<_i4.ScheduledLessonGroupMembershipTable> get memberships {
    if (_memberships != null) return _memberships!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'memberships',
      field: LessonGroup.t.id,
      foreignField: _i4.ScheduledLessonGroupMembership.t.lessonGroupId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ScheduledLessonGroupMembershipTable(
              tableRelation: foreignTableRelation),
    );
    _memberships = _i1.ManyRelation<_i4.ScheduledLessonGroupMembershipTable>(
      tableWithRelations: relationTable,
      table: _i4.ScheduledLessonGroupMembershipTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _memberships!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        publicId,
        name,
        color,
        timetableId,
        createdBy,
        createdAt,
        modifiedBy,
        modifiedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'timetable') {
      return timetable;
    }
    if (relationField == 'scheduledLessons') {
      return __scheduledLessons;
    }
    if (relationField == 'memberships') {
      return __memberships;
    }
    return null;
  }
}

class LessonGroupInclude extends _i1.IncludeObject {
  LessonGroupInclude._({
    _i2.TimetableInclude? timetable,
    _i3.ScheduledLessonIncludeList? scheduledLessons,
    _i4.ScheduledLessonGroupMembershipIncludeList? memberships,
  }) {
    _timetable = timetable;
    _scheduledLessons = scheduledLessons;
    _memberships = memberships;
  }

  _i2.TimetableInclude? _timetable;

  _i3.ScheduledLessonIncludeList? _scheduledLessons;

  _i4.ScheduledLessonGroupMembershipIncludeList? _memberships;

  @override
  Map<String, _i1.Include?> get includes => {
        'timetable': _timetable,
        'scheduledLessons': _scheduledLessons,
        'memberships': _memberships,
      };

  @override
  _i1.Table<int?> get table => LessonGroup.t;
}

class LessonGroupIncludeList extends _i1.IncludeList {
  LessonGroupIncludeList._({
    _i1.WhereExpressionBuilder<LessonGroupTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LessonGroup.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LessonGroup.t;
}

class LessonGroupRepository {
  const LessonGroupRepository._();

  final attach = const LessonGroupAttachRepository._();

  final attachRow = const LessonGroupAttachRowRepository._();

  final detach = const LessonGroupDetachRepository._();

  final detachRow = const LessonGroupDetachRowRepository._();

  /// Returns a list of [LessonGroup]s matching the given query parameters.
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
  Future<List<LessonGroup>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonGroupTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonGroupTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonGroupTable>? orderByList,
    _i1.Transaction? transaction,
    LessonGroupInclude? include,
  }) async {
    return session.db.find<LessonGroup>(
      where: where?.call(LessonGroup.t),
      orderBy: orderBy?.call(LessonGroup.t),
      orderByList: orderByList?.call(LessonGroup.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [LessonGroup] matching the given query parameters.
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
  Future<LessonGroup?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonGroupTable>? where,
    int? offset,
    _i1.OrderByBuilder<LessonGroupTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonGroupTable>? orderByList,
    _i1.Transaction? transaction,
    LessonGroupInclude? include,
  }) async {
    return session.db.findFirstRow<LessonGroup>(
      where: where?.call(LessonGroup.t),
      orderBy: orderBy?.call(LessonGroup.t),
      orderByList: orderByList?.call(LessonGroup.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [LessonGroup] by its [id] or null if no such row exists.
  Future<LessonGroup?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    LessonGroupInclude? include,
  }) async {
    return session.db.findById<LessonGroup>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [LessonGroup]s in the list and returns the inserted rows.
  ///
  /// The returned [LessonGroup]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LessonGroup>> insert(
    _i1.Session session,
    List<LessonGroup> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LessonGroup>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LessonGroup] and returns the inserted row.
  ///
  /// The returned [LessonGroup] will have its `id` field set.
  Future<LessonGroup> insertRow(
    _i1.Session session,
    LessonGroup row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LessonGroup>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LessonGroup]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LessonGroup>> update(
    _i1.Session session,
    List<LessonGroup> rows, {
    _i1.ColumnSelections<LessonGroupTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LessonGroup>(
      rows,
      columns: columns?.call(LessonGroup.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LessonGroup]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LessonGroup> updateRow(
    _i1.Session session,
    LessonGroup row, {
    _i1.ColumnSelections<LessonGroupTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LessonGroup>(
      row,
      columns: columns?.call(LessonGroup.t),
      transaction: transaction,
    );
  }

  /// Deletes all [LessonGroup]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LessonGroup>> delete(
    _i1.Session session,
    List<LessonGroup> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LessonGroup>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LessonGroup].
  Future<LessonGroup> deleteRow(
    _i1.Session session,
    LessonGroup row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LessonGroup>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LessonGroup>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LessonGroupTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LessonGroup>(
      where: where(LessonGroup.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonGroupTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LessonGroup>(
      where: where?.call(LessonGroup.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class LessonGroupAttachRepository {
  const LessonGroupAttachRepository._();

  /// Creates a relation between this [LessonGroup] and the given [ScheduledLesson]s
  /// by setting each [ScheduledLesson]'s foreign key `lessonGroupId` to refer to this [LessonGroup].
  Future<void> scheduledLessons(
    _i1.Session session,
    LessonGroup lessonGroup,
    List<_i3.ScheduledLesson> scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.any((e) => e.id == null)) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }
    if (lessonGroup.id == null) {
      throw ArgumentError.notNull('lessonGroup.id');
    }

    var $scheduledLesson = scheduledLesson
        .map((e) => e.copyWith(lessonGroupId: lessonGroup.id))
        .toList();
    await session.db.update<_i3.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i3.ScheduledLesson.t.lessonGroupId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [LessonGroup] and the given [ScheduledLessonGroupMembership]s
  /// by setting each [ScheduledLessonGroupMembership]'s foreign key `lessonGroupId` to refer to this [LessonGroup].
  Future<void> memberships(
    _i1.Session session,
    LessonGroup lessonGroup,
    List<_i4.ScheduledLessonGroupMembership> scheduledLessonGroupMembership, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLessonGroupMembership.any((e) => e.id == null)) {
      throw ArgumentError.notNull('scheduledLessonGroupMembership.id');
    }
    if (lessonGroup.id == null) {
      throw ArgumentError.notNull('lessonGroup.id');
    }

    var $scheduledLessonGroupMembership = scheduledLessonGroupMembership
        .map((e) => e.copyWith(lessonGroupId: lessonGroup.id))
        .toList();
    await session.db.update<_i4.ScheduledLessonGroupMembership>(
      $scheduledLessonGroupMembership,
      columns: [_i4.ScheduledLessonGroupMembership.t.lessonGroupId],
      transaction: transaction,
    );
  }
}

class LessonGroupAttachRowRepository {
  const LessonGroupAttachRowRepository._();

  /// Creates a relation between the given [LessonGroup] and [Timetable]
  /// by setting the [LessonGroup]'s foreign key `timetableId` to refer to the [Timetable].
  Future<void> timetable(
    _i1.Session session,
    LessonGroup lessonGroup,
    _i2.Timetable timetable, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonGroup.id == null) {
      throw ArgumentError.notNull('lessonGroup.id');
    }
    if (timetable.id == null) {
      throw ArgumentError.notNull('timetable.id');
    }

    var $lessonGroup = lessonGroup.copyWith(timetableId: timetable.id);
    await session.db.updateRow<LessonGroup>(
      $lessonGroup,
      columns: [LessonGroup.t.timetableId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [LessonGroup] and the given [ScheduledLesson]
  /// by setting the [ScheduledLesson]'s foreign key `lessonGroupId` to refer to this [LessonGroup].
  Future<void> scheduledLessons(
    _i1.Session session,
    LessonGroup lessonGroup,
    _i3.ScheduledLesson scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.id == null) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }
    if (lessonGroup.id == null) {
      throw ArgumentError.notNull('lessonGroup.id');
    }

    var $scheduledLesson =
        scheduledLesson.copyWith(lessonGroupId: lessonGroup.id);
    await session.db.updateRow<_i3.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i3.ScheduledLesson.t.lessonGroupId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [LessonGroup] and the given [ScheduledLessonGroupMembership]
  /// by setting the [ScheduledLessonGroupMembership]'s foreign key `lessonGroupId` to refer to this [LessonGroup].
  Future<void> memberships(
    _i1.Session session,
    LessonGroup lessonGroup,
    _i4.ScheduledLessonGroupMembership scheduledLessonGroupMembership, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLessonGroupMembership.id == null) {
      throw ArgumentError.notNull('scheduledLessonGroupMembership.id');
    }
    if (lessonGroup.id == null) {
      throw ArgumentError.notNull('lessonGroup.id');
    }

    var $scheduledLessonGroupMembership =
        scheduledLessonGroupMembership.copyWith(lessonGroupId: lessonGroup.id);
    await session.db.updateRow<_i4.ScheduledLessonGroupMembership>(
      $scheduledLessonGroupMembership,
      columns: [_i4.ScheduledLessonGroupMembership.t.lessonGroupId],
      transaction: transaction,
    );
  }
}

class LessonGroupDetachRepository {
  const LessonGroupDetachRepository._();

  /// Detaches the relation between this [LessonGroup] and the given [ScheduledLesson]
  /// by setting the [ScheduledLesson]'s foreign key `lessonGroupId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> scheduledLessons(
    _i1.Session session,
    List<_i3.ScheduledLesson> scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.any((e) => e.id == null)) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }

    var $scheduledLesson =
        scheduledLesson.map((e) => e.copyWith(lessonGroupId: null)).toList();
    await session.db.update<_i3.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i3.ScheduledLesson.t.lessonGroupId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [LessonGroup] and the given [ScheduledLessonGroupMembership]
  /// by setting the [ScheduledLessonGroupMembership]'s foreign key `lessonGroupId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> memberships(
    _i1.Session session,
    List<_i4.ScheduledLessonGroupMembership> scheduledLessonGroupMembership, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLessonGroupMembership.any((e) => e.id == null)) {
      throw ArgumentError.notNull('scheduledLessonGroupMembership.id');
    }

    var $scheduledLessonGroupMembership = scheduledLessonGroupMembership
        .map((e) => e.copyWith(lessonGroupId: null))
        .toList();
    await session.db.update<_i4.ScheduledLessonGroupMembership>(
      $scheduledLessonGroupMembership,
      columns: [_i4.ScheduledLessonGroupMembership.t.lessonGroupId],
      transaction: transaction,
    );
  }
}

class LessonGroupDetachRowRepository {
  const LessonGroupDetachRowRepository._();

  /// Detaches the relation between this [LessonGroup] and the given [ScheduledLesson]
  /// by setting the [ScheduledLesson]'s foreign key `lessonGroupId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> scheduledLessons(
    _i1.Session session,
    _i3.ScheduledLesson scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.id == null) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }

    var $scheduledLesson = scheduledLesson.copyWith(lessonGroupId: null);
    await session.db.updateRow<_i3.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i3.ScheduledLesson.t.lessonGroupId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [LessonGroup] and the given [ScheduledLessonGroupMembership]
  /// by setting the [ScheduledLessonGroupMembership]'s foreign key `lessonGroupId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> memberships(
    _i1.Session session,
    _i4.ScheduledLessonGroupMembership scheduledLessonGroupMembership, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLessonGroupMembership.id == null) {
      throw ArgumentError.notNull('scheduledLessonGroupMembership.id');
    }

    var $scheduledLessonGroupMembership =
        scheduledLessonGroupMembership.copyWith(lessonGroupId: null);
    await session.db.updateRow<_i4.ScheduledLessonGroupMembership>(
      $scheduledLessonGroupMembership,
      columns: [_i4.ScheduledLessonGroupMembership.t.lessonGroupId],
      transaction: transaction,
    );
  }
}
