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
import '../../../learning/timetable/lesson/subject.dart' as _i2;
import '../../../learning/timetable/lesson/timetable_slot.dart' as _i3;
import '../../../learning/timetable/room.dart' as _i4;
import '../../../learning/timetable/lesson/lesson_group.dart' as _i5;
import 'package:school_data_hub_server/src/generated/protocol.dart' as _i6;

abstract class ScheduledLesson
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ScheduledLesson._({
    this.id,
    required this.active,
    required this.publicId,
    required this.subjectId,
    this.subject,
    required this.scheduledAtId,
    this.scheduledAt,
    required this.lessonId,
    required this.roomId,
    this.room,
    required this.lessonGroupId,
    this.lessonGroup,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
    this.recordtest,
  }) : _roomScheduledlessonsRoomId = null;

  factory ScheduledLesson({
    int? id,
    required bool active,
    required String publicId,
    required int subjectId,
    _i2.Subject? subject,
    required int scheduledAtId,
    _i3.TimetableSlot? scheduledAt,
    required String lessonId,
    required int roomId,
    _i4.Room? room,
    required int lessonGroupId,
    _i5.LessonGroup? lessonGroup,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required DateTime modifiedAt,
    ({int testint, String testString})? recordtest,
  }) = _ScheduledLessonImpl;

  factory ScheduledLesson.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScheduledLessonImplicit._(
      id: jsonSerialization['id'] as int?,
      active: jsonSerialization['active'] as bool,
      publicId: jsonSerialization['publicId'] as String,
      subjectId: jsonSerialization['subjectId'] as int,
      subject: jsonSerialization['subject'] == null
          ? null
          : _i2.Subject.fromJson(
              (jsonSerialization['subject'] as Map<String, dynamic>)),
      scheduledAtId: jsonSerialization['scheduledAtId'] as int,
      scheduledAt: jsonSerialization['scheduledAt'] == null
          ? null
          : _i3.TimetableSlot.fromJson(
              (jsonSerialization['scheduledAt'] as Map<String, dynamic>)),
      lessonId: jsonSerialization['lessonId'] as String,
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _i4.Room.fromJson(
              (jsonSerialization['room'] as Map<String, dynamic>)),
      lessonGroupId: jsonSerialization['lessonGroupId'] as int,
      lessonGroup: jsonSerialization['lessonGroup'] == null
          ? null
          : _i5.LessonGroup.fromJson(
              (jsonSerialization['lessonGroup'] as Map<String, dynamic>)),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      modifiedBy: jsonSerialization['modifiedBy'] as String,
      modifiedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['modifiedAt']),
      recordtest: jsonSerialization['recordtest'] == null
          ? null
          : _i6.Protocol().deserialize<({int testint, String testString})?>(
              (jsonSerialization['recordtest'] as Map<String, dynamic>)),
      $_roomScheduledlessonsRoomId:
          jsonSerialization['_roomScheduledlessonsRoomId'] as int?,
    );
  }

  static final t = ScheduledLessonTable();

  static const db = ScheduledLessonRepository._();

  @override
  int? id;

  bool active;

  String publicId;

  int subjectId;

  _i2.Subject? subject;

  int scheduledAtId;

  _i3.TimetableSlot? scheduledAt;

  String lessonId;

  int roomId;

  _i4.Room? room;

  int lessonGroupId;

  _i5.LessonGroup? lessonGroup;

  String createdBy;

  DateTime createdAt;

  String modifiedBy;

  DateTime modifiedAt;

  ({int testint, String testString})? recordtest;

  final int? _roomScheduledlessonsRoomId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ScheduledLesson]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduledLesson copyWith({
    int? id,
    bool? active,
    String? publicId,
    int? subjectId,
    _i2.Subject? subject,
    int? scheduledAtId,
    _i3.TimetableSlot? scheduledAt,
    String? lessonId,
    int? roomId,
    _i4.Room? room,
    int? lessonGroupId,
    _i5.LessonGroup? lessonGroup,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
    ({int testint, String testString})? recordtest,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'active': active,
      'publicId': publicId,
      'subjectId': subjectId,
      if (subject != null) 'subject': subject?.toJson(),
      'scheduledAtId': scheduledAtId,
      if (scheduledAt != null) 'scheduledAt': scheduledAt?.toJson(),
      'lessonId': lessonId,
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
      'lessonGroupId': lessonGroupId,
      if (lessonGroup != null) 'lessonGroup': lessonGroup?.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      'modifiedAt': modifiedAt.toJson(),
      if (recordtest != null) 'recordtest': _i6.mapRecordToJson(recordtest),
      if (_roomScheduledlessonsRoomId != null)
        '_roomScheduledlessonsRoomId': _roomScheduledlessonsRoomId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'active': active,
      'publicId': publicId,
      'subjectId': subjectId,
      if (subject != null) 'subject': subject?.toJsonForProtocol(),
      'scheduledAtId': scheduledAtId,
      if (scheduledAt != null) 'scheduledAt': scheduledAt?.toJsonForProtocol(),
      'lessonId': lessonId,
      'roomId': roomId,
      if (room != null) 'room': room?.toJsonForProtocol(),
      'lessonGroupId': lessonGroupId,
      if (lessonGroup != null) 'lessonGroup': lessonGroup?.toJsonForProtocol(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      'modifiedAt': modifiedAt.toJson(),
      if (recordtest != null) 'recordtest': _i6.mapRecordToJson(recordtest),
    };
  }

  static ScheduledLessonInclude include({
    _i2.SubjectInclude? subject,
    _i3.TimetableSlotInclude? scheduledAt,
    _i4.RoomInclude? room,
    _i5.LessonGroupInclude? lessonGroup,
  }) {
    return ScheduledLessonInclude._(
      subject: subject,
      scheduledAt: scheduledAt,
      room: room,
      lessonGroup: lessonGroup,
    );
  }

  static ScheduledLessonIncludeList includeList({
    _i1.WhereExpressionBuilder<ScheduledLessonTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledLessonTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledLessonTable>? orderByList,
    ScheduledLessonInclude? include,
  }) {
    return ScheduledLessonIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScheduledLesson.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ScheduledLesson.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScheduledLessonImpl extends ScheduledLesson {
  _ScheduledLessonImpl({
    int? id,
    required bool active,
    required String publicId,
    required int subjectId,
    _i2.Subject? subject,
    required int scheduledAtId,
    _i3.TimetableSlot? scheduledAt,
    required String lessonId,
    required int roomId,
    _i4.Room? room,
    required int lessonGroupId,
    _i5.LessonGroup? lessonGroup,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required DateTime modifiedAt,
    ({int testint, String testString})? recordtest,
  }) : super._(
          id: id,
          active: active,
          publicId: publicId,
          subjectId: subjectId,
          subject: subject,
          scheduledAtId: scheduledAtId,
          scheduledAt: scheduledAt,
          lessonId: lessonId,
          roomId: roomId,
          room: room,
          lessonGroupId: lessonGroupId,
          lessonGroup: lessonGroup,
          createdBy: createdBy,
          createdAt: createdAt,
          modifiedBy: modifiedBy,
          modifiedAt: modifiedAt,
          recordtest: recordtest,
        );

  /// Returns a shallow copy of this [ScheduledLesson]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduledLesson copyWith({
    Object? id = _Undefined,
    bool? active,
    String? publicId,
    int? subjectId,
    Object? subject = _Undefined,
    int? scheduledAtId,
    Object? scheduledAt = _Undefined,
    String? lessonId,
    int? roomId,
    Object? room = _Undefined,
    int? lessonGroupId,
    Object? lessonGroup = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
    Object? recordtest = _Undefined,
  }) {
    return ScheduledLessonImplicit._(
      id: id is int? ? id : this.id,
      active: active ?? this.active,
      publicId: publicId ?? this.publicId,
      subjectId: subjectId ?? this.subjectId,
      subject: subject is _i2.Subject? ? subject : this.subject?.copyWith(),
      scheduledAtId: scheduledAtId ?? this.scheduledAtId,
      scheduledAt: scheduledAt is _i3.TimetableSlot?
          ? scheduledAt
          : this.scheduledAt?.copyWith(),
      lessonId: lessonId ?? this.lessonId,
      roomId: roomId ?? this.roomId,
      room: room is _i4.Room? ? room : this.room?.copyWith(),
      lessonGroupId: lessonGroupId ?? this.lessonGroupId,
      lessonGroup: lessonGroup is _i5.LessonGroup?
          ? lessonGroup
          : this.lessonGroup?.copyWith(),
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      recordtest: recordtest is ({int testint, String testString})?
          ? recordtest
          : this.recordtest == null
              ? null
              : (
                  testint: this.recordtest!.testint,
                  testString: this.recordtest!.testString,
                ),
      $_roomScheduledlessonsRoomId: this._roomScheduledlessonsRoomId,
    );
  }
}

