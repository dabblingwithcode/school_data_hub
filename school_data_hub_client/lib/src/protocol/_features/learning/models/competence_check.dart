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
import '../../../_features/learning/models/competence.dart' as _i3;
import '../../../_shared/models/hub_document.dart' as _i4;

abstract class CompetenceCheck implements _i1.SerializableModel {
  CompetenceCheck._({
    this.id,
    required this.checkId,
    required this.score,
    this.comment,
    required this.createdBy,
    required this.createdAt,
    required this.valueFactor,
    this.groupCheckId,
    this.groupCheckName,
    required this.pupilId,
    this.pupil,
    required this.competenceId,
    this.competence,
    this.documents,
  });

  factory CompetenceCheck({
    int? id,
    required String checkId,
    required int score,
    String? comment,
    required String createdBy,
    required DateTime createdAt,
    required double valueFactor,
    String? groupCheckId,
    String? groupCheckName,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    List<_i4.HubDocument>? documents,
  }) = _CompetenceCheckImpl;

  factory CompetenceCheck.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompetenceCheck(
      id: jsonSerialization['id'] as int?,
      checkId: jsonSerialization['checkId'] as String,
      score: jsonSerialization['score'] as int,
      comment: jsonSerialization['comment'] as String?,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      valueFactor: (jsonSerialization['valueFactor'] as num).toDouble(),
      groupCheckId: jsonSerialization['groupCheckId'] as String?,
      groupCheckName: jsonSerialization['groupCheckName'] as String?,
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

  String checkId;

  int score;

  String? comment;

  String createdBy;

  DateTime createdAt;

  double valueFactor;

  String? groupCheckId;

  String? groupCheckName;

  int pupilId;

  _i2.PupilData? pupil;

  int competenceId;

  _i3.Competence? competence;

  List<_i4.HubDocument>? documents;

  /// Returns a shallow copy of this [CompetenceCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompetenceCheck copyWith({
    int? id,
    String? checkId,
    int? score,
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
    List<_i4.HubDocument>? documents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'checkId': checkId,
      'score': score,
      if (comment != null) 'comment': comment,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'valueFactor': valueFactor,
      if (groupCheckId != null) 'groupCheckId': groupCheckId,
      if (groupCheckName != null) 'groupCheckName': groupCheckName,
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

class _CompetenceCheckImpl extends CompetenceCheck {
  _CompetenceCheckImpl({
    int? id,
    required String checkId,
    required int score,
    String? comment,
    required String createdBy,
    required DateTime createdAt,
    required double valueFactor,
    String? groupCheckId,
    String? groupCheckName,
    required int pupilId,
    _i2.PupilData? pupil,
    required int competenceId,
    _i3.Competence? competence,
    List<_i4.HubDocument>? documents,
  }) : super._(
          id: id,
          checkId: checkId,
          score: score,
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
          documents: documents,
        );

  /// Returns a shallow copy of this [CompetenceCheck]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompetenceCheck copyWith({
    Object? id = _Undefined,
    String? checkId,
    int? score,
    Object? comment = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    double? valueFactor,
    Object? groupCheckId = _Undefined,
    Object? groupCheckName = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
    int? competenceId,
    Object? competence = _Undefined,
    Object? documents = _Undefined,
  }) {
    return CompetenceCheck(
      id: id is int? ? id : this.id,
      checkId: checkId ?? this.checkId,
      score: score ?? this.score,
      comment: comment is String? ? comment : this.comment,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      valueFactor: valueFactor ?? this.valueFactor,
      groupCheckId: groupCheckId is String? ? groupCheckId : this.groupCheckId,
      groupCheckName:
          groupCheckName is String? ? groupCheckName : this.groupCheckName,
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
