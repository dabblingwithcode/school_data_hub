/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i2;
import '../../user/roles/roles.dart' as _i3;

abstract class Staff implements _i1.SerializableModel {
  Staff._({
    this.id,
    required this.userInfoId,
    this.userInfo,
    required this.role,
    required this.timeUnits,
    this.pupilsAuth,
    required this.credit,
    required this.changedPassword,
    required this.passwordLastChanged,
  });

  factory Staff({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required _i3.Role role,
    required int timeUnits,
    Set<int>? pupilsAuth,
    required int credit,
    required bool changedPassword,
    required DateTime passwordLastChanged,
  }) = _StaffImpl;

  factory Staff.fromJson(Map<String, dynamic> jsonSerialization) {
    return Staff(
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
      changedPassword: jsonSerialization['changedPassword'] as bool,
      passwordLastChanged: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['passwordLastChanged']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userInfoId;

  _i2.UserInfo? userInfo;

  _i3.Role role;

  int timeUnits;

  Set<int>? pupilsAuth;

  int credit;

  bool changedPassword;

  DateTime passwordLastChanged;

  /// Returns a shallow copy of this [Staff]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Staff copyWith({
    int? id,
    int? userInfoId,
    _i2.UserInfo? userInfo,
    _i3.Role? role,
    int? timeUnits,
    Set<int>? pupilsAuth,
    int? credit,
    bool? changedPassword,
    DateTime? passwordLastChanged,
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
      'changedPassword': changedPassword,
      'passwordLastChanged': passwordLastChanged.toJson(),
    };
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
    required _i3.Role role,
    required int timeUnits,
    Set<int>? pupilsAuth,
    required int credit,
    required bool changedPassword,
    required DateTime passwordLastChanged,
  }) : super._(
          id: id,
          userInfoId: userInfoId,
          userInfo: userInfo,
          role: role,
          timeUnits: timeUnits,
          pupilsAuth: pupilsAuth,
          credit: credit,
          changedPassword: changedPassword,
          passwordLastChanged: passwordLastChanged,
        );

  /// Returns a shallow copy of this [Staff]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Staff copyWith({
    Object? id = _Undefined,
    int? userInfoId,
    Object? userInfo = _Undefined,
    _i3.Role? role,
    int? timeUnits,
    Object? pupilsAuth = _Undefined,
    int? credit,
    bool? changedPassword,
    DateTime? passwordLastChanged,
  }) {
    return Staff(
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
      changedPassword: changedPassword ?? this.changedPassword,
      passwordLastChanged: passwordLastChanged ?? this.passwordLastChanged,
    );
  }
}
