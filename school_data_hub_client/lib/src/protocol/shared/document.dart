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

abstract class HubDocument implements _i1.SerializableModel {
  HubDocument._({
    this.id,
    required this.documentId,
    required this.createdBy,
    required this.createdAt,
  });

  factory HubDocument({
    int? id,
    required String documentId,
    required String createdBy,
    required DateTime createdAt,
  }) = _HubDocumentImpl;

  factory HubDocument.fromJson(Map<String, dynamic> jsonSerialization) {
    return HubDocument(
      id: jsonSerialization['id'] as int?,
      documentId: jsonSerialization['documentId'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String documentId;

  String createdBy;

  DateTime createdAt;

  /// Returns a shallow copy of this [HubDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HubDocument copyWith({
    int? id,
    String? documentId,
    String? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'documentId': documentId,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HubDocumentImpl extends HubDocument {
  _HubDocumentImpl({
    int? id,
    required String documentId,
    required String createdBy,
    required DateTime createdAt,
  }) : super._(
          id: id,
          documentId: documentId,
          createdBy: createdBy,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [HubDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HubDocument copyWith({
    Object? id = _Undefined,
    String? documentId,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return HubDocument(
      id: id is int? ? id : this.id,
      documentId: documentId ?? this.documentId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
