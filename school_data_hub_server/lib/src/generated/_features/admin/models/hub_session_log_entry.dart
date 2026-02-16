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

abstract class HubSessionLogEntry
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  HubSessionLogEntry._({
    required this.sessionId,
    required this.serverId,
    required this.time,
    this.endpoint,
    this.method,
    this.duration,
    this.numQueries,
    this.slow,
    this.error,
    this.stackTrace,
    this.authenticatedUserId,
    this.isOpen,
  });

  factory HubSessionLogEntry({
    required int sessionId,
    required String serverId,
    required DateTime time,
    String? endpoint,
    String? method,
    double? duration,
    int? numQueries,
    bool? slow,
    String? error,
    String? stackTrace,
    int? authenticatedUserId,
    bool? isOpen,
  }) = _HubSessionLogEntryImpl;

  factory HubSessionLogEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return HubSessionLogEntry(
      sessionId: jsonSerialization['sessionId'] as int,
      serverId: jsonSerialization['serverId'] as String,
      time: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['time']),
      endpoint: jsonSerialization['endpoint'] as String?,
      method: jsonSerialization['method'] as String?,
      duration: (jsonSerialization['duration'] as num?)?.toDouble(),
      numQueries: jsonSerialization['numQueries'] as int?,
      slow: jsonSerialization['slow'] as bool?,
      error: jsonSerialization['error'] as String?,
      stackTrace: jsonSerialization['stackTrace'] as String?,
      authenticatedUserId: jsonSerialization['authenticatedUserId'] as int?,
      isOpen: jsonSerialization['isOpen'] as bool?,
    );
  }

  int sessionId;

  String serverId;

  DateTime time;

  String? endpoint;

  String? method;

  double? duration;

  int? numQueries;

  bool? slow;

  String? error;

  String? stackTrace;

  int? authenticatedUserId;

  bool? isOpen;

  /// Returns a shallow copy of this [HubSessionLogEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HubSessionLogEntry copyWith({
    int? sessionId,
    String? serverId,
    DateTime? time,
    String? endpoint,
    String? method,
    double? duration,
    int? numQueries,
    bool? slow,
    String? error,
    String? stackTrace,
    int? authenticatedUserId,
    bool? isOpen,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'serverId': serverId,
      'time': time.toJson(),
      if (endpoint != null) 'endpoint': endpoint,
      if (method != null) 'method': method,
      if (duration != null) 'duration': duration,
      if (numQueries != null) 'numQueries': numQueries,
      if (slow != null) 'slow': slow,
      if (error != null) 'error': error,
      if (stackTrace != null) 'stackTrace': stackTrace,
      if (authenticatedUserId != null)
        'authenticatedUserId': authenticatedUserId,
      if (isOpen != null) 'isOpen': isOpen,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'sessionId': sessionId,
      'serverId': serverId,
      'time': time.toJson(),
      if (endpoint != null) 'endpoint': endpoint,
      if (method != null) 'method': method,
      if (duration != null) 'duration': duration,
      if (numQueries != null) 'numQueries': numQueries,
      if (slow != null) 'slow': slow,
      if (error != null) 'error': error,
      if (stackTrace != null) 'stackTrace': stackTrace,
      if (authenticatedUserId != null)
        'authenticatedUserId': authenticatedUserId,
      if (isOpen != null) 'isOpen': isOpen,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HubSessionLogEntryImpl extends HubSessionLogEntry {
  _HubSessionLogEntryImpl({
    required int sessionId,
    required String serverId,
    required DateTime time,
    String? endpoint,
    String? method,
    double? duration,
    int? numQueries,
    bool? slow,
    String? error,
    String? stackTrace,
    int? authenticatedUserId,
    bool? isOpen,
  }) : super._(
          sessionId: sessionId,
          serverId: serverId,
          time: time,
          endpoint: endpoint,
          method: method,
          duration: duration,
          numQueries: numQueries,
          slow: slow,
          error: error,
          stackTrace: stackTrace,
          authenticatedUserId: authenticatedUserId,
          isOpen: isOpen,
        );

  /// Returns a shallow copy of this [HubSessionLogEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HubSessionLogEntry copyWith({
    int? sessionId,
    String? serverId,
    DateTime? time,
    Object? endpoint = _Undefined,
    Object? method = _Undefined,
    Object? duration = _Undefined,
    Object? numQueries = _Undefined,
    Object? slow = _Undefined,
    Object? error = _Undefined,
    Object? stackTrace = _Undefined,
    Object? authenticatedUserId = _Undefined,
    Object? isOpen = _Undefined,
  }) {
    return HubSessionLogEntry(
      sessionId: sessionId ?? this.sessionId,
      serverId: serverId ?? this.serverId,
      time: time ?? this.time,
      endpoint: endpoint is String? ? endpoint : this.endpoint,
      method: method is String? ? method : this.method,
      duration: duration is double? ? duration : this.duration,
      numQueries: numQueries is int? ? numQueries : this.numQueries,
      slow: slow is bool? ? slow : this.slow,
      error: error is String? ? error : this.error,
      stackTrace: stackTrace is String? ? stackTrace : this.stackTrace,
      authenticatedUserId: authenticatedUserId is int?
          ? authenticatedUserId
          : this.authenticatedUserId,
      isOpen: isOpen is bool? ? isOpen : this.isOpen,
    );
  }
}
