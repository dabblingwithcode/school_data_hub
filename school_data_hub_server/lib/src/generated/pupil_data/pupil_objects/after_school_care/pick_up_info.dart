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

abstract class PickUpInfo
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PickUpInfo._({
    required this.time,
    required this.modality,
  });

  factory PickUpInfo({
    required String time,
    required String modality,
  }) = _PickUpInfoImpl;

  factory PickUpInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return PickUpInfo(
      time: jsonSerialization['time'] as String,
      modality: jsonSerialization['modality'] as String,
    );
  }

  String time;

  String modality;

  /// Returns a shallow copy of this [PickUpInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PickUpInfo copyWith({
    String? time,
    String? modality,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'modality': modality,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'time': time,
      'modality': modality,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PickUpInfoImpl extends PickUpInfo {
  _PickUpInfoImpl({
    required String time,
    required String modality,
  }) : super._(
          time: time,
          modality: modality,
        );

  /// Returns a shallow copy of this [PickUpInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PickUpInfo copyWith({
    String? time,
    String? modality,
  }) {
    return PickUpInfo(
      time: time ?? this.time,
      modality: modality ?? this.modality,
    );
  }
}
