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
import '../../../../_features/user/models/staff_user.dart' as _i2;
import '../../../../_features/timetable/models/lesson/lesson.dart' as _i3;

abstract class LessonTeacher implements _i1.SerializableModel {
  LessonTeacher._({
    this.id,
    required this.userId,
    this.user,
    required this.scheduledLessonId,
    this.scheduledLesson,
  });

  factory LessonTeacher({
    int? id,
    required int userId,
    _i2.User? user,
    required int scheduledLessonId,
    _i3.Lesson? scheduledLesson,
  }) = _LessonTeacherImpl;

  factory LessonTeacher.fromJson(Map<String, dynamic> jsonSerialization) {
    return LessonTeacher(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i2.User.fromJson(
              (jsonSerialization['user'] as Map<String, dynamic>)),
      scheduledLessonId: jsonSerialization['scheduledLessonId'] as int,
      scheduledLesson: jsonSerialization['scheduledLesson'] == null
          ? null
          : _i3.Lesson.fromJson(
              (jsonSerialization['scheduledLesson'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _i2.User? user;

  int scheduledLessonId;

  _i3.Lesson? scheduledLesson;

  /// Returns a shallow copy of this [LessonTeacher]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LessonTeacher copyWith({
    int? id,
    int? userId,
    _i2.User? user,
    int? scheduledLessonId,
    _i3.Lesson? scheduledLesson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'scheduledLessonId': scheduledLessonId,
      if (scheduledLesson != null) 'scheduledLesson': scheduledLesson?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LessonTeacherImpl extends LessonTeacher {
  _LessonTeacherImpl({
    int? id,
    required int userId,
    _i2.User? user,
    required int scheduledLessonId,
    _i3.Lesson? scheduledLesson,
  }) : super._(
          id: id,
          userId: userId,
          user: user,
          scheduledLessonId: scheduledLessonId,
          scheduledLesson: scheduledLesson,
        );

  /// Returns a shallow copy of this [LessonTeacher]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LessonTeacher copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? scheduledLessonId,
    Object? scheduledLesson = _Undefined,
  }) {
    return LessonTeacher(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      scheduledLessonId: scheduledLessonId ?? this.scheduledLessonId,
      scheduledLesson: scheduledLesson is _i3.Lesson?
          ? scheduledLesson
          : this.scheduledLesson?.copyWith(),
    );
  }
}
