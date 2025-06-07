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
import '../../../_features/learning/models/competence_report_check.dart' as _i2;

abstract class CompetenceReportItem implements _i1.SerializableModel {
  CompetenceReportItem._({
    this.id,
    required this.publicId,
    this.parentItem,
    required this.name,
    this.level,
    this.order,
    this.competenceReportchecks,
  });

  factory CompetenceReportItem({
    int? id,
    required int publicId,
    int? parentItem,
    required String name,
    List<String>? level,
    int? order,
    List<_i2.CompetenceReportCheck>? competenceReportchecks,
  }) = _CompetenceReportItemImpl;

  factory CompetenceReportItem.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CompetenceReportItem(
      id: jsonSerialization['id'] as int?,
      publicId: jsonSerialization['publicId'] as int,
      parentItem: jsonSerialization['parentItem'] as int?,
      name: jsonSerialization['name'] as String,
      level: (jsonSerialization['level'] as List?)
          ?.map((e) => e as String)
          .toList(),
      order: jsonSerialization['order'] as int?,
      competenceReportchecks: (jsonSerialization['competenceReportchecks']
              as List?)
          ?.map((e) =>
              _i2.CompetenceReportCheck.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int publicId;

  int? parentItem;

  String name;

  List<String>? level;

  int? order;

  List<_i2.CompetenceReportCheck>? competenceReportchecks;

  /// Returns a shallow copy of this [CompetenceReportItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompetenceReportItem copyWith({
    int? id,
    int? publicId,
    int? parentItem,
    String? name,
    List<String>? level,
    int? order,
    List<_i2.CompetenceReportCheck>? competenceReportchecks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'publicId': publicId,
      if (parentItem != null) 'parentItem': parentItem,
      'name': name,
      if (level != null) 'level': level?.toJson(),
      if (order != null) 'order': order,
      if (competenceReportchecks != null)
        'competenceReportchecks':
            competenceReportchecks?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetenceReportItemImpl extends CompetenceReportItem {
  _CompetenceReportItemImpl({
    int? id,
    required int publicId,
    int? parentItem,
    required String name,
    List<String>? level,
    int? order,
    List<_i2.CompetenceReportCheck>? competenceReportchecks,
  }) : super._(
          id: id,
          publicId: publicId,
          parentItem: parentItem,
          name: name,
          level: level,
          order: order,
          competenceReportchecks: competenceReportchecks,
        );

  /// Returns a shallow copy of this [CompetenceReportItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompetenceReportItem copyWith({
    Object? id = _Undefined,
    int? publicId,
    Object? parentItem = _Undefined,
    String? name,
    Object? level = _Undefined,
    Object? order = _Undefined,
    Object? competenceReportchecks = _Undefined,
  }) {
    return CompetenceReportItem(
      id: id is int? ? id : this.id,
      publicId: publicId ?? this.publicId,
      parentItem: parentItem is int? ? parentItem : this.parentItem,
      name: name ?? this.name,
      level:
          level is List<String>? ? level : this.level?.map((e0) => e0).toList(),
      order: order is int? ? order : this.order,
      competenceReportchecks: competenceReportchecks
              is List<_i2.CompetenceReportCheck>?
          ? competenceReportchecks
          : this.competenceReportchecks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
