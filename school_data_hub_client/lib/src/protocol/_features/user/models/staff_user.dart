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
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i2;
import '../../../_features/user/models/roles.dart' as _i3;
import '../../../_features/timetable/models/junction_models/scheduled_lesson_teacher.dart'
    as _i4;
import '../../../_features/timetable/models/junction_models/lesson_teacher.dart'
    as _i5;
import '../../../_features/user/models/user_flags.dart' as _i6;

abstract class User implements _i1.SerializableModel {
  User._({
    this.id,
    required this.userInfoId,
    this.userInfo,
    required this.role,
    this.matrixUserId,
    required this.timeUnits,
    required this.reliefTimeUnits,
    this.scheduledLessonsTeacher,
    this.lessonsTeacher,
    this.pupilsAuth,
    this.schooldayEventsProcessingTeam,
    required this.credit,
    required this.userFlags,
  });

  factory User({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required _i3.Role role,
    String? matrixUserId,
    required int timeUnits,
    required int reliefTimeUnits,
    List<_i4.ScheduledLessonTeacher>? scheduledLessonsTeacher,
    List<_i5.LessonTeacher>? lessonsTeacher,
    Set<int>? pupilsAuth,
    String? schooldayEventsProcessingTeam,
    required int credit,
    required _i6.UserFlags userFlags,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      userInfoId: jsonSerialization['userInfoId'] as int,
      userInfo: jsonSerialization['userInfo'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['userInfo'] as Map<String, dynamic>)),
      role: _i3.Role.fromJson((jsonSerialization['role'] as String)),
      matrixUserId: jsonSerialization['matrixUserId'] as String?,
      timeUnits: jsonSerialization['timeUnits'] as int,
      reliefTimeUnits: jsonSerialization['reliefTimeUnits'] as int,
      scheduledLessonsTeacher: (jsonSerialization['scheduledLessonsTeacher']
              as List?)
          ?.map((e) =>
              _i4.ScheduledLessonTeacher.fromJson((e as Map<String, dynamic>)))
          .toList(),
      lessonsTeacher: (jsonSerialization['lessonsTeacher'] as List?)
          ?.map((e) => _i5.LessonTeacher.fromJson((e as Map<String, dynamic>)))
          .toList(),
      pupilsAuth: jsonSerialization['pupilsAuth'] == null
          ? null
          : _i1.SetJsonExtension.fromJson(
              (jsonSerialization['pupilsAuth'] as List),
              itemFromJson: (e) => e as int),
      schooldayEventsProcessingTeam:
          jsonSerialization['schooldayEventsProcessingTeam'] as String?,
      credit: jsonSerialization['credit'] as int,
      userFlags: _i6.UserFlags.fromJson(
          (jsonSerialization['userFlags'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userInfoId;

  _i2.UserInfo? userInfo;

  _i3.Role role;

  String? matrixUserId;

  int timeUnits;

  int reliefTimeUnits;

  List<_i4.ScheduledLessonTeacher>? scheduledLessonsTeacher;

  List<_i5.LessonTeacher>? lessonsTeacher;

  Set<int>? pupilsAuth;

  String? schooldayEventsProcessingTeam;

  int credit;

  _i6.UserFlags userFlags;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    int? userInfoId,
    _i2.UserInfo? userInfo,
    _i3.Role? role,
    String? matrixUserId,
    int? timeUnits,
    int? reliefTimeUnits,
    List<_i4.ScheduledLessonTeacher>? scheduledLessonsTeacher,
    List<_i5.LessonTeacher>? lessonsTeacher,
    Set<int>? pupilsAuth,
    String? schooldayEventsProcessingTeam,
    int? credit,
    _i6.UserFlags? userFlags,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      'role': role.toJson(),
      if (matrixUserId != null) 'matrixUserId': matrixUserId,
      'timeUnits': timeUnits,
      'reliefTimeUnits': reliefTimeUnits,
      if (scheduledLessonsTeacher != null)
        'scheduledLessonsTeacher':
            scheduledLessonsTeacher?.toJson(valueToJson: (v) => v.toJson()),
      if (lessonsTeacher != null)
        'lessonsTeacher':
            lessonsTeacher?.toJson(valueToJson: (v) => v.toJson()),
      if (pupilsAuth != null) 'pupilsAuth': pupilsAuth?.toJson(),
      if (schooldayEventsProcessingTeam != null)
        'schooldayEventsProcessingTeam': schooldayEventsProcessingTeam,
      'credit': credit,
      'userFlags': userFlags.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required _i3.Role role,
    String? matrixUserId,
    required int timeUnits,
    required int reliefTimeUnits,
    List<_i4.ScheduledLessonTeacher>? scheduledLessonsTeacher,
    List<_i5.LessonTeacher>? lessonsTeacher,
    Set<int>? pupilsAuth,
    String? schooldayEventsProcessingTeam,
    required int credit,
    required _i6.UserFlags userFlags,
  }) : super._(
          id: id,
          userInfoId: userInfoId,
          userInfo: userInfo,
          role: role,
          matrixUserId: matrixUserId,
          timeUnits: timeUnits,
          reliefTimeUnits: reliefTimeUnits,
          scheduledLessonsTeacher: scheduledLessonsTeacher,
          lessonsTeacher: lessonsTeacher,
          pupilsAuth: pupilsAuth,
          schooldayEventsProcessingTeam: schooldayEventsProcessingTeam,
          credit: credit,
          userFlags: userFlags,
        );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    int? userInfoId,
    Object? userInfo = _Undefined,
    _i3.Role? role,
    Object? matrixUserId = _Undefined,
    int? timeUnits,
    int? reliefTimeUnits,
    Object? scheduledLessonsTeacher = _Undefined,
    Object? lessonsTeacher = _Undefined,
    Object? pupilsAuth = _Undefined,
    Object? schooldayEventsProcessingTeam = _Undefined,
    int? credit,
    _i6.UserFlags? userFlags,
  }) {
    return User(
      id: id is int? ? id : this.id,
      userInfoId: userInfoId ?? this.userInfoId,
      userInfo:
          userInfo is _i2.UserInfo? ? userInfo : this.userInfo?.copyWith(),
      role: role ?? this.role,
      matrixUserId: matrixUserId is String? ? matrixUserId : this.matrixUserId,
      timeUnits: timeUnits ?? this.timeUnits,
      reliefTimeUnits: reliefTimeUnits ?? this.reliefTimeUnits,
      scheduledLessonsTeacher: scheduledLessonsTeacher
              is List<_i4.ScheduledLessonTeacher>?
          ? scheduledLessonsTeacher
          : this.scheduledLessonsTeacher?.map((e0) => e0.copyWith()).toList(),
      lessonsTeacher: lessonsTeacher is List<_i5.LessonTeacher>?
          ? lessonsTeacher
          : this.lessonsTeacher?.map((e0) => e0.copyWith()).toList(),
      pupilsAuth: pupilsAuth is Set<int>?
          ? pupilsAuth
          : this.pupilsAuth?.map((e0) => e0).toSet(),
      schooldayEventsProcessingTeam: schooldayEventsProcessingTeam is String?
          ? schooldayEventsProcessingTeam
          : this.schooldayEventsProcessingTeam,
      credit: credit ?? this.credit,
      userFlags: userFlags ?? this.userFlags.copyWith(),
    );
  }
}
