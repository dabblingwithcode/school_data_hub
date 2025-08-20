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
import '../../../_features/timetable/models/scheduled_lesson.dart' as _i2;

abstract class Classroom
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Classroom._({
    this.id,
    required this.roomCode,
    required this.roomName,
    this.scheduledLessons,
  });

  factory Classroom({
    int? id,
    required String roomCode,
    required String roomName,
    List<_i2.ScheduledLesson>? scheduledLessons,
  }) = _ClassroomImpl;

  factory Classroom.fromJson(Map<String, dynamic> jsonSerialization) {
    return Classroom(
      id: jsonSerialization['id'] as int?,
      roomCode: jsonSerialization['roomCode'] as String,
      roomName: jsonSerialization['roomName'] as String,
      scheduledLessons: (jsonSerialization['scheduledLessons'] as List?)
          ?.map(
              (e) => _i2.ScheduledLesson.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = ClassroomTable();

  static const db = ClassroomRepository._();

  @override
  int? id;

  String roomCode;

  String roomName;

  List<_i2.ScheduledLesson>? scheduledLessons;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Classroom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Classroom copyWith({
    int? id,
    String? roomCode,
    String? roomName,
    List<_i2.ScheduledLesson>? scheduledLessons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomCode': roomCode,
      'roomName': roomName,
      if (scheduledLessons != null)
        'scheduledLessons':
            scheduledLessons?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'roomCode': roomCode,
      'roomName': roomName,
      if (scheduledLessons != null)
        'scheduledLessons':
            scheduledLessons?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static ClassroomInclude include(
      {_i2.ScheduledLessonIncludeList? scheduledLessons}) {
    return ClassroomInclude._(scheduledLessons: scheduledLessons);
  }

  static ClassroomIncludeList includeList({
    _i1.WhereExpressionBuilder<ClassroomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassroomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassroomTable>? orderByList,
    ClassroomInclude? include,
  }) {
    return ClassroomIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Classroom.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Classroom.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassroomImpl extends Classroom {
  _ClassroomImpl({
    int? id,
    required String roomCode,
    required String roomName,
    List<_i2.ScheduledLesson>? scheduledLessons,
  }) : super._(
          id: id,
          roomCode: roomCode,
          roomName: roomName,
          scheduledLessons: scheduledLessons,
        );

  /// Returns a shallow copy of this [Classroom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Classroom copyWith({
    Object? id = _Undefined,
    String? roomCode,
    String? roomName,
    Object? scheduledLessons = _Undefined,
  }) {
    return Classroom(
      id: id is int? ? id : this.id,
      roomCode: roomCode ?? this.roomCode,
      roomName: roomName ?? this.roomName,
      scheduledLessons: scheduledLessons is List<_i2.ScheduledLesson>?
          ? scheduledLessons
          : this.scheduledLessons?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class ClassroomTable extends _i1.Table<int?> {
  ClassroomTable({super.tableRelation}) : super(tableName: 'room') {
    roomCode = _i1.ColumnString(
      'roomCode',
      this,
    );
    roomName = _i1.ColumnString(
      'roomName',
      this,
    );
  }

  late final _i1.ColumnString roomCode;

  late final _i1.ColumnString roomName;

  _i2.ScheduledLessonTable? ___scheduledLessons;

  _i1.ManyRelation<_i2.ScheduledLessonTable>? _scheduledLessons;

  _i2.ScheduledLessonTable get __scheduledLessons {
    if (___scheduledLessons != null) return ___scheduledLessons!;
    ___scheduledLessons = _i1.createRelationTable(
      relationFieldName: '__scheduledLessons',
      field: Classroom.t.id,
      foreignField: _i2.ScheduledLesson.t.$_roomScheduledlessonsRoomId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ScheduledLessonTable(tableRelation: foreignTableRelation),
    );
    return ___scheduledLessons!;
  }

  _i1.ManyRelation<_i2.ScheduledLessonTable> get scheduledLessons {
    if (_scheduledLessons != null) return _scheduledLessons!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'scheduledLessons',
      field: Classroom.t.id,
      foreignField: _i2.ScheduledLesson.t.$_roomScheduledlessonsRoomId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ScheduledLessonTable(tableRelation: foreignTableRelation),
    );
    _scheduledLessons = _i1.ManyRelation<_i2.ScheduledLessonTable>(
      tableWithRelations: relationTable,
      table: _i2.ScheduledLessonTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _scheduledLessons!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        roomCode,
        roomName,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'scheduledLessons') {
      return __scheduledLessons;
    }
    return null;
  }
}

class ClassroomInclude extends _i1.IncludeObject {
  ClassroomInclude._({_i2.ScheduledLessonIncludeList? scheduledLessons}) {
    _scheduledLessons = scheduledLessons;
  }

  _i2.ScheduledLessonIncludeList? _scheduledLessons;

  @override
  Map<String, _i1.Include?> get includes =>
      {'scheduledLessons': _scheduledLessons};

  @override
  _i1.Table<int?> get table => Classroom.t;
}

class ClassroomIncludeList extends _i1.IncludeList {
  ClassroomIncludeList._({
    _i1.WhereExpressionBuilder<ClassroomTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Classroom.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Classroom.t;
}

class ClassroomRepository {
  const ClassroomRepository._();

  final attach = const ClassroomAttachRepository._();

  final attachRow = const ClassroomAttachRowRepository._();

  final detach = const ClassroomDetachRepository._();

  final detachRow = const ClassroomDetachRowRepository._();

  /// Returns a list of [Classroom]s matching the given query parameters.
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
  Future<List<Classroom>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassroomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClassroomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassroomTable>? orderByList,
    _i1.Transaction? transaction,
    ClassroomInclude? include,
  }) async {
    return session.db.find<Classroom>(
      where: where?.call(Classroom.t),
      orderBy: orderBy?.call(Classroom.t),
      orderByList: orderByList?.call(Classroom.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Classroom] matching the given query parameters.
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
  Future<Classroom?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassroomTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClassroomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClassroomTable>? orderByList,
    _i1.Transaction? transaction,
    ClassroomInclude? include,
  }) async {
    return session.db.findFirstRow<Classroom>(
      where: where?.call(Classroom.t),
      orderBy: orderBy?.call(Classroom.t),
      orderByList: orderByList?.call(Classroom.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Classroom] by its [id] or null if no such row exists.
  Future<Classroom?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ClassroomInclude? include,
  }) async {
    return session.db.findById<Classroom>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Classroom]s in the list and returns the inserted rows.
  ///
  /// The returned [Classroom]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Classroom>> insert(
    _i1.Session session,
    List<Classroom> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Classroom>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Classroom] and returns the inserted row.
  ///
  /// The returned [Classroom] will have its `id` field set.
  Future<Classroom> insertRow(
    _i1.Session session,
    Classroom row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Classroom>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Classroom]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Classroom>> update(
    _i1.Session session,
    List<Classroom> rows, {
    _i1.ColumnSelections<ClassroomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Classroom>(
      rows,
      columns: columns?.call(Classroom.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Classroom]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Classroom> updateRow(
    _i1.Session session,
    Classroom row, {
    _i1.ColumnSelections<ClassroomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Classroom>(
      row,
      columns: columns?.call(Classroom.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Classroom]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Classroom>> delete(
    _i1.Session session,
    List<Classroom> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Classroom>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Classroom].
  Future<Classroom> deleteRow(
    _i1.Session session,
    Classroom row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Classroom>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Classroom>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClassroomTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Classroom>(
      where: where(Classroom.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClassroomTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Classroom>(
      where: where?.call(Classroom.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ClassroomAttachRepository {
  const ClassroomAttachRepository._();

  /// Creates a relation between this [Classroom] and the given [ScheduledLesson]s
  /// by setting each [ScheduledLesson]'s foreign key `_roomScheduledlessonsRoomId` to refer to this [Classroom].
  Future<void> scheduledLessons(
    _i1.Session session,
    Classroom classroom,
    List<_i2.ScheduledLesson> scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.any((e) => e.id == null)) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }
    if (classroom.id == null) {
      throw ArgumentError.notNull('classroom.id');
    }

    var $scheduledLesson = scheduledLesson
        .map((e) => _i2.ScheduledLessonImplicit(
              e,
              $_roomScheduledlessonsRoomId: classroom.id,
            ))
        .toList();
    await session.db.update<_i2.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i2.ScheduledLesson.t.$_roomScheduledlessonsRoomId],
      transaction: transaction,
    );
  }
}

class ClassroomAttachRowRepository {
  const ClassroomAttachRowRepository._();

  /// Creates a relation between this [Classroom] and the given [ScheduledLesson]
  /// by setting the [ScheduledLesson]'s foreign key `_roomScheduledlessonsRoomId` to refer to this [Classroom].
  Future<void> scheduledLessons(
    _i1.Session session,
    Classroom classroom,
    _i2.ScheduledLesson scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.id == null) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }
    if (classroom.id == null) {
      throw ArgumentError.notNull('classroom.id');
    }

    var $scheduledLesson = _i2.ScheduledLessonImplicit(
      scheduledLesson,
      $_roomScheduledlessonsRoomId: classroom.id,
    );
    await session.db.updateRow<_i2.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i2.ScheduledLesson.t.$_roomScheduledlessonsRoomId],
      transaction: transaction,
    );
  }
}

class ClassroomDetachRepository {
  const ClassroomDetachRepository._();

  /// Detaches the relation between this [Classroom] and the given [ScheduledLesson]
  /// by setting the [ScheduledLesson]'s foreign key `_roomScheduledlessonsRoomId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> scheduledLessons(
    _i1.Session session,
    List<_i2.ScheduledLesson> scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.any((e) => e.id == null)) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }

    var $scheduledLesson = scheduledLesson
        .map((e) => _i2.ScheduledLessonImplicit(
              e,
              $_roomScheduledlessonsRoomId: null,
            ))
        .toList();
    await session.db.update<_i2.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i2.ScheduledLesson.t.$_roomScheduledlessonsRoomId],
      transaction: transaction,
    );
  }
}

class ClassroomDetachRowRepository {
  const ClassroomDetachRowRepository._();

  /// Detaches the relation between this [Classroom] and the given [ScheduledLesson]
  /// by setting the [ScheduledLesson]'s foreign key `_roomScheduledlessonsRoomId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> scheduledLessons(
    _i1.Session session,
    _i2.ScheduledLesson scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.id == null) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }

    var $scheduledLesson = _i2.ScheduledLessonImplicit(
      scheduledLesson,
      $_roomScheduledlessonsRoomId: null,
    );
    await session.db.updateRow<_i2.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i2.ScheduledLesson.t.$_roomScheduledlessonsRoomId],
      transaction: transaction,
    );
  }
}
