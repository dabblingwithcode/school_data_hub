// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/hook.dart';

import 'flags.dart';
import 'matrix_user.dart';

part 'policy.g.dart';

@JsonSerializable()
class Policy {
  final int schemaVersion;
  final String? identificationStamp;
  final Flags flags;
  final List<Hook>? hooks;
  final List<String> managedRoomIds;

  @JsonKey(name: 'users')
  final List<MatrixUser>? matrixUsers;

  factory Policy.fromJson(Map<String, dynamic> json) => _$PolicyFromJson(json);

  Map<String, dynamic> toJson() => _$PolicyToJson(this);

  Policy copyWith(
          {int? schemaVersion,
          dynamic identificationStamp,
          Flags? flags,
          List<Hook>? hooks,
          List<String>? managedRoomIds,
          List<MatrixUser>? matrixUsers}) =>
      Policy(
        schemaVersion: schemaVersion ?? this.schemaVersion,
        identificationStamp: identificationStamp ?? this.identificationStamp,
        flags: flags ?? this.flags,
        hooks: hooks ?? this.hooks,
        managedRoomIds: managedRoomIds ?? this.managedRoomIds,
        matrixUsers: matrixUsers ?? this.matrixUsers,
      );

  Policy({
    required this.schemaVersion,
    required this.identificationStamp,
    required this.flags,
    required this.hooks,
    required this.matrixUsers,
    required this.managedRoomIds,
  });
}
