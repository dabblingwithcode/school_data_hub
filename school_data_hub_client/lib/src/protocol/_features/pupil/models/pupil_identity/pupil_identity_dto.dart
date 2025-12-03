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

abstract class PupilIdentityDto implements _i1.SerializableModel {
  PupilIdentityDto._({
    required this.sender,
    required this.type,
    this.dataTimeStamp,
    required this.value,
  });

  factory PupilIdentityDto({
    required String sender,
    required String type,
    DateTime? dataTimeStamp,
    required String value,
  }) = _PupilIdentityDtoImpl;

  factory PupilIdentityDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilIdentityDto(
      sender: jsonSerialization['sender'] as String,
      type: jsonSerialization['type'] as String,
      dataTimeStamp: jsonSerialization['dataTimeStamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['dataTimeStamp']),
      value: jsonSerialization['value'] as String,
    );
  }

  String sender;

  String type;

  DateTime? dataTimeStamp;

  String value;

  /// Returns a shallow copy of this [PupilIdentityDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilIdentityDto copyWith({
    String? sender,
    String? type,
    DateTime? dataTimeStamp,
    String? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'type': type,
      if (dataTimeStamp != null) 'dataTimeStamp': dataTimeStamp?.toJson(),
      'value': value,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilIdentityDtoImpl extends PupilIdentityDto {
  _PupilIdentityDtoImpl({
    required String sender,
    required String type,
    DateTime? dataTimeStamp,
    required String value,
  }) : super._(
          sender: sender,
          type: type,
          dataTimeStamp: dataTimeStamp,
          value: value,
        );

  /// Returns a shallow copy of this [PupilIdentityDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilIdentityDto copyWith({
    String? sender,
    String? type,
    Object? dataTimeStamp = _Undefined,
    String? value,
  }) {
    return PupilIdentityDto(
      sender: sender ?? this.sender,
      type: type ?? this.type,
      dataTimeStamp:
          dataTimeStamp is DateTime? ? dataTimeStamp : this.dataTimeStamp,
      value: value ?? this.value,
    );
  }
}
