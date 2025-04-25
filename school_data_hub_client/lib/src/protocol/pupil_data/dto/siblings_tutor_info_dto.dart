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
import '../../pupil_data/pupil_objects/communication/tutor_info.dart' as _i2;

abstract class SiblingsTutorInfo implements _i1.SerializableModel {
  SiblingsTutorInfo._({
    required this.tutorInfo,
    required this.siblingsInternalIds,
  });

  factory SiblingsTutorInfo({
    required _i2.TutorInfo tutorInfo,
    required Set<int> siblingsInternalIds,
  }) = _SiblingsTutorInfoImpl;

  factory SiblingsTutorInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return SiblingsTutorInfo(
      tutorInfo: _i2.TutorInfo.fromJson(
          (jsonSerialization['tutorInfo'] as Map<String, dynamic>)),
      siblingsInternalIds: _i1.SetJsonExtension.fromJson(
          (jsonSerialization['siblingsInternalIds'] as List),
          itemFromJson: (e) => e as int)!,
    );
  }

  _i2.TutorInfo tutorInfo;

  Set<int> siblingsInternalIds;

  /// Returns a shallow copy of this [SiblingsTutorInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SiblingsTutorInfo copyWith({
    _i2.TutorInfo? tutorInfo,
    Set<int>? siblingsInternalIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'tutorInfo': tutorInfo.toJson(),
      'siblingsInternalIds': siblingsInternalIds.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SiblingsTutorInfoImpl extends SiblingsTutorInfo {
  _SiblingsTutorInfoImpl({
    required _i2.TutorInfo tutorInfo,
    required Set<int> siblingsInternalIds,
  }) : super._(
          tutorInfo: tutorInfo,
          siblingsInternalIds: siblingsInternalIds,
        );

  /// Returns a shallow copy of this [SiblingsTutorInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SiblingsTutorInfo copyWith({
    _i2.TutorInfo? tutorInfo,
    Set<int>? siblingsInternalIds,
  }) {
    return SiblingsTutorInfo(
      tutorInfo: tutorInfo ?? this.tutorInfo.copyWith(),
      siblingsInternalIds: siblingsInternalIds ??
          this.siblingsInternalIds.map((e0) => e0).toSet(),
    );
  }
}
