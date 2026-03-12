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

abstract class ForceLogoutEvent implements _i1.SerializableModel {
  ForceLogoutEvent._({
    required this.userInfoId,
    required this.deviceId,
  });

  factory ForceLogoutEvent({
    required int userInfoId,
    required String deviceId,
  }) = _ForceLogoutEventImpl;

  factory ForceLogoutEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return ForceLogoutEvent(
      userInfoId: jsonSerialization['userInfoId'] as int,
      deviceId: jsonSerialization['deviceId'] as String,
    );
  }

  int userInfoId;

  String deviceId;

  /// Returns a shallow copy of this [ForceLogoutEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ForceLogoutEvent copyWith({
    int? userInfoId,
    String? deviceId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'userInfoId': userInfoId,
      'deviceId': deviceId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ForceLogoutEventImpl extends ForceLogoutEvent {
  _ForceLogoutEventImpl({
    required int userInfoId,
    required String deviceId,
  }) : super._(
          userInfoId: userInfoId,
          deviceId: deviceId,
        );

  /// Returns a shallow copy of this [ForceLogoutEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ForceLogoutEvent copyWith({
    int? userInfoId,
    String? deviceId,
  }) {
    return ForceLogoutEvent(
      userInfoId: userInfoId ?? this.userInfoId,
      deviceId: deviceId ?? this.deviceId,
    );
  }
}
