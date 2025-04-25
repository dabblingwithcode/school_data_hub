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
import '../../../learning/timetable/lesson/lesson.dart' as _i2;
import '../../../pupil_data/pupil_data.dart' as _i3;

abstract class LessonAttendance implements _i1.SerializableModel {
  LessonAttendance._({
    this.id,
    required this.lessonId,
    this.lesson,
    required this.pupilId,
    this.pupil,
    this.comment,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
  });

  factory LessonAttendance({
    int? id,
    required int lessonId,
    _i2.Lesson? lesson,
    required int pupilId,
    _i3.PupilData? pupil,
    String? comment,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required DateTime modifiedAt,
  }) = _LessonAttendanceImpl;

  factory LessonAttendance.fromJson(Map<String, dynamic> jsonSerialization) {
    return LessonAttendance(
      id: jsonSerialization['id'] as int?,
      lessonId: jsonSerialization['lessonId'] as int,
      lesson: jsonSerialization['lesson'] == null
          ? null
          : _i2.Lesson.fromJson(
              (jsonSerialization['lesson'] as Map<String, dynamic>)),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i3.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      comment: jsonSerialization['comment'] as String?,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      modifiedBy: jsonSerialization['modifiedBy'] as String,
      modifiedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['modifiedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int lessonId;

  _i2.Lesson? lesson;

  int pupilId;

  _i3.PupilData? pupil;

  String? comment;

  String createdBy;

  DateTime createdAt;

  String modifiedBy;

  DateTime modifiedAt;

  /// Returns a shallow copy of this [LessonAttendance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LessonAttendance copyWith({
    int? id,
    int? lessonId,
    _i2.Lesson? lesson,
    int? pupilId,
    _i3.PupilData? pupil,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'lessonId': lessonId,
      if (lesson != null) 'lesson': lesson?.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      if (comment != null) 'comment': comment,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      'modifiedAt': modifiedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LessonAttendanceImpl extends LessonAttendance {
  _LessonAttendanceImpl({
    int? id,
    required int lessonId,
    _i2.Lesson? lesson,
    required int pupilId,
    _i3.PupilData? pupil,
    String? comment,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required DateTime modifiedAt,
  }) : super._(
          id: id,
          lessonId: lessonId,
          lesson: lesson,
          pupilId: pupilId,
          pupil: pupil,
          comment: comment,
          createdBy: createdBy,
          createdAt: createdAt,
          modifiedBy: modifiedBy,
          modifiedAt: modifiedAt,
        );

  /// Returns a shallow copy of this [LessonAttendance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LessonAttendance copyWith({
    Object? id = _Undefined,
    int? lessonId,
    Object? lesson = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
    Object? comment = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    DateTime? modifiedAt,
  }) {
    return LessonAttendance(
      id: id is int? ? id : this.id,
      lessonId: lessonId ?? this.lessonId,
      lesson: lesson is _i2.Lesson? ? lesson : this.lesson?.copyWith(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i3.PupilData? ? pupil : this.pupil?.copyWith(),
      comment: comment is String? ? comment : this.comment,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }
}
