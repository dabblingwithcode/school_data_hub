import 'package:json_annotation/json_annotation.dart';
part 'flags.g.dart';

@JsonSerializable()
class MatrixPolicyFlags {
  final bool? allowCustomUserDisplayNames;
  final bool? allowCustomUserAvatars;
  final bool? allowCustomPassthroughUserPasswords;
  final bool? allowUnauthenticatedPasswordResets;
  final bool? forbidRoomCreation;
  final bool? forbidEncryptedRoomCreation;
  final bool? forbidUnencryptedRoomCreation;
  final bool? allow3pidLogin;

  factory MatrixPolicyFlags.fromJson(Map<String, dynamic> json) =>
      _$FlagsFromJson(json);

  Map<String, dynamic> toJson() => _$FlagsToJson(this);

  MatrixPolicyFlags({
    required this.allowCustomUserDisplayNames,
    required this.allowCustomUserAvatars,
    required this.allowCustomPassthroughUserPasswords,
    required this.allowUnauthenticatedPasswordResets,
    required this.forbidRoomCreation,
    required this.forbidEncryptedRoomCreation,
    required this.forbidUnencryptedRoomCreation,
    required this.allow3pidLogin,
  });

  MatrixPolicyFlags copyWith({
    bool? allowCustomUserDisplayNames,
    bool? allowCustomUserAvatars,
    bool? allowCustomPassthroughUserPasswords,
    bool? allowUnauthenticatedPasswordResets,
    bool? forbidRoomCreation,
    bool? forbidEncryptedRoomCreation,
    bool? forbidUnencryptedRoomCreation,
    bool? allow3pidLogin,
  }) => MatrixPolicyFlags(
    allowCustomUserDisplayNames:
        allowCustomUserDisplayNames ?? this.allowCustomUserDisplayNames,
    allowCustomUserAvatars:
        allowCustomUserAvatars ?? this.allowCustomUserAvatars,
    allowCustomPassthroughUserPasswords:
        allowCustomPassthroughUserPasswords ??
        this.allowCustomPassthroughUserPasswords,
    allowUnauthenticatedPasswordResets:
        allowUnauthenticatedPasswordResets ??
        this.allowUnauthenticatedPasswordResets,
    forbidRoomCreation: forbidRoomCreation ?? this.forbidRoomCreation,
    forbidEncryptedRoomCreation:
        forbidEncryptedRoomCreation ?? this.forbidEncryptedRoomCreation,
    forbidUnencryptedRoomCreation:
        forbidUnencryptedRoomCreation ?? this.forbidUnencryptedRoomCreation,
    allow3pidLogin: allow3pidLogin ?? this.allow3pidLogin,
  );

  /// Returns a copy of [source] with all null flag values treated as false.
  static MatrixPolicyFlags withDefaults(
    MatrixPolicyFlags? source,
  ) => MatrixPolicyFlags(
    allowCustomUserDisplayNames: source?.allowCustomUserDisplayNames ?? false,
    allowCustomUserAvatars: source?.allowCustomUserAvatars ?? false,
    allowCustomPassthroughUserPasswords:
        source?.allowCustomPassthroughUserPasswords ?? false,
    allowUnauthenticatedPasswordResets:
        source?.allowUnauthenticatedPasswordResets ?? false,
    forbidRoomCreation: source?.forbidRoomCreation ?? false,
    forbidEncryptedRoomCreation: source?.forbidEncryptedRoomCreation ?? false,
    forbidUnencryptedRoomCreation:
        source?.forbidUnencryptedRoomCreation ?? false,
    allow3pidLogin: source?.allow3pidLogin ?? false,
  );
}
