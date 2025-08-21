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

abstract class LastPupilIdentiesUpdate implements _i1.SerializableModel {
  LastPupilIdentiesUpdate._({
    this.id,
    this.date,
  });

  factory LastPupilIdentiesUpdate({
    int? id,
    DateTime? date,
  }) = _LastPupilIdentiesUpdateImpl;

  factory LastPupilIdentiesUpdate.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return LastPupilIdentiesUpdate(
      id: jsonSerialization['id'] as int?,
      date: jsonSerialization['date'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime? date;

  /// Returns a shallow copy of this [LastPupilIdentiesUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LastPupilIdentiesUpdate copyWith({
    int? id,
    DateTime? date,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (date != null) 'date': date?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LastPupilIdentiesUpdateImpl extends LastPupilIdentiesUpdate {
  _LastPupilIdentiesUpdateImpl({
    int? id,
    DateTime? date,
  }) : super._(
          id: id,
          date: date,
        );

  /// Returns a shallow copy of this [LastPupilIdentiesUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LastPupilIdentiesUpdate copyWith({
    Object? id = _Undefined,
    Object? date = _Undefined,
  }) {
    return LastPupilIdentiesUpdate(
      id: id is int? ? id : this.id,
      date: date is DateTime? ? date : this.date,
    );
  }
}
