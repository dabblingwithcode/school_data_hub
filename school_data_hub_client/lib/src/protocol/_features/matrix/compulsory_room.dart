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
import '../../_features/matrix/matrix_room_type.dart' as _i2;

abstract class CompulsoryRoom implements _i1.SerializableModel {
  CompulsoryRoom._({
    this.id,
    required this.roomId,
    required this.roomType,
  });

  factory CompulsoryRoom({
    int? id,
    required String roomId,
    required _i2.MatrixRoomType roomType,
  }) = _CompulsoryRoomImpl;

  factory CompulsoryRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompulsoryRoom(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as String,
      roomType: _i2.MatrixRoomType.fromJson(
          (jsonSerialization['roomType'] as String)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String roomId;

  _i2.MatrixRoomType roomType;

  /// Returns a shallow copy of this [CompulsoryRoom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompulsoryRoom copyWith({
    int? id,
    String? roomId,
    _i2.MatrixRoomType? roomType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomId': roomId,
      'roomType': roomType.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompulsoryRoomImpl extends CompulsoryRoom {
  _CompulsoryRoomImpl({
    int? id,
    required String roomId,
    required _i2.MatrixRoomType roomType,
  }) : super._(
          id: id,
          roomId: roomId,
          roomType: roomType,
        );

  /// Returns a shallow copy of this [CompulsoryRoom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompulsoryRoom copyWith({
    Object? id = _Undefined,
    String? roomId,
    _i2.MatrixRoomType? roomType,
  }) {
    return CompulsoryRoom(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      roomType: roomType ?? this.roomType,
    );
  }
}
