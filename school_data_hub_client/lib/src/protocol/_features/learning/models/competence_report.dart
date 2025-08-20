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
import '../../../_features/learning/models/competence_report_check.dart' as _i3;
import '../../../_features/schoolday/models/school_semester.dart' as _i4;

abstract class CompetenceReport implements _i1.SerializableModel {
  CompetenceReport._({
    this.id,
    required this.reportId,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.achievement,
    required this.achievedAt,
    required this.pupilId,
    this.pupil,
    this.competenceReportChecks,
    required this.schoolSemesterId,
    this.schoolSemester,
  });

  factory CompetenceReport({
    int? id,
    required String reportId,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required String achievement,
    required DateTime achievedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    List<_i3.CompetenceReportCheck>? competenceReportChecks,
    required int schoolSemesterId,
    _i4.SchoolSemester? schoolSemester,
  }) = _CompetenceReportImpl;

  factory CompetenceReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompetenceReport(
      id: jsonSerialization['id'] as int?,
      reportId: jsonSerialization['reportId'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      modifiedBy: jsonSerialization['modifiedBy'] as String,
      achievement: jsonSerialization['achievement'] as String,
      achievedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['achievedAt']),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      competenceReportChecks: (jsonSerialization['competenceReportChecks']
              as List?)
          ?.map((e) =>
              _i3.CompetenceReportCheck.fromJson((e as Map<String, dynamic>)))
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

  String reportId;

  String createdBy;

  DateTime createdAt;

  String modifiedBy;

  String achievement;

  DateTime achievedAt;

  int pupilId;

  _i2.PupilData? pupil;

  List<_i3.CompetenceReportCheck>? competenceReportChecks;

  int schoolSemesterId;

  _i4.SchoolSemester? schoolSemester;

  /// Returns a shallow copy of this [CompetenceReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompetenceReport copyWith({
    int? id,
    String? reportId,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    String? achievement,
    DateTime? achievedAt,
    int? pupilId,
    _i2.PupilData? pupil,
    List<_i3.CompetenceReportCheck>? competenceReportChecks,
    int? schoolSemesterId,
    _i4.SchoolSemester? schoolSemester,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'reportId': reportId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      'achievement': achievement,
      'achievedAt': achievedAt.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      if (competenceReportChecks != null)
        'competenceReportChecks':
            competenceReportChecks?.toJson(valueToJson: (v) => v.toJson()),
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

class _CompetenceReportImpl extends CompetenceReport {
  _CompetenceReportImpl({
    int? id,
    required String reportId,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required String achievement,
    required DateTime achievedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    List<_i3.CompetenceReportCheck>? competenceReportChecks,
    required int schoolSemesterId,
    _i4.SchoolSemester? schoolSemester,
  }) : super._(
          id: id,
          reportId: reportId,
          createdBy: createdBy,
          createdAt: createdAt,
          modifiedBy: modifiedBy,
          achievement: achievement,
          achievedAt: achievedAt,
          pupilId: pupilId,
          pupil: pupil,
          competenceReportChecks: competenceReportChecks,
          schoolSemesterId: schoolSemesterId,
          schoolSemester: schoolSemester,
        );

  /// Returns a shallow copy of this [CompetenceReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompetenceReport copyWith({
    Object? id = _Undefined,
    String? reportId,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    String? achievement,
    DateTime? achievedAt,
    int? pupilId,
    Object? pupil = _Undefined,
    Object? competenceReportChecks = _Undefined,
    int? schoolSemesterId,
    Object? schoolSemester = _Undefined,
  }) {
    return CompetenceReport(
      id: id is int? ? id : this.id,
      reportId: reportId ?? this.reportId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      achievement: achievement ?? this.achievement,
      achievedAt: achievedAt ?? this.achievedAt,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      competenceReportChecks: competenceReportChecks
              is List<_i3.CompetenceReportCheck>?
          ? competenceReportChecks
          : this.competenceReportChecks?.map((e0) => e0.copyWith()).toList(),
      schoolSemesterId: schoolSemesterId ?? this.schoolSemesterId,
      schoolSemester: schoolSemester is _i4.SchoolSemester?
          ? schoolSemester
          : this.schoolSemester?.copyWith(),
    );
  }
}
