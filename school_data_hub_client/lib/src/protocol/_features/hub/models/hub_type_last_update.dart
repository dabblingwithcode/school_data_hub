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
import '../../../_features/hub/models/hub_object_type.dart' as _i2;

abstract class HubTypeLastUpdate implements _i1.SerializableModel {
  HubTypeLastUpdate._({
    required this.objectType,
    required this.changedAt,
  });

  factory HubTypeLastUpdate({
    required _i2.HubObjectType objectType,
    required DateTime changedAt,
  }) = _HubTypeLastUpdateImpl;

  factory HubTypeLastUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return HubTypeLastUpdate(
      objectType:
          _i2.HubObjectType.fromJson((jsonSerialization['objectType'] as int)),
      changedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['changedAt']),
    );
  }

  _i2.HubObjectType objectType;

  DateTime changedAt;

  /// Returns a shallow copy of this [HubTypeLastUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HubTypeLastUpdate copyWith({
    _i2.HubObjectType? objectType,
    DateTime? changedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'objectType': objectType.toJson(),
      'changedAt': changedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _HubTypeLastUpdateImpl extends HubTypeLastUpdate {
  _HubTypeLastUpdateImpl({
    required _i2.HubObjectType objectType,
    required DateTime changedAt,
  }) : super._(
          objectType: objectType,
          changedAt: changedAt,
        );

  /// Returns a shallow copy of this [HubTypeLastUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HubTypeLastUpdate copyWith({
    _i2.HubObjectType? objectType,
    DateTime? changedAt,
  }) {
    return HubTypeLastUpdate(
      objectType: objectType ?? this.objectType,
      changedAt: changedAt ?? this.changedAt,
    );
  }
}
