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
import '../../../../_features/pupil/models/pupil_data/communication/public_media_auth.dart'
    as _i2;
import '../../../../_shared/models/hub_document.dart' as _i3;

abstract class PupilMediaData implements _i1.SerializableModel {
  PupilMediaData._({
    this.id,
    required this.publicMediaAuth,
    this.avatarId,
    this.avatar,
    this.avatarAuthId,
    this.avatarAuth,
    this.publicMediaAuthDocumentId,
    this.publicMediaAuthDocument,
  });

  factory PupilMediaData({
    int? id,
    required _i2.PublicMediaAuth publicMediaAuth,
    int? avatarId,
    _i3.HubDocument? avatar,
    int? avatarAuthId,
    _i3.HubDocument? avatarAuth,
    int? publicMediaAuthDocumentId,
    _i3.HubDocument? publicMediaAuthDocument,
  }) = _PupilMediaDataImpl;

  factory PupilMediaData.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilMediaData(
      id: jsonSerialization['id'] as int?,
      publicMediaAuth: _i2.PublicMediaAuth.fromJson(
          (jsonSerialization['publicMediaAuth'] as Map<String, dynamic>)),
      avatarId: jsonSerialization['avatarId'] as int?,
      avatar: jsonSerialization['avatar'] == null
          ? null
          : _i3.HubDocument.fromJson(
              (jsonSerialization['avatar'] as Map<String, dynamic>)),
      avatarAuthId: jsonSerialization['avatarAuthId'] as int?,
      avatarAuth: jsonSerialization['avatarAuth'] == null
          ? null
          : _i3.HubDocument.fromJson(
              (jsonSerialization['avatarAuth'] as Map<String, dynamic>)),
      publicMediaAuthDocumentId:
          jsonSerialization['publicMediaAuthDocumentId'] as int?,
      publicMediaAuthDocument:
          jsonSerialization['publicMediaAuthDocument'] == null
              ? null
              : _i3.HubDocument.fromJson(
                  (jsonSerialization['publicMediaAuthDocument']
                      as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.PublicMediaAuth publicMediaAuth;

  int? avatarId;

  _i3.HubDocument? avatar;

  int? avatarAuthId;

  _i3.HubDocument? avatarAuth;

  int? publicMediaAuthDocumentId;

  _i3.HubDocument? publicMediaAuthDocument;

  /// Returns a shallow copy of this [PupilMediaData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilMediaData copyWith({
    int? id,
    _i2.PublicMediaAuth? publicMediaAuth,
    int? avatarId,
    _i3.HubDocument? avatar,
    int? avatarAuthId,
    _i3.HubDocument? avatarAuth,
    int? publicMediaAuthDocumentId,
    _i3.HubDocument? publicMediaAuthDocument,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicMediaAuth': publicMediaAuth.toJson(),
      if (avatarId != null) 'avatarId': avatarId,
      if (avatar != null) 'avatar': avatar?.toJson(),
      if (avatarAuthId != null) 'avatarAuthId': avatarAuthId,
      if (avatarAuth != null) 'avatarAuth': avatarAuth?.toJson(),
      if (publicMediaAuthDocumentId != null)
        'publicMediaAuthDocumentId': publicMediaAuthDocumentId,
      if (publicMediaAuthDocument != null)
        'publicMediaAuthDocument': publicMediaAuthDocument?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilMediaDataImpl extends PupilMediaData {
  _PupilMediaDataImpl({
    int? id,
    required _i2.PublicMediaAuth publicMediaAuth,
    int? avatarId,
    _i3.HubDocument? avatar,
    int? avatarAuthId,
    _i3.HubDocument? avatarAuth,
    int? publicMediaAuthDocumentId,
    _i3.HubDocument? publicMediaAuthDocument,
  }) : super._(
          id: id,
          publicMediaAuth: publicMediaAuth,
          avatarId: avatarId,
          avatar: avatar,
          avatarAuthId: avatarAuthId,
          avatarAuth: avatarAuth,
          publicMediaAuthDocumentId: publicMediaAuthDocumentId,
          publicMediaAuthDocument: publicMediaAuthDocument,
        );

  /// Returns a shallow copy of this [PupilMediaData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilMediaData copyWith({
    Object? id = _Undefined,
    _i2.PublicMediaAuth? publicMediaAuth,
    Object? avatarId = _Undefined,
    Object? avatar = _Undefined,
    Object? avatarAuthId = _Undefined,
    Object? avatarAuth = _Undefined,
    Object? publicMediaAuthDocumentId = _Undefined,
    Object? publicMediaAuthDocument = _Undefined,
  }) {
    return PupilMediaData(
      id: id is int? ? id : this.id,
      publicMediaAuth: publicMediaAuth ?? this.publicMediaAuth.copyWith(),
      avatarId: avatarId is int? ? avatarId : this.avatarId,
      avatar: avatar is _i3.HubDocument? ? avatar : this.avatar?.copyWith(),
      avatarAuthId: avatarAuthId is int? ? avatarAuthId : this.avatarAuthId,
      avatarAuth: avatarAuth is _i3.HubDocument?
          ? avatarAuth
          : this.avatarAuth?.copyWith(),
      publicMediaAuthDocumentId: publicMediaAuthDocumentId is int?
          ? publicMediaAuthDocumentId
          : this.publicMediaAuthDocumentId,
      publicMediaAuthDocument: publicMediaAuthDocument is _i3.HubDocument?
          ? publicMediaAuthDocument
          : this.publicMediaAuthDocument?.copyWith(),
    );
  }
}
