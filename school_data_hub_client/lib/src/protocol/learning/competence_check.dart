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
import '../learning/competence_check_file.dart' as _i4;

abstract class CompetenceCheck implements _i1.SerializableModel {
  CompetenceCheck._({
    this.id,
    required this.publicId,
    required this.achievement,
    required this.comment,
    required this.createdBy,
    required this.createdAt,
    required this.valueFactor,
    required this.groupCheckId,
    required this.groupCheckName,
    required this.pupilId,
    this.pupil,
    required this.competenceId,
    this.competence,
    this.competenceCheckFiles,
  });

  factory CompetenceCheck({
    int? id,
    required String publicId,
    required String achievement,
    required String comment,
    required String createdBy,
    required DateTime createdAt,
    required double valueFactor,
    required String groupCheckId,
    required String groupCheckName,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    List<_i4.CompetenceCheckFile>? competenceCheckFiles,
  }) = _CompetenceCheckImpl;

  factory CompetenceCheck.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompetenceCheck(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as String,
      achievement: jsonSerialization['achievement'] as String,
      comment: jsonSerialization['comment'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      valueFactor: (jsonSerialization['valueFactor'] as num).toDouble(),
      groupCheckId: jsonSerialization['groupCheckId'] as String,
      groupCheckName: jsonSerialization['groupCheckName'] as String,
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
      competenceCheckFiles: (jsonSerialization['competenceCheckFiles'] as List?)
          ?.map((e) =>
              _i4.CompetenceCheckFile.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String publicId;

  String achievement;

  String comment;

  String createdBy;

  DateTime createdAt;

  double valueFactor;

  String groupCheckId;

  String groupCheckName;

  int pupilId;

  _i2.PupilData? pupil;

  int competenceId;

  _i3.Competence? competence;

  List<_i4.CompetenceCheckFile>? competenceCheckFiles;

  /// Returns a shallow copy of this [CompetenceCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompetenceCheck copyWith({
    int? id,
    String? publicId,
    String? achievement,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
    double? valueFactor,
    String? groupCheckId,
    String? groupCheckName,
    int? pupilId,
    _i2.PupilData? pupil,
    int? competenceId,
    _i3.Competence? competence,
    List<_i4.CompetenceCheckFile>? competenceCheckFiles,
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
      'valueFactor': valueFactor,
      'groupCheckId': groupCheckId,
      'groupCheckName': groupCheckName,
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'competenceId': competenceId,
      if (competence != null) 'competence': competence?.toJson(),
      if (competenceCheckFiles != null)
        'competenceCheckFiles':
            competenceCheckFiles?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetenceCheckImpl extends CompetenceCheck {
  _CompetenceCheckImpl({
    int? id,
    required String publicId,
    required String achievement,
    required String comment,
    required String createdBy,
    required DateTime createdAt,
    required double valueFactor,
    required String groupCheckId,
    required String groupCheckName,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    List<_i4.CompetenceCheckFile>? competenceCheckFiles,
  }) : super._(
          id: id,
          publicId: publicId,
          achievement: achievement,
          comment: comment,
          createdBy: createdBy,
          createdAt: createdAt,
          valueFactor: valueFactor,
          groupCheckId: groupCheckId,
          groupCheckName: groupCheckName,
          pupilId: pupilId,
          pupil: pupil,
          competenceId: competenceId,
          competence: competence,
          competenceCheckFiles: competenceCheckFiles,
        );

  /// Returns a shallow copy of this [CompetenceCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompetenceCheck copyWith({
    Object? id = _Undefined,
    String? publicId,
    String? achievement,
    String? comment,
    String? createdBy,
    DateTime? createdAt,
    double? valueFactor,
    String? groupCheckId,
    String? groupCheckName,
    int? pupilId,
    Object? pupil = _Undefined,
    int? competenceId,
    Object? competence = _Undefined,
    Object? competenceCheckFiles = _Undefined,
  }) {
    return CompetenceCheck(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      achievement: achievement ?? this.achievement,
      comment: comment ?? this.comment,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      valueFactor: valueFactor ?? this.valueFactor,
      groupCheckId: groupCheckId ?? this.groupCheckId,
      groupCheckName: groupCheckName ?? this.groupCheckName,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      competenceId: competenceId ?? this.competenceId,
      competence: competence is _i3.Competence?
          ? competence
          : this.competence?.copyWith(),
      competenceCheckFiles:
          competenceCheckFiles is List<_i4.CompetenceCheckFile>?
              ? competenceCheckFiles
              : this.competenceCheckFiles?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
