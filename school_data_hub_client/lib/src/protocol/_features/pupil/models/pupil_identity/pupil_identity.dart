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
import '../../../../_features/pupil/models/pupil_identity/school_grade.dart'
    as _i2;

abstract class PupilIdentity implements _i1.SerializableModel {
  PupilIdentity._({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.group,
    required this.groupTutor,
    this.deputyGroupTutor,
    required this.schoolGrade,
    this.specialNeeds,
    required this.gender,
    required this.language,
    this.nationality,
    this.family,
    required this.birthday,
    this.migrationSupportEnds,
    required this.pupilSince,
    required this.afterSchoolCare,
    this.religion,
    this.religionLessonsSince,
    this.religionLessonsCancelledAt,
    this.familyLanguageLessonsSince,
    this.leavingDate,
    this.schoolTransitionRecommendation,
  });

  factory PupilIdentity({
    required int id,
    required String firstName,
    required String lastName,
    required String group,
    required String groupTutor,
    String? deputyGroupTutor,
    required _i2.SchoolGrade schoolGrade,
    List<String>? specialNeeds,
    required String gender,
    required String language,
    String? nationality,
    String? family,
    required DateTime birthday,
    DateTime? migrationSupportEnds,
    required DateTime pupilSince,
    required bool afterSchoolCare,
    String? religion,
    DateTime? religionLessonsSince,
    DateTime? religionLessonsCancelledAt,
    DateTime? familyLanguageLessonsSince,
    DateTime? leavingDate,
    String? schoolTransitionRecommendation,
  }) = _PupilIdentityImpl;

