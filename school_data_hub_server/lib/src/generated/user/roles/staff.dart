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
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i2;
import '../../user/roles/roles.dart' as _i3;
import '../../user/user_flags.dart' as _i4;

abstract class StaffUser implements _i1.TableRow, _i1.ProtocolSerialization {
  StaffUser._({
    this.id,
    required this.userInfoId,
    this.userInfo,
    required this.role,
    required this.timeUnits,
    this.pupilsAuth,
    required this.credit,
    required this.userFlags,
  });

  factory StaffUser({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required _i3.Role role,
    required int timeUnits,
    Set<int>? pupilsAuth,
    required int credit,
    required _i4.UserFlags userFlags,
  }) = _StaffUserImpl;

  factory StaffUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return StaffUser(
      id: jsonSerialization['id'] as int?,
      userInfoId: jsonSerialization['userInfoId'] as int,
      userInfo: jsonSerialization['userInfo'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['userInfo'] as Map<String, dynamic>)),
      role: _i3.Role.fromJson((jsonSerialization['role'] as String)),
      timeUnits: jsonSerialization['timeUnits'] as int,
      pupilsAuth: jsonSerialization['pupilsAuth'] == null
          ? null
          : _i1.SetJsonExtension.fromJson(
              (jsonSerialization['pupilsAuth'] as List),
              itemFromJson: (e) => e as int),
      credit: jsonSerialization['credit'] as int,
      userFlags: _i4.UserFlags.fromJson(
          (jsonSerialization['userFlags'] as Map<String, dynamic>)),
    );
  }

  static final t = StaffUserTable();

  static const db = StaffUserRepository._();

  @override
  int? id;

  int userInfoId;

  _i2.UserInfo? userInfo;

  _i3.Role role;

  int timeUnits;

  Set<int>? pupilsAuth;

  int credit;

  _i4.UserFlags userFlags;

  @override
  _i1.Table get table => t;

  /// Returns a shallow copy of this [StaffUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StaffUser copyWith({
    int? id,
    int? userInfoId,
    _i2.UserInfo? userInfo,
    _i3.Role? role,
    int? timeUnits,
    Set<int>? pupilsAuth,
    int? credit,
    _i4.UserFlags? userFlags,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      'role': role.toJson(),
      'timeUnits': timeUnits,
      if (pupilsAuth != null) 'pupilsAuth': pupilsAuth?.toJson(),
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
      'timeUnits': timeUnits,
      if (pupilsAuth != null) 'pupilsAuth': pupilsAuth?.toJson(),
      'credit': credit,
      'userFlags': userFlags.toJsonForProtocol(),
    };
  }

  static StaffUserInclude include({_i2.UserInfoInclude? userInfo}) {
    return StaffUserInclude._(userInfo: userInfo);
  }

  static StaffUserIncludeList includeList({
    _i1.WhereExpressionBuilder<StaffUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StaffUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StaffUserTable>? orderByList,
    StaffUserInclude? include,
  }) {
    return StaffUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StaffUser.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StaffUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StaffUserImpl extends StaffUser {
  _StaffUserImpl({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required _i3.Role role,
    required int timeUnits,
    Set<int>? pupilsAuth,
    required int credit,
    required _i4.UserFlags userFlags,
  }) : super._(
          id: id,
          userInfoId: userInfoId,
          userInfo: userInfo,
          role: role,
          timeUnits: timeUnits,
          pupilsAuth: pupilsAuth,
          credit: credit,
          userFlags: userFlags,
        );

  /// Returns a shallow copy of this [StaffUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StaffUser copyWith({
    Object? id = _Undefined,
    int? userInfoId,
    Object? userInfo = _Undefined,
    _i3.Role? role,
    int? timeUnits,
    Object? pupilsAuth = _Undefined,
    int? credit,
    _i4.UserFlags? userFlags,
  }) {
    return StaffUser(
      id: id is int? ? id : this.id,
      userInfoId: userInfoId ?? this.userInfoId,
      userInfo:
          userInfo is _i2.UserInfo? ? userInfo : this.userInfo?.copyWith(),
      role: role ?? this.role,
      timeUnits: timeUnits ?? this.timeUnits,
      pupilsAuth: pupilsAuth is Set<int>?
          ? pupilsAuth
          : this.pupilsAuth?.map((e0) => e0).toSet(),
      credit: credit ?? this.credit,
      userFlags: userFlags ?? this.userFlags.copyWith(),
    );
  }
}

