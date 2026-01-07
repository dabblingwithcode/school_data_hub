import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

extension PupilIdentityExtension on PupilIdentity {
  String toTextLine() {
    final migrationSupportEnds = this.migrationSupportEnds != null
        ? this.migrationSupportEnds!.formatDateForJson()
        : '';

    final specialNeeds = this.specialNeeds ?? '';

    return [
      id.toString(),
      firstName,
      lastName,
      group,
      groupTutor,
      schoolGrade,
      specialNeeds,
      '', // this is a placeholder for the second special needs field in the administrative data source
      gender,
      language,
      family ?? '',
      birthday.formatDateForJson(normalizeUtc: false),
      migrationSupportEnds,
      pupilSince.formatDateForJson(normalizeUtc: false),
      afterSchoolCare ? 'OFFGANZ' : '',
      religion ?? '',
      religionLessonsSince?.formatDateForJson(normalizeUtc: false) ?? '',
      religionLessonsCancelledAt?.formatDateForJson(normalizeUtc: false) ?? '',
      familyLanguageLessonsSince?.formatDateForJson(normalizeUtc: false) ?? '',
      leavingDate?.formatDateForJson(normalizeUtc: false) ?? '',
    ].join(',');
  }

  bool isEqual(PupilIdentity other) {
    return id == other.id &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        group == other.group &&
        groupTutor == other.groupTutor &&
        schoolGrade == other.schoolGrade &&
        specialNeeds == other.specialNeeds &&
        gender == other.gender &&
        language == other.language &&
        family == other.family &&
        birthday == other.birthday &&
        migrationSupportEnds == other.migrationSupportEnds &&
        pupilSince == other.pupilSince &&
        afterSchoolCare == other.afterSchoolCare &&
        religion == other.religion &&
        religionLessonsSince == other.religionLessonsSince &&
        religionLessonsCancelledAt == other.religionLessonsCancelledAt &&
        familyLanguageLessonsSince == other.familyLanguageLessonsSince &&
        leavingDate == other.leavingDate;
  }
}
