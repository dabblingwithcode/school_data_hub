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
import '../authorization/pupil_authorization.dart' as _i2;

abstract class Authorization implements _i1.SerializableModel {
  Authorization._({
    this.id,
    required this.name,
    required this.description,
    required this.createdBy,
    this.authorizedPupils,
  });

  factory Authorization({
    int? id,
    required String name,
    required String description,
    required String createdBy,
    List<_i2.PupilAuthorization>? authorizedPupils,
  }) = _AuthorizationImpl;

  factory Authorization.fromJson(Map<String, dynamic> jsonSerialization) {
    return Authorization(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      authorizedPupils: (jsonSerialization['authorizedPupils'] as List?)
          ?.map((e) =>
              _i2.PupilAuthorization.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String description;

  String createdBy;

  List<_i2.PupilAuthorization>? authorizedPupils;

  /// Returns a shallow copy of this [Authorization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Authorization copyWith({
    int? id,
    String? name,
    String? description,
    String? createdBy,
    List<_i2.PupilAuthorization>? authorizedPupils,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'createdBy': createdBy,
      if (authorizedPupils != null)
        'authorizedPupils':
            authorizedPupils?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthorizationImpl extends Authorization {
  _AuthorizationImpl({
    int? id,
    required String name,
    required String description,
    required String createdBy,
    List<_i2.PupilAuthorization>? authorizedPupils,
  }) : super._(
          id: id,
          name: name,
          description: description,
          createdBy: createdBy,
          authorizedPupils: authorizedPupils,
        );

  /// Returns a shallow copy of this [Authorization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Authorization copyWith({
    Object? id = _Undefined,
    String? name,
    String? description,
    String? createdBy,
    Object? authorizedPupils = _Undefined,
  }) {
    return Authorization(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      authorizedPupils: authorizedPupils is List<_i2.PupilAuthorization>?
          ? authorizedPupils
          : this.authorizedPupils?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
