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
import '../shared/document.dart' as _i2;
import '../authorization/authorization.dart' as _i3;
import '../pupil_data/pupil_data.dart' as _i4;

abstract class PupilAuthorization implements _i1.SerializableModel {
  PupilAuthorization._({
    this.id,
    this.status,
    this.comment,
    this.createdBy,
    this.fileId,
    this.file,
    required this.authorizationId,
    this.authorization,
    required this.pupilId,
    this.pupil,
  });

  factory PupilAuthorization({
    int? id,
    bool? status,
    String? comment,
    String? createdBy,
    int? fileId,
    _i2.HubDocument? file,
    required int authorizationId,
    _i3.Authorization? authorization,
    required int pupilId,
    _i4.PupilData? pupil,
  }) = _PupilAuthorizationImpl;

  factory PupilAuthorization.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilAuthorization(
      id: jsonSerialization['id'] as int?,
      status: jsonSerialization['status'] as bool?,
      comment: jsonSerialization['comment'] as String?,
      createdBy: jsonSerialization['createdBy'] as String?,
      fileId: jsonSerialization['fileId'] as int?,
      file: jsonSerialization['file'] == null
          ? null
          : _i2.HubDocument.fromJson(
              (jsonSerialization['file'] as Map<String, dynamic>)),
      authorizationId: jsonSerialization['authorizationId'] as int,
      authorization: jsonSerialization['authorization'] == null
          ? null
          : _i3.Authorization.fromJson(
              (jsonSerialization['authorization'] as Map<String, dynamic>)),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i4.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  bool? status;

  String? comment;

  String? createdBy;

  int? fileId;

  _i2.HubDocument? file;

  int authorizationId;

  _i3.Authorization? authorization;

  int pupilId;

  _i4.PupilData? pupil;

  /// Returns a shallow copy of this [PupilAuthorization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilAuthorization copyWith({
    int? id,
    bool? status,
    String? comment,
    String? createdBy,
    int? fileId,
    _i2.HubDocument? file,
    int? authorizationId,
    _i3.Authorization? authorization,
    int? pupilId,
    _i4.PupilData? pupil,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (status != null) 'status': status,
      if (comment != null) 'comment': comment,
      if (createdBy != null) 'createdBy': createdBy,
      if (fileId != null) 'fileId': fileId,
      if (file != null) 'file': file?.toJson(),
      'authorizationId': authorizationId,
      if (authorization != null) 'authorization': authorization?.toJson(),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilAuthorizationImpl extends PupilAuthorization {
  _PupilAuthorizationImpl({
    int? id,
    bool? status,
    String? comment,
    String? createdBy,
    int? fileId,
    _i2.HubDocument? file,
    required int authorizationId,
    _i3.Authorization? authorization,
    required int pupilId,
    _i4.PupilData? pupil,
  }) : super._(
          id: id,
          status: status,
          comment: comment,
          createdBy: createdBy,
          fileId: fileId,
          file: file,
          authorizationId: authorizationId,
          authorization: authorization,
          pupilId: pupilId,
          pupil: pupil,
        );

  /// Returns a shallow copy of this [PupilAuthorization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilAuthorization copyWith({
    Object? id = _Undefined,
    Object? status = _Undefined,
    Object? comment = _Undefined,
    Object? createdBy = _Undefined,
    Object? fileId = _Undefined,
    Object? file = _Undefined,
    int? authorizationId,
    Object? authorization = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
  }) {
    return PupilAuthorization(
      id: id is int? ? id : this.id,
      status: status is bool? ? status : this.status,
      comment: comment is String? ? comment : this.comment,
      createdBy: createdBy is String? ? createdBy : this.createdBy,
      fileId: fileId is int? ? fileId : this.fileId,
      file: file is _i2.HubDocument? ? file : this.file?.copyWith(),
      authorizationId: authorizationId ?? this.authorizationId,
      authorization: authorization is _i3.Authorization?
          ? authorization
          : this.authorization?.copyWith(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i4.PupilData? ? pupil : this.pupil?.copyWith(),
    );
  }
}
