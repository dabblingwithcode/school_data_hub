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
import '../../../../_features/timetable/models/lesson/lesson_attendance.dart'
    as _i2;
import '../../../../_features/timetable/models/scheduled_lesson/subject.dart'
    as _i3;
import '../../../../_features/timetable/models/junction_models/lesson_teacher.dart'
    as _i4;

abstract class Lesson implements _i1.SerializableModel {
  Lesson._({
    this.id,
    required this.publicId,
    this.attendedPupils,
    required this.subjectId,
    this.subject,
    this.lessonTeachers,
  });

  factory Lesson({
    int? id,
    required String publicId,
    List<_i2.LessonAttendance>? attendedPupils,
    required int subjectId,
    _i3.Subject? subject,
    List<_i4.LessonTeacher>? lessonTeachers,
  }) = _LessonImpl;

  factory Lesson.fromJson(Map<String, dynamic> jsonSerialization) {
    return Lesson(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as String,
      attendedPupils: (jsonSerialization['attendedPupils'] as List?)
          ?.map(
              (e) => _i2.LessonAttendance.fromJson((e as Map<String, dynamic>)))
          .toList(),
      subjectId: jsonSerialization['subjectId'] as int,
      subject: jsonSerialization['subject'] == null
          ? null
          : _i3.Subject.fromJson(
              (jsonSerialization['subject'] as Map<String, dynamic>)),
      lessonTeachers: (jsonSerialization['lessonTeachers'] as List?)
          ?.map((e) => _i4.LessonTeacher.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String publicId;

  List<_i2.LessonAttendance>? attendedPupils;

  int subjectId;

  _i3.Subject? subject;

  List<_i4.LessonTeacher>? lessonTeachers;

  /// Returns a shallow copy of this [Lesson]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Lesson copyWith({
    int? id,
    String? publicId,
    List<_i2.LessonAttendance>? attendedPupils,
    int? subjectId,
    _i3.Subject? subject,
    List<_i4.LessonTeacher>? lessonTeachers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      if (attendedPupils != null)
        'attendedPupils':
            attendedPupils?.toJson(valueToJson: (v) => v.toJson()),
      'subjectId': subjectId,
      if (subject != null) 'subject': subject?.toJson(),
      if (lessonTeachers != null)
        'lessonTeachers':
            lessonTeachers?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LessonImpl extends Lesson {
  _LessonImpl({
    int? id,
    required String publicId,
    List<_i2.LessonAttendance>? attendedPupils,
    required int subjectId,
    _i3.Subject? subject,
    List<_i4.LessonTeacher>? lessonTeachers,
  }) : super._(
          id: id,
          publicId: publicId,
          attendedPupils: attendedPupils,
          subjectId: subjectId,
          subject: subject,
          lessonTeachers: lessonTeachers,
        );

  /// Returns a shallow copy of this [Lesson]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Lesson copyWith({
    Object? id = _Undefined,
    String? publicId,
    Object? attendedPupils = _Undefined,
    int? subjectId,
    Object? subject = _Undefined,
    Object? lessonTeachers = _Undefined,
  }) {
    return Lesson(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      attendedPupils: attendedPupils is List<_i2.LessonAttendance>?
          ? attendedPupils
          : this.attendedPupils?.map((e0) => e0.copyWith()).toList(),
      subjectId: subjectId ?? this.subjectId,
      subject: subject is _i3.Subject? ? subject : this.subject?.copyWith(),
      lessonTeachers: lessonTeachers is List<_i4.LessonTeacher>?
          ? lessonTeachers
          : this.lessonTeachers?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
