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

abstract class PupilIdentityDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PupilIdentityDto._({
    required this.type,
    required this.value,
  });

  factory PupilIdentityDto({
    required String type,
    required String value,
  }) = _PupilIdentityDtoImpl;

  factory PupilIdentityDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilIdentityDto(
      type: jsonSerialization['type'] as String,
      value: jsonSerialization['value'] as String,
    );
  }

  String type;

  String value;

  /// Returns a shallow copy of this [PupilIdentityDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilIdentityDto copyWith({
    String? type,
    String? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'type': type,
      'value': value,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PupilIdentityDtoImpl extends PupilIdentityDto {
  _PupilIdentityDtoImpl({
    required String type,
    required String value,
  }) : super._(
          type: type,
          value: value,
        );

  /// Returns a shallow copy of this [PupilIdentityDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilIdentityDto copyWith({
    String? type,
    String? value,
  }) {
    return PupilIdentityDto(
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }
}
