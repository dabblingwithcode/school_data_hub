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

abstract class SupportLevelLegacyDto implements _i1.SerializableModel {
  SupportLevelLegacyDto._({
    required this.pupilId,
    required this.level,
    this.comment,
    this.createdAt,
    this.createdBy,
  });

  factory SupportLevelLegacyDto({
    required int pupilId,
    required int level,
    String? comment,
    DateTime? createdAt,
    String? createdBy,
  }) = _SupportLevelLegacyDtoImpl;

  factory SupportLevelLegacyDto.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SupportLevelLegacyDto(
      pupilId: jsonSerialization['pupilId'] as int,
      level: jsonSerialization['level'] as int,
      comment: jsonSerialization['comment'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      createdBy: jsonSerialization['createdBy'] as String?,
    );
  }

  int pupilId;

  int level;

  String? comment;

  DateTime? createdAt;

  String? createdBy;

  /// Returns a shallow copy of this [SupportLevelLegacyDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportLevelLegacyDto copyWith({
    int? pupilId,
    int? level,
    String? comment,
    DateTime? createdAt,
    String? createdBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'pupilId': pupilId,
      'level': level,
      if (comment != null) 'comment': comment,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (createdBy != null) 'createdBy': createdBy,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportLevelLegacyDtoImpl extends SupportLevelLegacyDto {
  _SupportLevelLegacyDtoImpl({
    required int pupilId,
    required int level,
    String? comment,
    DateTime? createdAt,
    String? createdBy,
  }) : super._(
          pupilId: pupilId,
          level: level,
          comment: comment,
          createdAt: createdAt,
          createdBy: createdBy,
        );

  /// Returns a shallow copy of this [SupportLevelLegacyDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportLevelLegacyDto copyWith({
    int? pupilId,
    int? level,
    Object? comment = _Undefined,
    Object? createdAt = _Undefined,
    Object? createdBy = _Undefined,
  }) {
    return SupportLevelLegacyDto(
      pupilId: pupilId ?? this.pupilId,
      level: level ?? this.level,
      comment: comment is String? ? comment : this.comment,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      createdBy: createdBy is String? ? createdBy : this.createdBy,
    );
  }
}
