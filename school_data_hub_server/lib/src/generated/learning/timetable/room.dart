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
import '../../learning/timetable/lesson/scheduled_lesson.dart' as _i2;

abstract class Room implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  Room._({
    this.id,
    required this.roomCode,
    required this.roomName,
    this.scheduledLessons,
  });

  factory Room({
    int? id,
    required String roomCode,
    required String roomName,
    List<_i2.ScheduledLesson>? scheduledLessons,
  }) = _RoomImpl;

  factory Room.fromJson(Map<String, dynamic> jsonSerialization) {
    return Room(
      id: jsonSerialization['id'] as int?,
      roomCode: jsonSerialization['roomCode'] as String,
      roomName: jsonSerialization['roomName'] as String,
      scheduledLessons: (jsonSerialization['scheduledLessons'] as List?)
          ?.map(
              (e) => _i2.ScheduledLesson.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = RoomTable();

  static const db = RoomRepository._();

  @override
  int? id;

  String roomCode;

  String roomName;

  List<_i2.ScheduledLesson>? scheduledLessons;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Room copyWith({
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

  static RoomInclude include(
      {_i2.ScheduledLessonIncludeList? scheduledLessons}) {
    return RoomInclude._(scheduledLessons: scheduledLessons);
  }

  static RoomIncludeList includeList({
    _i1.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomTable>? orderByList,
    RoomInclude? include,
  }) {
    return RoomIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Room.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Room.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomImpl extends Room {
  _RoomImpl({
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

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Room copyWith({
    Object? id = _Undefined,
    String? roomCode,
    String? roomName,
    Object? scheduledLessons = _Undefined,
  }) {
    return Room(
      id: id is int? ? id : this.id,
      roomCode: roomCode ?? this.roomCode,
      roomName: roomName ?? this.roomName,
      scheduledLessons: scheduledLessons is List<_i2.ScheduledLesson>?
          ? scheduledLessons
          : this.scheduledLessons?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class RoomTable extends _i1.Table<int> {
  RoomTable({super.tableRelation}) : super(tableName: 'room') {
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
      field: Room.t.id,
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
      field: Room.t.id,
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

class RoomInclude extends _i1.IncludeObject {
  RoomInclude._({_i2.ScheduledLessonIncludeList? scheduledLessons}) {
    _scheduledLessons = scheduledLessons;
  }

  _i2.ScheduledLessonIncludeList? _scheduledLessons;

  @override
  Map<String, _i1.Include?> get includes =>
      {'scheduledLessons': _scheduledLessons};

  @override
  _i1.Table<int> get table => Room.t;
}

class RoomIncludeList extends _i1.IncludeList {
  RoomIncludeList._({
    _i1.WhereExpressionBuilder<RoomTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Room.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => Room.t;
}

class RoomRepository {
  const RoomRepository._();

  final attach = const RoomAttachRepository._();

  final attachRow = const RoomAttachRowRepository._();

  final detach = const RoomDetachRepository._();

  final detachRow = const RoomDetachRowRepository._();

  /// Returns a list of [Room]s matching the given query parameters.
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
  Future<List<Room>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomTable>? orderByList,
    _i1.Transaction? transaction,
    RoomInclude? include,
  }) async {
    return session.db.find<Room>(
      where: where?.call(Room.t),
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Room] matching the given query parameters.
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
  Future<Room?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomTable>? orderByList,
    _i1.Transaction? transaction,
    RoomInclude? include,
  }) async {
    return session.db.findFirstRow<Room>(
      where: where?.call(Room.t),
      orderBy: orderBy?.call(Room.t),
      orderByList: orderByList?.call(Room.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Room] by its [id] or null if no such row exists.
  Future<Room?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    RoomInclude? include,
  }) async {
    return session.db.findById<Room>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Room]s in the list and returns the inserted rows.
  ///
  /// The returned [Room]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Room>> insert(
    _i1.Session session,
    List<Room> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Room>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Room] and returns the inserted row.
  ///
  /// The returned [Room] will have its `id` field set.
  Future<Room> insertRow(
    _i1.Session session,
    Room row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Room>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Room]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Room>> update(
    _i1.Session session,
    List<Room> rows, {
    _i1.ColumnSelections<RoomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Room>(
      rows,
      columns: columns?.call(Room.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Room]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Room> updateRow(
    _i1.Session session,
    Room row, {
    _i1.ColumnSelections<RoomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Room>(
      row,
      columns: columns?.call(Room.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Room]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Room>> delete(
    _i1.Session session,
    List<Room> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Room>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Room].
  Future<Room> deleteRow(
    _i1.Session session,
    Room row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Room>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Room>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoomTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Room>(
      where: where(Room.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoomTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Room>(
      where: where?.call(Room.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RoomAttachRepository {
  const RoomAttachRepository._();

  /// Creates a relation between this [Room] and the given [ScheduledLesson]s
  /// by setting each [ScheduledLesson]'s foreign key `_roomScheduledlessonsRoomId` to refer to this [Room].
  Future<void> scheduledLessons(
    _i1.Session session,
    Room room,
    List<_i2.ScheduledLesson> scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.any((e) => e.id == null)) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $scheduledLesson = scheduledLesson
        .map((e) => _i2.ScheduledLessonImplicit(
              e,
              $_roomScheduledlessonsRoomId: room.id,
            ))
        .toList();
    await session.db.update<_i2.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i2.ScheduledLesson.t.$_roomScheduledlessonsRoomId],
      transaction: transaction,
    );
  }
}

class RoomAttachRowRepository {
  const RoomAttachRowRepository._();

  /// Creates a relation between this [Room] and the given [ScheduledLesson]
  /// by setting the [ScheduledLesson]'s foreign key `_roomScheduledlessonsRoomId` to refer to this [Room].
  Future<void> scheduledLessons(
    _i1.Session session,
    Room room,
    _i2.ScheduledLesson scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.id == null) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $scheduledLesson = _i2.ScheduledLessonImplicit(
      scheduledLesson,
      $_roomScheduledlessonsRoomId: room.id,
    );
    await session.db.updateRow<_i2.ScheduledLesson>(
      $scheduledLesson,
      columns: [_i2.ScheduledLesson.t.$_roomScheduledlessonsRoomId],
      transaction: transaction,
    );
  }
}

class RoomDetachRepository {
  const RoomDetachRepository._();

  /// Detaches the relation between this [Room] and the given [ScheduledLesson]
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

class RoomDetachRowRepository {
  const RoomDetachRowRepository._();

  /// Detaches the relation between this [Room] and the given [ScheduledLesson]
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
