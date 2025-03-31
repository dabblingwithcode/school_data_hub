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
import '../../learning_support/support_goal/support_goal_check.dart' as _i2;

abstract class SupportGoalCheckFile implements _i1.SerializableModel {
  SupportGoalCheckFile._({
    this.id,
    required this.fileId,
    required this.createdBy,
    required this.createdAt,
    required this.fileUrl,
    required this.supportGoalCheckId,
    this.supportGoalCheck,
  });

  factory SupportGoalCheckFile({
    int? id,
    required String fileId,
    required String createdBy,
    required DateTime createdAt,
    required String fileUrl,
    required int supportGoalCheckId,
    _i2.SupportGoalCheck? supportGoalCheck,
  }) = _SupportGoalCheckFileImpl;

  factory SupportGoalCheckFile.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SupportGoalCheckFile(
      id: jsonSerialization['id'] as int?,
      fileId: jsonSerialization['fileId'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      fileUrl: jsonSerialization['fileUrl'] as String,
      supportGoalCheckId: jsonSerialization['supportGoalCheckId'] as int,
      supportGoalCheck: jsonSerialization['supportGoalCheck'] == null
          ? null
          : _i2.SupportGoalCheck.fromJson(
              (jsonSerialization['supportGoalCheck'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String fileId;

  String createdBy;

  DateTime createdAt;

  String fileUrl;

  int supportGoalCheckId;

  _i2.SupportGoalCheck? supportGoalCheck;

  /// Returns a shallow copy of this [SupportGoalCheckFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportGoalCheckFile copyWith({
    int? id,
    String? fileId,
    String? createdBy,
    DateTime? createdAt,
    String? fileUrl,
    int? supportGoalCheckId,
    _i2.SupportGoalCheck? supportGoalCheck,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'fileId': fileId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'fileUrl': fileUrl,
      'supportGoalCheckId': supportGoalCheckId,
      if (supportGoalCheck != null)
        'supportGoalCheck': supportGoalCheck?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportGoalCheckFileImpl extends SupportGoalCheckFile {
  _SupportGoalCheckFileImpl({
    int? id,
    required String fileId,
    required String createdBy,
    required DateTime createdAt,
    required String fileUrl,
    required int supportGoalCheckId,
    _i2.SupportGoalCheck? supportGoalCheck,
  }) : super._(
          id: id,
          fileId: fileId,
          createdBy: createdBy,
          createdAt: createdAt,
          fileUrl: fileUrl,
          supportGoalCheckId: supportGoalCheckId,
          supportGoalCheck: supportGoalCheck,
        );

  /// Returns a shallow copy of this [SupportGoalCheckFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportGoalCheckFile copyWith({
    Object? id = _Undefined,
    String? fileId,
    String? createdBy,
    DateTime? createdAt,
    String? fileUrl,
    int? supportGoalCheckId,
    Object? supportGoalCheck = _Undefined,
  }) {
    return SupportGoalCheckFile(
      id: id is int? ? id : this.id,
      fileId: fileId ?? this.fileId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      fileUrl: fileUrl ?? this.fileUrl,
      supportGoalCheckId: supportGoalCheckId ?? this.supportGoalCheckId,
      supportGoalCheck: supportGoalCheck is _i2.SupportGoalCheck?
          ? supportGoalCheck
          : this.supportGoalCheck?.copyWith(),
    );
  }
}
