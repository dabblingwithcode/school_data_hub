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
import '../../../_features/user/models/roles.dart' as _i2;

abstract class CreateUserRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CreateUserRequest._({
    required this.userName,
    required this.fullName,
    required this.email,
    required this.password,
    required this.role,
    required this.timeUnits,
    required this.reliefTimeUnits,
    required this.scopeNames,
    required this.isTester,
    this.matrixUserId,
    this.credit,
    this.pupilsAuth,
  });

  factory CreateUserRequest({
    required String userName,
    required String fullName,
    required String email,
    required String password,
    required _i2.Role role,
    required int timeUnits,
    required int reliefTimeUnits,
    required List<String> scopeNames,
    required bool isTester,
    String? matrixUserId,
    int? credit,
    Set<int>? pupilsAuth,
  }) = _CreateUserRequestImpl;

  factory CreateUserRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return CreateUserRequest(
      userName: jsonSerialization['userName'] as String,
      fullName: jsonSerialization['fullName'] as String,
      email: jsonSerialization['email'] as String,
      password: jsonSerialization['password'] as String,
      role: _i2.Role.fromJson((jsonSerialization['role'] as String)),
      timeUnits: jsonSerialization['timeUnits'] as int,
      reliefTimeUnits: jsonSerialization['reliefTimeUnits'] as int,
      scopeNames: (jsonSerialization['scopeNames'] as List)
          .map((e) => e as String)
          .toList(),
      isTester: jsonSerialization['isTester'] as bool,
      matrixUserId: jsonSerialization['matrixUserId'] as String?,
      credit: jsonSerialization['credit'] as int?,
      pupilsAuth: jsonSerialization['pupilsAuth'] == null
          ? null
          : _i1.SetJsonExtension.fromJson(
              (jsonSerialization['pupilsAuth'] as List),
              itemFromJson: (e) => e as int),
    );
  }

  String userName;

  String fullName;

  String email;

  String password;

  _i2.Role role;

  int timeUnits;

  int reliefTimeUnits;

  List<String> scopeNames;

  bool isTester;

  String? matrixUserId;

  int? credit;

  Set<int>? pupilsAuth;

  /// Returns a shallow copy of this [CreateUserRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateUserRequest copyWith({
    String? userName,
    String? fullName,
    String? email,
    String? password,
    _i2.Role? role,
    int? timeUnits,
    int? reliefTimeUnits,
    List<String>? scopeNames,
    bool? isTester,
    String? matrixUserId,
    int? credit,
    Set<int>? pupilsAuth,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'fullName': fullName,
      'email': email,
      'password': password,
      'role': role.toJson(),
      'timeUnits': timeUnits,
      'reliefTimeUnits': reliefTimeUnits,
      'scopeNames': scopeNames.toJson(),
      'isTester': isTester,
      if (matrixUserId != null) 'matrixUserId': matrixUserId,
      if (credit != null) 'credit': credit,
      if (pupilsAuth != null) 'pupilsAuth': pupilsAuth?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'userName': userName,
      'fullName': fullName,
      'email': email,
      'password': password,
      'role': role.toJson(),
      'timeUnits': timeUnits,
      'reliefTimeUnits': reliefTimeUnits,
      'scopeNames': scopeNames.toJson(),
      'isTester': isTester,
      if (matrixUserId != null) 'matrixUserId': matrixUserId,
      if (credit != null) 'credit': credit,
      if (pupilsAuth != null) 'pupilsAuth': pupilsAuth?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateUserRequestImpl extends CreateUserRequest {
  _CreateUserRequestImpl({
    required String userName,
    required String fullName,
    required String email,
    required String password,
    required _i2.Role role,
    required int timeUnits,
    required int reliefTimeUnits,
    required List<String> scopeNames,
    required bool isTester,
    String? matrixUserId,
    int? credit,
    Set<int>? pupilsAuth,
  }) : super._(
          userName: userName,
          fullName: fullName,
          email: email,
          password: password,
          role: role,
          timeUnits: timeUnits,
          reliefTimeUnits: reliefTimeUnits,
          scopeNames: scopeNames,
          isTester: isTester,
          matrixUserId: matrixUserId,
          credit: credit,
          pupilsAuth: pupilsAuth,
        );

  /// Returns a shallow copy of this [CreateUserRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateUserRequest copyWith({
    String? userName,
    String? fullName,
    String? email,
    String? password,
    _i2.Role? role,
    int? timeUnits,
    int? reliefTimeUnits,
    List<String>? scopeNames,
    bool? isTester,
    Object? matrixUserId = _Undefined,
    Object? credit = _Undefined,
    Object? pupilsAuth = _Undefined,
  }) {
    return CreateUserRequest(
      userName: userName ?? this.userName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      timeUnits: timeUnits ?? this.timeUnits,
      reliefTimeUnits: reliefTimeUnits ?? this.reliefTimeUnits,
      scopeNames: scopeNames ?? this.scopeNames.map((e0) => e0).toList(),
      isTester: isTester ?? this.isTester,
      matrixUserId: matrixUserId is String? ? matrixUserId : this.matrixUserId,
      credit: credit is int? ? credit : this.credit,
      pupilsAuth: pupilsAuth is Set<int>?
          ? pupilsAuth
          : this.pupilsAuth?.map((e0) => e0).toSet(),
    );
  }
}
