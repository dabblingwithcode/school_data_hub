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
import '../../../../_features/pupil/models/pupil_data/communication/communication_skills.dart'
    as _i2;
import '../../../../_features/pupil/models/pupil_data/communication/tutor_info.dart'
    as _i3;

abstract class PupilCommunicationData implements _i1.SerializableModel {
  PupilCommunicationData._({
    this.id,
    this.contact,
    this.communicationPupil,
    this.specialInformation,
    this.tutorInfo,
  });

  factory PupilCommunicationData({
    int? id,
    String? contact,
    _i2.CommunicationSkills? communicationPupil,
    String? specialInformation,
    _i3.TutorInfo? tutorInfo,
  }) = _PupilCommunicationDataImpl;

  factory PupilCommunicationData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return PupilCommunicationData(
      id: jsonSerialization['id'] as int?,
      contact: jsonSerialization['contact'] as String?,
      communicationPupil: jsonSerialization['communicationPupil'] == null
          ? null
          : _i2.CommunicationSkills.fromJson(
              (jsonSerialization['communicationPupil']
                  as Map<String, dynamic>)),
      specialInformation: jsonSerialization['specialInformation'] as String?,
      tutorInfo: jsonSerialization['tutorInfo'] == null
          ? null
          : _i3.TutorInfo.fromJson(
              (jsonSerialization['tutorInfo'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? contact;

  _i2.CommunicationSkills? communicationPupil;

  String? specialInformation;

  _i3.TutorInfo? tutorInfo;

  /// Returns a shallow copy of this [PupilCommunicationData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilCommunicationData copyWith({
    int? id,
    String? contact,
    _i2.CommunicationSkills? communicationPupil,
    String? specialInformation,
    _i3.TutorInfo? tutorInfo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (contact != null) 'contact': contact,
      if (communicationPupil != null)
        'communicationPupil': communicationPupil?.toJson(),
      if (specialInformation != null) 'specialInformation': specialInformation,
      if (tutorInfo != null) 'tutorInfo': tutorInfo?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilCommunicationDataImpl extends PupilCommunicationData {
  _PupilCommunicationDataImpl({
    int? id,
    String? contact,
    _i2.CommunicationSkills? communicationPupil,
    String? specialInformation,
    _i3.TutorInfo? tutorInfo,
  }) : super._(
          id: id,
          contact: contact,
          communicationPupil: communicationPupil,
          specialInformation: specialInformation,
          tutorInfo: tutorInfo,
        );

  /// Returns a shallow copy of this [PupilCommunicationData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilCommunicationData copyWith({
    Object? id = _Undefined,
    Object? contact = _Undefined,
    Object? communicationPupil = _Undefined,
    Object? specialInformation = _Undefined,
    Object? tutorInfo = _Undefined,
  }) {
    return PupilCommunicationData(
      id: id is int? ? id : this.id,
      contact: contact is String? ? contact : this.contact,
      communicationPupil: communicationPupil is _i2.CommunicationSkills?
          ? communicationPupil
          : this.communicationPupil?.copyWith(),
      specialInformation: specialInformation is String?
          ? specialInformation
          : this.specialInformation,
      tutorInfo:
          tutorInfo is _i3.TutorInfo? ? tutorInfo : this.tutorInfo?.copyWith(),
    );
  }
}
