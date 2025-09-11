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
import '../../../../_features/timetable/models/timetable.dart' as _i2;
import '../../../../_features/timetable/models/scheduled_lesson/scheduled_lesson.dart'
    as _i3;
import '../../../../_features/timetable/models/scheduled_lesson/lesson_group_membership.dart'
    as _i4;

abstract class LessonGroup implements _i1.SerializableModel {
  LessonGroup._({
    this.id,
    required this.publicId,
    required this.name,
    this.color,
    required this.timetableId,
    this.timetable,
    required this.createdBy,
    required this.createdAt,
    this.modifiedBy,
    this.modifiedAt,
    this.scheduledLessons,
    this.memberships,
  });

  factory LessonGroup({
    int? id,
    required String publicId,
    required String name,
    String? color,
    required int timetableId,
    _i2.Timetable? timetable,
    required String createdBy,
    required DateTime createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
    List<_i3.ScheduledLesson>? scheduledLessons,
    List<_i4.ScheduledLessonGroupMembership>? memberships,
  }) = _LessonGroupImpl;

  factory LessonGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return LessonGroup(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as String,
      name: jsonSerialization['name'] as String,
      color: jsonSerialization['color'] as String?,
      timetableId: jsonSerialization['timetableId'] as int,
      timetable: jsonSerialization['timetable'] == null
          ? null
          : _i2.Timetable.fromJson(
              (jsonSerialization['timetable'] as Map<String, dynamic>)),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      modifiedBy: jsonSerialization['modifiedBy'] as String?,
      modifiedAt: jsonSerialization['modifiedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['modifiedAt']),
      scheduledLessons: (jsonSerialization['scheduledLessons'] as List?)
          ?.map(
              (e) => _i3.ScheduledLesson.fromJson((e as Map<String, dynamic>)))
          .toList(),
      memberships: (jsonSerialization['memberships'] as List?)
          ?.map((e) => _i4.ScheduledLessonGroupMembership.fromJson(
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

  int timetableId;

  _i2.Timetable? timetable;

  String createdBy;

  DateTime createdAt;

  String? modifiedBy;

  DateTime? modifiedAt;

  List<_i3.ScheduledLesson>? scheduledLessons;

  List<_i4.ScheduledLessonGroupMembership>? memberships;

  /// Returns a shallow copy of this [LessonGroup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LessonGroup copyWith({
    int? id,
    String? publicId,
    String? name,
    String? color,
    int? timetableId,
    _i2.Timetable? timetable,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
    List<_i3.ScheduledLesson>? scheduledLessons,
    List<_i4.ScheduledLessonGroupMembership>? memberships,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      'name': name,
      if (color != null) 'color': color,
      'timetableId': timetableId,
      if (timetable != null) 'timetable': timetable?.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (modifiedBy != null) 'modifiedBy': modifiedBy,
      if (modifiedAt != null) 'modifiedAt': modifiedAt?.toJson(),
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
    required int timetableId,
    _i2.Timetable? timetable,
    required String createdBy,
    required DateTime createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
    List<_i3.ScheduledLesson>? scheduledLessons,
    List<_i4.ScheduledLessonGroupMembership>? memberships,
  }) : super._(
          id: id,
          publicId: publicId,
          name: name,
          color: color,
          timetableId: timetableId,
          timetable: timetable,
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
    int? timetableId,
    Object? timetable = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    Object? modifiedBy = _Undefined,
    Object? modifiedAt = _Undefined,
    Object? scheduledLessons = _Undefined,
    Object? memberships = _Undefined,
  }) {
    return LessonGroup(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      color: color is String? ? color : this.color,
      timetableId: timetableId ?? this.timetableId,
      timetable:
          timetable is _i2.Timetable? ? timetable : this.timetable?.copyWith(),
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedBy: modifiedBy is String? ? modifiedBy : this.modifiedBy,
      modifiedAt: modifiedAt is DateTime? ? modifiedAt : this.modifiedAt,
      scheduledLessons: scheduledLessons is List<_i3.ScheduledLesson>?
          ? scheduledLessons
          : this.scheduledLessons?.map((e0) => e0.copyWith()).toList(),
      memberships: memberships is List<_i4.ScheduledLessonGroupMembership>?
          ? memberships
          : this.memberships?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
