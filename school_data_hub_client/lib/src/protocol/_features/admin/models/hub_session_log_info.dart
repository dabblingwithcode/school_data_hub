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
import '../../../_features/admin/models/hub_session_log_entry.dart' as _i2;
import '../../../_features/admin/models/hub_log_entry.dart' as _i3;
import '../../../_features/admin/models/hub_query_log_entry.dart' as _i4;

abstract class HubSessionLogInfo implements _i1.SerializableModel {
  HubSessionLogInfo._({
    required this.sessionLogEntry,
    required this.logs,
    required this.queries,
  });

  factory HubSessionLogInfo({
    required _i2.HubSessionLogEntry sessionLogEntry,
    required List<_i3.HubLogEntry> logs,
    required List<_i4.HubQueryLogEntry> queries,
  }) = _HubSessionLogInfoImpl;

  factory HubSessionLogInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return HubSessionLogInfo(
      sessionLogEntry: _i2.HubSessionLogEntry.fromJson(
          (jsonSerialization['sessionLogEntry'] as Map<String, dynamic>)),
      logs: (jsonSerialization['logs'] as List)
          .map((e) => _i3.HubLogEntry.fromJson((e as Map<String, dynamic>)))
          .toList(),
      queries: (jsonSerialization['queries'] as List)
          .map(
              (e) => _i4.HubQueryLogEntry.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.HubSessionLogEntry sessionLogEntry;

  List<_i3.HubLogEntry> logs;

  List<_i4.HubQueryLogEntry> queries;

  /// Returns a shallow copy of this [HubSessionLogInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HubSessionLogInfo copyWith({
    _i2.HubSessionLogEntry? sessionLogEntry,
    List<_i3.HubLogEntry>? logs,
    List<_i4.HubQueryLogEntry>? queries,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'sessionLogEntry': sessionLogEntry.toJson(),
      'logs': logs.toJson(valueToJson: (v) => v.toJson()),
      'queries': queries.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _HubSessionLogInfoImpl extends HubSessionLogInfo {
  _HubSessionLogInfoImpl({
    required _i2.HubSessionLogEntry sessionLogEntry,
    required List<_i3.HubLogEntry> logs,
    required List<_i4.HubQueryLogEntry> queries,
  }) : super._(
          sessionLogEntry: sessionLogEntry,
          logs: logs,
          queries: queries,
        );

  /// Returns a shallow copy of this [HubSessionLogInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HubSessionLogInfo copyWith({
    _i2.HubSessionLogEntry? sessionLogEntry,
    List<_i3.HubLogEntry>? logs,
    List<_i4.HubQueryLogEntry>? queries,
  }) {
    return HubSessionLogInfo(
      sessionLogEntry: sessionLogEntry ?? this.sessionLogEntry.copyWith(),
      logs: logs ?? this.logs.map((e0) => e0.copyWith()).toList(),
      queries: queries ?? this.queries.map((e0) => e0.copyWith()).toList(),
    );
  }
}
