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
import '../../../_features/schoolday/models/schoolday.dart' as _i2;
import '../../../_features/learning/models/competence_report.dart' as _i3;
import '../../../_features/learning_support/models/learning_support_plan.dart'
    as _i4;

abstract class SchoolSemester implements _i1.SerializableModel {
  SchoolSemester._({
    this.id,
    required this.schoolYear,
    required this.isFirst,
    required this.startDate,
    required this.endDate,
    this.classConferenceDate,
    this.supportConferenceDate,
    this.reportConferenceDate,
    this.reportSignedDate,
    this.schooldays,
    this.competenceReports,
    this.learningSupportPlans,
  });

  factory SchoolSemester({
    int? id,
    required String schoolYear,
    required bool isFirst,
    required DateTime startDate,
    required DateTime endDate,
    DateTime? classConferenceDate,
    DateTime? supportConferenceDate,
    DateTime? reportConferenceDate,
    DateTime? reportSignedDate,
    List<_i2.Schoolday>? schooldays,
    List<_i3.CompetenceReport>? competenceReports,
    List<_i4.LearningSupportPlan>? learningSupportPlans,
  }) = _SchoolSemesterImpl;

  factory SchoolSemester.fromJson(Map<String, dynamic> jsonSerialization) {
    return SchoolSemester(
      id: jsonSerialization['id'] as int?,
      schoolYear: jsonSerialization['schoolYear'] as String,
      isFirst: jsonSerialization['isFirst'] as bool,
      startDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startDate']),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      classConferenceDate: jsonSerialization['classConferenceDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['classConferenceDate']),
      supportConferenceDate: jsonSerialization['supportConferenceDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['supportConferenceDate']),
      reportConferenceDate: jsonSerialization['reportConferenceDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['reportConferenceDate']),
      reportSignedDate: jsonSerialization['reportSignedDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['reportSignedDate']),
      schooldays: (jsonSerialization['schooldays'] as List?)
          ?.map((e) => _i2.Schoolday.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceReports: (jsonSerialization['competenceReports'] as List?)
          ?.map(
              (e) => _i3.CompetenceReport.fromJson((e as Map<String, dynamic>)))
          .toList(),
      learningSupportPlans: (jsonSerialization['learningSupportPlans'] as List?)
          ?.map((e) =>
              _i4.LearningSupportPlan.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String schoolYear;

  bool isFirst;

  DateTime startDate;

  DateTime endDate;

  DateTime? classConferenceDate;

  DateTime? supportConferenceDate;

  DateTime? reportConferenceDate;

  DateTime? reportSignedDate;

  List<_i2.Schoolday>? schooldays;

  List<_i3.CompetenceReport>? competenceReports;

  List<_i4.LearningSupportPlan>? learningSupportPlans;

  /// Returns a shallow copy of this [SchoolSemester]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SchoolSemester copyWith({
    int? id,
    String? schoolYear,
    bool? isFirst,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? classConferenceDate,
    DateTime? supportConferenceDate,
    DateTime? reportConferenceDate,
    DateTime? reportSignedDate,
    List<_i2.Schoolday>? schooldays,
    List<_i3.CompetenceReport>? competenceReports,
    List<_i4.LearningSupportPlan>? learningSupportPlans,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'schoolYear': schoolYear,
      'isFirst': isFirst,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      if (classConferenceDate != null)
        'classConferenceDate': classConferenceDate?.toJson(),
      if (supportConferenceDate != null)
        'supportConferenceDate': supportConferenceDate?.toJson(),
      if (reportConferenceDate != null)
        'reportConferenceDate': reportConferenceDate?.toJson(),
      if (reportSignedDate != null)
        'reportSignedDate': reportSignedDate?.toJson(),
      if (schooldays != null)
        'schooldays': schooldays?.toJson(valueToJson: (v) => v.toJson()),
      if (competenceReports != null)
        'competenceReports':
            competenceReports?.toJson(valueToJson: (v) => v.toJson()),
      if (learningSupportPlans != null)
        'learningSupportPlans':
            learningSupportPlans?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SchoolSemesterImpl extends SchoolSemester {
  _SchoolSemesterImpl({
    int? id,
    required String schoolYear,
    required bool isFirst,
    required DateTime startDate,
    required DateTime endDate,
    DateTime? classConferenceDate,
    DateTime? supportConferenceDate,
    DateTime? reportConferenceDate,
    DateTime? reportSignedDate,
    List<_i2.Schoolday>? schooldays,
    List<_i3.CompetenceReport>? competenceReports,
    List<_i4.LearningSupportPlan>? learningSupportPlans,
  }) : super._(
          id: id,
          schoolYear: schoolYear,
          isFirst: isFirst,
          startDate: startDate,
          endDate: endDate,
          classConferenceDate: classConferenceDate,
          supportConferenceDate: supportConferenceDate,
          reportConferenceDate: reportConferenceDate,
          reportSignedDate: reportSignedDate,
          schooldays: schooldays,
          competenceReports: competenceReports,
          learningSupportPlans: learningSupportPlans,
        );

  /// Returns a shallow copy of this [SchoolSemester]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SchoolSemester copyWith({
    Object? id = _Undefined,
    String? schoolYear,
    bool? isFirst,
    DateTime? startDate,
    DateTime? endDate,
    Object? classConferenceDate = _Undefined,
    Object? supportConferenceDate = _Undefined,
    Object? reportConferenceDate = _Undefined,
    Object? reportSignedDate = _Undefined,
    Object? schooldays = _Undefined,
    Object? competenceReports = _Undefined,
    Object? learningSupportPlans = _Undefined,
  }) {
    return SchoolSemester(
      id: id is int? ? id : this.id,
      schoolYear: schoolYear ?? this.schoolYear,
      isFirst: isFirst ?? this.isFirst,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      classConferenceDate: classConferenceDate is DateTime?
          ? classConferenceDate
          : this.classConferenceDate,
      supportConferenceDate: supportConferenceDate is DateTime?
          ? supportConferenceDate
          : this.supportConferenceDate,
      reportConferenceDate: reportConferenceDate is DateTime?
          ? reportConferenceDate
          : this.reportConferenceDate,
      reportSignedDate: reportSignedDate is DateTime?
          ? reportSignedDate
          : this.reportSignedDate,
      schooldays: schooldays is List<_i2.Schoolday>?
          ? schooldays
          : this.schooldays?.map((e0) => e0.copyWith()).toList(),
      competenceReports: competenceReports is List<_i3.CompetenceReport>?
          ? competenceReports
          : this.competenceReports?.map((e0) => e0.copyWith()).toList(),
      learningSupportPlans:
          learningSupportPlans is List<_i4.LearningSupportPlan>?
              ? learningSupportPlans
              : this.learningSupportPlans?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
