// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/pupil_authorization.dart';

part 'authorization.g.dart';

@JsonSerializable()
class Authorization {
  @JsonKey(name: "authorization_description")
  final String authorizationDescription;
  @JsonKey(name: "authorization_id")
  final String authorizationId;
  @JsonKey(name: "authorization_name")
  final String authorizationName;
  @JsonKey(name: "created_by")
  final String? createdBy;
  @JsonKey(name: "authorized_pupils")
  final List<PupilAuthorization> authorizedPupils;

  factory Authorization.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizationToJson(this);

  Authorization(
      {required this.authorizationDescription,
      required this.authorizationId,
      required this.authorizationName,
      required this.createdBy,
      required this.authorizedPupils});
}
