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
import '../../../learning/timetable/lesson/subject.dart' as _i2;
import '../../../learning/timetable/lesson/timetable_slot.dart' as _i3;
import '../../../learning/timetable/room.dart' as _i4;
import '../../../learning/timetable/lesson/lesson_group.dart' as _i5;
import 'package:school_data_hub_client/src/protocol/protocol.dart' as _i6;

abstract class ScheduledLesson implements _i1.SerializableModel {
  ScheduledLesson._({
    this.id,
    required this.active,
    required this.publicId,
    required this.subjectId,
    this.subject,
    required this.scheduledAtId,
    this.scheduledAt,
    required this.lessonId,
    required this.roomId,
    this.room,
    required this.lessonGroupId,
    this.lessonGroup,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
    this.recordtest,
  });

  factory ScheduledLesson({
    int? id,
    required bool active,
    required String publicId,
    required int subjectId,
    _i2.Subject? subject,
    required int scheduledAtId,
    _i3.TimetableSlot? scheduledAt,
    required String lessonId,
    required int roomId,
    _i4.Room? room,
    required int lessonGroupId,
    _i5.LessonGroup? lessonGroup,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required DateTime modifiedAt,
    ({int testint, String testString})? recordtest,
  }) = _ScheduledLessonImpl;

  factory ScheduledLesson.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScheduledLesson(
      id: jsonSerialization['id'] as int?,
      active: jsonSerialization['active'] as bool,
      publicId: jsonSerialization['publicId'] as String,
      subjectId: jsonSerialization['subjectId'] as int,
      subject: jsonSerialization['subject'] == null
          ? null
          : _i2.Subject.fromJson(
              (jsonSerialization['subject'] as Map<String, dynamic>)),
      scheduledAtId: jsonSerialization['scheduledAtId'] as int,
      scheduledAt: jsonSerialization['scheduledAt'] == null
          ? null
          : _i3.TimetableSlot.fromJson(
              (jsonSerialization['scheduledAt'] as Map<String, dynamic>)),
      lessonId: jsonSerialization['lessonId'] as String,
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _i4.Room.fromJson(
              (jsonSerialization['room'] as Map<String, dynamic>)),
      lessonGroupId: jsonSerialization['lessonGroupId'] as int,
      lessonGroup: jsonSerialization['lessonGroup'] == null
          ? null
          : _i5.LessonGroup.fromJson(
              (jsonSerialization['lessonGroup'] as Map<String, dynamic>)),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      modifiedBy: jsonSerialization['modifiedBy'] as String,
      modifiedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['modifiedAt']),
      recordtest: jsonSerialization['recordtest'] == null
          ? null
          : _i6.Protocol().deserialize<({int testint, String testString})?>(
              (jsonSerialization['recordtest'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  bool active;

  String publicId;

  int subjectId;

  _i2.Subject? subject;

  int scheduledAtId;

  _i3.TimetableSlot? scheduledAt;

  String lessonId;

  int roomId;

  _i4.Room? room;

  int lessonGroupId;

  _i5.LessonGroup? lessonGroup;

  String createdBy;

  DateTime createdAt;

  String modifiedBy;

  DateTime modifiedAt;

  ({int testint, String testString})? recordtest;

  /// Returns a shallow copy of this [ScheduledLesson]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduledLesson copyWith({
    int? id,
    bool? active,
    String? publicId,
    int? subjectId,
    _i2.Subject? subject,
    int? scheduledAtId,
    _i3.TimetableSlot? scheduledAt,
    String? lessonId,
    int? roomId,
    _i4.Room? room,
    int? lessonGroupId,
    _i5.LessonGroup? lessonGroup,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
    ({int testint, String testString})? recordtest,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'active': active,
      'publicId': publicId,
      'subjectId': subjectId,
      if (subject != null) 'subject': subject?.toJson(),
      'scheduledAtId': scheduledAtId,
      if (scheduledAt != null) 'scheduledAt': scheduledAt?.toJson(),
      'lessonId': lessonId,
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
      'lessonGroupId': lessonGroupId,
      if (lessonGroup != null) 'lessonGroup': lessonGroup?.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      'modifiedAt': modifiedAt.toJson(),
      if (recordtest != null) 'recordtest': _i6.mapRecordToJson(recordtest),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScheduledLessonImpl extends ScheduledLesson {
  _ScheduledLessonImpl({
    int? id,
    required bool active,
    required String publicId,
    required int subjectId,
    _i2.Subject? subject,
    required int scheduledAtId,
    _i3.TimetableSlot? scheduledAt,
    required String lessonId,
    required int roomId,
    _i4.Room? room,
    required int lessonGroupId,
    _i5.LessonGroup? lessonGroup,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required DateTime modifiedAt,
    ({int testint, String testString})? recordtest,
  }) : super._(
          id: id,
          active: active,
          publicId: publicId,
          subjectId: subjectId,
          subject: subject,
          scheduledAtId: scheduledAtId,
          scheduledAt: scheduledAt,
          lessonId: lessonId,
          roomId: roomId,
          room: room,
          lessonGroupId: lessonGroupId,
          lessonGroup: lessonGroup,
          createdBy: createdBy,
          createdAt: createdAt,
          modifiedBy: modifiedBy,
          modifiedAt: modifiedAt,
          recordtest: recordtest,
        );

  /// Returns a shallow copy of this [ScheduledLesson]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduledLesson copyWith({
    Object? id = _Undefined,
    bool? active,
    String? publicId,
    int? subjectId,
    Object? subject = _Undefined,
    int? scheduledAtId,
    Object? scheduledAt = _Undefined,
    String? lessonId,
    int? roomId,
    Object? room = _Undefined,
    int? lessonGroupId,
    Object? lessonGroup = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
    Object? recordtest = _Undefined,
  }) {
    return ScheduledLesson(
      id: id is int? ? id : this.id,
      active: active ?? this.active,
      publicId: publicId ?? this.publicId,
      subjectId: subjectId ?? this.subjectId,
      subject: subject is _i2.Subject? ? subject : this.subject?.copyWith(),
      scheduledAtId: scheduledAtId ?? this.scheduledAtId,
      scheduledAt: scheduledAt is _i3.TimetableSlot?
          ? scheduledAt
          : this.scheduledAt?.copyWith(),
      lessonId: lessonId ?? this.lessonId,
      roomId: roomId ?? this.roomId,
      room: room is _i4.Room? ? room : this.room?.copyWith(),
      lessonGroupId: lessonGroupId ?? this.lessonGroupId,
      lessonGroup: lessonGroup is _i5.LessonGroup?
          ? lessonGroup
          : this.lessonGroup?.copyWith(),
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      recordtest: recordtest is ({int testint, String testString})?
          ? recordtest
          : this.recordtest == null
              ? null
              : (
                  testint: this.recordtest!.testint,
                  testString: this.recordtest!.testString,
                ),
    );
  }
}
