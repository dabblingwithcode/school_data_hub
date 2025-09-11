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
import '../../../../_features/user/models/staff_user.dart' as _i2;
import '../../../../_features/timetable/models/scheduled_lesson/scheduled_lesson.dart'
    as _i3;

abstract class ScheduledLessonTeacher
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ScheduledLessonTeacher._({
    this.id,
    required this.userId,
    this.user,
    required this.scheduledLessonId,
    this.scheduledLesson,
  });

  factory ScheduledLessonTeacher({
    int? id,
    required int userId,
    _i2.User? user,
    required int scheduledLessonId,
    _i3.ScheduledLesson? scheduledLesson,
  }) = _ScheduledLessonTeacherImpl;

  factory ScheduledLessonTeacher.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ScheduledLessonTeacher(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i2.User.fromJson(
              (jsonSerialization['user'] as Map<String, dynamic>)),
      scheduledLessonId: jsonSerialization['scheduledLessonId'] as int,
      scheduledLesson: jsonSerialization['scheduledLesson'] == null
          ? null
          : _i3.ScheduledLesson.fromJson(
              (jsonSerialization['scheduledLesson'] as Map<String, dynamic>)),
    );
  }

  static final t = ScheduledLessonTeacherTable();

  static const db = ScheduledLessonTeacherRepository._();

  @override
  int? id;

  int userId;

  _i2.User? user;

  int scheduledLessonId;

  _i3.ScheduledLesson? scheduledLesson;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ScheduledLessonTeacher]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduledLessonTeacher copyWith({
    int? id,
    int? userId,
    _i2.User? user,
    int? scheduledLessonId,
    _i3.ScheduledLesson? scheduledLesson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'scheduledLessonId': scheduledLessonId,
      if (scheduledLesson != null) 'scheduledLesson': scheduledLesson?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'scheduledLessonId': scheduledLessonId,
      if (scheduledLesson != null)
        'scheduledLesson': scheduledLesson?.toJsonForProtocol(),
    };
  }

  static ScheduledLessonTeacherInclude include({
    _i2.UserInclude? user,
    _i3.ScheduledLessonInclude? scheduledLesson,
  }) {
    return ScheduledLessonTeacherInclude._(
      user: user,
      scheduledLesson: scheduledLesson,
    );
  }

  static ScheduledLessonTeacherIncludeList includeList({
    _i1.WhereExpressionBuilder<ScheduledLessonTeacherTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledLessonTeacherTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledLessonTeacherTable>? orderByList,
    ScheduledLessonTeacherInclude? include,
  }) {
    return ScheduledLessonTeacherIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScheduledLessonTeacher.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ScheduledLessonTeacher.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScheduledLessonTeacherImpl extends ScheduledLessonTeacher {
  _ScheduledLessonTeacherImpl({
    int? id,
    required int userId,
    _i2.User? user,
    required int scheduledLessonId,
    _i3.ScheduledLesson? scheduledLesson,
  }) : super._(
          id: id,
          userId: userId,
          user: user,
          scheduledLessonId: scheduledLessonId,
          scheduledLesson: scheduledLesson,
        );

  /// Returns a shallow copy of this [ScheduledLessonTeacher]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduledLessonTeacher copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? scheduledLessonId,
    Object? scheduledLesson = _Undefined,
  }) {
    return ScheduledLessonTeacher(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      scheduledLessonId: scheduledLessonId ?? this.scheduledLessonId,
      scheduledLesson: scheduledLesson is _i3.ScheduledLesson?
          ? scheduledLesson
          : this.scheduledLesson?.copyWith(),
    );
  }
}

class ScheduledLessonTeacherTable extends _i1.Table<int?> {
  ScheduledLessonTeacherTable({super.tableRelation})
      : super(tableName: 'scheduled_lesson_teacher') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    scheduledLessonId = _i1.ColumnInt(
      'scheduledLessonId',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  _i2.UserTable? _user;

  late final _i1.ColumnInt scheduledLessonId;

  _i3.ScheduledLessonTable? _scheduledLesson;

  _i2.UserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: ScheduledLessonTeacher.t.userId,
      foreignField: _i2.User.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.ScheduledLessonTable get scheduledLesson {
    if (_scheduledLesson != null) return _scheduledLesson!;
    _scheduledLesson = _i1.createRelationTable(
      relationFieldName: 'scheduledLesson',
      field: ScheduledLessonTeacher.t.scheduledLessonId,
      foreignField: _i3.ScheduledLesson.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ScheduledLessonTable(tableRelation: foreignTableRelation),
    );
    return _scheduledLesson!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        scheduledLessonId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'scheduledLesson') {
      return scheduledLesson;
    }
    return null;
  }
}

class ScheduledLessonTeacherInclude extends _i1.IncludeObject {
  ScheduledLessonTeacherInclude._({
    _i2.UserInclude? user,
    _i3.ScheduledLessonInclude? scheduledLesson,
  }) {
    _user = user;
    _scheduledLesson = scheduledLesson;
  }

  _i2.UserInclude? _user;

  _i3.ScheduledLessonInclude? _scheduledLesson;

  @override
  Map<String, _i1.Include?> get includes => {
        'user': _user,
        'scheduledLesson': _scheduledLesson,
      };

  @override
  _i1.Table<int?> get table => ScheduledLessonTeacher.t;
}

