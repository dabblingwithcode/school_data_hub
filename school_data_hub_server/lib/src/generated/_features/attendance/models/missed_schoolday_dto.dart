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
import '../../../_features/attendance/models/missed_schoolday.dart' as _i2;

abstract class MissedSchooldayDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  MissedSchooldayDto._({
    required this.missedSchoolday,
    required this.operation,
  });

  factory MissedSchooldayDto({
    required _i2.MissedSchoolday missedSchoolday,
    required String operation,
  }) = _MissedSchooldayDtoImpl;

  factory MissedSchooldayDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return MissedSchooldayDto(
      missedSchoolday: _i2.MissedSchoolday.fromJson(
          (jsonSerialization['missedSchoolday'] as Map<String, dynamic>)),
      operation: jsonSerialization['operation'] as String,
    );
  }

  _i2.MissedSchoolday missedSchoolday;

  String operation;

  /// Returns a shallow copy of this [MissedSchooldayDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MissedSchooldayDto copyWith({
    _i2.MissedSchoolday? missedSchoolday,
    String? operation,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'missedSchoolday': missedSchoolday.toJson(),
      'operation': operation,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'missedSchoolday': missedSchoolday.toJsonForProtocol(),
      'operation': operation,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MissedSchooldayDtoImpl extends MissedSchooldayDto {
  _MissedSchooldayDtoImpl({
    required _i2.MissedSchoolday missedSchoolday,
    required String operation,
  }) : super._(
          missedSchoolday: missedSchoolday,
          operation: operation,
        );

  /// Returns a shallow copy of this [MissedSchooldayDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MissedSchooldayDto copyWith({
    _i2.MissedSchoolday? missedSchoolday,
    String? operation,
  }) {
    return MissedSchooldayDto(
      missedSchoolday: missedSchoolday ?? this.missedSchoolday.copyWith(),
      operation: operation ?? this.operation,
    );
  }
}
