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
import '../../../_features/learning_support/models/support_level.dart' as _i2;
import '../../../_features/pupil/models/pupil_data/pupil_data.dart' as _i3;
import '../../../_features/learning_support/models/support_category_status.dart'
    as _i4;
import '../../../_features/learning_support/models/support_goal/support_goal.dart'
    as _i5;
import '../../../_features/schoolday/models/school_semester.dart' as _i6;

abstract class LearningSupportPlan implements _i1.SerializableModel {
  LearningSupportPlan._({
    this.id,
    required this.planId,
    this.number,
    required this.createdBy,
    this.socialPedagogue,
    this.proffesionalsInvolved,
    this.strengthsDescription,
    this.problemsDescription,
    required this.learningSupportLevelId,
    this.learningSupportLevel,
    required this.createdAt,
    this.comment,
    required this.pupilId,
    this.pupil,
    this.supportCategoryStatuses,
    this.supportGoals,
    required this.schoolSemesterId,
    this.schoolSemester,
  });

  factory LearningSupportPlan({
    int? id,
    required String planId,
    int? number,
    required String createdBy,
    String? socialPedagogue,
    String? proffesionalsInvolved,
    String? strengthsDescription,
    String? problemsDescription,
    required int learningSupportLevelId,
    _i2.SupportLevel? learningSupportLevel,
    required DateTime createdAt,
    String? comment,
    required int pupilId,
    _i3.PupilData? pupil,
    List<_i4.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i5.SupportGoal>? supportGoals,
    required int schoolSemesterId,
    _i6.SchoolSemester? schoolSemester,
  }) = _LearningSupportPlanImpl;

