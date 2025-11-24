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
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i2;
import '../../../_features/user/models/roles.dart' as _i3;
import '../../../_features/timetable/models/junction_models/scheduled_lesson_teacher.dart'
    as _i4;
import '../../../_features/timetable/models/junction_models/lesson_teacher.dart'
    as _i5;
import '../../../_features/user/models/user_flags.dart' as _i6;

abstract class User implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  User._({
    this.id,
    required this.userInfoId,
    this.userInfo,
    required this.role,
    this.matrixUserId,
    required this.timeUnits,
    required this.reliefTimeUnits,
    this.scheduledLessonsTeacher,
    this.lessonsTeacher,
    this.pupilsAuth,
    this.schooldayEventsProcessingTeam,
    required this.credit,
    required this.userFlags,
  });

  factory User({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required _i3.Role role,
    String? matrixUserId,
    required int timeUnits,
    required int reliefTimeUnits,
    List<_i4.ScheduledLessonTeacher>? scheduledLessonsTeacher,
    List<_i5.LessonTeacher>? lessonsTeacher,
    Set<int>? pupilsAuth,
    String? schooldayEventsProcessingTeam,
    required int credit,
    required _i6.UserFlags userFlags,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      userInfoId: jsonSerialization['userInfoId'] as int,
      userInfo: jsonSerialization['userInfo'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['userInfo'] as Map<String, dynamic>)),
      role: _i3.Role.fromJson((jsonSerialization['role'] as String)),
      matrixUserId: jsonSerialization['matrixUserId'] as String?,
      timeUnits: jsonSerialization['timeUnits'] as int,
      reliefTimeUnits: jsonSerialization['reliefTimeUnits'] as int,
      scheduledLessonsTeacher: (jsonSerialization['scheduledLessonsTeacher']
              as List?)
          ?.map((e) =>
              _i4.ScheduledLessonTeacher.fromJson((e as Map<String, dynamic>)))
          .toList(),
      lessonsTeacher: (jsonSerialization['lessonsTeacher'] as List?)
          ?.map((e) => _i5.LessonTeacher.fromJson((e as Map<String, dynamic>)))
          .toList(),
      pupilsAuth: jsonSerialization['pupilsAuth'] == null
          ? null
          : _i1.SetJsonExtension.fromJson(
              (jsonSerialization['pupilsAuth'] as List),
              itemFromJson: (e) => e as int),
      schooldayEventsProcessingTeam:
          jsonSerialization['schooldayEventsProcessingTeam'] as String?,
      credit: jsonSerialization['credit'] as int,
      userFlags: _i6.UserFlags.fromJson(
          (jsonSerialization['userFlags'] as Map<String, dynamic>)),
    );
  }

  static final t = UserTable();

  static const db = UserRepository._();

  @override
  int? id;

  int userInfoId;

  _i2.UserInfo? userInfo;

  _i3.Role role;

  String? matrixUserId;

  int timeUnits;

  int reliefTimeUnits;

  List<_i4.ScheduledLessonTeacher>? scheduledLessonsTeacher;

  List<_i5.LessonTeacher>? lessonsTeacher;

  Set<int>? pupilsAuth;

  String? schooldayEventsProcessingTeam;

  int credit;

  _i6.UserFlags userFlags;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    int? userInfoId,
    _i2.UserInfo? userInfo,
    _i3.Role? role,
    String? matrixUserId,
    int? timeUnits,
    int? reliefTimeUnits,
    List<_i4.ScheduledLessonTeacher>? scheduledLessonsTeacher,
    List<_i5.LessonTeacher>? lessonsTeacher,
    Set<int>? pupilsAuth,
    String? schooldayEventsProcessingTeam,
    int? credit,
    _i6.UserFlags? userFlags,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      'role': role.toJson(),
      if (matrixUserId != null) 'matrixUserId': matrixUserId,
      'timeUnits': timeUnits,
      'reliefTimeUnits': reliefTimeUnits,
      if (scheduledLessonsTeacher != null)
        'scheduledLessonsTeacher':
            scheduledLessonsTeacher?.toJson(valueToJson: (v) => v.toJson()),
      if (lessonsTeacher != null)
        'lessonsTeacher':
            lessonsTeacher?.toJson(valueToJson: (v) => v.toJson()),
      if (pupilsAuth != null) 'pupilsAuth': pupilsAuth?.toJson(),
      if (schooldayEventsProcessingTeam != null)
        'schooldayEventsProcessingTeam': schooldayEventsProcessingTeam,
      'credit': credit,
      'userFlags': userFlags.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJsonForProtocol(),
      'role': role.toJson(),
      if (matrixUserId != null) 'matrixUserId': matrixUserId,
      'timeUnits': timeUnits,
      'reliefTimeUnits': reliefTimeUnits,
      if (scheduledLessonsTeacher != null)
        'scheduledLessonsTeacher': scheduledLessonsTeacher?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (lessonsTeacher != null)
        'lessonsTeacher':
            lessonsTeacher?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (pupilsAuth != null) 'pupilsAuth': pupilsAuth?.toJson(),
      if (schooldayEventsProcessingTeam != null)
        'schooldayEventsProcessingTeam': schooldayEventsProcessingTeam,
      'credit': credit,
      'userFlags': userFlags.toJsonForProtocol(),
    };
  }

  static UserInclude include({
    _i2.UserInfoInclude? userInfo,
    _i4.ScheduledLessonTeacherIncludeList? scheduledLessonsTeacher,
    _i5.LessonTeacherIncludeList? lessonsTeacher,
  }) {
    return UserInclude._(
      userInfo: userInfo,
      scheduledLessonsTeacher: scheduledLessonsTeacher,
      lessonsTeacher: lessonsTeacher,
    );
  }

  static UserIncludeList includeList({
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    UserInclude? include,
  }) {
    return UserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(User.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required _i3.Role role,
    String? matrixUserId,
    required int timeUnits,
    required int reliefTimeUnits,
    List<_i4.ScheduledLessonTeacher>? scheduledLessonsTeacher,
    List<_i5.LessonTeacher>? lessonsTeacher,
    Set<int>? pupilsAuth,
    String? schooldayEventsProcessingTeam,
    required int credit,
    required _i6.UserFlags userFlags,
  }) : super._(
          id: id,
          userInfoId: userInfoId,
          userInfo: userInfo,
          role: role,
          matrixUserId: matrixUserId,
          timeUnits: timeUnits,
          reliefTimeUnits: reliefTimeUnits,
          scheduledLessonsTeacher: scheduledLessonsTeacher,
          lessonsTeacher: lessonsTeacher,
          pupilsAuth: pupilsAuth,
          schooldayEventsProcessingTeam: schooldayEventsProcessingTeam,
          credit: credit,
          userFlags: userFlags,
        );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    int? userInfoId,
    Object? userInfo = _Undefined,
    _i3.Role? role,
    Object? matrixUserId = _Undefined,
    int? timeUnits,
    int? reliefTimeUnits,
    Object? scheduledLessonsTeacher = _Undefined,
    Object? lessonsTeacher = _Undefined,
    Object? pupilsAuth = _Undefined,
    Object? schooldayEventsProcessingTeam = _Undefined,
    int? credit,
    _i6.UserFlags? userFlags,
  }) {
    return User(
      id: id is int? ? id : this.id,
      userInfoId: userInfoId ?? this.userInfoId,
      userInfo:
          userInfo is _i2.UserInfo? ? userInfo : this.userInfo?.copyWith(),
      role: role ?? this.role,
      matrixUserId: matrixUserId is String? ? matrixUserId : this.matrixUserId,
      timeUnits: timeUnits ?? this.timeUnits,
      reliefTimeUnits: reliefTimeUnits ?? this.reliefTimeUnits,
      scheduledLessonsTeacher: scheduledLessonsTeacher
              is List<_i4.ScheduledLessonTeacher>?
          ? scheduledLessonsTeacher
          : this.scheduledLessonsTeacher?.map((e0) => e0.copyWith()).toList(),
      lessonsTeacher: lessonsTeacher is List<_i5.LessonTeacher>?
          ? lessonsTeacher
          : this.lessonsTeacher?.map((e0) => e0.copyWith()).toList(),
      pupilsAuth: pupilsAuth is Set<int>?
          ? pupilsAuth
          : this.pupilsAuth?.map((e0) => e0).toSet(),
      schooldayEventsProcessingTeam: schooldayEventsProcessingTeam is String?
          ? schooldayEventsProcessingTeam
          : this.schooldayEventsProcessingTeam,
      credit: credit ?? this.credit,
      userFlags: userFlags ?? this.userFlags.copyWith(),
    );
  }
}

