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

abstract class UserDevice implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userInfoId;

  _i2.UserInfo? userInfo;

  String deviceId;

  String deviceName;

  DateTime lastLogin;

  bool isActive;

  int authId;

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
