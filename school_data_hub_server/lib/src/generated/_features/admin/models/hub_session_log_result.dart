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
import '../../../_features/admin/models/hub_session_log_info.dart' as _i2;

abstract class HubSessionLogResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  HubSessionLogResult._({required this.sessionLog});

  factory HubSessionLogResult(
          {required List<_i2.HubSessionLogInfo> sessionLog}) =
      _HubSessionLogResultImpl;

  factory HubSessionLogResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return HubSessionLogResult(
        sessionLog: (jsonSerialization['sessionLog'] as List)
            .map((e) =>
                _i2.HubSessionLogInfo.fromJson((e as Map<String, dynamic>)))
            .toList());
  }

  List<_i2.HubSessionLogInfo> sessionLog;

  /// Returns a shallow copy of this [HubSessionLogResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HubSessionLogResult copyWith({List<_i2.HubSessionLogInfo>? sessionLog});
  @override
  Map<String, dynamic> toJson() {
    return {'sessionLog': sessionLog.toJson(valueToJson: (v) => v.toJson())};
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'sessionLog': sessionLog.toJson(valueToJson: (v) => v.toJsonForProtocol())
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _HubSessionLogResultImpl extends HubSessionLogResult {
  _HubSessionLogResultImpl({required List<_i2.HubSessionLogInfo> sessionLog})
      : super._(sessionLog: sessionLog);

  /// Returns a shallow copy of this [HubSessionLogResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HubSessionLogResult copyWith({List<_i2.HubSessionLogInfo>? sessionLog}) {
    return HubSessionLogResult(
        sessionLog:
            sessionLog ?? this.sessionLog.map((e0) => e0.copyWith()).toList());
  }
}
