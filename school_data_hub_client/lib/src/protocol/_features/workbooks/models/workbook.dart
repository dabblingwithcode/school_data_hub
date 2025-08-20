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
import '../../../_features/workbooks/models/pupil_workbook.dart' as _i2;

abstract class Workbook implements _i1.SerializableModel {
  Workbook._({
    this.id,
    required this.isbn,
    required this.name,
    this.subject,
    this.level,
    this.amount,
    required this.imageUrl,
    this.assignedPupils,
  });

  factory Workbook({
    int? id,
    required int isbn,
    required String name,
    String? subject,
    String? level,
    int? amount,
    required String imageUrl,
    List<_i2.PupilWorkbook>? assignedPupils,
  }) = _WorkbookImpl;

  factory Workbook.fromJson(Map<String, dynamic> jsonSerialization) {
    return Workbook(
      id: jsonSerialization['id'] as int?,
      isbn: jsonSerialization['isbn'] as int,
      name: jsonSerialization['name'] as String,
      subject: jsonSerialization['subject'] as String?,
      level: jsonSerialization['level'] as String?,
      amount: jsonSerialization['amount'] as int?,
      imageUrl: jsonSerialization['imageUrl'] as String,
      assignedPupils: (jsonSerialization['assignedPupils'] as List?)
          ?.map((e) => _i2.PupilWorkbook.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int isbn;

  String name;

  String? subject;

  String? level;

  int? amount;

  String imageUrl;

  List<_i2.PupilWorkbook>? assignedPupils;

  /// Returns a shallow copy of this [Workbook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Workbook copyWith({
    int? id,
    int? isbn,
    String? name,
    String? subject,
    String? level,
    int? amount,
    String? imageUrl,
    List<_i2.PupilWorkbook>? assignedPupils,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'isbn': isbn,
      'name': name,
      if (subject != null) 'subject': subject,
      if (level != null) 'level': level,
      if (amount != null) 'amount': amount,
      'imageUrl': imageUrl,
      if (assignedPupils != null)
        'assignedPupils':
            assignedPupils?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkbookImpl extends Workbook {
  _WorkbookImpl({
    int? id,
    required int isbn,
    required String name,
    String? subject,
    String? level,
    int? amount,
    required String imageUrl,
    List<_i2.PupilWorkbook>? assignedPupils,
  }) : super._(
          id: id,
          isbn: isbn,
          name: name,
          subject: subject,
          level: level,
          amount: amount,
          imageUrl: imageUrl,
          assignedPupils: assignedPupils,
        );

  /// Returns a shallow copy of this [Workbook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Workbook copyWith({
    Object? id = _Undefined,
    int? isbn,
    String? name,
    Object? subject = _Undefined,
    Object? level = _Undefined,
    Object? amount = _Undefined,
    String? imageUrl,
    Object? assignedPupils = _Undefined,
  }) {
    return Workbook(
      id: id is int? ? id : this.id,
      isbn: isbn ?? this.isbn,
      name: name ?? this.name,
      subject: subject is String? ? subject : this.subject,
      level: level is String? ? level : this.level,
      amount: amount is int? ? amount : this.amount,
      imageUrl: imageUrl ?? this.imageUrl,
      assignedPupils: assignedPupils is List<_i2.PupilWorkbook>?
          ? assignedPupils
          : this.assignedPupils?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
