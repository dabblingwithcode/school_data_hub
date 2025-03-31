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
import '../../learning_support/support_goal/support_goal_check_file.dart'
    as _i2;
import '../../learning_support/support_goal/support_goal.dart' as _i3;

abstract class SupportGoalCheck implements _i1.SerializableModel {
  SupportGoalCheck._({
    this.id,
    required this.checkId,
    required this.createdBy,
    required this.createdAt,
    required this.achieved,
    required this.comment,
    this.supportGoalCheckFiles,
    required this.supportGoalId,
    this.supportGoal,
  });

  factory SupportGoalCheck({
    int? id,
    required String checkId,
    required String createdBy,
    required DateTime createdAt,
    required int achieved,
    required String comment,
    List<_i2.SupportGoalCheckFile>? supportGoalCheckFiles,
    required int supportGoalId,
    _i3.SupportGoal? supportGoal,
  }) = _SupportGoalCheckImpl;

  factory SupportGoalCheck.fromJson(Map<String, dynamic> jsonSerialization) {
    return SupportGoalCheck(
      id: jsonSerialization['id'] as int?,
      checkId: jsonSerialization['checkId'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      achieved: jsonSerialization['achieved'] as int,
      comment: jsonSerialization['comment'] as String,
      supportGoalCheckFiles: (jsonSerialization['supportGoalCheckFiles']
              as List?)
          ?.map((e) =>
              _i2.SupportGoalCheckFile.fromJson((e as Map<String, dynamic>)))
          .toList(),
      supportGoalId: jsonSerialization['supportGoalId'] as int,
      supportGoal: jsonSerialization['supportGoal'] == null
          ? null
          : _i3.SupportGoal.fromJson(
              (jsonSerialization['supportGoal'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String checkId;

  String createdBy;

  DateTime createdAt;

  int achieved;

  String comment;

  List<_i2.SupportGoalCheckFile>? supportGoalCheckFiles;

  int supportGoalId;

  _i3.SupportGoal? supportGoal;

  /// Returns a shallow copy of this [SupportGoalCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportGoalCheck copyWith({
    int? id,
    String? checkId,
    String? createdBy,
    DateTime? createdAt,
    int? achieved,
    String? comment,
    List<_i2.SupportGoalCheckFile>? supportGoalCheckFiles,
    int? supportGoalId,
    _i3.SupportGoal? supportGoal,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'checkId': checkId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'achieved': achieved,
      'comment': comment,
      if (supportGoalCheckFiles != null)
        'supportGoalCheckFiles':
            supportGoalCheckFiles?.toJson(valueToJson: (v) => v.toJson()),
      'supportGoalId': supportGoalId,
      if (supportGoal != null) 'supportGoal': supportGoal?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportGoalCheckImpl extends SupportGoalCheck {
  _SupportGoalCheckImpl({
    int? id,
    required String checkId,
    required String createdBy,
    required DateTime createdAt,
    required int achieved,
    required String comment,
    List<_i2.SupportGoalCheckFile>? supportGoalCheckFiles,
    required int supportGoalId,
    _i3.SupportGoal? supportGoal,
  }) : super._(
          id: id,
          checkId: checkId,
          createdBy: createdBy,
          createdAt: createdAt,
          achieved: achieved,
          comment: comment,
          supportGoalCheckFiles: supportGoalCheckFiles,
          supportGoalId: supportGoalId,
          supportGoal: supportGoal,
        );

  /// Returns a shallow copy of this [SupportGoalCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportGoalCheck copyWith({
    Object? id = _Undefined,
    String? checkId,
    String? createdBy,
    DateTime? createdAt,
    int? achieved,
    String? comment,
    Object? supportGoalCheckFiles = _Undefined,
    int? supportGoalId,
    Object? supportGoal = _Undefined,
  }) {
    return SupportGoalCheck(
      id: id is int? ? id : this.id,
      checkId: checkId ?? this.checkId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      achieved: achieved ?? this.achieved,
      comment: comment ?? this.comment,
      supportGoalCheckFiles:
          supportGoalCheckFiles is List<_i2.SupportGoalCheckFile>?
              ? supportGoalCheckFiles
              : this.supportGoalCheckFiles?.map((e0) => e0.copyWith()).toList(),
      supportGoalId: supportGoalId ?? this.supportGoalId,
      supportGoal: supportGoal is _i3.SupportGoal?
          ? supportGoal
          : this.supportGoal?.copyWith(),
    );
  }
}
