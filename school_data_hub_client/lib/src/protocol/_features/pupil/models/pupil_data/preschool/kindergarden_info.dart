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

abstract class KindergardenInfo implements _i1.SerializableModel {
  KindergardenInfo._({
    required this.attendedMonths,
    required this.comments,
  });

  factory KindergardenInfo({
    required int attendedMonths,
    required String comments,
  }) = _KindergardenInfoImpl;

  factory KindergardenInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return KindergardenInfo(
      attendedMonths: jsonSerialization['attendedMonths'] as int,
      comments: jsonSerialization['comments'] as String,
    );
  }

  int attendedMonths;

  String comments;

  /// Returns a shallow copy of this [KindergardenInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  KindergardenInfo copyWith({
    int? attendedMonths,
    String? comments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'attendedMonths': attendedMonths,
      'comments': comments,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _KindergardenInfoImpl extends KindergardenInfo {
  _KindergardenInfoImpl({
    required int attendedMonths,
    required String comments,
  }) : super._(
          attendedMonths: attendedMonths,
          comments: comments,
        );

  /// Returns a shallow copy of this [KindergardenInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  KindergardenInfo copyWith({
    int? attendedMonths,
    String? comments,
  }) {
    return KindergardenInfo(
      attendedMonths: attendedMonths ?? this.attendedMonths,
      comments: comments ?? this.comments,
    );
  }
}
