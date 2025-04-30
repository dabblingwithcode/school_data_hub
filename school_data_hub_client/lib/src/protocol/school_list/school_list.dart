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
import '../school_list/pupil_list.dart' as _i2;

abstract class SchoolList implements _i1.SerializableModel {
  SchoolList._({
    this.id,
    required this.listId,
    required this.archived,
    required this.name,
    required this.description,
    required this.createdBy,
    required this.public,
    this.authorizedUsers,
    this.pupilLists,
  });

  factory SchoolList({
    int? id,
    required String listId,
    required bool archived,
    required String name,
    required String description,
    required String createdBy,
    required bool public,
    String? authorizedUsers,
    List<_i2.PupilList>? pupilLists,
  }) = _SchoolListImpl;

  factory SchoolList.fromJson(Map<String, dynamic> jsonSerialization) {
    return SchoolList(
      id: jsonSerialization['id'] as int?,
      listId: jsonSerialization['listId'] as String,
      archived: jsonSerialization['archived'] as bool,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      public: jsonSerialization['public'] as bool,
      authorizedUsers: jsonSerialization['authorizedUsers'] as String?,
      pupilLists: (jsonSerialization['pupilLists'] as List?)
          ?.map((e) => _i2.PupilList.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String listId;

  bool archived;

  String name;

  String description;

  String createdBy;

  bool public;

  String? authorizedUsers;

  List<_i2.PupilList>? pupilLists;

  /// Returns a shallow copy of this [SchoolList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SchoolList copyWith({
    int? id,
    String? listId,
    bool? archived,
    String? name,
    String? description,
    String? createdBy,
    bool? public,
    String? authorizedUsers,
    List<_i2.PupilList>? pupilLists,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'listId': listId,
      'archived': archived,
      'name': name,
      'description': description,
      'createdBy': createdBy,
      'public': public,
      if (authorizedUsers != null) 'authorizedUsers': authorizedUsers,
      if (pupilLists != null)
        'pupilLists': pupilLists?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SchoolListImpl extends SchoolList {
  _SchoolListImpl({
    int? id,
    required String listId,
    required bool archived,
    required String name,
    required String description,
    required String createdBy,
    required bool public,
    String? authorizedUsers,
    List<_i2.PupilList>? pupilLists,
  }) : super._(
          id: id,
          listId: listId,
          archived: archived,
          name: name,
          description: description,
          createdBy: createdBy,
          public: public,
          authorizedUsers: authorizedUsers,
          pupilLists: pupilLists,
        );

  /// Returns a shallow copy of this [SchoolList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SchoolList copyWith({
    Object? id = _Undefined,
    String? listId,
    bool? archived,
    String? name,
    String? description,
    String? createdBy,
    bool? public,
    Object? authorizedUsers = _Undefined,
    Object? pupilLists = _Undefined,
  }) {
    return SchoolList(
      id: id is int? ? id : this.id,
      listId: listId ?? this.listId,
      archived: archived ?? this.archived,
      name: name ?? this.name,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      public: public ?? this.public,
      authorizedUsers:
          authorizedUsers is String? ? authorizedUsers : this.authorizedUsers,
      pupilLists: pupilLists is List<_i2.PupilList>?
          ? pupilLists
          : this.pupilLists?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