class ScheduledLessonImplicit extends _ScheduledLessonImpl {
  ScheduledLessonImplicit._({
    int? id,
    required bool active,
    required String publicId,
    required int subjectId,
    _i2.Subject? subject,
    required int scheduledAtId,
    _i3.TimetableSlot? scheduledAt,
    required String lessonId,
    required int roomId,
    _i4.Room? room,
    required int lessonGroupId,
    _i5.LessonGroup? lessonGroup,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required DateTime modifiedAt,
    ({int testint, String testString})? recordtest,
    int? $_roomScheduledlessonsRoomId,
  })  : _roomScheduledlessonsRoomId = $_roomScheduledlessonsRoomId,
        super(
          id: id,
          active: active,
          publicId: publicId,
          subjectId: subjectId,
          subject: subject,
          scheduledAtId: scheduledAtId,
          scheduledAt: scheduledAt,
          lessonId: lessonId,
          roomId: roomId,
          room: room,
          lessonGroupId: lessonGroupId,
          lessonGroup: lessonGroup,
          createdBy: createdBy,
          createdAt: createdAt,
          modifiedBy: modifiedBy,
          modifiedAt: modifiedAt,
          recordtest: recordtest,
        );

  factory ScheduledLessonImplicit(
    ScheduledLesson scheduledLesson, {
    int? $_roomScheduledlessonsRoomId,
  }) {
    return ScheduledLessonImplicit._(
      id: scheduledLesson.id,
      active: scheduledLesson.active,
      publicId: scheduledLesson.publicId,
      subjectId: scheduledLesson.subjectId,
      subject: scheduledLesson.subject,
      scheduledAtId: scheduledLesson.scheduledAtId,
      scheduledAt: scheduledLesson.scheduledAt,
      lessonId: scheduledLesson.lessonId,
      roomId: scheduledLesson.roomId,
      room: scheduledLesson.room,
      lessonGroupId: scheduledLesson.lessonGroupId,
      lessonGroup: scheduledLesson.lessonGroup,
      createdBy: scheduledLesson.createdBy,
      createdAt: scheduledLesson.createdAt,
      modifiedBy: scheduledLesson.modifiedBy,
      modifiedAt: scheduledLesson.modifiedAt,
      recordtest: scheduledLesson.recordtest,
      $_roomScheduledlessonsRoomId: $_roomScheduledlessonsRoomId,
    );
  }

