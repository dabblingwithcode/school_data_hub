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
import '../../../../_features/timetable/models/lesson/lesson.dart' as _i3;

abstract class LessonTeacher
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LessonTeacher._({
    this.id,
    required this.userId,
    this.user,
    required this.scheduledLessonId,
    this.scheduledLesson,
  });

  factory LessonTeacher({
    int? id,
    required int userId,
    _i2.User? user,
    required int scheduledLessonId,
    _i3.Lesson? scheduledLesson,
  }) = _LessonTeacherImpl;

  factory LessonTeacher.fromJson(Map<String, dynamic> jsonSerialization) {
    return LessonTeacher(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i2.User.fromJson(
              (jsonSerialization['user'] as Map<String, dynamic>)),
      scheduledLessonId: jsonSerialization['scheduledLessonId'] as int,
      scheduledLesson: jsonSerialization['scheduledLesson'] == null
          ? null
          : _i3.Lesson.fromJson(
              (jsonSerialization['scheduledLesson'] as Map<String, dynamic>)),
    );
  }

  static final t = LessonTeacherTable();

  static const db = LessonTeacherRepository._();

  @override
  int? id;

  int userId;

  _i2.User? user;

  int scheduledLessonId;

  _i3.Lesson? scheduledLesson;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LessonTeacher]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LessonTeacher copyWith({
    int? id,
    int? userId,
    _i2.User? user,
    int? scheduledLessonId,
    _i3.Lesson? scheduledLesson,
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

  static LessonTeacherInclude include({
    _i2.UserInclude? user,
    _i3.LessonInclude? scheduledLesson,
  }) {
    return LessonTeacherInclude._(
      user: user,
      scheduledLesson: scheduledLesson,
    );
  }

  static LessonTeacherIncludeList includeList({
    _i1.WhereExpressionBuilder<LessonTeacherTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonTeacherTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonTeacherTable>? orderByList,
    LessonTeacherInclude? include,
  }) {
    return LessonTeacherIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LessonTeacher.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LessonTeacher.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LessonTeacherImpl extends LessonTeacher {
  _LessonTeacherImpl({
    int? id,
    required int userId,
    _i2.User? user,
    required int scheduledLessonId,
    _i3.Lesson? scheduledLesson,
  }) : super._(
          id: id,
          userId: userId,
          user: user,
          scheduledLessonId: scheduledLessonId,
          scheduledLesson: scheduledLesson,
        );

  /// Returns a shallow copy of this [LessonTeacher]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LessonTeacher copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? scheduledLessonId,
    Object? scheduledLesson = _Undefined,
  }) {
    return LessonTeacher(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      scheduledLessonId: scheduledLessonId ?? this.scheduledLessonId,
      scheduledLesson: scheduledLesson is _i3.Lesson?
          ? scheduledLesson
          : this.scheduledLesson?.copyWith(),
    );
  }
}

class LessonTeacherTable extends _i1.Table<int?> {
  LessonTeacherTable({super.tableRelation})
      : super(tableName: 'lesson_teacher') {
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

  _i3.LessonTable? _scheduledLesson;

  _i2.UserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: LessonTeacher.t.userId,
      foreignField: _i2.User.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.LessonTable get scheduledLesson {
    if (_scheduledLesson != null) return _scheduledLesson!;
    _scheduledLesson = _i1.createRelationTable(
      relationFieldName: 'scheduledLesson',
      field: LessonTeacher.t.scheduledLessonId,
      foreignField: _i3.Lesson.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.LessonTable(tableRelation: foreignTableRelation),
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

class LessonTeacherInclude extends _i1.IncludeObject {
  LessonTeacherInclude._({
    _i2.UserInclude? user,
    _i3.LessonInclude? scheduledLesson,
  }) {
    _user = user;
    _scheduledLesson = scheduledLesson;
  }

  _i2.UserInclude? _user;

  _i3.LessonInclude? _scheduledLesson;

  @override
  Map<String, _i1.Include?> get includes => {
        'user': _user,
        'scheduledLesson': _scheduledLesson,
      };

  @override
  _i1.Table<int?> get table => LessonTeacher.t;
}

class LessonTeacherIncludeList extends _i1.IncludeList {
  LessonTeacherIncludeList._({
    _i1.WhereExpressionBuilder<LessonTeacherTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LessonTeacher.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LessonTeacher.t;
}

class LessonTeacherRepository {
  const LessonTeacherRepository._();

  final attachRow = const LessonTeacherAttachRowRepository._();

  /// Returns a list of [LessonTeacher]s matching the given query parameters.
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
  Future<List<LessonTeacher>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonTeacherTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonTeacherTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonTeacherTable>? orderByList,
    _i1.Transaction? transaction,
    LessonTeacherInclude? include,
  }) async {
    return session.db.find<LessonTeacher>(
      where: where?.call(LessonTeacher.t),
      orderBy: orderBy?.call(LessonTeacher.t),
      orderByList: orderByList?.call(LessonTeacher.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [LessonTeacher] matching the given query parameters.
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
  Future<LessonTeacher?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonTeacherTable>? where,
    int? offset,
    _i1.OrderByBuilder<LessonTeacherTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonTeacherTable>? orderByList,
    _i1.Transaction? transaction,
    LessonTeacherInclude? include,
  }) async {
    return session.db.findFirstRow<LessonTeacher>(
      where: where?.call(LessonTeacher.t),
      orderBy: orderBy?.call(LessonTeacher.t),
      orderByList: orderByList?.call(LessonTeacher.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [LessonTeacher] by its [id] or null if no such row exists.
  Future<LessonTeacher?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    LessonTeacherInclude? include,
  }) async {
    return session.db.findById<LessonTeacher>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [LessonTeacher]s in the list and returns the inserted rows.
  ///
  /// The returned [LessonTeacher]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LessonTeacher>> insert(
    _i1.Session session,
    List<LessonTeacher> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LessonTeacher>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LessonTeacher] and returns the inserted row.
  ///
  /// The returned [LessonTeacher] will have its `id` field set.
  Future<LessonTeacher> insertRow(
    _i1.Session session,
    LessonTeacher row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LessonTeacher>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LessonTeacher]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LessonTeacher>> update(
    _i1.Session session,
    List<LessonTeacher> rows, {
    _i1.ColumnSelections<LessonTeacherTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LessonTeacher>(
      rows,
      columns: columns?.call(LessonTeacher.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LessonTeacher]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LessonTeacher> updateRow(
    _i1.Session session,
    LessonTeacher row, {
    _i1.ColumnSelections<LessonTeacherTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LessonTeacher>(
      row,
      columns: columns?.call(LessonTeacher.t),
      transaction: transaction,
    );
  }

  /// Deletes all [LessonTeacher]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LessonTeacher>> delete(
    _i1.Session session,
    List<LessonTeacher> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LessonTeacher>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LessonTeacher].
  Future<LessonTeacher> deleteRow(
    _i1.Session session,
    LessonTeacher row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LessonTeacher>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LessonTeacher>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LessonTeacherTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LessonTeacher>(
      where: where(LessonTeacher.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonTeacherTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LessonTeacher>(
      where: where?.call(LessonTeacher.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class LessonTeacherAttachRowRepository {
  const LessonTeacherAttachRowRepository._();

  /// Creates a relation between the given [LessonTeacher] and [User]
  /// by setting the [LessonTeacher]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.Session session,
    LessonTeacher lessonTeacher,
    _i2.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonTeacher.id == null) {
      throw ArgumentError.notNull('lessonTeacher.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $lessonTeacher = lessonTeacher.copyWith(userId: user.id);
    await session.db.updateRow<LessonTeacher>(
      $lessonTeacher,
      columns: [LessonTeacher.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [LessonTeacher] and [Lesson]
  /// by setting the [LessonTeacher]'s foreign key `scheduledLessonId` to refer to the [Lesson].
  Future<void> scheduledLesson(
    _i1.Session session,
    LessonTeacher lessonTeacher,
    _i3.Lesson scheduledLesson, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonTeacher.id == null) {
      throw ArgumentError.notNull('lessonTeacher.id');
    }
    if (scheduledLesson.id == null) {
      throw ArgumentError.notNull('scheduledLesson.id');
    }

    var $lessonTeacher =
        lessonTeacher.copyWith(scheduledLessonId: scheduledLesson.id);
    await session.db.updateRow<LessonTeacher>(
      $lessonTeacher,
      columns: [LessonTeacher.t.scheduledLessonId],
      transaction: transaction,
    );
  }
}
