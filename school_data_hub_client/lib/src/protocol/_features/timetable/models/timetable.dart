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
import '../../../_features/schoolday/models/school_semester.dart' as _i2;
import '../../../_features/timetable/models/scheduled_lesson/scheduled_lesson.dart'
    as _i3;
import '../../../_features/timetable/models/scheduled_lesson/timetable_slot.dart'
    as _i4;
import 'package:school_data_hub_client/src/protocol/protocol.dart' as _i5;

abstract class Timetable implements _i1.SerializableModel {
  Timetable._({
    this.id,
    required this.active,
    required this.startsAt,
    this.endsAt,
    required this.name,
    required this.schoolSemesterId,
    this.schoolSemester,
    this.scheduledLessons,
    this.timetableSlots,
    required this.createdBy,
    required this.createdAt,
    this.modified,
  });

  factory Timetable({
    int? id,
    required bool active,
    required DateTime startsAt,
    DateTime? endsAt,
    required String name,
    required int schoolSemesterId,
    _i2.SchoolSemester? schoolSemester,
    List<_i3.ScheduledLesson>? scheduledLessons,
    List<_i4.TimetableSlot>? timetableSlots,
    required String createdBy,
    required DateTime createdAt,
    List<({String modifiedBy, DateTime modifiedAt})>? modified,
  }) = _TimetableImpl;

  factory Timetable.fromJson(Map<String, dynamic> jsonSerialization) {
    return Timetable(
      id: jsonSerialization['id'] as int?,
      active: jsonSerialization['active'] as bool,
      startsAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startsAt']),
      endsAt: jsonSerialization['endsAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      name: jsonSerialization['name'] as String,
      schoolSemesterId: jsonSerialization['schoolSemesterId'] as int,
      schoolSemester: jsonSerialization['schoolSemester'] == null
          ? null
          : _i2.SchoolSemester.fromJson(
              (jsonSerialization['schoolSemester'] as Map<String, dynamic>)),
      scheduledLessons: (jsonSerialization['scheduledLessons'] as List?)
          ?.map(
              (e) => _i3.ScheduledLesson.fromJson((e as Map<String, dynamic>)))
          .toList(),
      timetableSlots: (jsonSerialization['timetableSlots'] as List?)
          ?.map((e) => _i4.TimetableSlot.fromJson((e as Map<String, dynamic>)))
          .toList(),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      modified: (jsonSerialization['modified'] as List?)
          ?.map((e) => _i5.Protocol()
              .deserialize<({String modifiedBy, DateTime modifiedAt})>(
                  (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  bool active;

  DateTime startsAt;

  DateTime? endsAt;

  String name;

  int schoolSemesterId;

  _i2.SchoolSemester? schoolSemester;

  List<_i3.ScheduledLesson>? scheduledLessons;

  List<_i4.TimetableSlot>? timetableSlots;

  String createdBy;

  DateTime createdAt;

  List<({String modifiedBy, DateTime modifiedAt})>? modified;

  /// Returns a shallow copy of this [Timetable]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Timetable copyWith({
    int? id,
    bool? active,
    DateTime? startsAt,
    DateTime? endsAt,
    String? name,
    int? schoolSemesterId,
    _i2.SchoolSemester? schoolSemester,
    List<_i3.ScheduledLesson>? scheduledLessons,
    List<_i4.TimetableSlot>? timetableSlots,
    String? createdBy,
    DateTime? createdAt,
    List<({String modifiedBy, DateTime modifiedAt})>? modified,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'active': active,
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      'name': name,
      'schoolSemesterId': schoolSemesterId,
      if (schoolSemester != null) 'schoolSemester': schoolSemester?.toJson(),
      if (scheduledLessons != null)
        'scheduledLessons':
            scheduledLessons?.toJson(valueToJson: (v) => v.toJson()),
      if (timetableSlots != null)
        'timetableSlots':
            timetableSlots?.toJson(valueToJson: (v) => v.toJson()),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (modified != null)
        'modified': _i5.mapRecordContainingContainerToJson(modified!),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TimetableImpl extends Timetable {
  _TimetableImpl({
    int? id,
    required bool active,
    required DateTime startsAt,
    DateTime? endsAt,
    required String name,
    required int schoolSemesterId,
    _i2.SchoolSemester? schoolSemester,
    List<_i3.ScheduledLesson>? scheduledLessons,
    List<_i4.TimetableSlot>? timetableSlots,
    required String createdBy,
    required DateTime createdAt,
    List<({String modifiedBy, DateTime modifiedAt})>? modified,
  }) : super._(
          id: id,
          active: active,
          startsAt: startsAt,
          endsAt: endsAt,
          name: name,
          schoolSemesterId: schoolSemesterId,
          schoolSemester: schoolSemester,
          scheduledLessons: scheduledLessons,
          timetableSlots: timetableSlots,
          createdBy: createdBy,
          createdAt: createdAt,
          modified: modified,
        );

  /// Returns a shallow copy of this [Timetable]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Timetable copyWith({
    Object? id = _Undefined,
    bool? active,
    DateTime? startsAt,
    Object? endsAt = _Undefined,
    String? name,
    int? schoolSemesterId,
    Object? schoolSemester = _Undefined,
    Object? scheduledLessons = _Undefined,
    Object? timetableSlots = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    Object? modified = _Undefined,
  }) {
    return Timetable(
      id: id is int? ? id : this.id,
      active: active ?? this.active,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt is DateTime? ? endsAt : this.endsAt,
      name: name ?? this.name,
      schoolSemesterId: schoolSemesterId ?? this.schoolSemesterId,
      schoolSemester: schoolSemester is _i2.SchoolSemester?
          ? schoolSemester
          : this.schoolSemester?.copyWith(),
      scheduledLessons: scheduledLessons is List<_i3.ScheduledLesson>?
          ? scheduledLessons
          : this.scheduledLessons?.map((e0) => e0.copyWith()).toList(),
      timetableSlots: timetableSlots is List<_i4.TimetableSlot>?
          ? timetableSlots
          : this.timetableSlots?.map((e0) => e0.copyWith()).toList(),
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modified: modified is List<({String modifiedBy, DateTime modifiedAt})>?
          ? modified
          : this
              .modified
              ?.map((e0) => (
                    modifiedBy: e0.modifiedBy,
                    modifiedAt: e0.modifiedAt,
                  ))
              .toList(),
    );
  }
}
