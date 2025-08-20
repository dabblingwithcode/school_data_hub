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
import '../../../../../_features/pupil/models/pupil_data/pupil_data.dart'
    as _i2;

abstract class Kindergarden implements _i1.SerializableModel {
  Kindergarden._({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.contactPerson,
    this.pupils,
  });

  factory Kindergarden({
    int? id,
    required String name,
    required String phone,
    required String address,
    required String email,
    required String contactPerson,
    List<_i2.PupilData>? pupils,
  }) = _KindergardenImpl;

  factory Kindergarden.fromJson(Map<String, dynamic> jsonSerialization) {
    return Kindergarden(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      phone: jsonSerialization['phone'] as String,
      address: jsonSerialization['address'] as String,
      email: jsonSerialization['email'] as String,
      contactPerson: jsonSerialization['contactPerson'] as String,
      pupils: (jsonSerialization['pupils'] as List?)
          ?.map((e) => _i2.PupilData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String phone;

  String address;

  String email;

  String contactPerson;

  List<_i2.PupilData>? pupils;

  /// Returns a shallow copy of this [Kindergarden]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Kindergarden copyWith({
    int? id,
    String? name,
    String? phone,
    String? address,
    String? email,
    String? contactPerson,
    List<_i2.PupilData>? pupils,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
      'contactPerson': contactPerson,
      if (pupils != null)
        'pupils': pupils?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _KindergardenImpl extends Kindergarden {
  _KindergardenImpl({
    int? id,
    required String name,
    required String phone,
    required String address,
    required String email,
    required String contactPerson,
    List<_i2.PupilData>? pupils,
  }) : super._(
          id: id,
          name: name,
          phone: phone,
          address: address,
          email: email,
          contactPerson: contactPerson,
          pupils: pupils,
        );

  /// Returns a shallow copy of this [Kindergarden]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Kindergarden copyWith({
    Object? id = _Undefined,
    String? name,
    String? phone,
    String? address,
    String? email,
    String? contactPerson,
    Object? pupils = _Undefined,
  }) {
    return Kindergarden(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      email: email ?? this.email,
      contactPerson: contactPerson ?? this.contactPerson,
      pupils: pupils is List<_i2.PupilData>?
          ? pupils
          : this.pupils?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
