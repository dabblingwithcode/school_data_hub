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
import '../schoolday/schoolday.dart' as _i2;
import '../pupil_data/pupil_data.dart' as _i3;

abstract class MissedClass implements _i1.SerializableModel {
  MissedClass._({
    this.id,
    required this.missedType,
    required this.unexcused,
    required this.contacted,
    required this.returned,
    required this.returnedAt,
    required this.writtenExcuse,
    required this.minutesLate,
    required this.createdBy,
    required this.modifiedBy,
    required this.comment,
    required this.schooldayId,
    this.schoolday,
    required this.pupilId,
    this.pupil,
  });

  factory MissedClass({
    int? id,
    required int missedType,
    required bool unexcused,
    required String contacted,
    required bool returned,
    required DateTime returnedAt,
    required bool writtenExcuse,
    required int minutesLate,
    required String createdBy,
    required String modifiedBy,
    required String comment,
    required int schooldayId,
    _i2.Schoolday? schoolday,
    required int pupilId,
    _i3.PupilData? pupil,
  }) = _MissedClassImpl;

  factory MissedClass.fromJson(Map<String, dynamic> jsonSerialization) {
    return MissedClass(
      id: jsonSerialization['id'] as int?,
      missedType: jsonSerialization['missedType'] as int,
      unexcused: jsonSerialization['unexcused'] as bool,
      contacted: jsonSerialization['contacted'] as String,
      returned: jsonSerialization['returned'] as bool,
      returnedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['returnedAt']),
      writtenExcuse: jsonSerialization['writtenExcuse'] as bool,
      minutesLate: jsonSerialization['minutesLate'] as int,
      createdBy: jsonSerialization['createdBy'] as String,
      modifiedBy: jsonSerialization['modifiedBy'] as String,
      comment: jsonSerialization['comment'] as String,
      schooldayId: jsonSerialization['schooldayId'] as int,
      schoolday: jsonSerialization['schoolday'] == null
          ? null
          : _i2.Schoolday.fromJson(
              (jsonSerialization['schoolday'] as Map<String, dynamic>)),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i3.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int missedType;

  bool unexcused;

  String contacted;

  bool returned;

  DateTime returnedAt;

  bool writtenExcuse;

  int minutesLate;

  String createdBy;

  String modifiedBy;

  String comment;

  int schooldayId;

  _i2.Schoolday? schoolday;

  int pupilId;

  _i3.PupilData? pupil;

  /// Returns a shallow copy of this [MissedClass]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MissedClass copyWith({
    int? id,
    int? missedType,
    bool? unexcused,
    String? contacted,
    bool? returned,
    DateTime? returnedAt,
    bool? writtenExcuse,
    int? minutesLate,
    String? createdBy,
    String? modifiedBy,
    String? comment,
    int? schooldayId,
    _i2.Schoolday? schoolday,
    int? pupilId,
    _i3.PupilData? pupil,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'missedType': missedType,
      'unexcused': unexcused,
      'contacted': contacted,
      'returned': returned,
      'returnedAt': returnedAt.toJson(),
      'writtenExcuse': writtenExcuse,
      'minutesLate': minutesLate,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'comment': comment,
      'schooldayId': schooldayId,
      if (schoolday != null) 'schoolday': schoolday?.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MissedClassImpl extends MissedClass {
  _MissedClassImpl({
    int? id,
    required int missedType,
    required bool unexcused,
    required String contacted,
    required bool returned,
    required DateTime returnedAt,
    required bool writtenExcuse,
    required int minutesLate,
    required String createdBy,
    required String modifiedBy,
    required String comment,
    required int schooldayId,
    _i2.Schoolday? schoolday,
    required int pupilId,
    _i3.PupilData? pupil,
  }) : super._(
          id: id,
          missedType: missedType,
          unexcused: unexcused,
          contacted: contacted,
          returned: returned,
          returnedAt: returnedAt,
          writtenExcuse: writtenExcuse,
          minutesLate: minutesLate,
          createdBy: createdBy,
          modifiedBy: modifiedBy,
          comment: comment,
          schooldayId: schooldayId,
          schoolday: schoolday,
          pupilId: pupilId,
          pupil: pupil,
        );

  /// Returns a shallow copy of this [MissedClass]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MissedClass copyWith({
    Object? id = _Undefined,
    int? missedType,
    bool? unexcused,
    String? contacted,
    bool? returned,
    DateTime? returnedAt,
    bool? writtenExcuse,
    int? minutesLate,
    String? createdBy,
    String? modifiedBy,
    String? comment,
    int? schooldayId,
    Object? schoolday = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
  }) {
    return MissedClass(
      id: id is int? ? id : this.id,
      missedType: missedType ?? this.missedType,
      unexcused: unexcused ?? this.unexcused,
      contacted: contacted ?? this.contacted,
      returned: returned ?? this.returned,
      returnedAt: returnedAt ?? this.returnedAt,
      writtenExcuse: writtenExcuse ?? this.writtenExcuse,
      minutesLate: minutesLate ?? this.minutesLate,
      createdBy: createdBy ?? this.createdBy,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      comment: comment ?? this.comment,
      schooldayId: schooldayId ?? this.schooldayId,
      schoolday:
          schoolday is _i2.Schoolday? ? schoolday : this.schoolday?.copyWith(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i3.PupilData? ? pupil : this.pupil?.copyWith(),
    );
  }
}