  @override
  final int? _roomScheduledlessonsRoomId;
}

class ScheduledLessonTable extends _i1.Table<int?> {
  ScheduledLessonTable({super.tableRelation})
      : super(tableName: 'scheduled_lesson') {
    active = _i1.ColumnBool(
      'active',
      this,
    );
    publicId = _i1.ColumnString(
      'publicId',
      this,
    );
    subjectId = _i1.ColumnInt(
      'subjectId',
      this,
    );
    scheduledAtId = _i1.ColumnInt(
      'scheduledAtId',
      this,
    );
    lessonId = _i1.ColumnString(
      'lessonId',
      this,
    );
    roomId = _i1.ColumnInt(
      'roomId',
      this,
    );
    lessonGroupId = _i1.ColumnInt(
      'lessonGroupId',
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
    recordtest = _i1.ColumnSerializable(
      'recordtest',
      this,
    );
    $_roomScheduledlessonsRoomId = _i1.ColumnInt(
      '_roomScheduledlessonsRoomId',
      this,
    );
  }

  late final _i1.ColumnBool active;

  late final _i1.ColumnString publicId;

  late final _i1.ColumnInt subjectId;

  _i2.SubjectTable? _subject;

  late final _i1.ColumnInt scheduledAtId;

  _i3.TimetableSlotTable? _scheduledAt;

  late final _i1.ColumnString lessonId;

  late final _i1.ColumnInt roomId;

  _i4.RoomTable? _room;

  late final _i1.ColumnInt lessonGroupId;

  _i5.LessonGroupTable? _lessonGroup;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString modifiedBy;

  late final _i1.ColumnDateTime modifiedAt;

  late final _i1.ColumnSerializable recordtest;

  late final _i1.ColumnInt $_roomScheduledlessonsRoomId;

  _i2.SubjectTable get subject {
    if (_subject != null) return _subject!;
    _subject = _i1.createRelationTable(
      relationFieldName: 'subject',
      field: ScheduledLesson.t.subjectId,
      foreignField: _i2.Subject.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SubjectTable(tableRelation: foreignTableRelation),
    );
    return _subject!;
  }

  _i3.TimetableSlotTable get scheduledAt {
    if (_scheduledAt != null) return _scheduledAt!;
    _scheduledAt = _i1.createRelationTable(
      relationFieldName: 'scheduledAt',
      field: ScheduledLesson.t.scheduledAtId,
      foreignField: _i3.TimetableSlot.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.TimetableSlotTable(tableRelation: foreignTableRelation),
    );
    return _scheduledAt!;
  }

  _i4.RoomTable get room {
    if (_room != null) return _room!;
    _room = _i1.createRelationTable(
      relationFieldName: 'room',
      field: ScheduledLesson.t.roomId,
      foreignField: _i4.Room.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RoomTable(tableRelation: foreignTableRelation),
    );
    return _room!;
  }

  _i5.LessonGroupTable get lessonGroup {
    if (_lessonGroup != null) return _lessonGroup!;
    _lessonGroup = _i1.createRelationTable(
      relationFieldName: 'lessonGroup',
      field: ScheduledLesson.t.lessonGroupId,
      foreignField: _i5.LessonGroup.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.LessonGroupTable(tableRelation: foreignTableRelation),
    );
    return _lessonGroup!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        active,
        publicId,
        subjectId,
        scheduledAtId,
        lessonId,
        roomId,
        lessonGroupId,
        createdBy,
        createdAt,
        modifiedBy,
        modifiedAt,
        recordtest,
        $_roomScheduledlessonsRoomId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        active,
        publicId,
        subjectId,
        scheduledAtId,
        lessonId,
        roomId,
        lessonGroupId,
        createdBy,
        createdAt,
        modifiedBy,
        modifiedAt,
        recordtest,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'subject') {
      return subject;
    }
    if (relationField == 'scheduledAt') {
      return scheduledAt;
    }
    if (relationField == 'room') {
      return room;
    }
    if (relationField == 'lessonGroup') {
      return lessonGroup;
    }
    return null;
  }
}

