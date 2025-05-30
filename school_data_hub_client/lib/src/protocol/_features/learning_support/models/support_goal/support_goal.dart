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
import '../../../../_features/pupil/models/pupil_data/pupil_data.dart' as _i2;
import '../../../../_features/learning_support/models/support_category.dart'
    as _i3;
import '../../../../_features/learning_support/models/support_goal/support_goal_check.dart'
    as _i4;

abstract class SupportGoal implements _i1.SerializableModel {
  SupportGoal._({
    this.id,
    required this.goalId,
    required this.createdBy,
    required this.createdAt,
    required this.score,
    this.achievedAt,
    required this.description,
    required this.strategies,
    required this.pupilId,
    this.pupil,
    required this.supportCategoryId,
    this.supportCategory,
    this.goalChecks,
  });

  factory SupportGoal({
    int? id,
    required String goalId,
    required String createdBy,
    required DateTime createdAt,
    required int score,
    DateTime? achievedAt,
    required String description,
    required String strategies,
    required int pupilId,
    _i2.PupilData? pupil,
    required int supportCategoryId,
    _i3.SupportCategory? supportCategory,
    List<_i4.SupportGoalCheck>? goalChecks,
  }) = _SupportGoalImpl;

  factory SupportGoal.fromJson(Map<String, dynamic> jsonSerialization) {
    return SupportGoal(
      id: jsonSerialization['id'] as int?,
      goalId: jsonSerialization['goalId'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      score: jsonSerialization['score'] as int,
      achievedAt: jsonSerialization['achievedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['achievedAt']),
      description: jsonSerialization['description'] as String,
      strategies: jsonSerialization['strategies'] as String,
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      supportCategoryId: jsonSerialization['supportCategoryId'] as int,
      supportCategory: jsonSerialization['supportCategory'] == null
          ? null
          : _i3.SupportCategory.fromJson(
              (jsonSerialization['supportCategory'] as Map<String, dynamic>)),
      goalChecks: (jsonSerialization['goalChecks'] as List?)
          ?.map(
              (e) => _i4.SupportGoalCheck.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String goalId;

  String createdBy;

  DateTime createdAt;

  int score;

  DateTime? achievedAt;

  String description;

  String strategies;

  int pupilId;

  _i2.PupilData? pupil;

  int supportCategoryId;

  _i3.SupportCategory? supportCategory;

  List<_i4.SupportGoalCheck>? goalChecks;

  /// Returns a shallow copy of this [SupportGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportGoal copyWith({
    int? id,
    String? goalId,
    String? createdBy,
    DateTime? createdAt,
    int? score,
    DateTime? achievedAt,
    String? description,
    String? strategies,
    int? pupilId,
    _i2.PupilData? pupil,
    int? supportCategoryId,
    _i3.SupportCategory? supportCategory,
    List<_i4.SupportGoalCheck>? goalChecks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'goalId': goalId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'score': score,
      if (achievedAt != null) 'achievedAt': achievedAt?.toJson(),
      'description': description,
      'strategies': strategies,
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'supportCategoryId': supportCategoryId,
      if (supportCategory != null) 'supportCategory': supportCategory?.toJson(),
      if (goalChecks != null)
        'goalChecks': goalChecks?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportGoalImpl extends SupportGoal {
  _SupportGoalImpl({
    int? id,
    required String goalId,
    required String createdBy,
    required DateTime createdAt,
    required int score,
    DateTime? achievedAt,
    required String description,
    required String strategies,
    required int pupilId,
    _i2.PupilData? pupil,
    required int supportCategoryId,
    _i3.SupportCategory? supportCategory,
    List<_i4.SupportGoalCheck>? goalChecks,
  }) : super._(
          id: id,
          goalId: goalId,
          createdBy: createdBy,
          createdAt: createdAt,
          score: score,
          achievedAt: achievedAt,
          description: description,
          strategies: strategies,
          pupilId: pupilId,
          pupil: pupil,
          supportCategoryId: supportCategoryId,
          supportCategory: supportCategory,
          goalChecks: goalChecks,
        );

  /// Returns a shallow copy of this [SupportGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportGoal copyWith({
    Object? id = _Undefined,
    String? goalId,
    String? createdBy,
    DateTime? createdAt,
    int? score,
    Object? achievedAt = _Undefined,
    String? description,
    String? strategies,
    int? pupilId,
    Object? pupil = _Undefined,
    int? supportCategoryId,
    Object? supportCategory = _Undefined,
    Object? goalChecks = _Undefined,
  }) {
    return SupportGoal(
      id: id is int? ? id : this.id,
      goalId: goalId ?? this.goalId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      score: score ?? this.score,
      achievedAt: achievedAt is DateTime? ? achievedAt : this.achievedAt,
      description: description ?? this.description,
      strategies: strategies ?? this.strategies,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      supportCategoryId: supportCategoryId ?? this.supportCategoryId,
      supportCategory: supportCategory is _i3.SupportCategory?
          ? supportCategory
          : this.supportCategory?.copyWith(),
      goalChecks: goalChecks is List<_i4.SupportGoalCheck>?
          ? goalChecks
          : this.goalChecks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
