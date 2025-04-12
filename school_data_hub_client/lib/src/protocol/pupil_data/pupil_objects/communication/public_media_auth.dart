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

abstract class PublicMediaAuth implements _i1.SerializableModel {
  PublicMediaAuth._({
    required this.groupPicturesOnWebsite,
    required this.groupPicturesInPress,
    required this.portraitPicturesOnWebsite,
    required this.portraitPicturesInPress,
    required this.nameOnWebsite,
    required this.nameInPress,
    required this.videoOnWebsite,
    required this.videoInPress,
  });

  factory PublicMediaAuth({
    required bool groupPicturesOnWebsite,
    required bool groupPicturesInPress,
    required bool portraitPicturesOnWebsite,
    required bool portraitPicturesInPress,
    required bool nameOnWebsite,
    required bool nameInPress,
    required bool videoOnWebsite,
    required bool videoInPress,
  }) = _PublicMediaAuthImpl;

  factory PublicMediaAuth.fromJson(Map<String, dynamic> jsonSerialization) {
    return PublicMediaAuth(
      groupPicturesOnWebsite:
          jsonSerialization['groupPicturesOnWebsite'] as bool,
      groupPicturesInPress: jsonSerialization['groupPicturesInPress'] as bool,
      portraitPicturesOnWebsite:
          jsonSerialization['portraitPicturesOnWebsite'] as bool,
      portraitPicturesInPress:
          jsonSerialization['portraitPicturesInPress'] as bool,
      nameOnWebsite: jsonSerialization['nameOnWebsite'] as bool,
      nameInPress: jsonSerialization['nameInPress'] as bool,
      videoOnWebsite: jsonSerialization['videoOnWebsite'] as bool,
      videoInPress: jsonSerialization['videoInPress'] as bool,
    );
  }

  bool groupPicturesOnWebsite;

  bool groupPicturesInPress;

  bool portraitPicturesOnWebsite;

  bool portraitPicturesInPress;

  bool nameOnWebsite;

  bool nameInPress;

  bool videoOnWebsite;

  bool videoInPress;

  /// Returns a shallow copy of this [PublicMediaAuth]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PublicMediaAuth copyWith({
    bool? groupPicturesOnWebsite,
    bool? groupPicturesInPress,
    bool? portraitPicturesOnWebsite,
    bool? portraitPicturesInPress,
    bool? nameOnWebsite,
    bool? nameInPress,
    bool? videoOnWebsite,
    bool? videoInPress,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'groupPicturesOnWebsite': groupPicturesOnWebsite,
      'groupPicturesInPress': groupPicturesInPress,
      'portraitPicturesOnWebsite': portraitPicturesOnWebsite,
      'portraitPicturesInPress': portraitPicturesInPress,
      'nameOnWebsite': nameOnWebsite,
      'nameInPress': nameInPress,
      'videoOnWebsite': videoOnWebsite,
      'videoInPress': videoInPress,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PublicMediaAuthImpl extends PublicMediaAuth {
  _PublicMediaAuthImpl({
    required bool groupPicturesOnWebsite,
    required bool groupPicturesInPress,
    required bool portraitPicturesOnWebsite,
    required bool portraitPicturesInPress,
    required bool nameOnWebsite,
    required bool nameInPress,
    required bool videoOnWebsite,
    required bool videoInPress,
  }) : super._(
          groupPicturesOnWebsite: groupPicturesOnWebsite,
          groupPicturesInPress: groupPicturesInPress,
          portraitPicturesOnWebsite: portraitPicturesOnWebsite,
          portraitPicturesInPress: portraitPicturesInPress,
          nameOnWebsite: nameOnWebsite,
          nameInPress: nameInPress,
          videoOnWebsite: videoOnWebsite,
          videoInPress: videoInPress,
        );

  /// Returns a shallow copy of this [PublicMediaAuth]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PublicMediaAuth copyWith({
    bool? groupPicturesOnWebsite,
    bool? groupPicturesInPress,
    bool? portraitPicturesOnWebsite,
    bool? portraitPicturesInPress,
    bool? nameOnWebsite,
    bool? nameInPress,
    bool? videoOnWebsite,
    bool? videoInPress,
  }) {
    return PublicMediaAuth(
      groupPicturesOnWebsite:
          groupPicturesOnWebsite ?? this.groupPicturesOnWebsite,
      groupPicturesInPress: groupPicturesInPress ?? this.groupPicturesInPress,
      portraitPicturesOnWebsite:
          portraitPicturesOnWebsite ?? this.portraitPicturesOnWebsite,
      portraitPicturesInPress:
          portraitPicturesInPress ?? this.portraitPicturesInPress,
      nameOnWebsite: nameOnWebsite ?? this.nameOnWebsite,
      nameInPress: nameInPress ?? this.nameInPress,
      videoOnWebsite: videoOnWebsite ?? this.videoOnWebsite,
      videoInPress: videoInPress ?? this.videoInPress,
    );
  }
}
