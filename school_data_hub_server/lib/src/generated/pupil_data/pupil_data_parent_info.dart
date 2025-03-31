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

abstract class PupilDataParentInfo
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PupilDataParentInfo._({
    required this.parentsContact,
    required this.communicationTutor1,
    required this.communicationTutor2,
    required this.createdBy,
  });

  factory PupilDataParentInfo({
    required String parentsContact,
    required String communicationTutor1,
    required String communicationTutor2,
    required String createdBy,
  }) = _PupilDataParentInfoImpl;

  factory PupilDataParentInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilDataParentInfo(
      parentsContact: jsonSerialization['parentsContact'] as String,
      communicationTutor1: jsonSerialization['communicationTutor1'] as String,
      communicationTutor2: jsonSerialization['communicationTutor2'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
    );
  }

  String parentsContact;

  String communicationTutor1;

  String communicationTutor2;

  String createdBy;

  /// Returns a shallow copy of this [PupilDataParentInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilDataParentInfo copyWith({
    String? parentsContact,
    String? communicationTutor1,
    String? communicationTutor2,
    String? createdBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'parentsContact': parentsContact,
      'communicationTutor1': communicationTutor1,
      'communicationTutor2': communicationTutor2,
      'createdBy': createdBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'parentsContact': parentsContact,
      'communicationTutor1': communicationTutor1,
      'communicationTutor2': communicationTutor2,
      'createdBy': createdBy,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PupilDataParentInfoImpl extends PupilDataParentInfo {
  _PupilDataParentInfoImpl({
    required String parentsContact,
    required String communicationTutor1,
    required String communicationTutor2,
    required String createdBy,
  }) : super._(
          parentsContact: parentsContact,
          communicationTutor1: communicationTutor1,
          communicationTutor2: communicationTutor2,
          createdBy: createdBy,
        );

  /// Returns a shallow copy of this [PupilDataParentInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilDataParentInfo copyWith({
    String? parentsContact,
    String? communicationTutor1,
    String? communicationTutor2,
    String? createdBy,
  }) {
    return PupilDataParentInfo(
      parentsContact: parentsContact ?? this.parentsContact,
      communicationTutor1: communicationTutor1 ?? this.communicationTutor1,
      communicationTutor2: communicationTutor2 ?? this.communicationTutor2,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
