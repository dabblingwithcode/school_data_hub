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
import '../book/pupil_book_lending.dart' as _i2;

abstract class PupilBookLendingFile implements _i1.SerializableModel {
  PupilBookLendingFile._({
    this.id,
    required this.fileId,
    required this.fileUrl,
    required this.fileExtension,
    required this.uploadedAt,
    required this.uploadedBy,
    required this.lendingId,
    this.lending,
  });

  factory PupilBookLendingFile({
    int? id,
    required String fileId,
    required String fileUrl,
    required String fileExtension,
    required DateTime uploadedAt,
    required String uploadedBy,
    required int lendingId,
    _i2.PupilBookLending? lending,
  }) = _PupilBookLendingFileImpl;

  factory PupilBookLendingFile.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return PupilBookLendingFile(
      id: jsonSerialization['id'] as int?,
      fileId: jsonSerialization['fileId'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      fileExtension: jsonSerialization['fileExtension'] as String,
      uploadedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['uploadedAt']),
      uploadedBy: jsonSerialization['uploadedBy'] as String,
      lendingId: jsonSerialization['lendingId'] as int,
      lending: jsonSerialization['lending'] == null
          ? null
          : _i2.PupilBookLending.fromJson(
              (jsonSerialization['lending'] as Map<String, dynamic>)),
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

  int lendingId;

  _i2.PupilBookLending? lending;

  /// Returns a shallow copy of this [PupilBookLendingFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilBookLendingFile copyWith({
    int? id,
    String? fileId,
    String? fileUrl,
    String? fileExtension,
    DateTime? uploadedAt,
    String? uploadedBy,
    int? lendingId,
    _i2.PupilBookLending? lending,
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
      'lendingId': lendingId,
      if (lending != null) 'lending': lending?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilBookLendingFileImpl extends PupilBookLendingFile {
  _PupilBookLendingFileImpl({
    int? id,
    required String fileId,
    required String fileUrl,
    required String fileExtension,
    required DateTime uploadedAt,
    required String uploadedBy,
    required int lendingId,
    _i2.PupilBookLending? lending,
  }) : super._(
          id: id,
          fileId: fileId,
          fileUrl: fileUrl,
          fileExtension: fileExtension,
          uploadedAt: uploadedAt,
          uploadedBy: uploadedBy,
          lendingId: lendingId,
          lending: lending,
        );

  /// Returns a shallow copy of this [PupilBookLendingFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilBookLendingFile copyWith({
    Object? id = _Undefined,
    String? fileId,
    String? fileUrl,
    String? fileExtension,
    DateTime? uploadedAt,
    String? uploadedBy,
    int? lendingId,
    Object? lending = _Undefined,
  }) {
    return PupilBookLendingFile(
      id: id is int? ? id : this.id,
      fileId: fileId ?? this.fileId,
      fileUrl: fileUrl ?? this.fileUrl,
      fileExtension: fileExtension ?? this.fileExtension,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      lendingId: lendingId ?? this.lendingId,
      lending:
          lending is _i2.PupilBookLending? ? lending : this.lending?.copyWith(),
    );
  }
}