class UserTable extends _i1.Table<int?> {
  UserTable({super.tableRelation}) : super(tableName: 'user') {
    userInfoId = _i1.ColumnInt(
      'userInfoId',
      this,
    );
    role = _i1.ColumnEnum(
      'role',
      this,
      _i1.EnumSerialization.byName,
    );
    matrixUserId = _i1.ColumnString(
      'matrixUserId',
      this,
    );
    timeUnits = _i1.ColumnInt(
      'timeUnits',
      this,
    );
    reliefTimeUnits = _i1.ColumnInt(
      'reliefTimeUnits',
      this,
    );
    pupilsAuth = _i1.ColumnSerializable(
      'pupilsAuth',
      this,
    );
    schooldayEventsProcessingTeam = _i1.ColumnString(
      'schooldayEventsProcessingTeam',
      this,
    );
    credit = _i1.ColumnInt(
      'credit',
      this,
    );
    userFlags = _i1.ColumnSerializable(
      'userFlags',
      this,
    );
  }

  late final _i1.ColumnInt userInfoId;

  _i2.UserInfoTable? _userInfo;

  late final _i1.ColumnEnum<_i3.Role> role;

  late final _i1.ColumnString matrixUserId;

  late final _i1.ColumnInt timeUnits;

  late final _i1.ColumnInt reliefTimeUnits;