class ScheduledLessonTeacherIncludeList extends _i1.IncludeList {
  ScheduledLessonTeacherIncludeList._({
    _i1.WhereExpressionBuilder<ScheduledLessonTeacherTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ScheduledLessonTeacher.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ScheduledLessonTeacher.t;
}

class ScheduledLessonTeacherRepository {
  const ScheduledLessonTeacherRepository._();

  final attachRow = const ScheduledLessonTeacherAttachRowRepository._();

  /// Returns a list of [ScheduledLessonTeacher]s matching the given query parameters.
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
  Future<List<ScheduledLessonTeacher>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduledLessonTeacherTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledLessonTeacherTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledLessonTeacherTable>? orderByList,
    _i1.Transaction? transaction,
    ScheduledLessonTeacherInclude? include,
  }) async {
    return session.db.find<ScheduledLessonTeacher>(
      where: where?.call(ScheduledLessonTeacher.t),
      orderBy: orderBy?.call(ScheduledLessonTeacher.t),
      orderByList: orderByList?.call(ScheduledLessonTeacher.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ScheduledLessonTeacher] matching the given query parameters.
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
  Future<ScheduledLessonTeacher?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduledLessonTeacherTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScheduledLessonTeacherTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledLessonTeacherTable>? orderByList,
    _i1.Transaction? transaction,
    ScheduledLessonTeacherInclude? include,
  }) async {
    return session.db.findFirstRow<ScheduledLessonTeacher>(
      where: where?.call(ScheduledLessonTeacher.t),
      orderBy: orderBy?.call(ScheduledLessonTeacher.t),
      orderByList: orderByList?.call(ScheduledLessonTeacher.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ScheduledLessonTeacher] by its [id] or null if no such row exists.
  Future<ScheduledLessonTeacher?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ScheduledLessonTeacherInclude? include,
  }) async {
    return session.db.findById<ScheduledLessonTeacher>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ScheduledLessonTeacher]s in the list and returns the inserted rows.
  ///
  /// The returned [ScheduledLessonTeacher]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ScheduledLessonTeacher>> insert(
    _i1.Session session,
    List<ScheduledLessonTeacher> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ScheduledLessonTeacher>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ScheduledLessonTeacher] and returns the inserted row.
  ///
  /// The returned [ScheduledLessonTeacher] will have its `id` field set.
  Future<ScheduledLessonTeacher> insertRow(
    _i1.Session session,
    ScheduledLessonTeacher row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ScheduledLessonTeacher>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ScheduledLessonTeacher]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ScheduledLessonTeacher>> update(
    _i1.Session session,
    List<ScheduledLessonTeacher> rows, {
    _i1.ColumnSelections<ScheduledLessonTeacherTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ScheduledLessonTeacher>(
      rows,
      columns: columns?.call(ScheduledLessonTeacher.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScheduledLessonTeacher]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ScheduledLessonTeacher> updateRow(
    _i1.Session session,
    ScheduledLessonTeacher row, {
    _i1.ColumnSelections<ScheduledLessonTeacherTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ScheduledLessonTeacher>(
      row,
      columns: columns?.call(ScheduledLessonTeacher.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ScheduledLessonTeacher]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ScheduledLessonTeacher>> delete(
    _i1.Session session,
    List<ScheduledLessonTeacher> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ScheduledLessonTeacher>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ScheduledLessonTeacher].
  Future<ScheduledLessonTeacher> deleteRow(
    _i1.Session session,
    ScheduledLessonTeacher row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ScheduledLessonTeacher>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ScheduledLessonTeacher>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ScheduledLessonTeacherTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ScheduledLessonTeacher>(
      where: where(ScheduledLessonTeacher.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduledLessonTeacherTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ScheduledLessonTeacher>(
      where: where?.call(ScheduledLessonTeacher.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ScheduledLessonTeacherAttachRowRepository {
  const ScheduledLessonTeacherAttachRowRepository._();

  /// Creates a relation between the given [ScheduledLessonTeacher] and [User]
  /// by setting the [ScheduledLessonTeacher]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.Session session,
    ScheduledLessonTeacher scheduledLessonTeacher,
    _i2.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLessonTeacher.id == null) {
      throw ArgumentError.notNull('scheduledLessonTeacher.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $scheduledLessonTeacher =
        scheduledLessonTeacher.copyWith(userId: user.id);
    await session.db.updateRow<ScheduledLessonTeacher>(
      $scheduledLessonTeacher,
      columns: [ScheduledLessonTeacher.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ScheduledLessonTeacher] and [ScheduledLesson]
  /// by setting the [ScheduledLessonTeacher]'s foreign key `scheduledLessonId` to refer to the [ScheduledLesson].
  Future<void> scheduledLesson(
    _i1.Session session,
    ScheduledLessonTeacher scheduledLessonTeacher,
    _i3.ScheduledLesson scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLessonTeacher.id == null) {
      throw ArgumentError.notNull('scheduledLessonTeacher.id');
    }
    if (scheduledLesson.id == null) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }

    var $scheduledLessonTeacher =
        scheduledLessonTeacher.copyWith(scheduledLessonId: scheduledLesson.id);
    await session.db.updateRow<ScheduledLessonTeacher>(
      $scheduledLessonTeacher,
      columns: [ScheduledLessonTeacher.t.scheduledLessonId],
      transaction: transaction,
    );
  }
}
