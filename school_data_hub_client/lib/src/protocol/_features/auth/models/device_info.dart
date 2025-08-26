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
    this.identitiesLastUpdated,
  });

  factory DeviceInfo({
    required String deviceId,
    required String deviceName,
    DateTime? identitiesLastUpdated,
  }) = _DeviceInfoImpl;

  factory DeviceInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceInfo(
      deviceId: jsonSerialization['deviceId'] as String,
      deviceName: jsonSerialization['deviceName'] as String,
      identitiesLastUpdated: jsonSerialization['identitiesLastUpdated'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['identitiesLastUpdated']),
    );
  }

  String deviceId;

  String deviceName;

  DateTime? identitiesLastUpdated;

  /// Returns a shallow copy of this [DeviceInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceInfo copyWith({
    String? deviceId,
    String? deviceName,
    DateTime? identitiesLastUpdated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'deviceName': deviceName,
      if (identitiesLastUpdated != null)
        'identitiesLastUpdated': identitiesLastUpdated?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceInfoImpl extends DeviceInfo {
  _DeviceInfoImpl({
    required String deviceId,
    required String deviceName,
    DateTime? identitiesLastUpdated,
  }) : super._(
          deviceId: deviceId,
          deviceName: deviceName,
          identitiesLastUpdated: identitiesLastUpdated,
        );

  /// Returns a shallow copy of this [DeviceInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceInfo copyWith({
    String? deviceId,
    String? deviceName,
    Object? identitiesLastUpdated = _Undefined,
  }) {
    return DeviceInfo(
      deviceId: deviceId ?? this.deviceId,
      deviceName: deviceName ?? this.deviceName,
      identitiesLastUpdated: identitiesLastUpdated is DateTime?
          ? identitiesLastUpdated
          : this.identitiesLastUpdated,
    );
  }
}
