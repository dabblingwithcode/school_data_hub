// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flags _$FlagsFromJson(Map<String, dynamic> json) => Flags(
      allowCustomUserDisplayNames: json['allowCustomUserDisplayNames'] as bool?,
      allowCustomUserAvatars: json['allowCustomUserAvatars'] as bool?,
      allowCustomPassthroughUserPasswords:
          json['allowCustomPassthroughUserPasswords'] as bool?,
      allowUnauthenticatedPasswordResets:
          json['allowUnauthenticatedPasswordResets'] as bool?,
      forbidRoomCreation: json['forbidRoomCreation'] as bool?,
      forbidEncryptedRoomCreation: json['forbidEncryptedRoomCreation'] as bool?,
      forbidUnencryptedRoomCreation:
          json['forbidUnencryptedRoomCreation'] as bool?,
      allow3pidLogin: json['allow3pidLogin'] as bool?,
    );

Map<String, dynamic> _$FlagsToJson(Flags instance) => <String, dynamic>{
      'allowCustomUserDisplayNames': instance.allowCustomUserDisplayNames,
      'allowCustomUserAvatars': instance.allowCustomUserAvatars,
      'allowCustomPassthroughUserPasswords':
          instance.allowCustomPassthroughUserPasswords,
      'allowUnauthenticatedPasswordResets':
          instance.allowUnauthenticatedPasswordResets,
      'forbidRoomCreation': instance.forbidRoomCreation,
      'forbidEncryptedRoomCreation': instance.forbidEncryptedRoomCreation,
      'forbidUnencryptedRoomCreation': instance.forbidUnencryptedRoomCreation,
      'allow3pidLogin': instance.allow3pidLogin,
    };
