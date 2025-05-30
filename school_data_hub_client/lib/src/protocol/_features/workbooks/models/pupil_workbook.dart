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
import '../../../_features/pupil/models/pupil_data/pupil_data.dart' as _i2;
import '../../../_features/workbooks/models/workbook.dart' as _i3;

abstract class PupilWorkbook implements _i1.SerializableModel {
  PupilWorkbook._({
    this.id,
    required this.isbn,
    this.comment,
    required this.score,
    required this.createdBy,
    required this.createdAt,
    this.finishedAt,
    required this.pupilId,
    this.pupil,
    required this.workbookId,
    this.workbook,
  });

  factory PupilWorkbook({
    int? id,
    required int isbn,
    String? comment,
    required int score,
    required String createdBy,
    required DateTime createdAt,
    DateTime? finishedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int workbookId,
    _i3.Workbook? workbook,
  }) = _PupilWorkbookImpl;

  factory PupilWorkbook.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilWorkbook(
      id: jsonSerialization['id'] as int?,
      isbn: jsonSerialization['isbn'] as int,
      comment: jsonSerialization['comment'] as String?,
      score: jsonSerialization['score'] as int,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      finishedAt: jsonSerialization['finishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['finishedAt']),
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

  int isbn;

  String? comment;

  int score;

  String createdBy;

  DateTime createdAt;

  DateTime? finishedAt;

  int pupilId;

  _i2.PupilData? pupil;

  int workbookId;

  _i3.Workbook? workbook;

  /// Returns a shallow copy of this [PupilWorkbook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilWorkbook copyWith({
    int? id,
    int? isbn,
    String? comment,
    int? score,
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
      'isbn': isbn,
      if (comment != null) 'comment': comment,
      'score': score,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (finishedAt != null) 'finishedAt': finishedAt?.toJson(),
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
    required int isbn,
    String? comment,
    required int score,
    required String createdBy,
    required DateTime createdAt,
    DateTime? finishedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int workbookId,
    _i3.Workbook? workbook,
  }) : super._(
          id: id,
          isbn: isbn,
          comment: comment,
          score: score,
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
    int? isbn,
    Object? comment = _Undefined,
    int? score,
    String? createdBy,
    DateTime? createdAt,
    Object? finishedAt = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
    int? workbookId,
    Object? workbook = _Undefined,
  }) {
    return PupilWorkbook(
      id: id is int? ? id : this.id,
      isbn: isbn ?? this.isbn,
      comment: comment is String? ? comment : this.comment,
      score: score ?? this.score,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      finishedAt: finishedAt is DateTime? ? finishedAt : this.finishedAt,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      workbookId: workbookId ?? this.workbookId,
      workbook:
          workbook is _i3.Workbook? ? workbook : this.workbook?.copyWith(),
    );
  }
}
