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
import '../shared/document.dart' as _i4;

abstract class CompetenceGoal implements _i1.SerializableModel {
  CompetenceGoal._({
    this.id,
    required this.publicId,
    required this.description,
    this.strategies,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.achievement,
    required this.achievedAt,
    required this.pupilId,
    this.pupil,
    required this.competenceId,
    this.competence,
    this.documents,
  });

  factory CompetenceGoal({
    int? id,
    required String publicId,
    required String description,
    List<String>? strategies,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required String achievement,
    required DateTime achievedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    List<_i4.HubDocument>? documents,
  }) = _CompetenceGoalImpl;

  factory CompetenceGoal.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompetenceGoal(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as String,
      description: jsonSerialization['description'] as String,
      strategies: (jsonSerialization['strategies'] as List?)
          ?.map((e) => e as String)
          .toList(),
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
      competenceId: jsonSerialization['competenceId'] as int,
      competence: jsonSerialization['competence'] == null
          ? null
          : _i3.Competence.fromJson(
              (jsonSerialization['competence'] as Map<String, dynamic>)),
      documents: (jsonSerialization['documents'] as List?)
          ?.map((e) => _i4.HubDocument.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String publicId;

  String description;

  List<String>? strategies;

  String createdBy;

  DateTime createdAt;

  String modifiedBy;

  String achievement;

  DateTime achievedAt;

  int pupilId;

  _i2.PupilData? pupil;

  int competenceId;

  _i3.Competence? competence;

  List<_i4.HubDocument>? documents;

  /// Returns a shallow copy of this [CompetenceGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompetenceGoal copyWith({
    int? id,
    String? publicId,
    String? description,
    List<String>? strategies,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    String? achievement,
    DateTime? achievedAt,
    int? pupilId,
    _i2.PupilData? pupil,
    int? competenceId,
    _i3.Competence? competence,
    List<_i4.HubDocument>? documents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      'description': description,
      if (strategies != null) 'strategies': strategies?.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'modifiedBy': modifiedBy,
      'achievement': achievement,
      'achievedAt': achievedAt.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'competenceId': competenceId,
      if (competence != null) 'competence': competence?.toJson(),
      if (documents != null)
        'documents': documents?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetenceGoalImpl extends CompetenceGoal {
  _CompetenceGoalImpl({
    int? id,
    required String publicId,
    required String description,
    List<String>? strategies,
    required String createdBy,
    required DateTime createdAt,
    required String modifiedBy,
    required String achievement,
    required DateTime achievedAt,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    List<_i4.HubDocument>? documents,
  }) : super._(
          id: id,
          publicId: publicId,
          description: description,
          strategies: strategies,
          createdBy: createdBy,
          createdAt: createdAt,
          modifiedBy: modifiedBy,
          achievement: achievement,
          achievedAt: achievedAt,
          pupilId: pupilId,
          pupil: pupil,
          competenceId: competenceId,
          competence: competence,
          documents: documents,
        );

  /// Returns a shallow copy of this [CompetenceGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompetenceGoal copyWith({
    Object? id = _Undefined,
    String? publicId,
    String? description,
    Object? strategies = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    String? modifiedBy,
    String? achievement,
    DateTime? achievedAt,
    int? pupilId,
    Object? pupil = _Undefined,
    int? competenceId,
    Object? competence = _Undefined,
    Object? documents = _Undefined,
  }) {
    return CompetenceGoal(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      description: description ?? this.description,
      strategies: strategies is List<String>?
          ? strategies
          : this.strategies?.map((e0) => e0).toList(),
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      achievement: achievement ?? this.achievement,
      achievedAt: achievedAt ?? this.achievedAt,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      competenceId: competenceId ?? this.competenceId,
      competence: competence is _i3.Competence?
          ? competence
          : this.competence?.copyWith(),
      documents: documents is List<_i4.HubDocument>?
          ? documents
          : this.documents?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