  factory PupilIdentity.fromJson(Map<String, dynamic> jsonSerialization) {
    return PupilIdentity(
      id: jsonSerialization['id'] as int,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      group: jsonSerialization['group'] as String,
      groupTutor: jsonSerialization['groupTutor'] as String,
      deputyGroupTutor: jsonSerialization['deputyGroupTutor'] as String?,
      schoolGrade: _i2.SchoolGrade.fromJson(
          (jsonSerialization['schoolGrade'] as String)),
      specialNeeds: (jsonSerialization['specialNeeds'] as List?)
          ?.map((e) => e as String)
          .toList(),
      gender: jsonSerialization['gender'] as String,
      language: jsonSerialization['language'] as String,
      nationality: jsonSerialization['nationality'] as String?,
      family: jsonSerialization['family'] as String?,
      birthday:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['birthday']),
      migrationSupportEnds: jsonSerialization['migrationSupportEnds'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['migrationSupportEnds']),
      pupilSince:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['pupilSince']),
      afterSchoolCare: jsonSerialization['afterSchoolCare'] as bool,
      religion: jsonSerialization['religion'] as String?,
      religionLessonsSince: jsonSerialization['religionLessonsSince'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['religionLessonsSince']),
      religionLessonsCancelledAt:
          jsonSerialization['religionLessonsCancelledAt'] == null
              ? null
              : _i1.DateTimeJsonExtension.fromJson(
                  jsonSerialization['religionLessonsCancelledAt']),
      familyLanguageLessonsSince:
          jsonSerialization['familyLanguageLessonsSince'] == null
              ? null
              : _i1.DateTimeJsonExtension.fromJson(
                  jsonSerialization['familyLanguageLessonsSince']),
      leavingDate: jsonSerialization['leavingDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['leavingDate']),
      schoolTransitionRecommendation:
          jsonSerialization['schoolTransitionRecommendation'] as String?,
    );
  }

  int id;

  String firstName;

  String lastName;

  String group;

  String groupTutor;

  String? deputyGroupTutor;

  _i2.SchoolGrade schoolGrade;

  List<String>? specialNeeds;

  String gender;

  String language;

  String? nationality;

  String? family;

  DateTime birthday;

  DateTime? migrationSupportEnds;

  DateTime pupilSince;

  bool afterSchoolCare;

  String? religion;

  DateTime? religionLessonsSince;

  DateTime? religionLessonsCancelledAt;

  DateTime? familyLanguageLessonsSince;

  DateTime? leavingDate;

  String? schoolTransitionRecommendation;

  /// Returns a shallow copy of this [PupilIdentity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PupilIdentity copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? group,
    String? groupTutor,
    String? deputyGroupTutor,
    _i2.SchoolGrade? schoolGrade,
    List<String>? specialNeeds,
    String? gender,
    String? language,
    String? nationality,
    String? family,
    DateTime? birthday,
    DateTime? migrationSupportEnds,
    DateTime? pupilSince,
    bool? afterSchoolCare,
    String? religion,
    DateTime? religionLessonsSince,
    DateTime? religionLessonsCancelledAt,
    DateTime? familyLanguageLessonsSince,
    DateTime? leavingDate,
    String? schoolTransitionRecommendation,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'group': group,
      'groupTutor': groupTutor,
      if (deputyGroupTutor != null) 'deputyGroupTutor': deputyGroupTutor,
      'schoolGrade': schoolGrade.toJson(),
      if (specialNeeds != null) 'specialNeeds': specialNeeds?.toJson(),
      'gender': gender,
      'language': language,
      if (nationality != null) 'nationality': nationality,
      if (family != null) 'family': family,
      'birthday': birthday.toJson(),
      if (migrationSupportEnds != null)
        'migrationSupportEnds': migrationSupportEnds?.toJson(),
      'pupilSince': pupilSince.toJson(),
      'afterSchoolCare': afterSchoolCare,
      if (religion != null) 'religion': religion,
      if (religionLessonsSince != null)
        'religionLessonsSince': religionLessonsSince?.toJson(),
      if (religionLessonsCancelledAt != null)
        'religionLessonsCancelledAt': religionLessonsCancelledAt?.toJson(),
      if (familyLanguageLessonsSince != null)
        'familyLanguageLessonsSince': familyLanguageLessonsSince?.toJson(),
      if (leavingDate != null) 'leavingDate': leavingDate?.toJson(),
      if (schoolTransitionRecommendation != null)
        'schoolTransitionRecommendation': schoolTransitionRecommendation,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PupilIdentityImpl extends PupilIdentity {
  _PupilIdentityImpl({
    required int id,
    required String firstName,
    required String lastName,
    required String group,
    required String groupTutor,
    String? deputyGroupTutor,
    required _i2.SchoolGrade schoolGrade,
    List<String>? specialNeeds,
    required String gender,
    required String language,
    String? nationality,
    String? family,
    required DateTime birthday,
    DateTime? migrationSupportEnds,
    required DateTime pupilSince,
    required bool afterSchoolCare,
    String? religion,
    DateTime? religionLessonsSince,
    DateTime? religionLessonsCancelledAt,
    DateTime? familyLanguageLessonsSince,
    DateTime? leavingDate,
    String? schoolTransitionRecommendation,
  }) : super._(
          id: id,
          firstName: firstName,
          lastName: lastName,
          group: group,
          groupTutor: groupTutor,
          deputyGroupTutor: deputyGroupTutor,
          schoolGrade: schoolGrade,
          specialNeeds: specialNeeds,
          gender: gender,
          language: language,
          nationality: nationality,
          family: family,
          birthday: birthday,
          migrationSupportEnds: migrationSupportEnds,
          pupilSince: pupilSince,
          afterSchoolCare: afterSchoolCare,
          religion: religion,
          religionLessonsSince: religionLessonsSince,
          religionLessonsCancelledAt: religionLessonsCancelledAt,
          familyLanguageLessonsSince: familyLanguageLessonsSince,
          leavingDate: leavingDate,
          schoolTransitionRecommendation: schoolTransitionRecommendation,
        );

  /// Returns a shallow copy of this [PupilIdentity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PupilIdentity copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? group,
    String? groupTutor,
    Object? deputyGroupTutor = _Undefined,
    _i2.SchoolGrade? schoolGrade,
    Object? specialNeeds = _Undefined,
    String? gender,
    String? language,
    Object? nationality = _Undefined,
    Object? family = _Undefined,
    DateTime? birthday,
    Object? migrationSupportEnds = _Undefined,
    DateTime? pupilSince,
    bool? afterSchoolCare,
    Object? religion = _Undefined,
    Object? religionLessonsSince = _Undefined,
    Object? religionLessonsCancelledAt = _Undefined,
    Object? familyLanguageLessonsSince = _Undefined,
    Object? leavingDate = _Undefined,
    Object? schoolTransitionRecommendation = _Undefined,
  }) {
    return PupilIdentity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      group: group ?? this.group,
      groupTutor: groupTutor ?? this.groupTutor,
      deputyGroupTutor: deputyGroupTutor is String?
          ? deputyGroupTutor
          : this.deputyGroupTutor,
      schoolGrade: schoolGrade ?? this.schoolGrade,
      specialNeeds: specialNeeds is List<String>?
          ? specialNeeds
          : this.specialNeeds?.map((e0) => e0).toList(),
      gender: gender ?? this.gender,
      language: language ?? this.language,
      nationality: nationality is String? ? nationality : this.nationality,
      family: family is String? ? family : this.family,
      birthday: birthday ?? this.birthday,
      migrationSupportEnds: migrationSupportEnds is DateTime?
          ? migrationSupportEnds
          : this.migrationSupportEnds,
      pupilSince: pupilSince ?? this.pupilSince,
      afterSchoolCare: afterSchoolCare ?? this.afterSchoolCare,
      religion: religion is String? ? religion : this.religion,
      religionLessonsSince: religionLessonsSince is DateTime?
          ? religionLessonsSince
          : this.religionLessonsSince,
      religionLessonsCancelledAt: religionLessonsCancelledAt is DateTime?
          ? religionLessonsCancelledAt
          : this.religionLessonsCancelledAt,
      familyLanguageLessonsSince: familyLanguageLessonsSince is DateTime?
          ? familyLanguageLessonsSince
          : this.familyLanguageLessonsSince,
      leavingDate: leavingDate is DateTime? ? leavingDate : this.leavingDate,
      schoolTransitionRecommendation: schoolTransitionRecommendation is String?
          ? schoolTransitionRecommendation
          : this.schoolTransitionRecommendation,
    );
  }
}
