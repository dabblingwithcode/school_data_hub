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
import '../../../../../_features/pupil/models/pupil_data/communication/tutor_info.dart'
    as _i2;

abstract class SiblingsTutorInfo
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SiblingsTutorInfo._({
    this.tutorInfo,
    required this.siblingsIds,
  });

  factory SiblingsTutorInfo({
    _i2.TutorInfo? tutorInfo,
    required Set<int> siblingsIds,
  }) = _SiblingsTutorInfoImpl;

  factory SiblingsTutorInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return SiblingsTutorInfo(
      tutorInfo: jsonSerialization['tutorInfo'] == null
          ? null
          : _i2.TutorInfo.fromJson(
              (jsonSerialization['tutorInfo'] as Map<String, dynamic>)),
      siblingsIds: _i1.SetJsonExtension.fromJson(
          (jsonSerialization['siblingsIds'] as List),
          itemFromJson: (e) => e as int)!,
    );
  }

  _i2.TutorInfo? tutorInfo;

  Set<int> siblingsIds;

  /// Returns a shallow copy of this [SiblingsTutorInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SiblingsTutorInfo copyWith({
    _i2.TutorInfo? tutorInfo,
    Set<int>? siblingsIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (tutorInfo != null) 'tutorInfo': tutorInfo?.toJson(),
      'siblingsIds': siblingsIds.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (tutorInfo != null) 'tutorInfo': tutorInfo?.toJsonForProtocol(),
      'siblingsIds': siblingsIds.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SiblingsTutorInfoImpl extends SiblingsTutorInfo {
  _SiblingsTutorInfoImpl({
    _i2.TutorInfo? tutorInfo,
    required Set<int> siblingsIds,
  }) : super._(
          tutorInfo: tutorInfo,
          siblingsIds: siblingsIds,
        );

  /// Returns a shallow copy of this [SiblingsTutorInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SiblingsTutorInfo copyWith({
    Object? tutorInfo = _Undefined,
    Set<int>? siblingsIds,
  }) {
    return SiblingsTutorInfo(
      tutorInfo:
          tutorInfo is _i2.TutorInfo? ? tutorInfo : this.tutorInfo?.copyWith(),
      siblingsIds: siblingsIds ?? this.siblingsIds.map((e0) => e0).toSet(),
    );
  }
}
