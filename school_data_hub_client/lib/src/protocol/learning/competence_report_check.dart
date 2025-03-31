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
import '../learning/competence.dart' as _i3;
import '../learning/competence_report.dart' as _i4;

abstract class CompetenceReportCheck implements _i1.SerializableModel {
  CompetenceReportCheck._({
    this.id,
    required this.publicId,
    required this.achievement,
    required this.comment,
    required this.createdBy,
    required this.createdAt,
    required this.pupilId,
    this.pupil,
    required this.competenceId,
    this.competence,
    required this.competenceReportId,
    this.competenceReport,
  });

  factory CompetenceReportCheck({
    int? id,
    required String publicId,
    required int achievement,
    required String comment,
    required String createdBy,
    required DateTime createdAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    required int competenceReportId,
    _i4.CompetenceReport? competenceReport,
  }) = _CompetenceReportCheckImpl;

  factory CompetenceReportCheck.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CompetenceReportCheck(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as String,
      achievement: jsonSerialization['achievement'] as int,
      comment: jsonSerialization['comment'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      competenceId: jsonSerialization['competenceId'] as int,
      competence: jsonSerialization['competence'] == null
          ? null
          : _i3.Competence.fromJson(
              (jsonSerialization['competence'] as Map<String, dynamic>)),
      competenceReportId: jsonSerialization['competenceReportId'] as int,
      competenceReport: jsonSerialization['competenceReport'] == null
          ? null
          : _i4.CompetenceReport.fromJson(
              (jsonSerialization['competenceReport'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String publicId;

  int achievement;

  String comment;

  String createdBy;

  DateTime createdAt;

  int pupilId;

  _i2.PupilData? pupil;

  int competenceId;

  _i3.Competence? competence;

  int competenceReportId;

  _i4.CompetenceReport? competenceReport;

  /// Returns a shallow copy of this [CompetenceReportCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompetenceReportCheck copyWith({
    int? id,
    String? publicId,
    int? achievement,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
    int? pupilId,
    _i2.PupilData? pupil,
    int? competenceId,
    _i3.Competence? competence,
    int? competenceReportId,
    _i4.CompetenceReport? competenceReport,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      'achievement': achievement,
      'comment': comment,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'competenceId': competenceId,
      if (competence != null) 'competence': competence?.toJson(),
      'competenceReportId': competenceReportId,
      if (competenceReport != null)
        'competenceReport': competenceReport?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetenceReportCheckImpl extends CompetenceReportCheck {
  _CompetenceReportCheckImpl({
    int? id,
    required String publicId,
    required int achievement,
    required String comment,
    required String createdBy,
    required DateTime createdAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    required int competenceReportId,
    _i4.CompetenceReport? competenceReport,
  }) : super._(
          id: id,
          publicId: publicId,
          achievement: achievement,
          comment: comment,
          createdBy: createdBy,
          createdAt: createdAt,
          pupilId: pupilId,
          pupil: pupil,
          competenceId: competenceId,
          competence: competence,
          competenceReportId: competenceReportId,
          competenceReport: competenceReport,
        );

  /// Returns a shallow copy of this [CompetenceReportCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompetenceReportCheck copyWith({
    Object? id = _Undefined,
    String? publicId,
    int? achievement,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
    int? pupilId,
    Object? pupil = _Undefined,
    int? competenceId,
    Object? competence = _Undefined,
    int? competenceReportId,
    Object? competenceReport = _Undefined,
  }) {
    return CompetenceReportCheck(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      achievement: achievement ?? this.achievement,
      comment: comment ?? this.comment,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      competenceId: competenceId ?? this.competenceId,
      competence: competence is _i3.Competence?
          ? competence
          : this.competence?.copyWith(),
      competenceReportId: competenceReportId ?? this.competenceReportId,
      competenceReport: competenceReport is _i4.CompetenceReport?
          ? competenceReport
          : this.competenceReport?.copyWith(),
    );
  }
}
