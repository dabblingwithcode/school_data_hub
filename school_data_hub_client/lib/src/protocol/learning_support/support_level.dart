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
import '../pupil_data/pupil_data.dart' as _i2;

/// support level class
abstract class SupportLevel implements _i1.SerializableModel {
  SupportLevel._({
    this.id,
    required this.level,
    required this.comment,
    required this.createdAt,
    required this.createdBy,
    required this.pupilIdId,
    this.pupilId,
  });

  factory SupportLevel({
    int? id,
    required int level,
    required String comment,
    required DateTime createdAt,
    required String createdBy,
    required int pupilIdId,
    _i2.PupilData? pupilId,
  }) = _SupportLevelImpl;

  factory SupportLevel.fromJson(Map<String, dynamic> jsonSerialization) {
    return SupportLevel(
      id: jsonSerialization['id'] as int?,
      level: jsonSerialization['level'] as int,
      comment: jsonSerialization['comment'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      createdBy: jsonSerialization['createdBy'] as String,
      pupilIdId: jsonSerialization['pupilIdId'] as int,
      pupilId: jsonSerialization['pupilId'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupilId'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int level;

  String comment;

  DateTime createdAt;

  String createdBy;

  int pupilIdId;

  _i2.PupilData? pupilId;

  /// Returns a shallow copy of this [SupportLevel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportLevel copyWith({
    int? id,
    int? level,
    String? comment,
    DateTime? createdAt,
    String? createdBy,
    int? pupilIdId,
    _i2.PupilData? pupilId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'level': level,
      'comment': comment,
      'createdAt': createdAt.toJson(),
      'createdBy': createdBy,
      'pupilIdId': pupilIdId,
      if (pupilId != null) 'pupilId': pupilId?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportLevelImpl extends SupportLevel {
  _SupportLevelImpl({
    int? id,
    required int level,
    required String comment,
    required DateTime createdAt,
    required String createdBy,
    required int pupilIdId,
    _i2.PupilData? pupilId,
  }) : super._(
          id: id,
          level: level,
          comment: comment,
          createdAt: createdAt,
          createdBy: createdBy,
          pupilIdId: pupilIdId,
          pupilId: pupilId,
        );

  /// Returns a shallow copy of this [SupportLevel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportLevel copyWith({
    Object? id = _Undefined,
    int? level,
    String? comment,
    DateTime? createdAt,
    String? createdBy,
    int? pupilIdId,
    Object? pupilId = _Undefined,
  }) {
    return SupportLevel(
      id: id is int? ? id : this.id,
      level: level ?? this.level,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      pupilIdId: pupilIdId ?? this.pupilIdId,
      pupilId: pupilId is _i2.PupilData? ? pupilId : this.pupilId?.copyWith(),
    );
  }
}
