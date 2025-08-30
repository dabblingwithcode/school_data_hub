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
import '../../../../_features/timetable/models/scheduled_lesson/weekday_enum.dart'
    as _i2;
import '../../../../_features/timetable/models/timetable.dart' as _i3;

abstract class TimetableSlot implements _i1.SerializableModel {
  TimetableSlot._({
    this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.timetableId,
    this.timetable,
  });

  factory TimetableSlot({
    int? id,
    required _i2.Weekday day,
    required String startTime,
    required String endTime,
    required int timetableId,
    _i3.Timetable? timetable,
  }) = _TimetableSlotImpl;

  factory TimetableSlot.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimetableSlot(
      id: jsonSerialization['id'] as int?,
      day: _i2.Weekday.fromJson((jsonSerialization['day'] as String)),
      startTime: jsonSerialization['startTime'] as String,
      endTime: jsonSerialization['endTime'] as String,
      timetableId: jsonSerialization['timetableId'] as int,
      timetable: jsonSerialization['timetable'] == null
          ? null
          : _i3.Timetable.fromJson(
              (jsonSerialization['timetable'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.Weekday day;

  String startTime;

  String endTime;

  int timetableId;

  _i3.Timetable? timetable;

  /// Returns a shallow copy of this [TimetableSlot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TimetableSlot copyWith({
    int? id,
    _i2.Weekday? day,
    String? startTime,
    String? endTime,
    int? timetableId,
    _i3.Timetable? timetable,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'day': day.toJson(),
      'startTime': startTime,
      'endTime': endTime,
      'timetableId': timetableId,
      if (timetable != null) 'timetable': timetable?.toJson(),
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
    required _i2.Weekday day,
    required String startTime,
    required String endTime,
    required int timetableId,
    _i3.Timetable? timetable,
  }) : super._(
          id: id,
          day: day,
          startTime: startTime,
          endTime: endTime,
          timetableId: timetableId,
          timetable: timetable,
        );

  /// Returns a shallow copy of this [TimetableSlot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TimetableSlot copyWith({
    Object? id = _Undefined,
    _i2.Weekday? day,
    String? startTime,
    String? endTime,
    int? timetableId,
    Object? timetable = _Undefined,
  }) {
    return TimetableSlot(
      id: id is int? ? id : this.id,
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timetableId: timetableId ?? this.timetableId,
      timetable:
          timetable is _i3.Timetable? ? timetable : this.timetable?.copyWith(),
    );
  }
}
