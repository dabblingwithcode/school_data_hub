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

abstract class KindergardenInfo
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  KindergardenInfo._({this.attendance});

  factory KindergardenInfo({String? attendance}) = _KindergardenInfoImpl;

  factory KindergardenInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return KindergardenInfo(
        attendance: jsonSerialization['attendance'] as String?);
  }

  String? attendance;

  /// Returns a shallow copy of this [KindergardenInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  KindergardenInfo copyWith({String? attendance});
  @override
  Map<String, dynamic> toJson() {
    return {if (attendance != null) 'attendance': attendance};
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {if (attendance != null) 'attendance': attendance};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _KindergardenInfoImpl extends KindergardenInfo {
  _KindergardenInfoImpl({String? attendance}) : super._(attendance: attendance);

  /// Returns a shallow copy of this [KindergardenInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  KindergardenInfo copyWith({Object? attendance = _Undefined}) {
    return KindergardenInfo(
        attendance: attendance is String? ? attendance : this.attendance);
  }
}
