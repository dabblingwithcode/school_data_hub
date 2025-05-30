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
import '../../../../../_shared/models/hub_document.dart' as _i2;

abstract class PreSchoolTest implements _i1.SerializableModel {
  PreSchoolTest._({
    this.id,
    this.careNeedsIntensity,
    this.preSchoolTestDocuments,
  });

  factory PreSchoolTest({
    int? id,
    int? careNeedsIntensity,
    List<_i2.HubDocument>? preSchoolTestDocuments,
  }) = _PreSchoolTestImpl;

  factory PreSchoolTest.fromJson(Map<String, dynamic> jsonSerialization) {
    return PreSchoolTest(
      id: jsonSerialization['id'] as int?,
      careNeedsIntensity: jsonSerialization['careNeedsIntensity'] as int?,
      preSchoolTestDocuments: (jsonSerialization['preSchoolTestDocuments']
              as List?)
          ?.map((e) => _i2.HubDocument.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? careNeedsIntensity;

  List<_i2.HubDocument>? preSchoolTestDocuments;

  /// Returns a shallow copy of this [PreSchoolTest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PreSchoolTest copyWith({
    int? id,
    int? careNeedsIntensity,
    List<_i2.HubDocument>? preSchoolTestDocuments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (careNeedsIntensity != null) 'careNeedsIntensity': careNeedsIntensity,
      if (preSchoolTestDocuments != null)
        'preSchoolTestDocuments':
            preSchoolTestDocuments?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PreSchoolTestImpl extends PreSchoolTest {
  _PreSchoolTestImpl({
    int? id,
    int? careNeedsIntensity,
    List<_i2.HubDocument>? preSchoolTestDocuments,
  }) : super._(
          id: id,
          careNeedsIntensity: careNeedsIntensity,
          preSchoolTestDocuments: preSchoolTestDocuments,
        );

  /// Returns a shallow copy of this [PreSchoolTest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PreSchoolTest copyWith({
    Object? id = _Undefined,
    Object? careNeedsIntensity = _Undefined,
    Object? preSchoolTestDocuments = _Undefined,
  }) {
    return PreSchoolTest(
      id: id is int? ? id : this.id,
      careNeedsIntensity: careNeedsIntensity is int?
          ? careNeedsIntensity
          : this.careNeedsIntensity,
      preSchoolTestDocuments: preSchoolTestDocuments is List<_i2.HubDocument>?
          ? preSchoolTestDocuments
          : this.preSchoolTestDocuments?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
