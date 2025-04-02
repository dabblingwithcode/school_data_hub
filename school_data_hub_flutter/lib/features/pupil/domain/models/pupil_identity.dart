// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'pupil_identity.g.dart';

@JsonSerializable()
class PupilIdentity {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String firstName;
  @JsonKey(name: "lastName")
  final String lastName;
  @JsonKey(name: "group")
  final String group;
  @JsonKey(name: "schoolyear")
  final String schoolGrade;
  @JsonKey(name: "specialNeeds")
  final String? specialNeeds;
  @JsonKey(name: "gender")
  final String gender;
  @JsonKey(name: "language")
  final String language;
  @JsonKey(name: "family")
  final String? family;
  @JsonKey(name: "birthday")
  final DateTime birthday;
  @JsonKey(name: "migrationSupportEnds")
  final DateTime? migrationSupportEnds;
  @JsonKey(name: "pupilSince")
  final DateTime pupilSince;

  factory PupilIdentity.fromJson(Map<String, dynamic> json) =>
      _$PupilIdentityFromJson(json);

  Map<String, dynamic> toJson() => _$PupilIdentityToJson(this);

  PupilIdentity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.group,
    required this.schoolGrade,
    required this.gender,
    required this.language,
    required this.family,
    required this.birthday,
    required this.pupilSince,
    required this.specialNeeds,
    required this.migrationSupportEnds,
  });
}
