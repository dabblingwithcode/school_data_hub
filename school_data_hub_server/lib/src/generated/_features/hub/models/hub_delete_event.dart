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
import '../../../_features/hub/models/hub_object_type.dart' as _i2;

abstract class HubDeleteEvent
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  HubDeleteEvent._({
    required this.id,
    required this.objectType,
  });

  factory HubDeleteEvent({
    required int id,
    required _i2.HubObjectType objectType,
  }) = _HubDeleteEventImpl;

  factory HubDeleteEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return HubDeleteEvent(
      id: jsonSerialization['id'] as int,
      objectType:
          _i2.HubObjectType.fromJson((jsonSerialization['objectType'] as int)),
    );
  }

  _i2.HubObjectType objectType;

  int id;

  /// Returns a shallow copy of this [HubDeleteEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HubDeleteEvent copyWith({
    int? id,
    _i2.HubObjectType? objectType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'objectType': objectType.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'id': id,
      'objectType': objectType.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _HubDeleteEventImpl extends HubDeleteEvent {
  _HubDeleteEventImpl({
    required int id,
    required _i2.HubObjectType objectType,
  }) : super._(
          id: id,
          objectType: objectType,
        );

  /// Returns a shallow copy of this [HubDeleteEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HubDeleteEvent copyWith({
    int? id,
    _i2.HubObjectType? objectType,
  }) {
    return HubDeleteEvent(
      id: id ?? this.id,
      objectType: objectType ?? this.objectType,
    );
  }
}
