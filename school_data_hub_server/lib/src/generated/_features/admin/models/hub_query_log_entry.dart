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

abstract class HubQueryLogEntry
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  HubQueryLogEntry._({
    required this.query,
    required this.duration,
    this.numRows,
    this.error,
    required this.slow,
    required this.order,
  });

  factory HubQueryLogEntry({
    required String query,
    required double duration,
    int? numRows,
    String? error,
    required bool slow,
    required int order,
  }) = _HubQueryLogEntryImpl;

  factory HubQueryLogEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return HubQueryLogEntry(
      query: jsonSerialization['query'] as String,
      duration: (jsonSerialization['duration'] as num).toDouble(),
      numRows: jsonSerialization['numRows'] as int?,
      error: jsonSerialization['error'] as String?,
      slow: jsonSerialization['slow'] as bool,
      order: jsonSerialization['order'] as int,
    );
  }

  String query;

  double duration;

  int? numRows;

  String? error;

  bool slow;

  int order;

  /// Returns a shallow copy of this [HubQueryLogEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HubQueryLogEntry copyWith({
    String? query,
    double? duration,
    int? numRows,
    String? error,
    bool? slow,
    int? order,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'duration': duration,
      if (numRows != null) 'numRows': numRows,
      if (error != null) 'error': error,
      'slow': slow,
      'order': order,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'query': query,
      'duration': duration,
      if (numRows != null) 'numRows': numRows,
      if (error != null) 'error': error,
      'slow': slow,
      'order': order,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HubQueryLogEntryImpl extends HubQueryLogEntry {
  _HubQueryLogEntryImpl({
    required String query,
    required double duration,
    int? numRows,
    String? error,
    required bool slow,
    required int order,
  }) : super._(
          query: query,
          duration: duration,
          numRows: numRows,
          error: error,
          slow: slow,
          order: order,
        );

  /// Returns a shallow copy of this [HubQueryLogEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HubQueryLogEntry copyWith({
    String? query,
    double? duration,
    Object? numRows = _Undefined,
    Object? error = _Undefined,
    bool? slow,
    int? order,
  }) {
    return HubQueryLogEntry(
      query: query ?? this.query,
      duration: duration ?? this.duration,
      numRows: numRows is int? ? numRows : this.numRows,
      error: error is String? ? error : this.error,
      slow: slow ?? this.slow,
      order: order ?? this.order,
    );
  }
}