class ScheduledLessonInclude extends _i1.IncludeObject {
  ScheduledLessonInclude._({
    _i2.SubjectInclude? subject,
    _i3.TimetableSlotInclude? scheduledAt,
    _i4.RoomInclude? room,
    _i5.LessonGroupInclude? lessonGroup,
  }) {
    _subject = subject;
    _scheduledAt = scheduledAt;
    _room = room;
    _lessonGroup = lessonGroup;
  }

  _i2.SubjectInclude? _subject;

  _i3.TimetableSlotInclude? _scheduledAt;

  _i4.RoomInclude? _room;

  _i5.LessonGroupInclude? _lessonGroup;

  @override
  Map<String, _i1.Include?> get includes => {
        'subject': _subject,
        'scheduledAt': _scheduledAt,
        'room': _room,
        'lessonGroup': _lessonGroup,
      };

  @override
  _i1.Table<int?> get table => ScheduledLesson.t;
}

class ScheduledLessonIncludeList extends _i1.IncludeList {
  ScheduledLessonIncludeList._({
    _i1.WhereExpressionBuilder<ScheduledLessonTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ScheduledLesson.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ScheduledLesson.t;
}

class ScheduledLessonRepository {
  const ScheduledLessonRepository._();

  final attachRow = const ScheduledLessonAttachRowRepository._();

  /// Returns a list of [ScheduledLesson]s matching the given query parameters.
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
  Future<List<ScheduledLesson>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduledLessonTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledLessonTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledLessonTable>? orderByList,
    _i1.Transaction? transaction,
    ScheduledLessonInclude? include,
  }) async {
    return session.db.find<ScheduledLesson>(
      where: where?.call(ScheduledLesson.t),
      orderBy: orderBy?.call(ScheduledLesson.t),
      orderByList: orderByList?.call(ScheduledLesson.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ScheduledLesson] matching the given query parameters.
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
  Future<ScheduledLesson?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduledLessonTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScheduledLessonTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledLessonTable>? orderByList,
    _i1.Transaction? transaction,
    ScheduledLessonInclude? include,
  }) async {
    return session.db.findFirstRow<ScheduledLesson>(
      where: where?.call(ScheduledLesson.t),
      orderBy: orderBy?.call(ScheduledLesson.t),
      orderByList: orderByList?.call(ScheduledLesson.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ScheduledLesson] by its [id] or null if no such row exists.
  Future<ScheduledLesson?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ScheduledLessonInclude? include,
  }) async {
    return session.db.findById<ScheduledLesson>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ScheduledLesson]s in the list and returns the inserted rows.
  ///
  /// The returned [ScheduledLesson]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ScheduledLesson>> insert(
    _i1.Session session,
    List<ScheduledLesson> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ScheduledLesson>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ScheduledLesson] and returns the inserted row.
  ///
  /// The returned [ScheduledLesson] will have its `id` field set.
  Future<ScheduledLesson> insertRow(
    _i1.Session session,
    ScheduledLesson row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ScheduledLesson>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ScheduledLesson]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ScheduledLesson>> update(
    _i1.Session session,
    List<ScheduledLesson> rows, {
    _i1.ColumnSelections<ScheduledLessonTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ScheduledLesson>(
      rows,
      columns: columns?.call(ScheduledLesson.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScheduledLesson]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ScheduledLesson> updateRow(
    _i1.Session session,
    ScheduledLesson row, {
    _i1.ColumnSelections<ScheduledLessonTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ScheduledLesson>(
      row,
      columns: columns?.call(ScheduledLesson.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ScheduledLesson]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ScheduledLesson>> delete(
    _i1.Session session,
    List<ScheduledLesson> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ScheduledLesson>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ScheduledLesson].
  Future<ScheduledLesson> deleteRow(
    _i1.Session session,
    ScheduledLesson row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ScheduledLesson>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ScheduledLesson>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ScheduledLessonTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ScheduledLesson>(
      where: where(ScheduledLesson.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduledLessonTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ScheduledLesson>(
      where: where?.call(ScheduledLesson.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ScheduledLessonAttachRowRepository {
  const ScheduledLessonAttachRowRepository._();

  /// Creates a relation between the given [ScheduledLesson] and [Subject]
  /// by setting the [ScheduledLesson]'s foreign key `subjectId` to refer to the [Subject].
  Future<void> subject(
    _i1.Session session,
    ScheduledLesson scheduledLesson,
    _i2.Subject subject, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.id == null) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }
    if (subject.id == null) {
      throw ArgumentError.notNull('subject.id');
    }

    var $scheduledLesson = scheduledLesson.copyWith(subjectId: subject.id);
    await session.db.updateRow<ScheduledLesson>(
      $scheduledLesson,
      columns: [ScheduledLesson.t.subjectId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ScheduledLesson] and [TimetableSlot]
  /// by setting the [ScheduledLesson]'s foreign key `scheduledAtId` to refer to the [TimetableSlot].
  Future<void> scheduledAt(
    _i1.Session session,
    ScheduledLesson scheduledLesson,
    _i3.TimetableSlot scheduledAt, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.id == null) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }
    if (scheduledAt.id == null) {
      throw ArgumentError.notNull('scheduledAt.id');
    }

    var $scheduledLesson =
        scheduledLesson.copyWith(scheduledAtId: scheduledAt.id);
    await session.db.updateRow<ScheduledLesson>(
      $scheduledLesson,
      columns: [ScheduledLesson.t.scheduledAtId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ScheduledLesson] and [Room]
  /// by setting the [ScheduledLesson]'s foreign key `roomId` to refer to the [Room].
  Future<void> room(
    _i1.Session session,
    ScheduledLesson scheduledLesson,
    _i4.Room room, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLesson.id == null) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }
    if (room.id == null) {
      throw ArgumentError.notNull('room.id');
    }

    var $scheduledLesson = scheduledLesson.copyWith(roomId: room.id);
    await session.db.updateRow<ScheduledLesson>(
      $scheduledLesson,
      columns: [ScheduledLesson.t.roomId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ScheduledLesson] and [LessonGroup]
  /// by setting the [ScheduledLesson]'s foreign key `lessonGroupId` to refer to the [LessonGroup].
  Future<void> lessonGroup(
    _i1.Session session,
    ScheduledLesson scheduledLesson,
    _i5.LessonGroup lessonGroup, {
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
    await session.db.updateRow<ScheduledLesson>(
      $scheduledLesson,
      columns: [ScheduledLesson.t.lessonGroupId],
      transaction: transaction,
    );
  }
}
