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
import '../learning/competence_check.dart' as _i2;

abstract class CompetenceCheckFile implements _i1.SerializableModel {
  CompetenceCheckFile._({
    this.id,
    required this.fileId,
    required this.fileUrl,
    required this.fileExtension,
    required this.uploadedAt,
    required this.uploadedBy,
    required this.competenceCheckId,
    this.competenceCheck,
  });

  factory CompetenceCheckFile({
    int? id,
    required String fileId,
    required String fileUrl,
    required String fileExtension,
    required DateTime uploadedAt,
    required String uploadedBy,
    required int competenceCheckId,
    _i2.CompetenceCheck? competenceCheck,
  }) = _CompetenceCheckFileImpl;

  factory CompetenceCheckFile.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompetenceCheckFile(
      id: jsonSerialization['id'] as int?,
      fileId: jsonSerialization['fileId'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      fileExtension: jsonSerialization['fileExtension'] as String,
      uploadedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['uploadedAt']),
      uploadedBy: jsonSerialization['uploadedBy'] as String,
      competenceCheckId: jsonSerialization['competenceCheckId'] as int,
      competenceCheck: jsonSerialization['competenceCheck'] == null
          ? null
          : _i2.CompetenceCheck.fromJson(
              (jsonSerialization['competenceCheck'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String fileId;

  String fileUrl;

  String fileExtension;

  DateTime uploadedAt;

  String uploadedBy;

  int competenceCheckId;

  _i2.CompetenceCheck? competenceCheck;

  /// Returns a shallow copy of this [CompetenceCheckFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompetenceCheckFile copyWith({
    int? id,
    String? fileId,
    String? fileUrl,
    String? fileExtension,
    DateTime? uploadedAt,
    String? uploadedBy,
    int? competenceCheckId,
    _i2.CompetenceCheck? competenceCheck,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'fileId': fileId,
      'fileUrl': fileUrl,
      'fileExtension': fileExtension,
      'uploadedAt': uploadedAt.toJson(),
      'uploadedBy': uploadedBy,
      'competenceCheckId': competenceCheckId,
      if (competenceCheck != null) 'competenceCheck': competenceCheck?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetenceCheckFileImpl extends CompetenceCheckFile {
  _CompetenceCheckFileImpl({
    int? id,
    required String fileId,
    required String fileUrl,
    required String fileExtension,
    required DateTime uploadedAt,
    required String uploadedBy,
    required int competenceCheckId,
    _i2.CompetenceCheck? competenceCheck,
  }) : super._(
          id: id,
          fileId: fileId,
          fileUrl: fileUrl,
          fileExtension: fileExtension,
          uploadedAt: uploadedAt,
          uploadedBy: uploadedBy,
          competenceCheckId: competenceCheckId,
          competenceCheck: competenceCheck,
        );

  /// Returns a shallow copy of this [CompetenceCheckFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompetenceCheckFile copyWith({
    Object? id = _Undefined,
    String? fileId,
    String? fileUrl,
    String? fileExtension,
    DateTime? uploadedAt,
    String? uploadedBy,
    int? competenceCheckId,
    Object? competenceCheck = _Undefined,
  }) {
    return CompetenceCheckFile(
      id: id is int? ? id : this.id,
      fileId: fileId ?? this.fileId,
      fileUrl: fileUrl ?? this.fileUrl,
      fileExtension: fileExtension ?? this.fileExtension,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      competenceCheckId: competenceCheckId ?? this.competenceCheckId,
      competenceCheck: competenceCheck is _i2.CompetenceCheck?
          ? competenceCheck
          : this.competenceCheck?.copyWith(),
    );
  }
}
