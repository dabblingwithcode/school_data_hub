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

abstract class HubSessionLogFilter
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  HubSessionLogFilter._({
    this.endpoint,
    this.method,
    required this.slow,
    required this.error,
    required this.open,
    this.lastSessionLogId,
  });

  factory HubSessionLogFilter({
    String? endpoint,
    String? method,
    required bool slow,
    required bool error,
    required bool open,
    int? lastSessionLogId,
  }) = _HubSessionLogFilterImpl;

  factory HubSessionLogFilter.fromJson(Map<String, dynamic> jsonSerialization) {
    return HubSessionLogFilter(
      endpoint: jsonSerialization['endpoint'] as String?,
      method: jsonSerialization['method'] as String?,
      slow: jsonSerialization['slow'] as bool,
      error: jsonSerialization['error'] as bool,
      open: jsonSerialization['open'] as bool,
      lastSessionLogId: jsonSerialization['lastSessionLogId'] as int?,
    );
  }

  String? endpoint;

  String? method;

  bool slow;

  bool error;

  bool open;

  int? lastSessionLogId;

  /// Returns a shallow copy of this [HubSessionLogFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HubSessionLogFilter copyWith({
    String? endpoint,
    String? method,
    bool? slow,
    bool? error,
    bool? open,
    int? lastSessionLogId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (endpoint != null) 'endpoint': endpoint,
      if (method != null) 'method': method,
      'slow': slow,
      'error': error,
      'open': open,
      if (lastSessionLogId != null) 'lastSessionLogId': lastSessionLogId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (endpoint != null) 'endpoint': endpoint,
      if (method != null) 'method': method,
      'slow': slow,
      'error': error,
      'open': open,
      if (lastSessionLogId != null) 'lastSessionLogId': lastSessionLogId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HubSessionLogFilterImpl extends HubSessionLogFilter {
  _HubSessionLogFilterImpl({
    String? endpoint,
    String? method,
    required bool slow,
    required bool error,
    required bool open,
    int? lastSessionLogId,
  }) : super._(
          endpoint: endpoint,
          method: method,
          slow: slow,
          error: error,
          open: open,
          lastSessionLogId: lastSessionLogId,
        );

  /// Returns a shallow copy of this [HubSessionLogFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HubSessionLogFilter copyWith({
    Object? endpoint = _Undefined,
    Object? method = _Undefined,
    bool? slow,
    bool? error,
    bool? open,
    Object? lastSessionLogId = _Undefined,
  }) {
    return HubSessionLogFilter(
      endpoint: endpoint is String? ? endpoint : this.endpoint,
      method: method is String? ? method : this.method,
      slow: slow ?? this.slow,
      error: error ?? this.error,
      open: open ?? this.open,
      lastSessionLogId:
          lastSessionLogId is int? ? lastSessionLogId : this.lastSessionLogId,
    );
  }
}
