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
import '../../../pupil_data/pupil_objects/after_school_care/pick_up_info.dart'
    as _i2;

abstract class AfterSchoolCarePickUpTimes implements _i1.SerializableModel {
  AfterSchoolCarePickUpTimes._({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
  });

  factory AfterSchoolCarePickUpTimes({
    _i2.PickUpInfo? monday,
    _i2.PickUpInfo? tuesday,
    _i2.PickUpInfo? wednesday,
    _i2.PickUpInfo? thursday,
    _i2.PickUpInfo? friday,
  }) = _AfterSchoolCarePickUpTimesImpl;

  factory AfterSchoolCarePickUpTimes.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return AfterSchoolCarePickUpTimes(
      monday: jsonSerialization['monday'] == null
          ? null
          : _i2.PickUpInfo.fromJson(
              (jsonSerialization['monday'] as Map<String, dynamic>)),
      tuesday: jsonSerialization['tuesday'] == null
          ? null
          : _i2.PickUpInfo.fromJson(
              (jsonSerialization['tuesday'] as Map<String, dynamic>)),
      wednesday: jsonSerialization['wednesday'] == null
          ? null
          : _i2.PickUpInfo.fromJson(
              (jsonSerialization['wednesday'] as Map<String, dynamic>)),
      thursday: jsonSerialization['thursday'] == null
          ? null
          : _i2.PickUpInfo.fromJson(
              (jsonSerialization['thursday'] as Map<String, dynamic>)),
      friday: jsonSerialization['friday'] == null
          ? null
          : _i2.PickUpInfo.fromJson(
              (jsonSerialization['friday'] as Map<String, dynamic>)),
    );
  }

  _i2.PickUpInfo? monday;

  _i2.PickUpInfo? tuesday;

  _i2.PickUpInfo? wednesday;

  _i2.PickUpInfo? thursday;

  _i2.PickUpInfo? friday;

  /// Returns a shallow copy of this [AfterSchoolCarePickUpTimes]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AfterSchoolCarePickUpTimes copyWith({
    _i2.PickUpInfo? monday,
    _i2.PickUpInfo? tuesday,
    _i2.PickUpInfo? wednesday,
    _i2.PickUpInfo? thursday,
    _i2.PickUpInfo? friday,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (monday != null) 'monday': monday?.toJson(),
      if (tuesday != null) 'tuesday': tuesday?.toJson(),
      if (wednesday != null) 'wednesday': wednesday?.toJson(),
      if (thursday != null) 'thursday': thursday?.toJson(),
      if (friday != null) 'friday': friday?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AfterSchoolCarePickUpTimesImpl extends AfterSchoolCarePickUpTimes {
  _AfterSchoolCarePickUpTimesImpl({
    _i2.PickUpInfo? monday,
    _i2.PickUpInfo? tuesday,
    _i2.PickUpInfo? wednesday,
    _i2.PickUpInfo? thursday,
    _i2.PickUpInfo? friday,
  }) : super._(
          monday: monday,
          tuesday: tuesday,
          wednesday: wednesday,
          thursday: thursday,
          friday: friday,
        );

  /// Returns a shallow copy of this [AfterSchoolCarePickUpTimes]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AfterSchoolCarePickUpTimes copyWith({
    Object? monday = _Undefined,
    Object? tuesday = _Undefined,
    Object? wednesday = _Undefined,
    Object? thursday = _Undefined,
    Object? friday = _Undefined,
  }) {
    return AfterSchoolCarePickUpTimes(
      monday: monday is _i2.PickUpInfo? ? monday : this.monday?.copyWith(),
      tuesday: tuesday is _i2.PickUpInfo? ? tuesday : this.tuesday?.copyWith(),
      wednesday:
          wednesday is _i2.PickUpInfo? ? wednesday : this.wednesday?.copyWith(),
      thursday:
          thursday is _i2.PickUpInfo? ? thursday : this.thursday?.copyWith(),
      friday: friday is _i2.PickUpInfo? ? friday : this.friday?.copyWith(),
    );
  }
}
