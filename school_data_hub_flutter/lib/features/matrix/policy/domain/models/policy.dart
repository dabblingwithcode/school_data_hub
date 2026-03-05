// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/hook.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';

import 'flags.dart';

part 'policy.g.dart';

@JsonSerializable()
class Policy {
  final int schemaVersion;
  final String? identificationStamp;
  final MatrixPolicyFlags flags;
  final List<Hook>? hooks;
  final List<String> managedRoomIds;

  @JsonKey(name: 'users')
  final List<MatrixUser> matrixUsers;

  factory Policy.fromJson(Map<String, dynamic> json) => _$PolicyFromJson(json);

  Map<String, dynamic> toJson() => _$PolicyToJson(this);

  /// Builds [List<MatrixUser>] from a list of user JSON maps using the same
  /// [MatrixUser] type as this library. Use when passing users from the
  /// manager into [copyWith] to avoid cross-library type mismatch.
  static List<MatrixUser> matrixUsersFromJsonMaps(List<dynamic> jsonMaps) {
    return jsonMaps
        .map((e) => MatrixUser.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Policy copyWith({
    int? schemaVersion,
    String? identificationStamp,
    MatrixPolicyFlags? flags,
    List<Hook>? hooks,
    List<String>? managedRoomIds,
    List<MatrixUser>? matrixUsers,
  }) => Policy(
    schemaVersion: schemaVersion ?? this.schemaVersion,
    identificationStamp: identificationStamp as String?,
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
