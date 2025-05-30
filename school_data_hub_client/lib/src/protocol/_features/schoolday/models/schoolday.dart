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
import '../../../_features/attendance/models/missed_class.dart' as _i2;
import '../../../_features/schoolday_events/models/schoolday_event.dart' as _i3;
import '../../../_features/schoolday/models/school_semester.dart' as _i4;

abstract class Schoolday implements _i1.SerializableModel {
  Schoolday._({
    this.id,
    required this.schoolday,
    this.missedClasses,
    this.schooldayEvents,
    required this.schoolSemesterId,
    this.schoolSemester,
  });

  factory Schoolday({
    int? id,
    required DateTime schoolday,
    List<_i2.MissedClass>? missedClasses,
    List<_i3.SchooldayEvent>? schooldayEvents,
    required int schoolSemesterId,
    _i4.SchoolSemester? schoolSemester,
  }) = _SchooldayImpl;

  factory Schoolday.fromJson(Map<String, dynamic> jsonSerialization) {
    return Schoolday(
      id: jsonSerialization['id'] as int?,
      schoolday:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['schoolday']),
      missedClasses: (jsonSerialization['missedClasses'] as List?)
          ?.map((e) => _i2.MissedClass.fromJson((e as Map<String, dynamic>)))
          .toList(),
      schooldayEvents: (jsonSerialization['schooldayEvents'] as List?)
          ?.map((e) => _i3.SchooldayEvent.fromJson((e as Map<String, dynamic>)))
          .toList(),
      schoolSemesterId: jsonSerialization['schoolSemesterId'] as int,
      schoolSemester: jsonSerialization['schoolSemester'] == null
          ? null
          : _i4.SchoolSemester.fromJson(
              (jsonSerialization['schoolSemester'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime schoolday;

  List<_i2.MissedClass>? missedClasses;

  List<_i3.SchooldayEvent>? schooldayEvents;

  int schoolSemesterId;

  _i4.SchoolSemester? schoolSemester;

  /// Returns a shallow copy of this [Schoolday]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Schoolday copyWith({
    int? id,
    DateTime? schoolday,
    List<_i2.MissedClass>? missedClasses,
    List<_i3.SchooldayEvent>? schooldayEvents,
    int? schoolSemesterId,
    _i4.SchoolSemester? schoolSemester,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'schoolday': schoolday.toJson(),
      if (missedClasses != null)
        'missedClasses': missedClasses?.toJson(valueToJson: (v) => v.toJson()),
      if (schooldayEvents != null)
        'schooldayEvents':
            schooldayEvents?.toJson(valueToJson: (v) => v.toJson()),
      'schoolSemesterId': schoolSemesterId,
      if (schoolSemester != null) 'schoolSemester': schoolSemester?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SchooldayImpl extends Schoolday {
  _SchooldayImpl({
    int? id,
    required DateTime schoolday,
    List<_i2.MissedClass>? missedClasses,
    List<_i3.SchooldayEvent>? schooldayEvents,
    required int schoolSemesterId,
    _i4.SchoolSemester? schoolSemester,
  }) : super._(
          id: id,
          schoolday: schoolday,
          missedClasses: missedClasses,
          schooldayEvents: schooldayEvents,
          schoolSemesterId: schoolSemesterId,
          schoolSemester: schoolSemester,
        );

  /// Returns a shallow copy of this [Schoolday]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Schoolday copyWith({
    Object? id = _Undefined,
    DateTime? schoolday,
    Object? missedClasses = _Undefined,
    Object? schooldayEvents = _Undefined,
    int? schoolSemesterId,
    Object? schoolSemester = _Undefined,
  }) {
    return Schoolday(
      id: id is int? ? id : this.id,
      schoolday: schoolday ?? this.schoolday,
      missedClasses: missedClasses is List<_i2.MissedClass>?
          ? missedClasses
          : this.missedClasses?.map((e0) => e0.copyWith()).toList(),
      schooldayEvents: schooldayEvents is List<_i3.SchooldayEvent>?
          ? schooldayEvents
          : this.schooldayEvents?.map((e0) => e0.copyWith()).toList(),
      schoolSemesterId: schoolSemesterId ?? this.schoolSemesterId,
      schoolSemester: schoolSemester is _i4.SchoolSemester?
          ? schoolSemester
          : this.schoolSemester?.copyWith(),
    );
  }
}
