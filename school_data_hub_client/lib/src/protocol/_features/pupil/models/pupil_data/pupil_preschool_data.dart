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
import '../../../../_features/pupil/models/pupil_data/preschool/kindergarden_info.dart'
    as _i2;
import '../../../../_features/pupil/models/pupil_data/preschool/pre_school_medical.dart'
    as _i3;
import '../../../../_features/pupil/models/pupil_data/preschool/kindergarden.dart'
    as _i4;
import '../../../../_features/pupil/models/pupil_data/preschool/pre_school_test.dart'
    as _i5;

abstract class PupilPreschoolData implements _i1.SerializableModel {
  PupilPreschoolData._({
    this.id,
    this.kindergardenData,
    this.preSchoolMedicalId,
    this.preSchoolMedical,
    this.kindergardenId,
    this.kindergarden,
    this.preSchoolTestId,
    this.preSchoolTest,
  });

  factory PupilPreschoolData({
    int? id,
    _i2.KindergardenInfo? kindergardenData,
    int? preSchoolMedicalId,
    _i3.PreSchoolMedical? preSchoolMedical,
    int? kindergardenId,
    _i4.Kindergarden? kindergarden,
    int? preSchoolTestId,
    _i5.PreSchoolTest? preSchoolTest,
  }) = _PupilPreschoolDataImpl;

  factory PupilPreschoolData.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilPreschoolData(
      id: jsonSerialization['id'] as int?,
      kindergardenData: jsonSerialization['kindergardenData'] == null
          ? null
          : _i2.KindergardenInfo.fromJson(
              (jsonSerialization['kindergardenData'] as Map<String, dynamic>)),
      preSchoolMedicalId: jsonSerialization['preSchoolMedicalId'] as int?,
      preSchoolMedical: jsonSerialization['preSchoolMedical'] == null
          ? null
          : _i3.PreSchoolMedical.fromJson(
              (jsonSerialization['preSchoolMedical'] as Map<String, dynamic>)),
      kindergardenId: jsonSerialization['kindergardenId'] as int?,
      kindergarden: jsonSerialization['kindergarden'] == null
          ? null
          : _i4.Kindergarden.fromJson(
              (jsonSerialization['kindergarden'] as Map<String, dynamic>)),
      preSchoolTestId: jsonSerialization['preSchoolTestId'] as int?,
      preSchoolTest: jsonSerialization['preSchoolTest'] == null
          ? null
          : _i5.PreSchoolTest.fromJson(
              (jsonSerialization['preSchoolTest'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.KindergardenInfo? kindergardenData;

  int? preSchoolMedicalId;

  _i3.PreSchoolMedical? preSchoolMedical;

  int? kindergardenId;

  _i4.Kindergarden? kindergarden;

  int? preSchoolTestId;

  _i5.PreSchoolTest? preSchoolTest;

  /// Returns a shallow copy of this [PupilPreschoolData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilPreschoolData copyWith({
    int? id,
    _i2.KindergardenInfo? kindergardenData,
    int? preSchoolMedicalId,
    _i3.PreSchoolMedical? preSchoolMedical,
    int? kindergardenId,
    _i4.Kindergarden? kindergarden,
    int? preSchoolTestId,
    _i5.PreSchoolTest? preSchoolTest,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (kindergardenData != null)
        'kindergardenData': kindergardenData?.toJson(),
      if (preSchoolMedicalId != null) 'preSchoolMedicalId': preSchoolMedicalId,
      if (preSchoolMedical != null)
        'preSchoolMedical': preSchoolMedical?.toJson(),
      if (kindergardenId != null) 'kindergardenId': kindergardenId,
      if (kindergarden != null) 'kindergarden': kindergarden?.toJson(),
      if (preSchoolTestId != null) 'preSchoolTestId': preSchoolTestId,
      if (preSchoolTest != null) 'preSchoolTest': preSchoolTest?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilPreschoolDataImpl extends PupilPreschoolData {
  _PupilPreschoolDataImpl({
    int? id,
    _i2.KindergardenInfo? kindergardenData,
    int? preSchoolMedicalId,
    _i3.PreSchoolMedical? preSchoolMedical,
    int? kindergardenId,
    _i4.Kindergarden? kindergarden,
    int? preSchoolTestId,
    _i5.PreSchoolTest? preSchoolTest,
  }) : super._(
          id: id,
          kindergardenData: kindergardenData,
          preSchoolMedicalId: preSchoolMedicalId,
          preSchoolMedical: preSchoolMedical,
          kindergardenId: kindergardenId,
          kindergarden: kindergarden,
          preSchoolTestId: preSchoolTestId,
          preSchoolTest: preSchoolTest,
        );

  /// Returns a shallow copy of this [PupilPreschoolData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilPreschoolData copyWith({
    Object? id = _Undefined,
    Object? kindergardenData = _Undefined,
    Object? preSchoolMedicalId = _Undefined,
    Object? preSchoolMedical = _Undefined,
    Object? kindergardenId = _Undefined,
    Object? kindergarden = _Undefined,
    Object? preSchoolTestId = _Undefined,
    Object? preSchoolTest = _Undefined,
  }) {
    return PupilPreschoolData(
      id: id is int? ? id : this.id,
      kindergardenData: kindergardenData is _i2.KindergardenInfo?
          ? kindergardenData
          : this.kindergardenData?.copyWith(),
      preSchoolMedicalId: preSchoolMedicalId is int?
          ? preSchoolMedicalId
          : this.preSchoolMedicalId,
      preSchoolMedical: preSchoolMedical is _i3.PreSchoolMedical?
          ? preSchoolMedical
          : this.preSchoolMedical?.copyWith(),
      kindergardenId:
          kindergardenId is int? ? kindergardenId : this.kindergardenId,
      kindergarden: kindergarden is _i4.Kindergarden?
          ? kindergarden
          : this.kindergarden?.copyWith(),
      preSchoolTestId:
          preSchoolTestId is int? ? preSchoolTestId : this.preSchoolTestId,
      preSchoolTest: preSchoolTest is _i5.PreSchoolTest?
          ? preSchoolTest
          : this.preSchoolTest?.copyWith(),
    );
  }
}
