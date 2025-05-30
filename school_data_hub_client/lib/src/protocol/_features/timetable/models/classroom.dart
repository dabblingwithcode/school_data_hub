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
import '../../../_features/timetable/models/scheduled_lesson.dart' as _i2;

abstract class Classroom implements _i1.SerializableModel {
  Classroom._({
    this.id,
    required this.roomCode,
    required this.roomName,
    this.scheduledLessons,
  });

  factory Classroom({
    int? id,
    required String roomCode,
    required String roomName,
    List<_i2.ScheduledLesson>? scheduledLessons,
  }) = _ClassroomImpl;

  factory Classroom.fromJson(Map<String, dynamic> jsonSerialization) {
    return Classroom(
      id: jsonSerialization['id'] as int?,
      roomCode: jsonSerialization['roomCode'] as String,
      roomName: jsonSerialization['roomName'] as String,
      scheduledLessons: (jsonSerialization['scheduledLessons'] as List?)
          ?.map(
              (e) => _i2.ScheduledLesson.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String roomCode;

  String roomName;

  List<_i2.ScheduledLesson>? scheduledLessons;

  /// Returns a shallow copy of this [Classroom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Classroom copyWith({
    int? id,
    String? roomCode,
    String? roomName,
    List<_i2.ScheduledLesson>? scheduledLessons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomCode': roomCode,
      'roomName': roomName,
      if (scheduledLessons != null)
        'scheduledLessons':
            scheduledLessons?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassroomImpl extends Classroom {
  _ClassroomImpl({
    int? id,
    required String roomCode,
    required String roomName,
    List<_i2.ScheduledLesson>? scheduledLessons,
  }) : super._(
          id: id,
          roomCode: roomCode,
          roomName: roomName,
          scheduledLessons: scheduledLessons,
        );

  /// Returns a shallow copy of this [Classroom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Classroom copyWith({
    Object? id = _Undefined,
    String? roomCode,
    String? roomName,
    Object? scheduledLessons = _Undefined,
  }) {
    return Classroom(
      id: id is int? ? id : this.id,
      roomCode: roomCode ?? this.roomCode,
      roomName: roomName ?? this.roomName,
      scheduledLessons: scheduledLessons is List<_i2.ScheduledLesson>?
          ? scheduledLessons
          : this.scheduledLessons?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
