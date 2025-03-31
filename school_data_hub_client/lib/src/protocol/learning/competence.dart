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
import '../learning/competence_goal.dart' as _i2;
import '../learning/competence_check.dart' as _i3;
import '../learning/competence_report_check.dart' as _i4;

abstract class Competence implements _i1.SerializableModel {
  Competence._({
    this.id,
    required this.publicId,
    this.parentCompetence,
    required this.name,
    this.level,
    this.indicators,
    this.order,
    this.competenceGoals,
    this.competenceChecks,
    this.competenceReportChecks,
  });

  factory Competence({
    int? id,
    required int publicId,
    int? parentCompetence,
    required String name,
    List<String>? level,
    List<String>? indicators,
    int? order,
    List<_i2.CompetenceGoal>? competenceGoals,
    List<_i3.CompetenceCheck>? competenceChecks,
    List<_i4.CompetenceReportCheck>? competenceReportChecks,
  }) = _CompetenceImpl;

  factory Competence.fromJson(Map<String, dynamic> jsonSerialization) {
    return Competence(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as int,
      parentCompetence: jsonSerialization['parentCompetence'] as int?,
      name: jsonSerialization['name'] as String,
      level: (jsonSerialization['level'] as List?)
          ?.map((e) => e as String)
          .toList(),
      indicators: (jsonSerialization['indicators'] as List?)
          ?.map((e) => e as String)
          .toList(),
      order: jsonSerialization['order'] as int?,
      competenceGoals: (jsonSerialization['competenceGoals'] as List?)
          ?.map((e) => _i2.CompetenceGoal.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceChecks: (jsonSerialization['competenceChecks'] as List?)
          ?.map(
              (e) => _i3.CompetenceCheck.fromJson((e as Map<String, dynamic>)))
          .toList(),
      competenceReportChecks: (jsonSerialization['competenceReportChecks']
              as List?)
          ?.map((e) =>
              _i4.CompetenceReportCheck.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int publicId;

  int? parentCompetence;

  String name;

  List<String>? level;

  List<String>? indicators;

  int? order;

  List<_i2.CompetenceGoal>? competenceGoals;

  List<_i3.CompetenceCheck>? competenceChecks;

  List<_i4.CompetenceReportCheck>? competenceReportChecks;

  /// Returns a shallow copy of this [Competence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Competence copyWith({
    int? id,
    int? publicId,
    int? parentCompetence,
    String? name,
    List<String>? level,
    List<String>? indicators,
    int? order,
    List<_i2.CompetenceGoal>? competenceGoals,
    List<_i3.CompetenceCheck>? competenceChecks,
    List<_i4.CompetenceReportCheck>? competenceReportChecks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      if (parentCompetence != null) 'parentCompetence': parentCompetence,
      'name': name,
      if (level != null) 'level': level?.toJson(),
      if (indicators != null) 'indicators': indicators?.toJson(),
      if (order != null) 'order': order,
      if (competenceGoals != null)
        'competenceGoals':
            competenceGoals?.toJson(valueToJson: (v) => v.toJson()),
      if (competenceChecks != null)
        'competenceChecks':
            competenceChecks?.toJson(valueToJson: (v) => v.toJson()),
      if (competenceReportChecks != null)
        'competenceReportChecks':
            competenceReportChecks?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetenceImpl extends Competence {
  _CompetenceImpl({
    int? id,
    required int publicId,
    int? parentCompetence,
    required String name,
    List<String>? level,
    List<String>? indicators,
    int? order,
    List<_i2.CompetenceGoal>? competenceGoals,
    List<_i3.CompetenceCheck>? competenceChecks,
    List<_i4.CompetenceReportCheck>? competenceReportChecks,
  }) : super._(
          id: id,
          publicId: publicId,
          parentCompetence: parentCompetence,
          name: name,
          level: level,
          indicators: indicators,
          order: order,
          competenceGoals: competenceGoals,
          competenceChecks: competenceChecks,
          competenceReportChecks: competenceReportChecks,
        );

  /// Returns a shallow copy of this [Competence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Competence copyWith({
    Object? id = _Undefined,
    int? publicId,
    Object? parentCompetence = _Undefined,
    String? name,
    Object? level = _Undefined,
    Object? indicators = _Undefined,
    Object? order = _Undefined,
    Object? competenceGoals = _Undefined,
    Object? competenceChecks = _Undefined,
    Object? competenceReportChecks = _Undefined,
  }) {
    return Competence(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      parentCompetence:
          parentCompetence is int? ? parentCompetence : this.parentCompetence,
      name: name ?? this.name,
      level:
          level is List<String>? ? level : this.level?.map((e0) => e0).toList(),
      indicators: indicators is List<String>?
          ? indicators
          : this.indicators?.map((e0) => e0).toList(),
      order: order is int? ? order : this.order,
      competenceGoals: competenceGoals is List<_i2.CompetenceGoal>?
          ? competenceGoals
          : this.competenceGoals?.map((e0) => e0.copyWith()).toList(),
      competenceChecks: competenceChecks is List<_i3.CompetenceCheck>?
          ? competenceChecks
          : this.competenceChecks?.map((e0) => e0.copyWith()).toList(),
      competenceReportChecks: competenceReportChecks
              is List<_i4.CompetenceReportCheck>?
          ? competenceReportChecks
          : this.competenceReportChecks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
