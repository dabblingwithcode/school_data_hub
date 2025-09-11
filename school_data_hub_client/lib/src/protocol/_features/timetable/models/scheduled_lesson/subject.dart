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
import '../../../../_features/timetable/models/lesson/lesson.dart' as _i3;

abstract class Subject implements _i1.SerializableModel {
  Subject._({
    this.id,
    required this.publicId,
    required this.name,
    this.description,
    this.color,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    this.scheduledLessons,
    this.lessons,
  });

  factory Subject({
    int? id,
    required String publicId,
    required String name,
    String? description,
    String? color,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    List<_i2.ScheduledLesson>? scheduledLessons,
    List<_i3.Lesson>? lessons,
  }) = _SubjectImpl;

  factory Subject.fromJson(Map<String, dynamic> jsonSerialization) {
    return Subject(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      color: jsonSerialization['color'] as String?,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      modifiedBy: jsonSerialization['modifiedBy'] as String,
      scheduledLessons: (jsonSerialization['scheduledLessons'] as List?)
          ?.map(
              (e) => _i2.ScheduledLesson.fromJson((e as Map<String, dynamic>)))
          .toList(),
      lessons: (jsonSerialization['lessons'] as List?)
          ?.map((e) => _i3.Lesson.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String publicId;

  String name;

  String? description;

  String? color;

  String createdBy;

  DateTime createdAt;

  String modifiedBy;

  List<_i2.ScheduledLesson>? scheduledLessons;

  List<_i3.Lesson>? lessons;

  /// Returns a shallow copy of this [Subject]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Subject copyWith({
    int? id,
    String? publicId,
    String? name,
    String? description,
    String? color,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    List<_i2.ScheduledLesson>? scheduledLessons,
    List<_i3.Lesson>? lessons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      'name': name,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      if (scheduledLessons != null)
        'scheduledLessons':
            scheduledLessons?.toJson(valueToJson: (v) => v.toJson()),
      if (lessons != null)
        'lessons': lessons?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubjectImpl extends Subject {
  _SubjectImpl({
    int? id,
    required String publicId,
    required String name,
    String? description,
    String? color,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    List<_i2.ScheduledLesson>? scheduledLessons,
    List<_i3.Lesson>? lessons,
  }) : super._(
          id: id,
          publicId: publicId,
          name: name,
          description: description,
          color: color,
          createdBy: createdBy,
          createdAt: createdAt,
          modifiedBy: modifiedBy,
          scheduledLessons: scheduledLessons,
          lessons: lessons,
        );

  /// Returns a shallow copy of this [Subject]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Subject copyWith({
    Object? id = _Undefined,
    String? publicId,
    String? name,
    Object? description = _Undefined,
    Object? color = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    Object? scheduledLessons = _Undefined,
    Object? lessons = _Undefined,
  }) {
    return Subject(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      color: color is String? ? color : this.color,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      scheduledLessons: scheduledLessons is List<_i2.ScheduledLesson>?
          ? scheduledLessons
          : this.scheduledLessons?.map((e0) => e0.copyWith()).toList(),
      lessons: lessons is List<_i3.Lesson>?
          ? lessons
          : this.lessons?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
