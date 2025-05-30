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
import '../../../_features/attendance/models/missed_type.dart' as _i2;
import '../../../_features/attendance/models/contacted_type.dart' as _i3;
import '../../../_features/schoolday/models/schoolday.dart' as _i4;
import '../../../_features/pupil/models/pupil_data/pupil_data.dart' as _i5;

abstract class MissedClass implements _i1.SerializableModel {
  MissedClass._({
    this.id,
    required this.missedType,
    required this.unexcused,
    required this.contacted,
    required this.returned,
    this.returnedAt,
    required this.writtenExcuse,
    this.minutesLate,
    required this.createdBy,
    this.modifiedBy,
    this.comment,
    required this.schooldayId,
    this.schoolday,
    required this.pupilId,
    this.pupil,
  });

  factory MissedClass({
    int? id,
    required _i2.MissedType missedType,
    required bool unexcused,
    required _i3.ContactedType contacted,
    required bool returned,
    DateTime? returnedAt,
    required bool writtenExcuse,
    int? minutesLate,
    required String createdBy,
    String? modifiedBy,
    String? comment,
    required int schooldayId,
    _i4.Schoolday? schoolday,
    required int pupilId,
    _i5.PupilData? pupil,
  }) = _MissedClassImpl;

  factory MissedClass.fromJson(Map<String, dynamic> jsonSerialization) {
    return MissedClass(
      id: jsonSerialization['id'] as int?,
      missedType:
          _i2.MissedType.fromJson((jsonSerialization['missedType'] as String)),
      unexcused: jsonSerialization['unexcused'] as bool,
      contacted: _i3.ContactedType.fromJson(
          (jsonSerialization['contacted'] as String)),
      returned: jsonSerialization['returned'] as bool,
      returnedAt: jsonSerialization['returnedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['returnedAt']),
      writtenExcuse: jsonSerialization['writtenExcuse'] as bool,
      minutesLate: jsonSerialization['minutesLate'] as int?,
      createdBy: jsonSerialization['createdBy'] as String,
      modifiedBy: jsonSerialization['modifiedBy'] as String?,
      comment: jsonSerialization['comment'] as String?,
      schooldayId: jsonSerialization['schooldayId'] as int,
      schoolday: jsonSerialization['schoolday'] == null
          ? null
          : _i4.Schoolday.fromJson(
              (jsonSerialization['schoolday'] as Map<String, dynamic>)),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i5.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.MissedType missedType;

  bool unexcused;

  _i3.ContactedType contacted;

  bool returned;

  DateTime? returnedAt;

  bool writtenExcuse;

  int? minutesLate;

  String createdBy;

  String? modifiedBy;

  String? comment;

  int schooldayId;

  _i4.Schoolday? schoolday;

  int pupilId;

  _i5.PupilData? pupil;

  /// Returns a shallow copy of this [MissedClass]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MissedClass copyWith({
    int? id,
    _i2.MissedType? missedType,
    bool? unexcused,
    _i3.ContactedType? contacted,
    bool? returned,
    DateTime? returnedAt,
    bool? writtenExcuse,
    int? minutesLate,
    String? createdBy,
    String? modifiedBy,
    String? comment,
    int? schooldayId,
    _i4.Schoolday? schoolday,
    int? pupilId,
    _i5.PupilData? pupil,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'missedType': missedType.toJson(),
      'unexcused': unexcused,
      'contacted': contacted.toJson(),
      'returned': returned,
      if (returnedAt != null) 'returnedAt': returnedAt?.toJson(),
      'writtenExcuse': writtenExcuse,
      if (minutesLate != null) 'minutesLate': minutesLate,
      'createdBy': createdBy,
      if (modifiedBy != null) 'modifiedBy': modifiedBy,
      if (comment != null) 'comment': comment,
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
    required _i2.MissedType missedType,
    required bool unexcused,
    required _i3.ContactedType contacted,
    required bool returned,
    DateTime? returnedAt,
    required bool writtenExcuse,
    int? minutesLate,
    required String createdBy,
    String? modifiedBy,
    String? comment,
    required int schooldayId,
    _i4.Schoolday? schoolday,
    required int pupilId,
    _i5.PupilData? pupil,
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
    _i2.MissedType? missedType,
    bool? unexcused,
    _i3.ContactedType? contacted,
    bool? returned,
    Object? returnedAt = _Undefined,
    bool? writtenExcuse,
    Object? minutesLate = _Undefined,
    String? createdBy,
    Object? modifiedBy = _Undefined,
    Object? comment = _Undefined,
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
      returnedAt: returnedAt is DateTime? ? returnedAt : this.returnedAt,
      writtenExcuse: writtenExcuse ?? this.writtenExcuse,
      minutesLate: minutesLate is int? ? minutesLate : this.minutesLate,
      createdBy: createdBy ?? this.createdBy,
      modifiedBy: modifiedBy is String? ? modifiedBy : this.modifiedBy,
      comment: comment is String? ? comment : this.comment,
      schooldayId: schooldayId ?? this.schooldayId,
      schoolday:
          schoolday is _i4.Schoolday? ? schoolday : this.schoolday?.copyWith(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i5.PupilData? ? pupil : this.pupil?.copyWith(),
    );
  }
}
