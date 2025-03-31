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
import '../pupil_data/pupil_data.dart' as _i2;
import '../workbook/workbook.dart' as _i3;

abstract class PupilWorkbook implements _i1.SerializableModel {
  PupilWorkbook._({
    this.id,
    required this.comment,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.finishedAt,
    required this.pupilId,
    this.pupil,
    required this.workbookId,
    this.workbook,
  });

  factory PupilWorkbook({
    int? id,
    required String comment,
    required String status,
    required String createdBy,
    required DateTime createdAt,
    required DateTime finishedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int workbookId,
    _i3.Workbook? workbook,
  }) = _PupilWorkbookImpl;

  factory PupilWorkbook.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilWorkbook(
      id: jsonSerialization['id'] as int?,
      comment: jsonSerialization['comment'] as String,
      status: jsonSerialization['status'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      finishedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['finishedAt']),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      workbookId: jsonSerialization['workbookId'] as int,
      workbook: jsonSerialization['workbook'] == null
          ? null
          : _i3.Workbook.fromJson(
              (jsonSerialization['workbook'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String comment;

  String status;

  String createdBy;

  DateTime createdAt;

  DateTime finishedAt;

  int pupilId;

  _i2.PupilData? pupil;

  int workbookId;

  _i3.Workbook? workbook;

  /// Returns a shallow copy of this [PupilWorkbook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilWorkbook copyWith({
    int? id,
    String? comment,
    String? status,
    String? createdBy,
    DateTime? createdAt,
    DateTime? finishedAt,
    int? pupilId,
    _i2.PupilData? pupil,
    int? workbookId,
    _i3.Workbook? workbook,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'comment': comment,
      'status': status,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'finishedAt': finishedAt.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'workbookId': workbookId,
      if (workbook != null) 'workbook': workbook?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilWorkbookImpl extends PupilWorkbook {
  _PupilWorkbookImpl({
    int? id,
    required String comment,
    required String status,
    required String createdBy,
    required DateTime createdAt,
    required DateTime finishedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int workbookId,
    _i3.Workbook? workbook,
  }) : super._(
          id: id,
          comment: comment,
          status: status,
          createdBy: createdBy,
          createdAt: createdAt,
          finishedAt: finishedAt,
          pupilId: pupilId,
          pupil: pupil,
          workbookId: workbookId,
          workbook: workbook,
        );

  /// Returns a shallow copy of this [PupilWorkbook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilWorkbook copyWith({
    Object? id = _Undefined,
    String? comment,
    String? status,
    String? createdBy,
    DateTime? createdAt,
    DateTime? finishedAt,
    int? pupilId,
    Object? pupil = _Undefined,
    int? workbookId,
    Object? workbook = _Undefined,
  }) {
    return PupilWorkbook(
      id: id is int? ? id : this.id,
      comment: comment ?? this.comment,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      finishedAt: finishedAt ?? this.finishedAt,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      workbookId: workbookId ?? this.workbookId,
      workbook:
          workbook is _i3.Workbook? ? workbook : this.workbook?.copyWith(),
    );
  }
}
