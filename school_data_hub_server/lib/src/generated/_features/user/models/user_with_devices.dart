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
import '../../../_features/user/models/staff_user.dart' as _i2;
import '../../../_features/auth/models/user_device.dart' as _i3;

abstract class UserWithDevices
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UserWithDevices._({
    required this.user,
    required this.userDevices,
  });

  factory UserWithDevices({
    required _i2.User user,
    required List<_i3.UserDevice> userDevices,
  }) = _UserWithDevicesImpl;

  factory UserWithDevices.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserWithDevices(
      user: _i2.User.fromJson(
          (jsonSerialization['user'] as Map<String, dynamic>)),
      userDevices: (jsonSerialization['userDevices'] as List)
          .map((e) => _i3.UserDevice.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.User user;

  List<_i3.UserDevice> userDevices;

  /// Returns a shallow copy of this [UserWithDevices]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserWithDevices copyWith({
    _i2.User? user,
    List<_i3.UserDevice>? userDevices,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'userDevices': userDevices.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'user': user.toJsonForProtocol(),
      'userDevices':
          userDevices.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UserWithDevicesImpl extends UserWithDevices {
  _UserWithDevicesImpl({
    required _i2.User user,
    required List<_i3.UserDevice> userDevices,
  }) : super._(
          user: user,
          userDevices: userDevices,
        );

  /// Returns a shallow copy of this [UserWithDevices]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserWithDevices copyWith({
    _i2.User? user,
    List<_i3.UserDevice>? userDevices,
  }) {
    return UserWithDevices(
      user: user ?? this.user.copyWith(),
      userDevices:
          userDevices ?? this.userDevices.map((e0) => e0.copyWith()).toList(),
    );
  }
}
