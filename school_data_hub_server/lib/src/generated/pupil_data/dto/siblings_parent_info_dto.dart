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

abstract class SiblingsParentInfo
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SiblingsParentInfo._({
    required this.parentsContact,
    required this.communicationTutor1,
    required this.communicationTutor2,
    required this.createdBy,
    required this.siblingsInternalIds,
  });

  factory SiblingsParentInfo({
    required String parentsContact,
    required String communicationTutor1,
    required String communicationTutor2,
    required String createdBy,
    required List<int> siblingsInternalIds,
  }) = _SiblingsParentInfoImpl;

  factory SiblingsParentInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return SiblingsParentInfo(
      parentsContact: jsonSerialization['parentsContact'] as String,
      communicationTutor1: jsonSerialization['communicationTutor1'] as String,
      communicationTutor2: jsonSerialization['communicationTutor2'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      siblingsInternalIds: (jsonSerialization['siblingsInternalIds'] as List)
          .map((e) => e as int)
          .toList(),
    );
  }

  String parentsContact;

  String communicationTutor1;

  String communicationTutor2;

  String createdBy;

  List<int> siblingsInternalIds;

  /// Returns a shallow copy of this [SiblingsParentInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SiblingsParentInfo copyWith({
    String? parentsContact,
    String? communicationTutor1,
    String? communicationTutor2,
    String? createdBy,
    List<int>? siblingsInternalIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'parentsContact': parentsContact,
      'communicationTutor1': communicationTutor1,
      'communicationTutor2': communicationTutor2,
      'createdBy': createdBy,
      'siblingsInternalIds': siblingsInternalIds.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'parentsContact': parentsContact,
      'communicationTutor1': communicationTutor1,
      'communicationTutor2': communicationTutor2,
      'createdBy': createdBy,
      'siblingsInternalIds': siblingsInternalIds.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SiblingsParentInfoImpl extends SiblingsParentInfo {
  _SiblingsParentInfoImpl({
    required String parentsContact,
    required String communicationTutor1,
    required String communicationTutor2,
    required String createdBy,
    required List<int> siblingsInternalIds,
  }) : super._(
          parentsContact: parentsContact,
          communicationTutor1: communicationTutor1,
          communicationTutor2: communicationTutor2,
          createdBy: createdBy,
          siblingsInternalIds: siblingsInternalIds,
        );

  /// Returns a shallow copy of this [SiblingsParentInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SiblingsParentInfo copyWith({
    String? parentsContact,
    String? communicationTutor1,
    String? communicationTutor2,
    String? createdBy,
    List<int>? siblingsInternalIds,
  }) {
    return SiblingsParentInfo(
      parentsContact: parentsContact ?? this.parentsContact,
      communicationTutor1: communicationTutor1 ?? this.communicationTutor1,
      communicationTutor2: communicationTutor2 ?? this.communicationTutor2,
      createdBy: createdBy ?? this.createdBy,
      siblingsInternalIds: siblingsInternalIds ??
          this.siblingsInternalIds.map((e0) => e0).toList(),
    );
  }
}
