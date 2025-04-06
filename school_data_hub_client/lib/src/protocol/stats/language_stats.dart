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
import '../pupil_data/language.dart' as _i2;

abstract class LanguageStats implements _i1.SerializableModel {
  LanguageStats._({
    this.id,
    this.languages,
  });

  factory LanguageStats({
    int? id,
    Set<_i2.Language>? languages,
  }) = _LanguageStatsImpl;

  factory LanguageStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return LanguageStats(
      id: jsonSerialization['id'] as int?,
      languages: jsonSerialization['languages'] == null
          ? null
          : _i1.SetJsonExtension.fromJson(
              (jsonSerialization['languages'] as List),
              itemFromJson: (e) =>
                  _i2.Language.fromJson((e as Map<String, dynamic>))),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  Set<_i2.Language>? languages;

  /// Returns a shallow copy of this [LanguageStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LanguageStats copyWith({
    int? id,
    Set<_i2.Language>? languages,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (languages != null)
        'languages': languages?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LanguageStatsImpl extends LanguageStats {
  _LanguageStatsImpl({
    int? id,
    Set<_i2.Language>? languages,
  }) : super._(
          id: id,
          languages: languages,
        );

  /// Returns a shallow copy of this [LanguageStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LanguageStats copyWith({
    Object? id = _Undefined,
    Object? languages = _Undefined,
  }) {
    return LanguageStats(
      id: id is int? ? id : this.id,
      languages: languages is Set<_i2.Language>?
          ? languages
          : this.languages?.map((e0) => e0.copyWith()).toSet(),
    );
  }
}
