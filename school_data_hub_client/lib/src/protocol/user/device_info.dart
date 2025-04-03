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

abstract class DeviceInfo implements _i1.SerializableModel {
  DeviceInfo._({
    required this.deviceId,
    required this.deviceName,
  });

  factory DeviceInfo({
    required String deviceId,
    required String deviceName,
  }) = _DeviceInfoImpl;

  factory DeviceInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceInfo(
      deviceId: jsonSerialization['deviceId'] as String,
      deviceName: jsonSerialization['deviceName'] as String,
    );
  }

  String deviceId;

  String deviceName;

  /// Returns a shallow copy of this [DeviceInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceInfo copyWith({
    String? deviceId,
    String? deviceName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'deviceName': deviceName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DeviceInfoImpl extends DeviceInfo {
  _DeviceInfoImpl({
    required String deviceId,
    required String deviceName,
  }) : super._(
          deviceId: deviceId,
          deviceName: deviceName,
        );

  /// Returns a shallow copy of this [DeviceInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceInfo copyWith({
    String? deviceId,
    String? deviceName,
  }) {
    return DeviceInfo(
      deviceId: deviceId ?? this.deviceId,
      deviceName: deviceName ?? this.deviceName,
    );
  }
}
