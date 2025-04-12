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
import '../../../pupil_data/pupil_objects/preschool/pre_school_medical_status.dart'
    as _i2;
import '../../../shared/document.dart' as _i3;

abstract class PreSchoolMedical implements _i1.SerializableModel {
  PreSchoolMedical._({
    this.preschoolMedicalStatus,
    this.preschoolMedicalFiles,
  });

  factory PreSchoolMedical({
    _i2.PreSchoolMedicalStatus? preschoolMedicalStatus,
    List<_i3.HubDocument>? preschoolMedicalFiles,
  }) = _PreSchoolMedicalImpl;

  factory PreSchoolMedical.fromJson(Map<String, dynamic> jsonSerialization) {
    return PreSchoolMedical(
      preschoolMedicalStatus:
          jsonSerialization['preschoolMedicalStatus'] == null
              ? null
              : _i2.PreSchoolMedicalStatus.fromJson(
                  (jsonSerialization['preschoolMedicalStatus'] as String)),
      preschoolMedicalFiles: (jsonSerialization['preschoolMedicalFiles']
              as List?)
          ?.map((e) => _i3.HubDocument.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.PreSchoolMedicalStatus? preschoolMedicalStatus;

  List<_i3.HubDocument>? preschoolMedicalFiles;

  /// Returns a shallow copy of this [PreSchoolMedical]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PreSchoolMedical copyWith({
    _i2.PreSchoolMedicalStatus? preschoolMedicalStatus,
    List<_i3.HubDocument>? preschoolMedicalFiles,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (preschoolMedicalStatus != null)
        'preschoolMedicalStatus': preschoolMedicalStatus?.toJson(),
      if (preschoolMedicalFiles != null)
        'preschoolMedicalFiles':
            preschoolMedicalFiles?.toJson(valueToJson: (v) => v.toJson()),
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
    _i2.PreSchoolMedicalStatus? preschoolMedicalStatus,
    List<_i3.HubDocument>? preschoolMedicalFiles,
  }) : super._(
          preschoolMedicalStatus: preschoolMedicalStatus,
          preschoolMedicalFiles: preschoolMedicalFiles,
        );

  /// Returns a shallow copy of this [PreSchoolMedical]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PreSchoolMedical copyWith({
    Object? preschoolMedicalStatus = _Undefined,
    Object? preschoolMedicalFiles = _Undefined,
  }) {
    return PreSchoolMedical(
      preschoolMedicalStatus:
          preschoolMedicalStatus is _i2.PreSchoolMedicalStatus?
              ? preschoolMedicalStatus
              : this.preschoolMedicalStatus,
      preschoolMedicalFiles: preschoolMedicalFiles is List<_i3.HubDocument>?
          ? preschoolMedicalFiles
          : this.preschoolMedicalFiles?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
