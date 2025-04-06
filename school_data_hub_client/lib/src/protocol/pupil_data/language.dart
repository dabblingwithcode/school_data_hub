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

abstract class Language implements _i1.SerializableModel {
  Language._({
    required this.languageName,
    required this.totalFamilies,
  });

  factory Language({
    required String languageName,
    required int totalFamilies,
  }) = _LanguageImpl;

  factory Language.fromJson(Map<String, dynamic> jsonSerialization) {
    return Language(
      languageName: jsonSerialization['languageName'] as String,
      totalFamilies: jsonSerialization['totalFamilies'] as int,
    );
  }

  String languageName;

  int totalFamilies;

  /// Returns a shallow copy of this [Language]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Language copyWith({
    String? languageName,
    int? totalFamilies,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'languageName': languageName,
      'totalFamilies': totalFamilies,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _LanguageImpl extends Language {
  _LanguageImpl({
    required String languageName,
    required int totalFamilies,
  }) : super._(
          languageName: languageName,
          totalFamilies: totalFamilies,
        );

  /// Returns a shallow copy of this [Language]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Language copyWith({
    String? languageName,
    int? totalFamilies,
  }) {
    return Language(
      languageName: languageName ?? this.languageName,
      totalFamilies: totalFamilies ?? this.totalFamilies,
    );
  }
}
