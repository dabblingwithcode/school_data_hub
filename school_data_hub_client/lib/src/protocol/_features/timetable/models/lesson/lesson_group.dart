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
import '../../../../_features/timetable/models/scheduled_lesson/scheduled_lesson.dart'
    as _i2;
import '../../../../_features/timetable/models/scheduled_lesson/lesson_group_membership.dart'
    as _i3;

abstract class LessonGroup implements _i1.SerializableModel {
  LessonGroup._({
    this.id,
    required this.publicId,
    required this.name,
    this.color,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
    this.scheduledLessons,
    this.memberships,
  });

  factory LessonGroup({
    int? id,
    required String publicId,
    required String name,
    String? color,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required DateTime modifiedAt,
    List<_i2.ScheduledLesson>? scheduledLessons,
    List<_i3.ScheduledLessonGroupMembership>? memberships,
  }) = _LessonGroupImpl;

  factory LessonGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return LessonGroup(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as String,
      name: jsonSerialization['name'] as String,
      color: jsonSerialization['color'] as String?,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      modifiedBy: jsonSerialization['modifiedBy'] as String,
      modifiedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['modifiedAt']),
      scheduledLessons: (jsonSerialization['scheduledLessons'] as List?)
          ?.map(
              (e) => _i2.ScheduledLesson.fromJson((e as Map<String, dynamic>)))
          .toList(),
      memberships: (jsonSerialization['memberships'] as List?)
          ?.map((e) => _i3.ScheduledLessonGroupMembership.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String publicId;

  String name;

  String? color;

  String createdBy;

  DateTime createdAt;

  String modifiedBy;

  DateTime modifiedAt;

  List<_i2.ScheduledLesson>? scheduledLessons;

  List<_i3.ScheduledLessonGroupMembership>? memberships;

  /// Returns a shallow copy of this [LessonGroup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LessonGroup copyWith({
    int? id,
    String? publicId,
    String? name,
    String? color,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
    List<_i2.ScheduledLesson>? scheduledLessons,
    List<_i3.ScheduledLessonGroupMembership>? memberships,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      'name': name,
      if (color != null) 'color': color,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      'modifiedAt': modifiedAt.toJson(),
      if (scheduledLessons != null)
        'scheduledLessons':
            scheduledLessons?.toJson(valueToJson: (v) => v.toJson()),
      if (memberships != null)
        'memberships': memberships?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LessonGroupImpl extends LessonGroup {
  _LessonGroupImpl({
    int? id,
    required String publicId,
    required String name,
    String? color,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required DateTime modifiedAt,
    List<_i2.ScheduledLesson>? scheduledLessons,
    List<_i3.ScheduledLessonGroupMembership>? memberships,
  }) : super._(
          id: id,
          publicId: publicId,
          name: name,
          color: color,
          createdBy: createdBy,
          createdAt: createdAt,
          modifiedBy: modifiedBy,
          modifiedAt: modifiedAt,
          scheduledLessons: scheduledLessons,
          memberships: memberships,
        );

  /// Returns a shallow copy of this [LessonGroup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LessonGroup copyWith({
    Object? id = _Undefined,
    String? publicId,
    String? name,
    Object? color = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
    Object? scheduledLessons = _Undefined,
    Object? memberships = _Undefined,
  }) {
    return LessonGroup(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      color: color is String? ? color : this.color,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      scheduledLessons: scheduledLessons is List<_i2.ScheduledLesson>?
          ? scheduledLessons
          : this.scheduledLessons?.map((e0) => e0.copyWith()).toList(),
      memberships: memberships is List<_i3.ScheduledLessonGroupMembership>?
          ? memberships
          : this.memberships?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
