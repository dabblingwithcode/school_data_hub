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

abstract class CommunicationSkills
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CommunicationSkills._({
    required this.understanding,
    required this.speaking,
    required this.reading,
    required this.createdBy,
  });

  factory CommunicationSkills({
    required int understanding,
    required int speaking,
    required int reading,
    required String createdBy,
  }) = _CommunicationSkillsImpl;

  factory CommunicationSkills.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommunicationSkills(
      understanding: jsonSerialization['understanding'] as int,
      speaking: jsonSerialization['speaking'] as int,
      reading: jsonSerialization['reading'] as int,
      createdBy: jsonSerialization['createdBy'] as String,
    );
  }

  int understanding;

  int speaking;

  int reading;

  String createdBy;

  /// Returns a shallow copy of this [CommunicationSkills]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommunicationSkills copyWith({
    int? understanding,
    int? speaking,
    int? reading,
    String? createdBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'understanding': understanding,
      'speaking': speaking,
      'reading': reading,
      'createdBy': createdBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'understanding': understanding,
      'speaking': speaking,
      'reading': reading,
      'createdBy': createdBy,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CommunicationSkillsImpl extends CommunicationSkills {
  _CommunicationSkillsImpl({
    required int understanding,
    required int speaking,
    required int reading,
    required String createdBy,
  }) : super._(
          understanding: understanding,
          speaking: speaking,
          reading: reading,
          createdBy: createdBy,
        );

  /// Returns a shallow copy of this [CommunicationSkills]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommunicationSkills copyWith({
    int? understanding,
    int? speaking,
    int? reading,
    String? createdBy,
  }) {
    return CommunicationSkills(
      understanding: understanding ?? this.understanding,
      speaking: speaking ?? this.speaking,
      reading: reading ?? this.reading,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
