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
import '../../../learning/timetable/lesson/weekday_enum.dart' as _i2;

abstract class TimetableSlot implements _i1.SerializableModel {
  TimetableSlot._({
    this.id,
    this.day,
    this.startTime,
    this.endTime,
  });

  factory TimetableSlot({
    int? id,
    _i2.Weekday? day,
    String? startTime,
    String? endTime,
  }) = _TimetableSlotImpl;

  factory TimetableSlot.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimetableSlot(
      id: jsonSerialization['id'] as int?,
      day: jsonSerialization['day'] == null
          ? null
          : _i2.Weekday.fromJson((jsonSerialization['day'] as String)),
      startTime: jsonSerialization['startTime'] as String?,
      endTime: jsonSerialization['endTime'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.Weekday? day;

  String? startTime;

  String? endTime;

  /// Returns a shallow copy of this [TimetableSlot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TimetableSlot copyWith({
    int? id,
    _i2.Weekday? day,
    String? startTime,
    String? endTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (day != null) 'day': day?.toJson(),
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TimetableSlotImpl extends TimetableSlot {
  _TimetableSlotImpl({
    int? id,
    _i2.Weekday? day,
    String? startTime,
    String? endTime,
  }) : super._(
          id: id,
          day: day,
          startTime: startTime,
          endTime: endTime,
        );

  /// Returns a shallow copy of this [TimetableSlot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TimetableSlot copyWith({
    Object? id = _Undefined,
    Object? day = _Undefined,
    Object? startTime = _Undefined,
    Object? endTime = _Undefined,
  }) {
    return TimetableSlot(
      id: id is int? ? id : this.id,
      day: day is _i2.Weekday? ? day : this.day,
      startTime: startTime is String? ? startTime : this.startTime,
      endTime: endTime is String? ? endTime : this.endTime,
    );
  }
}