  _i4.ScheduledLessonTeacherTable? ___scheduledLessonsTeacher;

  _i1.ManyRelation<_i4.ScheduledLessonTeacherTable>? _scheduledLessonsTeacher;

  _i5.LessonTeacherTable? ___lessonsTeacher;

  _i1.ManyRelation<_i5.LessonTeacherTable>? _lessonsTeacher;

  late final _i1.ColumnSerializable pupilsAuth;

  late final _i1.ColumnString schooldayEventsProcessingTeam;

  late final _i1.ColumnInt credit;

  late final _i1.ColumnSerializable userFlags;

  _i2.UserInfoTable get userInfo {
    if (_userInfo != null) return _userInfo!;
    _userInfo = _i1.createRelationTable(
      relationFieldName: 'userInfo',
      field: User.t.userInfoId,
      foreignField: _i2.UserInfo.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserInfoTable(tableRelation: foreignTableRelation),
    );
    return _userInfo!;
  }

  _i4.ScheduledLessonTeacherTable get __scheduledLessonsTeacher {
    if (___scheduledLessonsTeacher != null) return ___scheduledLessonsTeacher!;
    ___scheduledLessonsTeacher = _i1.createRelationTable(
      relationFieldName: '__scheduledLessonsTeacher',
      field: User.t.id,
      foreignField: _i4.ScheduledLessonTeacher.t.userId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ScheduledLessonTeacherTable(tableRelation: foreignTableRelation),
    );
    return ___scheduledLessonsTeacher!;
  }

  _i5.LessonTeacherTable get __lessonsTeacher {
    if (___lessonsTeacher != null) return ___lessonsTeacher!;
    ___lessonsTeacher = _i1.createRelationTable(
      relationFieldName: '__lessonsTeacher',
      field: User.t.id,
      foreignField: _i5.LessonTeacher.t.userId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.LessonTeacherTable(tableRelation: foreignTableRelation),
    );
    return ___lessonsTeacher!;
  }

  _i1.ManyRelation<_i4.ScheduledLessonTeacherTable>
      get scheduledLessonsTeacher {
    if (_scheduledLessonsTeacher != null) return _scheduledLessonsTeacher!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'scheduledLessonsTeacher',
      field: User.t.id,
      foreignField: _i4.ScheduledLessonTeacher.t.userId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ScheduledLessonTeacherTable(tableRelation: foreignTableRelation),
    );
    _scheduledLessonsTeacher =
        _i1.ManyRelation<_i4.ScheduledLessonTeacherTable>(
      tableWithRelations: relationTable,
      table: _i4.ScheduledLessonTeacherTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _scheduledLessonsTeacher!;
  }

  _i1.ManyRelation<_i5.LessonTeacherTable> get lessonsTeacher {
    if (_lessonsTeacher != null) return _lessonsTeacher!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'lessonsTeacher',
      field: User.t.id,
      foreignField: _i5.LessonTeacher.t.userId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.LessonTeacherTable(tableRelation: foreignTableRelation),
    );
    _lessonsTeacher = _i1.ManyRelation<_i5.LessonTeacherTable>(
      tableWithRelations: relationTable,
      table: _i5.LessonTeacherTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _lessonsTeacher!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        userInfoId,
        role,
        matrixUserId,
        timeUnits,
        reliefTimeUnits,
        pupilsAuth,
        schooldayEventsProcessingTeam,
        credit,
        userFlags,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'userInfo') {
      return userInfo;
    }
    if (relationField == 'scheduledLessonsTeacher') {
      return __scheduledLessonsTeacher;
    }
    if (relationField == 'lessonsTeacher') {
      return __lessonsTeacher;
    }
    return null;
  }
}

class UserInclude extends _i1.IncludeObject {
  UserInclude._({
    _i2.UserInfoInclude? userInfo,
    _i4.ScheduledLessonTeacherIncludeList? scheduledLessonsTeacher,
    _i5.LessonTeacherIncludeList? lessonsTeacher,
  }) {
    _userInfo = userInfo;
    _scheduledLessonsTeacher = scheduledLessonsTeacher;
    _lessonsTeacher = lessonsTeacher;
  }

  _i2.UserInfoInclude? _userInfo;

  _i4.ScheduledLessonTeacherIncludeList? _scheduledLessonsTeacher;

