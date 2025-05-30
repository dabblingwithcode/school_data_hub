// // ignore_for_file: invalid_annotation_target

// import 'package:json_annotation/json_annotation.dart';
// import 'package:school_data_hub_flutter/app_utils/extensions.dart';

// part 'pupil_identity.g.dart';

// @JsonSerializable()
// class PupilIdentity {
//   @JsonKey(name: "id")
//   final int id;
//   @JsonKey(name: "name")
//   final String firstName;
//   @JsonKey(name: "lastName")
//   final String lastName;
//   @JsonKey(name: "group")
//   final String group;
//   @JsonKey(name: "schoolyear")
//   final String schoolGrade;
//   @JsonKey(name: "specialNeeds")
//   final String? specialNeeds;
//   @JsonKey(name: "gender")
//   final String gender;
//   @JsonKey(name: "language")
//   final String language;
//   @JsonKey(name: "family")
//   final String? family;
//   @JsonKey(name: "birthday")
//   final DateTime birthday;
//   @JsonKey(name: "migrationSupportEnds")
//   final DateTime? migrationSupportEnds;
//   @JsonKey(name: "pupilSince")
//   final DateTime pupilSince;
//   @JsonKey(name: "afterSchoolCare")
//   final bool? afterSchoolCare;
//   @JsonKey(name: "leavingDate")
//   final DateTime? leavingDate;
//   @JsonKey(name: "religion")
//   final int? religion;
//   @JsonKey(name: "religionLessons")
//   final bool? religionLessons;

//   factory PupilIdentity.fromJson(Map<String, dynamic> json) =>
//       _$PupilIdentityFromJson(json);

//   Map<String, dynamic> toJson() => _$PupilIdentityToJson(this);

//   PupilIdentity({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.group,
//     required this.schoolGrade,
//     required this.gender,
//     required this.language,
//     required this.family,
//     required this.birthday,
//     required this.pupilSince,
//     this.specialNeeds,
//     required this.migrationSupportEnds,
//     required this.afterSchoolCare,
//     this.leavingDate,
//     this.religion,
//     this.religionLessons,
//   });

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is PupilIdentity &&
//         other.id == id &&
//         other.firstName == firstName &&
//         other.lastName == lastName &&
//         other.group == group &&
//         other.schoolGrade == schoolGrade &&
//         other.specialNeeds == specialNeeds &&
//         other.gender == gender &&
//         other.language == language &&
//         other.family == family &&
//         other.birthday.isSameDate(birthday) &&
//         (other.migrationSupportEnds
//                 ?.isSameDate(migrationSupportEnds ?? DateTime(0)) ??
//             migrationSupportEnds == null) &&
//         other.pupilSince.isSameDate(pupilSince) &&
//         other.afterSchoolCare == afterSchoolCare &&
//         (other.leavingDate?.isSameDate(leavingDate ?? DateTime(0)) ??
//             leavingDate == null) &&
//         other.religion == religion &&
//         other.religionLessons == religionLessons;
//   }

//   @override
//   int get hashCode => Object.hash(
//         id,
//         firstName,
//         lastName,
//         group,
//         schoolGrade,
//         specialNeeds,
//         gender,
//         language,
//         family,
//         birthday,
//         migrationSupportEnds,
//         pupilSince,
//         afterSchoolCare,
//         leavingDate,
//         religion,
//         religionLessons,
//       );
// }
