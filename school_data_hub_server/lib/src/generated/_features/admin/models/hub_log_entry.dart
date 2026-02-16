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

abstract class HubLogEntry
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  HubLogEntry._({
    required this.logLevel,
    required this.message,
    this.error,
    this.stackTrace,
    required this.time,
    required this.order,
  });

  factory HubLogEntry({
    required int logLevel,
    required String message,
    String? error,
    String? stackTrace,
    required DateTime time,
    required int order,
  }) = _HubLogEntryImpl;

  factory HubLogEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return HubLogEntry(
      logLevel: jsonSerialization['logLevel'] as int,
      message: jsonSerialization['message'] as String,
      error: jsonSerialization['error'] as String?,
      stackTrace: jsonSerialization['stackTrace'] as String?,
      time: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['time']),
      order: jsonSerialization['order'] as int,
    );
  }

  int logLevel;

  String message;

  String? error;

  String? stackTrace;

  DateTime time;

  int order;

  /// Returns a shallow copy of this [HubLogEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HubLogEntry copyWith({
    int? logLevel,
    String? message,
    String? error,
    String? stackTrace,
    DateTime? time,
    int? order,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'logLevel': logLevel,
      'message': message,
      if (error != null) 'error': error,
      if (stackTrace != null) 'stackTrace': stackTrace,
      'time': time.toJson(),
      'order': order,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'logLevel': logLevel,
      'message': message,
      if (error != null) 'error': error,
      if (stackTrace != null) 'stackTrace': stackTrace,
      'time': time.toJson(),
      'order': order,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HubLogEntryImpl extends HubLogEntry {
  _HubLogEntryImpl({
    required int logLevel,
    required String message,
    String? error,
    String? stackTrace,
    required DateTime time,
    required int order,
  }) : super._(
          logLevel: logLevel,
          message: message,
          error: error,
          stackTrace: stackTrace,
          time: time,
          order: order,
        );

  /// Returns a shallow copy of this [HubLogEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HubLogEntry copyWith({
    int? logLevel,
    String? message,
    Object? error = _Undefined,
    Object? stackTrace = _Undefined,
    DateTime? time,
    int? order,
  }) {
    return HubLogEntry(
      logLevel: logLevel ?? this.logLevel,
      message: message ?? this.message,
      error: error is String? ? error : this.error,
      stackTrace: stackTrace is String? ? stackTrace : this.stackTrace,
      time: time ?? this.time,
      order: order ?? this.order,
    );
  }
}
