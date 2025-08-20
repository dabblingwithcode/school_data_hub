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
import '../../../../_features/timetable/models/lesson/lesson.dart' as _i2;

abstract class LessonSubject implements _i1.SerializableModel {
  LessonSubject._({
    this.id,
    required this.name,
    this.description,
    this.lessons,
  });

  factory LessonSubject({
    int? id,
    required String name,
    String? description,
    List<_i2.Lesson>? lessons,
  }) = _LessonSubjectImpl;

  factory LessonSubject.fromJson(Map<String, dynamic> jsonSerialization) {
    return LessonSubject(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      lessons: (jsonSerialization['lessons'] as List?)
          ?.map((e) => _i2.Lesson.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String? description;

  List<_i2.Lesson>? lessons;

  /// Returns a shallow copy of this [LessonSubject]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LessonSubject copyWith({
    int? id,
    String? name,
    String? description,
    List<_i2.Lesson>? lessons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
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

class _LessonSubjectImpl extends LessonSubject {
  _LessonSubjectImpl({
    int? id,
    required String name,
    String? description,
    List<_i2.Lesson>? lessons,
  }) : super._(
          id: id,
          name: name,
          description: description,
          lessons: lessons,
        );

  /// Returns a shallow copy of this [LessonSubject]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LessonSubject copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    Object? lessons = _Undefined,
  }) {
    return LessonSubject(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      lessons: lessons is List<_i2.Lesson>?
          ? lessons
          : this.lessons?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
