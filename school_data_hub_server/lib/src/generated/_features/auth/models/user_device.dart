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

abstract class UserDevice
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserDevice._({
    this.id,
    required this.userInfoId,
    this.userInfo,
    required this.deviceId,
    required this.deviceName,
    required this.lastLogin,
    required this.isActive,
    required this.authId,
  });

  factory UserDevice({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required String deviceId,
    required String deviceName,
    required DateTime lastLogin,
    required bool isActive,
    required int authId,
  }) = _UserDeviceImpl;

  factory UserDevice.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserDevice(
      id: jsonSerialization['id'] as int?,
      userInfoId: jsonSerialization['userInfoId'] as int,
      userInfo: jsonSerialization['userInfo'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['userInfo'] as Map<String, dynamic>)),
      deviceId: jsonSerialization['deviceId'] as String,
      deviceName: jsonSerialization['deviceName'] as String,
      lastLogin:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastLogin']),
      isActive: jsonSerialization['isActive'] as bool,
      authId: jsonSerialization['authId'] as int,
    );
  }

  static final t = UserDeviceTable();

  static const db = UserDeviceRepository._();

  @override
  int? id;

  int userInfoId;

  _i2.UserInfo? userInfo;

  String deviceId;

  String deviceName;

  DateTime lastLogin;

  bool isActive;

  int authId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserDevice copyWith({
    int? id,
    int? userInfoId,
    _i2.UserInfo? userInfo,
    String? deviceId,
    String? deviceName,
    DateTime? lastLogin,
    bool? isActive,
    int? authId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      'deviceId': deviceId,
      'deviceName': deviceName,
      'lastLogin': lastLogin.toJson(),
      'isActive': isActive,
      'authId': authId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJsonForProtocol(),
      'deviceId': deviceId,
      'deviceName': deviceName,
      'lastLogin': lastLogin.toJson(),
      'isActive': isActive,
      'authId': authId,
    };
  }

  static UserDeviceInclude include({_i2.UserInfoInclude? userInfo}) {
    return UserDeviceInclude._(userInfo: userInfo);
  }

  static UserDeviceIncludeList includeList({
    _i1.WhereExpressionBuilder<UserDeviceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserDeviceTable>? orderByList,
    UserDeviceInclude? include,
  }) {
    return UserDeviceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserDevice.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserDevice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserDeviceImpl extends UserDevice {
  _UserDeviceImpl({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required String deviceId,
    required String deviceName,
    required DateTime lastLogin,
    required bool isActive,
    required int authId,
  }) : super._(
          id: id,
          userInfoId: userInfoId,
          userInfo: userInfo,
          deviceId: deviceId,
          deviceName: deviceName,
          lastLogin: lastLogin,
          isActive: isActive,
          authId: authId,
        );

  /// Returns a shallow copy of this [UserDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserDevice copyWith({
    Object? id = _Undefined,
    int? userInfoId,
    Object? userInfo = _Undefined,
    String? deviceId,
    String? deviceName,
    DateTime? lastLogin,
    bool? isActive,
    int? authId,
  }) {
    return UserDevice(
      id: id is int? ? id : this.id,
      userInfoId: userInfoId ?? this.userInfoId,
      userInfo:
          userInfo is _i2.UserInfo? ? userInfo : this.userInfo?.copyWith(),
      deviceId: deviceId ?? this.deviceId,
      deviceName: deviceName ?? this.deviceName,
      lastLogin: lastLogin ?? this.lastLogin,
      isActive: isActive ?? this.isActive,
      authId: authId ?? this.authId,
    );
  }
}

class UserDeviceTable extends _i1.Table<int?> {
  UserDeviceTable({super.tableRelation}) : super(tableName: 'user_device') {
    userInfoId = _i1.ColumnInt(
      'userInfoId',
      this,
    );
    deviceId = _i1.ColumnString(
      'deviceId',
      this,
    );
    deviceName = _i1.ColumnString(
      'deviceName',
      this,
    );
    lastLogin = _i1.ColumnDateTime(
      'lastLogin',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
    );
    authId = _i1.ColumnInt(
      'authId',
      this,
    );
  }

  late final _i1.ColumnInt userInfoId;

  _i2.UserInfoTable? _userInfo;

  late final _i1.ColumnString deviceId;

  late final _i1.ColumnString deviceName;

