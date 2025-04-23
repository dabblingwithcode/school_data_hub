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
import '../../schoolday/missed_class/missed_class.dart' as _i2;

abstract class MissedClassDto implements _i1.SerializableModel {
  MissedClassDto._({
    required this.missedClass,
    required this.operation,
  });

  factory MissedClassDto({
    required _i2.MissedClass missedClass,
    required String operation,
  }) = _MissedClassDtoImpl;

  factory MissedClassDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return MissedClassDto(
      missedClass: _i2.MissedClass.fromJson(
          (jsonSerialization['missedClass'] as Map<String, dynamic>)),
      operation: jsonSerialization['operation'] as String,
    );
  }

  _i2.MissedClass missedClass;

  String operation;

  /// Returns a shallow copy of this [MissedClassDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MissedClassDto copyWith({
    _i2.MissedClass? missedClass,
    String? operation,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'missedClass': missedClass.toJson(),
      'operation': operation,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MissedClassDtoImpl extends MissedClassDto {
  _MissedClassDtoImpl({
    required _i2.MissedClass missedClass,
    required String operation,
  }) : super._(
          missedClass: missedClass,
          operation: operation,
        );

  /// Returns a shallow copy of this [MissedClassDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MissedClassDto copyWith({
    _i2.MissedClass? missedClass,
    String? operation,
  }) {
    return MissedClassDto(
      missedClass: missedClass ?? this.missedClass.copyWith(),
      operation: operation ?? this.operation,
    );
  }
}
