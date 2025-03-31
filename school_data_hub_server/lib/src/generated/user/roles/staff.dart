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

abstract class Staff implements _i1.TableRow, _i1.ProtocolSerialization {
  Staff._({
    this.id,
    required this.userInfoId,
    this.userInfo,
    required this.name,
    required this.shortName,
    required this.role,
    required this.userId,
    required this.email,
    required this.password,
  });

  factory Staff({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required String name,
    required String shortName,
    required _i3.Role role,
    required String userId,
    required String email,
    required String password,
  }) = _StaffImpl;

  factory Staff.fromJson(Map<String, dynamic> jsonSerialization) {
    return Staff(
      id: jsonSerialization['id'] as int?,
      userInfoId: jsonSerialization['userInfoId'] as int,
      userInfo: jsonSerialization['userInfo'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['userInfo'] as Map<String, dynamic>)),
      name: jsonSerialization['name'] as String,
      shortName: jsonSerialization['shortName'] as String,
      role: _i3.Role.fromJson((jsonSerialization['role'] as String)),
      userId: jsonSerialization['userId'] as String,
      email: jsonSerialization['email'] as String,
      password: jsonSerialization['password'] as String,
    );
  }

  static final t = StaffTable();

  static const db = StaffRepository._();

  @override
  int? id;

  int userInfoId;

  _i2.UserInfo? userInfo;

  String name;

  String shortName;

  _i3.Role role;

  String userId;

  String email;

  String password;

  @override
  _i1.Table get table => t;

  /// Returns a shallow copy of this [Staff]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Staff copyWith({
    int? id,
    int? userInfoId,
    _i2.UserInfo? userInfo,
    String? name,
    String? shortName,
    _i3.Role? role,
    String? userId,
    String? email,
    String? password,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      'name': name,
      'shortName': shortName,
      'role': role.toJson(),
      'userId': userId,
      'email': email,
      'password': password,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJsonForProtocol(),
      'name': name,
      'shortName': shortName,
      'role': role.toJson(),
      'userId': userId,
      'email': email,
      'password': password,
    };
  }

  static StaffInclude include({_i2.UserInfoInclude? userInfo}) {
    return StaffInclude._(userInfo: userInfo);
  }

  static StaffIncludeList includeList({
    _i1.WhereExpressionBuilder<StaffTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StaffTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StaffTable>? orderByList,
    StaffInclude? include,
  }) {
    return StaffIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Staff.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Staff.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StaffImpl extends Staff {
  _StaffImpl({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required String name,
    required String shortName,
    required _i3.Role role,
    required String userId,
    required String email,
    required String password,
  }) : super._(
          id: id,
          userInfoId: userInfoId,
          userInfo: userInfo,
          name: name,
          shortName: shortName,
          role: role,
          userId: userId,
          email: email,
          password: password,
        );

  /// Returns a shallow copy of this [Staff]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Staff copyWith({
    Object? id = _Undefined,
    int? userInfoId,
    Object? userInfo = _Undefined,
    String? name,
    String? shortName,
    _i3.Role? role,
    String? userId,
    String? email,
    String? password,
  }) {
    return Staff(
      id: id is int? ? id : this.id,
      userInfoId: userInfoId ?? this.userInfoId,
      userInfo:
          userInfo is _i2.UserInfo? ? userInfo : this.userInfo?.copyWith(),
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      role: role ?? this.role,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class StaffTable extends _i1.Table {
  StaffTable({super.tableRelation}) : super(tableName: 'staff') {
    userInfoId = _i1.ColumnInt(
      'userInfoId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    shortName = _i1.ColumnString(
      'shortName',
      this,
    );
    role = _i1.ColumnEnum(
      'role',
      this,
      _i1.EnumSerialization.byName,
    );
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    password = _i1.ColumnString(
      'password',
      this,
    );
  }

  late final _i1.ColumnInt userInfoId;

  _i2.UserInfoTable? _userInfo;

  late final _i1.ColumnString name;

  late final _i1.ColumnString shortName;

  late final _i1.ColumnEnum<_i3.Role> role;

  late final _i1.ColumnString userId;

  late final _i1.ColumnString email;

  late final _i1.ColumnString password;

  _i2.UserInfoTable get userInfo {
    if (_userInfo != null) return _userInfo!;
    _userInfo = _i1.createRelationTable(
      relationFieldName: 'userInfo',
      field: Staff.t.userInfoId,
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
        name,
        shortName,
        role,
        userId,
        email,
        password,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'userInfo') {
      return userInfo;
    }
    return null;
  }
}

class StaffInclude extends _i1.IncludeObject {
  StaffInclude._({_i2.UserInfoInclude? userInfo}) {
    _userInfo = userInfo;
  }

  _i2.UserInfoInclude? _userInfo;

  @override
  Map<String, _i1.Include?> get includes => {'userInfo': _userInfo};

  @override
  _i1.Table get table => Staff.t;
}

class StaffIncludeList extends _i1.IncludeList {
  StaffIncludeList._({
    _i1.WhereExpressionBuilder<StaffTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Staff.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Staff.t;
}

class StaffRepository {
  const StaffRepository._();

  final attachRow = const StaffAttachRowRepository._();

  /// Returns a list of [Staff]s matching the given query parameters.
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
  Future<List<Staff>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StaffTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StaffTable>? orderByList,
    _i1.Transaction? transaction,
    StaffInclude? include,
  }) async {
    return session.db.find<Staff>(
      where: where?.call(Staff.t),
      orderBy: orderBy?.call(Staff.t),
      orderByList: orderByList?.call(Staff.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Staff] matching the given query parameters.
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
  Future<Staff?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffTable>? where,
    int? offset,
    _i1.OrderByBuilder<StaffTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StaffTable>? orderByList,
    _i1.Transaction? transaction,
    StaffInclude? include,
  }) async {
    return session.db.findFirstRow<Staff>(
      where: where?.call(Staff.t),
      orderBy: orderBy?.call(Staff.t),
      orderByList: orderByList?.call(Staff.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Staff] by its [id] or null if no such row exists.
  Future<Staff?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    StaffInclude? include,
  }) async {
    return session.db.findById<Staff>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Staff]s in the list and returns the inserted rows.
  ///
  /// The returned [Staff]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Staff>> insert(
    _i1.Session session,
    List<Staff> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Staff>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Staff] and returns the inserted row.
  ///
  /// The returned [Staff] will have its `id` field set.
  Future<Staff> insertRow(
    _i1.Session session,
    Staff row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Staff>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Staff]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Staff>> update(
    _i1.Session session,
    List<Staff> rows, {
    _i1.ColumnSelections<StaffTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Staff>(
      rows,
      columns: columns?.call(Staff.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Staff]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Staff> updateRow(
    _i1.Session session,
    Staff row, {
    _i1.ColumnSelections<StaffTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Staff>(
      row,
      columns: columns?.call(Staff.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Staff]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Staff>> delete(
    _i1.Session session,
    List<Staff> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Staff>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Staff].
  Future<Staff> deleteRow(
    _i1.Session session,
    Staff row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Staff>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Staff>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StaffTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Staff>(
      where: where(Staff.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StaffTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Staff>(
      where: where?.call(Staff.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class StaffAttachRowRepository {
  const StaffAttachRowRepository._();

  /// Creates a relation between the given [Staff] and [UserInfo]
  /// by setting the [Staff]'s foreign key `userInfoId` to refer to the [UserInfo].
  Future<void> userInfo(
    _i1.Session session,
    Staff staff,
    _i2.UserInfo userInfo, {
    _i1.Transaction? transaction,
  }) async {
    if (staff.id == null) {
      throw ArgumentError.notNull('staff.id');
    }
    if (userInfo.id == null) {
      throw ArgumentError.notNull('userInfo.id');
    }

    var $staff = staff.copyWith(userInfoId: userInfo.id);
    await session.db.updateRow<Staff>(
      $staff,
      columns: [Staff.t.userInfoId],
      transaction: transaction,
    );
  }
}
