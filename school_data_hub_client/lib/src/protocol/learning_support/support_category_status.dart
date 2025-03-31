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
import '../learning_support/support_category.dart' as _i3;

abstract class SupportCategoryStatus implements _i1.SerializableModel {
  SupportCategoryStatus._({
    this.id,
    required this.statusId,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.comment,
    required this.fileUrl,
    required this.fileId,
    required this.pupilId,
    this.pupil,
    required this.supportCategoryId,
    this.supportCategory,
  });

  factory SupportCategoryStatus({
    int? id,
    required String statusId,
    required int status,
    required String createdBy,
    required DateTime createdAt,
    required String comment,
    required String fileUrl,
    required String fileId,
    required int pupilId,
    _i2.PupilData? pupil,
    required int supportCategoryId,
    _i3.SupportCategory? supportCategory,
  }) = _SupportCategoryStatusImpl;

  factory SupportCategoryStatus.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SupportCategoryStatus(
      id: jsonSerialization['id'] as int?,
      statusId: jsonSerialization['statusId'] as String,
      status: jsonSerialization['status'] as int,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      comment: jsonSerialization['comment'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      fileId: jsonSerialization['fileId'] as String,
      pupilId: jsonSerialization['pupilId'] as int,
      pupil: jsonSerialization['pupil'] == null
          ? null
          : _i2.PupilData.fromJson(
              (jsonSerialization['pupil'] as Map<String, dynamic>)),
      supportCategoryId: jsonSerialization['supportCategoryId'] as int,
      supportCategory: jsonSerialization['supportCategory'] == null
          ? null
          : _i3.SupportCategory.fromJson(
              (jsonSerialization['supportCategory'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String statusId;

  int status;

  String createdBy;

  DateTime createdAt;

  String comment;

  String fileUrl;

  String fileId;

  int pupilId;

  _i2.PupilData? pupil;

  int supportCategoryId;

  _i3.SupportCategory? supportCategory;

  /// Returns a shallow copy of this [SupportCategoryStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportCategoryStatus copyWith({
    int? id,
    String? statusId,
    int? status,
    String? createdBy,
    DateTime? createdAt,
    String? comment,
    String? fileUrl,
    String? fileId,
    int? pupilId,
    _i2.PupilData? pupil,
    int? supportCategoryId,
    _i3.SupportCategory? supportCategory,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'statusId': statusId,
      'status': status,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'comment': comment,
      'fileUrl': fileUrl,
      'fileId': fileId,
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
    required String statusId,
    required int status,
    required String createdBy,
    required DateTime createdAt,
    required String comment,
    required String fileUrl,
    required String fileId,
    required int pupilId,
    _i2.PupilData? pupil,
    required int supportCategoryId,
    _i3.SupportCategory? supportCategory,
  }) : super._(
          id: id,
          statusId: statusId,
          status: status,
          createdBy: createdBy,
          createdAt: createdAt,
          comment: comment,
          fileUrl: fileUrl,
          fileId: fileId,
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
    String? statusId,
    int? status,
    String? createdBy,
    DateTime? createdAt,
    String? comment,
    String? fileUrl,
    String? fileId,
    int? pupilId,
    Object? pupil = _Undefined,
    int? supportCategoryId,
    Object? supportCategory = _Undefined,
  }) {
    return SupportCategoryStatus(
      id: id is int? ? id : this.id,
      statusId: statusId ?? this.statusId,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      comment: comment ?? this.comment,
      fileUrl: fileUrl ?? this.fileUrl,
      fileId: fileId ?? this.fileId,
      pupilId: pupilId ?? this.pupilId,
      pupil: pupil is _i2.PupilData? ? pupil : this.pupil?.copyWith(),
      supportCategoryId: supportCategoryId ?? this.supportCategoryId,
      supportCategory: supportCategory is _i3.SupportCategory?
          ? supportCategory
          : this.supportCategory?.copyWith(),
    );
  }
}
