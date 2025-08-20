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
import '../../../../../_features/pupil/models/pupil_data/preschool/pre_school_medical_status.dart'
    as _i2;
import '../../../../../_shared/models/hub_document.dart' as _i3;

abstract class PreSchoolMedical implements _i1.SerializableModel {
  PreSchoolMedical._({
    this.id,
    this.preschoolMedicalStatus,
    this.preschoolMedicalFiles,
    required this.createdBy,
    required this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory PreSchoolMedical({
    int? id,
    _i2.PreSchoolMedicalStatus? preschoolMedicalStatus,
    List<_i3.HubDocument>? preschoolMedicalFiles,
    required String createdBy,
    required DateTime createdAt,
    String? updatedBy,
    DateTime? updatedAt,
  }) = _PreSchoolMedicalImpl;

  factory PreSchoolMedical.fromJson(Map<String, dynamic> jsonSerialization) {
    return PreSchoolMedical(
      id: jsonSerialization['id'] as int?,
      preschoolMedicalStatus:
          jsonSerialization['preschoolMedicalStatus'] == null
              ? null
              : _i2.PreSchoolMedicalStatus.fromJson(
                  (jsonSerialization['preschoolMedicalStatus'] as String)),
      preschoolMedicalFiles: (jsonSerialization['preschoolMedicalFiles']
              as List?)
          ?.map((e) => _i3.HubDocument.fromJson((e as Map<String, dynamic>)))
          .toList(),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedBy: jsonSerialization['updatedBy'] as String?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.PreSchoolMedicalStatus? preschoolMedicalStatus;

  List<_i3.HubDocument>? preschoolMedicalFiles;

  String createdBy;

  DateTime createdAt;

  String? updatedBy;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [PreSchoolMedical]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PreSchoolMedical copyWith({
    int? id,
    _i2.PreSchoolMedicalStatus? preschoolMedicalStatus,
    List<_i3.HubDocument>? preschoolMedicalFiles,
    String? createdBy,
    DateTime? createdAt,
    String? updatedBy,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (preschoolMedicalStatus != null)
        'preschoolMedicalStatus': preschoolMedicalStatus?.toJson(),
      if (preschoolMedicalFiles != null)
        'preschoolMedicalFiles':
            preschoolMedicalFiles?.toJson(valueToJson: (v) => v.toJson()),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (updatedBy != null) 'updatedBy': updatedBy,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PreSchoolMedicalImpl extends PreSchoolMedical {
  _PreSchoolMedicalImpl({
    int? id,
    _i2.PreSchoolMedicalStatus? preschoolMedicalStatus,
    List<_i3.HubDocument>? preschoolMedicalFiles,
    required String createdBy,
    required DateTime createdAt,
    String? updatedBy,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          preschoolMedicalStatus: preschoolMedicalStatus,
          preschoolMedicalFiles: preschoolMedicalFiles,
          createdBy: createdBy,
          createdAt: createdAt,
          updatedBy: updatedBy,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [PreSchoolMedical]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PreSchoolMedical copyWith({
    Object? id = _Undefined,
    Object? preschoolMedicalStatus = _Undefined,
    Object? preschoolMedicalFiles = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    Object? updatedBy = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return PreSchoolMedical(
      id: id is int? ? id : this.id,
      preschoolMedicalStatus:
          preschoolMedicalStatus is _i2.PreSchoolMedicalStatus?
              ? preschoolMedicalStatus
              : this.preschoolMedicalStatus,
      preschoolMedicalFiles: preschoolMedicalFiles is List<_i3.HubDocument>?
          ? preschoolMedicalFiles
          : this.preschoolMedicalFiles?.map((e0) => e0.copyWith()).toList(),
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedBy: updatedBy is String? ? updatedBy : this.updatedBy,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
