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
import '../../../../../_features/pupil/models/pupil_data/after_school_care/after_school_pickup_times.dart'
    as _i2;

abstract class AfterSchoolCare
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AfterSchoolCare._({
    this.pickUpTimes,
    this.afterSchoolCareInfo,
    this.emergencyCare,
  });

  factory AfterSchoolCare({
    _i2.AfterSchoolCarePickUpTimes? pickUpTimes,
    String? afterSchoolCareInfo,
    bool? emergencyCare,
  }) = _AfterSchoolCareImpl;

  factory AfterSchoolCare.fromJson(Map<String, dynamic> jsonSerialization) {
    return AfterSchoolCare(
      pickUpTimes: jsonSerialization['pickUpTimes'] == null
          ? null
          : _i2.AfterSchoolCarePickUpTimes.fromJson(
              (jsonSerialization['pickUpTimes'] as Map<String, dynamic>)),
      afterSchoolCareInfo: jsonSerialization['afterSchoolCareInfo'] as String?,
      emergencyCare: jsonSerialization['emergencyCare'] as bool?,
    );
  }

  _i2.AfterSchoolCarePickUpTimes? pickUpTimes;

  String? afterSchoolCareInfo;

  bool? emergencyCare;

  /// Returns a shallow copy of this [AfterSchoolCare]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AfterSchoolCare copyWith({
    _i2.AfterSchoolCarePickUpTimes? pickUpTimes,
    String? afterSchoolCareInfo,
    bool? emergencyCare,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (pickUpTimes != null) 'pickUpTimes': pickUpTimes?.toJson(),
      if (afterSchoolCareInfo != null)
        'afterSchoolCareInfo': afterSchoolCareInfo,
      if (emergencyCare != null) 'emergencyCare': emergencyCare,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (pickUpTimes != null) 'pickUpTimes': pickUpTimes?.toJsonForProtocol(),
      if (afterSchoolCareInfo != null)
        'afterSchoolCareInfo': afterSchoolCareInfo,
      if (emergencyCare != null) 'emergencyCare': emergencyCare,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AfterSchoolCareImpl extends AfterSchoolCare {
  _AfterSchoolCareImpl({
    _i2.AfterSchoolCarePickUpTimes? pickUpTimes,
    String? afterSchoolCareInfo,
    bool? emergencyCare,
  }) : super._(
          pickUpTimes: pickUpTimes,
          afterSchoolCareInfo: afterSchoolCareInfo,
          emergencyCare: emergencyCare,
        );

  /// Returns a shallow copy of this [AfterSchoolCare]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AfterSchoolCare copyWith({
    Object? pickUpTimes = _Undefined,
    Object? afterSchoolCareInfo = _Undefined,
    Object? emergencyCare = _Undefined,
  }) {
    return AfterSchoolCare(
      pickUpTimes: pickUpTimes is _i2.AfterSchoolCarePickUpTimes?
          ? pickUpTimes
          : this.pickUpTimes?.copyWith(),
      afterSchoolCareInfo: afterSchoolCareInfo is String?
          ? afterSchoolCareInfo
          : this.afterSchoolCareInfo,
      emergencyCare:
          emergencyCare is bool? ? emergencyCare : this.emergencyCare,
    );
  }
}
