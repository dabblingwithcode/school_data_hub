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

abstract class UserFlags implements _i1.SerializableModel {
  UserFlags._({
    required this.confirmedTermsOfUse,
    required this.confirmedPrivacyPolicy,
    required this.changedPassword,
    required this.madeFirstSteps,
    required this.isTester,
  });

  factory UserFlags({
    required bool confirmedTermsOfUse,
    required bool confirmedPrivacyPolicy,
    required bool changedPassword,
    required bool madeFirstSteps,
    required bool isTester,
  }) = _UserFlagsImpl;

  factory UserFlags.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserFlags(
      confirmedTermsOfUse: jsonSerialization['confirmedTermsOfUse'] as bool,
      confirmedPrivacyPolicy:
          jsonSerialization['confirmedPrivacyPolicy'] as bool,
      changedPassword: jsonSerialization['changedPassword'] as bool,
      madeFirstSteps: jsonSerialization['madeFirstSteps'] as bool,
      isTester: jsonSerialization['isTester'] as bool,
    );
  }

  bool confirmedTermsOfUse;

  bool confirmedPrivacyPolicy;

  bool changedPassword;

  bool madeFirstSteps;

  bool isTester;

  /// Returns a shallow copy of this [UserFlags]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserFlags copyWith({
    bool? confirmedTermsOfUse,
    bool? confirmedPrivacyPolicy,
    bool? changedPassword,
    bool? madeFirstSteps,
    bool? isTester,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'confirmedTermsOfUse': confirmedTermsOfUse,
      'confirmedPrivacyPolicy': confirmedPrivacyPolicy,
      'changedPassword': changedPassword,
      'madeFirstSteps': madeFirstSteps,
      'isTester': isTester,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UserFlagsImpl extends UserFlags {
  _UserFlagsImpl({
    required bool confirmedTermsOfUse,
    required bool confirmedPrivacyPolicy,
    required bool changedPassword,
    required bool madeFirstSteps,
    required bool isTester,
  }) : super._(
          confirmedTermsOfUse: confirmedTermsOfUse,
          confirmedPrivacyPolicy: confirmedPrivacyPolicy,
          changedPassword: changedPassword,
          madeFirstSteps: madeFirstSteps,
          isTester: isTester,
        );

  /// Returns a shallow copy of this [UserFlags]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserFlags copyWith({
    bool? confirmedTermsOfUse,
    bool? confirmedPrivacyPolicy,
    bool? changedPassword,
    bool? madeFirstSteps,
    bool? isTester,
  }) {
    return UserFlags(
      confirmedTermsOfUse: confirmedTermsOfUse ?? this.confirmedTermsOfUse,
      confirmedPrivacyPolicy:
          confirmedPrivacyPolicy ?? this.confirmedPrivacyPolicy,
      changedPassword: changedPassword ?? this.changedPassword,
      madeFirstSteps: madeFirstSteps ?? this.madeFirstSteps,
      isTester: isTester ?? this.isTester,
    );
  }
}