  factory LearningSupportPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return LearningSupportPlan(
      id: jsonSerialization['id'] as int?,
      planId: jsonSerialization['planId'] as String,
      number: jsonSerialization['number'] as int?,
      createdBy: jsonSerialization['createdBy'] as String,
      socialPedagogue: jsonSerialization['socialPedagogue'] as String?,
      proffesionalsInvolved:
          jsonSerialization['proffesionalsInvolved'] as String?,
      strengthsDescription:
          jsonSerialization['strengthsDescription'] as String?,
      problemsDescription: jsonSerialization['problemsDescription'] as String?,
      learningSupportLevelId:
          jsonSerialization['learningSupportLevelId'] as int,
      learningSupportLevel: jsonSerialization['learningSupportLevel'] == null
          ? null
          : _i2.SupportLevel.fromJson((jsonSerialization['learningSupportLevel']
              as Map<String, dynamic>)),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      comment: jsonSerialization['comment'] as String?,
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i3.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      supportCategoryStatuses: (jsonSerialization['supportCategoryStatuses']
              as List?)
          ?.map((e) =>
              _i4.SupportCategoryStatus.fromJson((e as Map<String, dynamic>)))
          .toList(),
      supportGoals: (jsonSerialization['supportGoals'] as List?)
          ?.map((e) => _i5.SupportGoal.fromJson((e as Map<String, dynamic>)))
          .toList(),
      schoolSemesterId: jsonSerialization['schoolSemesterId'] as int,
      schoolSemester: jsonSerialization['schoolSemester'] == null
          ? null
          : _i6.SchoolSemester.fromJson(
              (jsonSerialization['schoolSemester'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String planId;

  int? number;

  String createdBy;

  String? socialPedagogue;

  String? proffesionalsInvolved;

  String? strengthsDescription;

  String? problemsDescription;

  int learningSupportLevelId;

  _i2.SupportLevel? learningSupportLevel;

  DateTime createdAt;

  String? comment;

  int pupilId;

  _i3.PupilData? pupil;

  List<_i4.SupportCategoryStatus>? supportCategoryStatuses;

  List<_i5.SupportGoal>? supportGoals;

  int schoolSemesterId;

  _i6.SchoolSemester? schoolSemester;

  /// Returns a shallow copy of this [LearningSupportPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LearningSupportPlan copyWith({
    int? id,
    String? planId,
    int? number,
    String? createdBy,
    String? socialPedagogue,
    String? proffesionalsInvolved,
    String? strengthsDescription,
    String? problemsDescription,
    int? learningSupportLevelId,
    _i2.SupportLevel? learningSupportLevel,
    DateTime? createdAt,
    String? comment,
    int? pupilId,
    _i3.PupilData? pupil,
    List<_i4.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i5.SupportGoal>? supportGoals,
    int? schoolSemesterId,
    _i6.SchoolSemester? schoolSemester,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'planId': planId,
      if (number != null) 'number': number,
      'createdBy': createdBy,
      if (socialPedagogue != null) 'socialPedagogue': socialPedagogue,
      if (proffesionalsInvolved != null)
        'proffesionalsInvolved': proffesionalsInvolved,
      if (strengthsDescription != null)
        'strengthsDescription': strengthsDescription,
      if (problemsDescription != null)
        'problemsDescription': problemsDescription,
      'learningSupportLevelId': learningSupportLevelId,
      if (learningSupportLevel != null)
        'learningSupportLevel': learningSupportLevel?.toJson(),
      'createdAt': createdAt.toJson(),
      if (comment != null) 'comment': comment,
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      if (supportCategoryStatuses != null)
        'supportCategoryStatuses':
            supportCategoryStatuses?.toJson(valueToJson: (v) => v.toJson()),
      if (supportGoals != null)
        'supportGoals': supportGoals?.toJson(valueToJson: (v) => v.toJson()),
      'schoolSemesterId': schoolSemesterId,
      if (schoolSemester != null) 'schoolSemester': schoolSemester?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LearningSupportPlanImpl extends LearningSupportPlan {
  _LearningSupportPlanImpl({
    int? id,
    required String planId,
    int? number,
    required String createdBy,
    String? socialPedagogue,
    String? proffesionalsInvolved,
    String? strengthsDescription,
    String? problemsDescription,
    required int learningSupportLevelId,
    _i2.SupportLevel? learningSupportLevel,
    required DateTime createdAt,
    String? comment,
    required int pupilId,
    _i3.PupilData? pupil,
    List<_i4.SupportCategoryStatus>? supportCategoryStatuses,
    List<_i5.SupportGoal>? supportGoals,
    required int schoolSemesterId,
    _i6.SchoolSemester? schoolSemester,
  }) : super._(
          id: id,
          planId: planId,
          number: number,
          createdBy: createdBy,
          socialPedagogue: socialPedagogue,
          proffesionalsInvolved: proffesionalsInvolved,
          strengthsDescription: strengthsDescription,
          problemsDescription: problemsDescription,
          learningSupportLevelId: learningSupportLevelId,
          learningSupportLevel: learningSupportLevel,
          createdAt: createdAt,
          comment: comment,
          pupilId: pupilId,
          pupil: pupil,
          supportCategoryStatuses: supportCategoryStatuses,
          supportGoals: supportGoals,
          schoolSemesterId: schoolSemesterId,
          schoolSemester: schoolSemester,
        );

  /// Returns a shallow copy of this [LearningSupportPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LearningSupportPlan copyWith({
    Object? id = _Undefined,
    String? planId,
    Object? number = _Undefined,
    String? createdBy,
    Object? socialPedagogue = _Undefined,
    Object? proffesionalsInvolved = _Undefined,
    Object? strengthsDescription = _Undefined,
    Object? problemsDescription = _Undefined,
    int? learningSupportLevelId,
    Object? learningSupportLevel = _Undefined,
    DateTime? createdAt,
    Object? comment = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
    Object? supportCategoryStatuses = _Undefined,
    Object? supportGoals = _Undefined,
    int? schoolSemesterId,
    Object? schoolSemester = _Undefined,
  }) {
    return LearningSupportPlan(
      id: id is int? ? id : this.id,
      planId: planId ?? this.planId,
      number: number is int? ? number : this.number,
      createdBy: createdBy ?? this.createdBy,
      socialPedagogue:
          socialPedagogue is String? ? socialPedagogue : this.socialPedagogue,
      proffesionalsInvolved: proffesionalsInvolved is String?
          ? proffesionalsInvolved
          : this.proffesionalsInvolved,
      strengthsDescription: strengthsDescription is String?
          ? strengthsDescription
          : this.strengthsDescription,
      problemsDescription: problemsDescription is String?
          ? problemsDescription
          : this.problemsDescription,
      learningSupportLevelId:
          learningSupportLevelId ?? this.learningSupportLevelId,
      learningSupportLevel: learningSupportLevel is _i2.SupportLevel?
          ? learningSupportLevel
          : this.learningSupportLevel?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      comment: comment is String? ? comment : this.comment,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i3.PupilData? ? pupil : this.pupil?.copyWith(),
      supportCategoryStatuses: supportCategoryStatuses
              is List<_i4.SupportCategoryStatus>?
          ? supportCategoryStatuses
          : this.supportCategoryStatuses?.map((e0) => e0.copyWith()).toList(),
      supportGoals: supportGoals is List<_i5.SupportGoal>?
          ? supportGoals
          : this.supportGoals?.map((e0) => e0.copyWith()).toList(),
      schoolSemesterId: schoolSemesterId ?? this.schoolSemesterId,
      schoolSemester: schoolSemester is _i6.SchoolSemester?
          ? schoolSemester
          : this.schoolSemester?.copyWith(),
    );
  }
}