  _i5.LessonTeacherIncludeList? _lessonsTeacher;

  @override
  Map<String, _i1.Include?> get includes => {
        'userInfo': _userInfo,
        'scheduledLessonsTeacher': _scheduledLessonsTeacher,
        'lessonsTeacher': _lessonsTeacher,
      };

  @override
  _i1.Table<int?> get table => User.t;
}

class UserIncludeList extends _i1.IncludeList {
  UserIncludeList._({
    _i1.WhereExpressionBuilder<UserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(User.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => User.t;
}

class UserRepository {
  const UserRepository._();

  final attach = const UserAttachRepository._();

  final attachRow = const UserAttachRowRepository._();

  /// Returns a list of [User]s matching the given query parameters.
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
  Future<List<User>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.db.find<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [User] matching the given query parameters.
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
  Future<User?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.db.findFirstRow<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [User] by its [id] or null if no such row exists.
  Future<User?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.db.findById<User>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [User]s in the list and returns the inserted rows.
  ///
  /// The returned [User]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<User>> insert(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<User>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [User] and returns the inserted row.
  ///
  /// The returned [User] will have its `id` field set.
  Future<User> insertRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [User]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<User>> update(
    _i1.Session session,
    List<User> rows, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<User>(
      rows,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Updates a single [User]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<User> updateRow(
    _i1.Session session,
    User row, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<User>(
      row,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Deletes all [User]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<User>> delete(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<User>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [User].
  Future<User> deleteRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<User>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<User>(
      where: where(User.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<User>(
      where: where?.call(User.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class UserAttachRepository {
  const UserAttachRepository._();

  /// Creates a relation between this [User] and the given [ScheduledLessonTeacher]s
  /// by setting each [ScheduledLessonTeacher]'s foreign key `userId` to refer to this [User].
  Future<void> scheduledLessonsTeacher(
    _i1.Session session,
    User user,
    List<_i4.ScheduledLessonTeacher> scheduledLessonTeacher, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledLessonTeacher.any((e) => e.id == null)) {
      throw ArgumentError.notNull('scheduledLessonTeacher.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $scheduledLessonTeacher =
        scheduledLessonTeacher.map((e) => e.copyWith(userId: user.id)).toList();
    await session.db.update<_i4.ScheduledLessonTeacher>(
      $scheduledLessonTeacher,
      columns: [_i4.ScheduledLessonTeacher.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [User] and the given [LessonTeacher]s
  /// by setting each [LessonTeacher]'s foreign key `userId` to refer to this [User].
  Future<void> lessonsTeacher(
    _i1.Session session,
    User user,
    List<_i5.LessonTeacher> lessonTeacher, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonTeacher.any((e) => e.id == null)) {
      throw ArgumentError.notNull('lessonTeacher.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $lessonTeacher =
        lessonTeacher.map((e) => e.copyWith(userId: user.id)).toList();
    await session.db.update<_i5.LessonTeacher>(
      $lessonTeacher,
      columns: [_i5.LessonTeacher.t.userId],
      transaction: transaction,
    );
  }
}

class UserAttachRowRepository {
  const UserAttachRowRepository._();

  /// Creates a relation between the given [User] and [UserInfo]
  /// by setting the [User]'s foreign key `userInfoId` to refer to the [UserInfo].
  Future<void> userInfo(
    _i1.Session session,
    User user,
    _i2.UserInfo userInfo, {
    _i1.Transaction? transaction,
  }) async {
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }
    if (userInfo.id == null) {
      throw ArgumentError.notNull('userInfo.id');
    }

    var $user = user.copyWith(userInfoId: userInfo.id);
    await session.db.updateRow<User>(
      $user,
      columns: [User.t.userInfoId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [User] and the given [ScheduledLessonTeacher]
  /// by setting the [ScheduledLessonTeacher]'s foreign key `userId` to refer to this [User].
  Future<void> scheduledLessonsTeacher(
    _i1.Session session,
    User user,
    _i4.ScheduledLessonTeacher scheduledLessonTeacher, {
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
    await session.db.updateRow<_i4.ScheduledLessonTeacher>(
      $scheduledLessonTeacher,
      columns: [_i4.ScheduledLessonTeacher.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [User] and the given [LessonTeacher]
  /// by setting the [LessonTeacher]'s foreign key `userId` to refer to this [User].
  Future<void> lessonsTeacher(
    _i1.Session session,
    User user,
    _i5.LessonTeacher lessonTeacher, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonTeacher.id == null) {
      throw ArgumentError.notNull('lessonTeacher.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $lessonTeacher = lessonTeacher.copyWith(userId: user.id);
    await session.db.updateRow<_i5.LessonTeacher>(
      $lessonTeacher,
      columns: [_i5.LessonTeacher.t.userId],
      transaction: transaction,
    );
  }
}
