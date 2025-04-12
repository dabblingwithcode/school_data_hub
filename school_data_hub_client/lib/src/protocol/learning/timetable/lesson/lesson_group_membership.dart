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
import '../../../learning/timetable/lesson/lesson_group.dart' as _i2;
import '../../../pupil_data/pupil_data.dart' as _i3;

abstract class ScheduledLessonGroupMembership implements _i1.SerializableModel {
  ScheduledLessonGroupMembership._({
    this.id,
    required this.lessonGroupId,
    this.lessonGroup,
    required this.pupilDataId,
    this.pupilData,
  });

  factory ScheduledLessonGroupMembership({
    int? id,
    required int lessonGroupId,
    _i2.LessonGroup? lessonGroup,
    required int pupilDataId,
    _i3.PupilData? pupilData,
  }) = _ScheduledLessonGroupMembershipImpl;

  factory ScheduledLessonGroupMembership.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ScheduledLessonGroupMembership(
      id: jsonSerialization['id'] as int?,
      lessonGroupId: jsonSerialization['lessonGroupId'] as int,
      lessonGroup: jsonSerialization['lessonGroup'] == null
          ? null
          : _i2.LessonGroup.fromJson(
              (jsonSerialization['lessonGroup'] as Map<String, dynamic>)),
      pupilDataId: jsonSerialization['pupilDataId'] as int,
      pupilData: jsonSerialization['pupilData'] == null
          ? null
          : _i3.PupilData.fromJson(
              (jsonSerialization['pupilData'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int lessonGroupId;

  _i2.LessonGroup? lessonGroup;

  int pupilDataId;

  _i3.PupilData? pupilData;

  /// Returns a shallow copy of this [ScheduledLessonGroupMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduledLessonGroupMembership copyWith({
    int? id,
    int? lessonGroupId,
    _i2.LessonGroup? lessonGroup,
    int? pupilDataId,
    _i3.PupilData? pupilData,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'lessonGroupId': lessonGroupId,
      if (lessonGroup != null) 'lessonGroup': lessonGroup?.toJson(),
      'pupilDataId': pupilDataId,
      if (pupilData != null) 'pupilData': pupilData?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScheduledLessonGroupMembershipImpl
    extends ScheduledLessonGroupMembership {
  _ScheduledLessonGroupMembershipImpl({
    int? id,
    required int lessonGroupId,
    _i2.LessonGroup? lessonGroup,
    required int pupilDataId,
    _i3.PupilData? pupilData,
  }) : super._(
          id: id,
          lessonGroupId: lessonGroupId,
          lessonGroup: lessonGroup,
          pupilDataId: pupilDataId,
          pupilData: pupilData,
        );

  /// Returns a shallow copy of this [ScheduledLessonGroupMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduledLessonGroupMembership copyWith({
    Object? id = _Undefined,
    int? lessonGroupId,
    Object? lessonGroup = _Undefined,
    int? pupilDataId,
    Object? pupilData = _Undefined,
  }) {
    return ScheduledLessonGroupMembership(
      id: id is int? ? id : this.id,
      lessonGroupId: lessonGroupId ?? this.lessonGroupId,
      lessonGroup: lessonGroup is _i2.LessonGroup?
          ? lessonGroup
          : this.lessonGroup?.copyWith(),
      pupilDataId: pupilDataId ?? this.pupilDataId,
      pupilData:
          pupilData is _i3.PupilData? ? pupilData : this.pupilData?.copyWith(),
    );
  }
}