class StaffUserTable extends _i1.Table {
  StaffUserTable({super.tableRelation}) : super(tableName: 'staff') {
    userInfoId = _i1.ColumnInt(
      'userInfoId',
      this,
    );
    role = _i1.ColumnEnum(
      'role',
      this,
      _i1.EnumSerialization.byName,
    );
    timeUnits = _i1.ColumnInt(
      'timeUnits',
      this,
    );
    pupilsAuth = _i1.ColumnSerializable(
      'pupilsAuth',
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

  late final _i1.ColumnInt timeUnits;

  late final _i1.ColumnSerializable pupilsAuth;

  late final _i1.ColumnInt credit;

  late final _i1.ColumnSerializable userFlags;

  _i2.UserInfoTable get userInfo {
    if (_userInfo != null) return _userInfo!;
    _userInfo = _i1.createRelationTable(
      relationFieldName: 'userInfo',
      field: StaffUser.t.userInfoId,
      foreignField: _i2.UserInfo.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserInfoTable(tableRelation: foreignTableRelation),
    );
    return _userInfo!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        userInfoId,
        role,
        timeUnits,
        pupilsAuth,
        credit,
        userFlags,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'userInfo') {
      return userInfo;
    }
    return null;
  }
}

class StaffUserInclude extends _i1.IncludeObject {
  StaffUserInclude._({_i2.UserInfoInclude? userInfo}) {
    _userInfo = userInfo;
  }

  _i2.UserInfoInclude? _userInfo;

  @override
  Map<String, _i1.Include?> get includes => {'userInfo': _userInfo};

  @override
  _i1.Table get table => StaffUser.t;
}

class StaffUserIncludeList extends _i1.IncludeList {
  StaffUserIncludeList._({
    _i1.WhereExpressionBuilder<StaffUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StaffUser.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => StaffUser.t;
}

class StaffUserRepository {
  const StaffUserRepository._();

  final attachRow = const StaffUserAttachRowRepository._();

  /// Returns a list of [StaffUser]s matching the given query parameters.
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
  Future<List<StaffUser>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StaffUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StaffUserTable>? orderByList,
    _i1.Transaction? transaction,
    StaffUserInclude? include,
  }) async {
    return session.db.find<StaffUser>(
      where: where?.call(StaffUser.t),
      orderBy: orderBy?.call(StaffUser.t),
      orderByList: orderByList?.call(StaffUser.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [StaffUser] matching the given query parameters.
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
  Future<StaffUser?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffUserTable>? where,
    int? offset,
    _i1.OrderByBuilder<StaffUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StaffUserTable>? orderByList,
    _i1.Transaction? transaction,
    StaffUserInclude? include,
  }) async {
    return session.db.findFirstRow<StaffUser>(
      where: where?.call(StaffUser.t),
      orderBy: orderBy?.call(StaffUser.t),
      orderByList: orderByList?.call(StaffUser.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [StaffUser] by its [id] or null if no such row exists.
  Future<StaffUser?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    StaffUserInclude? include,
  }) async {
    return session.db.findById<StaffUser>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [StaffUser]s in the list and returns the inserted rows.
  ///
  /// The returned [StaffUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StaffUser>> insert(
    _i1.Session session,
    List<StaffUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StaffUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StaffUser] and returns the inserted row.
  ///
  /// The returned [StaffUser] will have its `id` field set.
  Future<StaffUser> insertRow(
    _i1.Session session,
    StaffUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StaffUser>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StaffUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StaffUser>> update(
    _i1.Session session,
    List<StaffUser> rows, {
    _i1.ColumnSelections<StaffUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StaffUser>(
      rows,
      columns: columns?.call(StaffUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StaffUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StaffUser> updateRow(
    _i1.Session session,
    StaffUser row, {
    _i1.ColumnSelections<StaffUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StaffUser>(
      row,
      columns: columns?.call(StaffUser.t),
      transaction: transaction,
    );
  }

  /// Deletes all [StaffUser]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StaffUser>> delete(
    _i1.Session session,
    List<StaffUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StaffUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StaffUser].
  Future<StaffUser> deleteRow(
    _i1.Session session,
    StaffUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StaffUser>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StaffUser>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StaffUserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StaffUser>(
      where: where(StaffUser.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffUserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StaffUser>(
      where: where?.call(StaffUser.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class StaffUserAttachRowRepository {
  const StaffUserAttachRowRepository._();

  /// Creates a relation between the given [StaffUser] and [UserInfo]
  /// by setting the [StaffUser]'s foreign key `userInfoId` to refer to the [UserInfo].
  Future<void> userInfo(
    _i1.Session session,
    StaffUser staffUser,
    _i2.UserInfo userInfo, {
    _i1.Transaction? transaction,
  }) async {
    if (staffUser.id == null) {
      throw ArgumentError.notNull('staffUser.id');
    }
    if (userInfo.id == null) {
      throw ArgumentError.notNull('userInfo.id');
    }

    var $staffUser = staffUser.copyWith(userInfoId: userInfo.id);
    await session.db.updateRow<StaffUser>(
      $staffUser,
      columns: [StaffUser.t.userInfoId],
      transaction: transaction,
    );
  }
}
