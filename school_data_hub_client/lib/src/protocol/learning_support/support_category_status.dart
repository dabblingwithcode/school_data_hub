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
import '../pupil_data/pupil_data.dart' as _i3;
import '../learning_support/support_category.dart' as _i4;

abstract class SupportCategoryStatus implements _i1.SerializableModel {
  SupportCategoryStatus._({
    this.id,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.comment,
    this.documents,
    required this.pupilId,
    this.pupil,
    required this.supportCategoryId,
    this.supportCategory,
  });

  factory SupportCategoryStatus({
    int? id,
    required int status,
    required String createdBy,
    required DateTime createdAt,
    required String comment,
    List<_i2.HubDocument>? documents,
    required int pupilId,
    _i3.PupilData? pupil,
    required int supportCategoryId,
    _i4.SupportCategory? supportCategory,
  }) = _SupportCategoryStatusImpl;

  factory SupportCategoryStatus.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SupportCategoryStatus(
      id: jsonSerialization['id'] as int?,
      status: jsonSerialization['status'] as int,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      comment: jsonSerialization['comment'] as String,
      documents: (jsonSerialization['documents'] as List?)
          ?.map((e) => _i2.HubDocument.fromJson((e as Map<String, dynamic>)))
          .toList(),
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i3.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      supportCategoryId: jsonSerialization['supportCategoryId'] as int,
      supportCategory: jsonSerialization['supportCategory'] == null
          ? null
          : _i4.SupportCategory.fromJson(
              (jsonSerialization['supportCategory'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int status;

  String createdBy;

  DateTime createdAt;

  String comment;

  List<_i2.HubDocument>? documents;

  int pupilId;

  _i3.PupilData? pupil;

  int supportCategoryId;

  _i4.SupportCategory? supportCategory;

  /// Returns a shallow copy of this [SupportCategoryStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportCategoryStatus copyWith({
    int? id,
    int? status,
    String? createdBy,
    DateTime? createdAt,
    String? comment,
    List<_i2.HubDocument>? documents,
    int? pupilId,
    _i3.PupilData? pupil,
    int? supportCategoryId,
    _i4.SupportCategory? supportCategory,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'status': status,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'comment': comment,
      if (documents != null)
        'documents': documents?.toJson(valueToJson: (v) => v.toJson()),
      'pupilId': pupilId,
      if (pupil != null) 'pupil': pupil?.toJson(),
      'supportCategoryId': supportCategoryId,
      if (supportCategory != null) 'supportCategory': supportCategory?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportCategoryStatusImpl extends SupportCategoryStatus {
  _SupportCategoryStatusImpl({
    int? id,
    required int status,
    required String createdBy,
    required DateTime createdAt,
    required String comment,
    List<_i2.HubDocument>? documents,
    required int pupilId,
    _i3.PupilData? pupil,
    required int supportCategoryId,
    _i4.SupportCategory? supportCategory,
  }) : super._(
          id: id,
          status: status,
          createdBy: createdBy,
          createdAt: createdAt,
          comment: comment,
          documents: documents,
          pupilId: pupilId,
          pupil: pupil,
          supportCategoryId: supportCategoryId,
          supportCategory: supportCategory,
        );

  /// Returns a shallow copy of this [SupportCategoryStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportCategoryStatus copyWith({
    Object? id = _Undefined,
    int? status,
    String? createdBy,
    DateTime? createdAt,
    String? comment,
    Object? documents = _Undefined,
    int? pupilId,
    Object? pupil = _Undefined,
    int? supportCategoryId,
    Object? supportCategory = _Undefined,
  }) {
    return SupportCategoryStatus(
      id: id is int? ? id : this.id,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      comment: comment ?? this.comment,
      documents: documents is List<_i2.HubDocument>?
          ? documents
          : this.documents?.map((e0) => e0.copyWith()).toList(),
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i3.PupilData? ? pupil : this.pupil?.copyWith(),
      supportCategoryId: supportCategoryId ?? this.supportCategoryId,
      supportCategory: supportCategory is _i4.SupportCategory?
          ? supportCategory
          : this.supportCategory?.copyWith(),
    );
  }
}
