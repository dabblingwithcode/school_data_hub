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
import '../../../_shared/models/hub_document.dart' as _i2;

abstract class SchoolData implements _i1.SerializableModel {
  SchoolData._({
    this.id,
    required this.name,
    required this.officialName,
    required this.address,
    required this.schoolNumber,
    required this.telephoneNumber,
    required this.email,
    required this.website,
    this.logoId,
    this.logo,
    this.officialSealId,
    this.officialSeal,
  });

  factory SchoolData({
    int? id,
    required String name,
    required String officialName,
    required String address,
    required String schoolNumber,
    required String telephoneNumber,
    required String email,
    required String website,
    int? logoId,
    _i2.HubDocument? logo,
    int? officialSealId,
    _i2.HubDocument? officialSeal,
  }) = _SchoolDataImpl;

  factory SchoolData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SchoolData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      officialName: jsonSerialization['officialName'] as String,
      address: jsonSerialization['address'] as String,
      schoolNumber: jsonSerialization['schoolNumber'] as String,
      telephoneNumber: jsonSerialization['telephoneNumber'] as String,
      email: jsonSerialization['email'] as String,
      website: jsonSerialization['website'] as String,
      logoId: jsonSerialization['logoId'] as int?,
      logo: jsonSerialization['logo'] == null
          ? null
          : _i2.HubDocument.fromJson(
              (jsonSerialization['logo'] as Map<String, dynamic>)),
      officialSealId: jsonSerialization['officialSealId'] as int?,
      officialSeal: jsonSerialization['officialSeal'] == null
          ? null
          : _i2.HubDocument.fromJson(
              (jsonSerialization['officialSeal'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String officialName;

  String address;

  String schoolNumber;

  String telephoneNumber;

  String email;

  String website;

  int? logoId;

  _i2.HubDocument? logo;

  int? officialSealId;

  _i2.HubDocument? officialSeal;

  /// Returns a shallow copy of this [SchoolData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SchoolData copyWith({
    int? id,
    String? name,
    String? officialName,
    String? address,
    String? schoolNumber,
    String? telephoneNumber,
    String? email,
    String? website,
    int? logoId,
    _i2.HubDocument? logo,
    int? officialSealId,
    _i2.HubDocument? officialSeal,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'officialName': officialName,
      'address': address,
      'schoolNumber': schoolNumber,
      'telephoneNumber': telephoneNumber,
      'email': email,
      'website': website,
      if (logoId != null) 'logoId': logoId,
      if (logo != null) 'logo': logo?.toJson(),
      if (officialSealId != null) 'officialSealId': officialSealId,
      if (officialSeal != null) 'officialSeal': officialSeal?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SchoolDataImpl extends SchoolData {
  _SchoolDataImpl({
    int? id,
    required String name,
    required String officialName,
    required String address,
    required String schoolNumber,
    required String telephoneNumber,
    required String email,
    required String website,
    int? logoId,
    _i2.HubDocument? logo,
    int? officialSealId,
    _i2.HubDocument? officialSeal,
  }) : super._(
          id: id,
          name: name,
          officialName: officialName,
          address: address,
          schoolNumber: schoolNumber,
          telephoneNumber: telephoneNumber,
          email: email,
          website: website,
          logoId: logoId,
          logo: logo,
          officialSealId: officialSealId,
          officialSeal: officialSeal,
        );

  /// Returns a shallow copy of this [SchoolData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SchoolData copyWith({
    Object? id = _Undefined,
    String? name,
    String? officialName,
    String? address,
    String? schoolNumber,
    String? telephoneNumber,
    String? email,
    String? website,
    Object? logoId = _Undefined,
    Object? logo = _Undefined,
    Object? officialSealId = _Undefined,
    Object? officialSeal = _Undefined,
  }) {
    return SchoolData(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      officialName: officialName ?? this.officialName,
      address: address ?? this.address,
      schoolNumber: schoolNumber ?? this.schoolNumber,
      telephoneNumber: telephoneNumber ?? this.telephoneNumber,
      email: email ?? this.email,
      website: website ?? this.website,
      logoId: logoId is int? ? logoId : this.logoId,
      logo: logo is _i2.HubDocument? ? logo : this.logo?.copyWith(),
      officialSealId:
          officialSealId is int? ? officialSealId : this.officialSealId,
      officialSeal: officialSeal is _i2.HubDocument?
          ? officialSeal
          : this.officialSeal?.copyWith(),
    );
  }
}