  late final _i1.ColumnDateTime lastLogin;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnInt authId;

  _i2.UserInfoTable get userInfo {
    if (_userInfo != null) return _userInfo!;
    _userInfo = _i1.createRelationTable(
      relationFieldName: 'userInfo',
      field: UserDevice.t.userInfoId,
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
        deviceId,
        deviceName,
        lastLogin,
        isActive,
        authId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'userInfo') {
      return userInfo;
    }
    return null;
  }
}

class UserDeviceInclude extends _i1.IncludeObject {
  UserDeviceInclude._({_i2.UserInfoInclude? userInfo}) {
    _userInfo = userInfo;
  }

  _i2.UserInfoInclude? _userInfo;

  @override
  Map<String, _i1.Include?> get includes => {'userInfo': _userInfo};

  @override
  _i1.Table<int?> get table => UserDevice.t;
}

class UserDeviceIncludeList extends _i1.IncludeList {
  UserDeviceIncludeList._({
    _i1.WhereExpressionBuilder<UserDeviceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserDevice.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserDevice.t;
}

class UserDeviceRepository {
  const UserDeviceRepository._();

  final attachRow = const UserDeviceAttachRowRepository._();

  /// Returns a list of [UserDevice]s matching the given query parameters.
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
  Future<List<UserDevice>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserDeviceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserDeviceTable>? orderByList,
    _i1.Transaction? transaction,
    UserDeviceInclude? include,
  }) async {
    return session.db.find<UserDevice>(
      where: where?.call(UserDevice.t),
      orderBy: orderBy?.call(UserDevice.t),
      orderByList: orderByList?.call(UserDevice.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [UserDevice] matching the given query parameters.
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
  Future<UserDevice?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserDeviceTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserDeviceTable>? orderByList,
    _i1.Transaction? transaction,
    UserDeviceInclude? include,
  }) async {
    return session.db.findFirstRow<UserDevice>(
      where: where?.call(UserDevice.t),
      orderBy: orderBy?.call(UserDevice.t),
      orderByList: orderByList?.call(UserDevice.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [UserDevice] by its [id] or null if no such row exists.
  Future<UserDevice?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    UserDeviceInclude? include,
  }) async {
    return session.db.findById<UserDevice>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [UserDevice]s in the list and returns the inserted rows.
  ///
  /// The returned [UserDevice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserDevice>> insert(
    _i1.Session session,
    List<UserDevice> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserDevice>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserDevice] and returns the inserted row.
  ///
  /// The returned [UserDevice] will have its `id` field set.
  Future<UserDevice> insertRow(
    _i1.Session session,
    UserDevice row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserDevice>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserDevice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserDevice>> update(
    _i1.Session session,
    List<UserDevice> rows, {
    _i1.ColumnSelections<UserDeviceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserDevice>(
      rows,
      columns: columns?.call(UserDevice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserDevice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserDevice> updateRow(
    _i1.Session session,
    UserDevice row, {
    _i1.ColumnSelections<UserDeviceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserDevice>(
      row,
      columns: columns?.call(UserDevice.t),
      transaction: transaction,
    );
  }

  /// Deletes all [UserDevice]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserDevice>> delete(
    _i1.Session session,
    List<UserDevice> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserDevice>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserDevice].
  Future<UserDevice> deleteRow(
    _i1.Session session,
    UserDevice row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserDevice>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserDevice>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserDeviceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserDevice>(
      where: where(UserDevice.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserDeviceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserDevice>(
      where: where?.call(UserDevice.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class UserDeviceAttachRowRepository {
  const UserDeviceAttachRowRepository._();

  /// Creates a relation between the given [UserDevice] and [UserInfo]
  /// by setting the [UserDevice]'s foreign key `userInfoId` to refer to the [UserInfo].
  Future<void> userInfo(
    _i1.Session session,
    UserDevice userDevice,
    _i2.UserInfo userInfo, {
    _i1.Transaction? transaction,
  }) async {
    if (userDevice.id == null) {
      throw ArgumentError.notNull('userDevice.id');
    }
    if (userInfo.id == null) {
      throw ArgumentError.notNull('userInfo.id');
    }

    var $userDevice = userDevice.copyWith(userInfoId: userInfo.id);
    await session.db.updateRow<UserDevice>(
      $userDevice,
      columns: [UserDevice.t.userInfoId],
      transaction: transaction,
    );
  }
}
