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
import '../school_list/school_list.dart' as _i2;
import '../pupil_data/pupil_data.dart' as _i3;

abstract class PupilListEntry implements _i1.SerializableModel {
  PupilListEntry._({
    this.id,
    this.status,
    this.comment,
    this.entryBy,
    required this.schoolListId,
    this.schoolList,
    required this.pupilId,
    this.pupil,
  });

  factory PupilListEntry({
    int? id,
    bool? status,
    String? comment,
    String? entryBy,
    required int schoolListId,
    _i2.SchoolList? schoolList,
    required int pupilId,
    _i3.PupilData? pupil,
  }) = _PupilListEntryImpl;

  factory PupilListEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilListEntry(
      id: jsonSerialization['id'] as int?,
      status: jsonSerialization['status'] as bool?,
      comment: jsonSerialization['comment'] as String?,
      entryBy: jsonSerialization['entryBy'] as String?,
      schoolListId: jsonSerialization['schoolListId'] as int,
      schoolList: jsonSerialization['schoolList'] == null
          ? null
          : _i2.SchoolList.fromJson(
              (jsonSerialization['schoolList'] as Map<String, dynamic>)),
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

  bool? status;

  String? comment;

  String? entryBy;

  int schoolListId;

  _i2.SchoolList? schoolList;

  int pupilId;

  _i3.PupilData? pupil;

  /// Returns a shallow copy of this [PupilListEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilListEntry copyWith({
    int? id,
    bool? status,
    String? comment,
    String? entryBy,
    int? schoolListId,
    _i2.SchoolList? schoolList,
    int? pupilId,
    _i3.PupilData? pupil,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (status != null) 'status': status,
      if (comment != null) 'comment': comment,
      if (entryBy != null) 'entryBy': entryBy,
      'schoolListId': schoolListId,
      if (schoolList != null) 'schoolList': schoolList?.toJson(),
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

class _PupilListEntryImpl extends PupilListEntry {
  _PupilListEntryImpl({
    int? id,
    bool? status,
    String? comment,
    String? entryBy,
    required int schoolListId,
    _i2.SchoolList? schoolList,
    required int pupilId,
    _i3.PupilData? pupil,
  }) : super._(
          id: id,
          status: status,
          comment: comment,
          entryBy: entryBy,
          schoolListId: schoolListId,
          schoolList: schoolList,
          pupilId: pupilId,
          pupil: pupil,
        );

  /// Returns a shallow copy of this [PupilListEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilListEntry copyWith({
    Object? id = _Undefined,
    Object? status = _Undefined,
    Object? comment = _Undefined,
    Object? entryBy = _Undefined,
    int? schoolListId,
    Object? schoolList = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
  }) {
    return PupilListEntry(
      id: id is int? ? id : this.id,
      status: status is bool? ? status : this.status,
      comment: comment is String? ? comment : this.comment,
      entryBy: entryBy is String? ? entryBy : this.entryBy,
      schoolListId: schoolListId ?? this.schoolListId,
      schoolList: schoolList is _i2.SchoolList?
          ? schoolList
          : this.schoolList?.copyWith(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i3.PupilData? ? pupil : this.pupil?.copyWith(),
    );
  }
}
