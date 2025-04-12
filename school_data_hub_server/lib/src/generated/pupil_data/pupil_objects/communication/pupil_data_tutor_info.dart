/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../pupil_data/pupil_objects/communication/communication_skills.dart'
    as _i2;

abstract class PupilDataTutorInfo
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PupilDataTutorInfo._({
    this.parentsContact,
    this.communicationTutor1,
    this.communicationTutor2,
    required this.createdBy,
  });

  factory PupilDataTutorInfo({
    String? parentsContact,
    _i2.CommunicationSkills? communicationTutor1,
    _i2.CommunicationSkills? communicationTutor2,
    required String createdBy,
  }) = _PupilDataTutorInfoImpl;

  factory PupilDataTutorInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilDataTutorInfo(
      parentsContact: jsonSerialization['parentsContact'] as String?,
      communicationTutor1: jsonSerialization['communicationTutor1'] == null
          ? null
          : _i2.CommunicationSkills.fromJson(
              (jsonSerialization['communicationTutor1']
                  as Map<String, dynamic>)),
      communicationTutor2: jsonSerialization['communicationTutor2'] == null
          ? null
          : _i2.CommunicationSkills.fromJson(
              (jsonSerialization['communicationTutor2']
                  as Map<String, dynamic>)),
      createdBy: jsonSerialization['createdBy'] as String,
    );
  }

  String? parentsContact;

  _i2.CommunicationSkills? communicationTutor1;

  _i2.CommunicationSkills? communicationTutor2;

  String createdBy;

  /// Returns a shallow copy of this [PupilDataTutorInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilDataTutorInfo copyWith({
    String? parentsContact,
    _i2.CommunicationSkills? communicationTutor1,
    _i2.CommunicationSkills? communicationTutor2,
    String? createdBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (parentsContact != null) 'parentsContact': parentsContact,
      if (communicationTutor1 != null)
        'communicationTutor1': communicationTutor1?.toJson(),
      if (communicationTutor2 != null)
        'communicationTutor2': communicationTutor2?.toJson(),
      'createdBy': createdBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (parentsContact != null) 'parentsContact': parentsContact,
      if (communicationTutor1 != null)
        'communicationTutor1': communicationTutor1?.toJsonForProtocol(),
      if (communicationTutor2 != null)
        'communicationTutor2': communicationTutor2?.toJsonForProtocol(),
      'createdBy': createdBy,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilDataTutorInfoImpl extends PupilDataTutorInfo {
  _PupilDataTutorInfoImpl({
    String? parentsContact,
    _i2.CommunicationSkills? communicationTutor1,
    _i2.CommunicationSkills? communicationTutor2,
    required String createdBy,
  }) : super._(
          parentsContact: parentsContact,
          communicationTutor1: communicationTutor1,
          communicationTutor2: communicationTutor2,
          createdBy: createdBy,
        );

  /// Returns a shallow copy of this [PupilDataTutorInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilDataTutorInfo copyWith({
    Object? parentsContact = _Undefined,
    Object? communicationTutor1 = _Undefined,
    Object? communicationTutor2 = _Undefined,
    String? createdBy,
  }) {
    return PupilDataTutorInfo(
      parentsContact:
          parentsContact is String? ? parentsContact : this.parentsContact,
      communicationTutor1: communicationTutor1 is _i2.CommunicationSkills?
          ? communicationTutor1
          : this.communicationTutor1?.copyWith(),
      communicationTutor2: communicationTutor2 is _i2.CommunicationSkills?
          ? communicationTutor2
          : this.communicationTutor2?.copyWith(),
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
