import 'package:collection/collection.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

extension PupilIdentityExtension on PupilIdentity {
  String toTextLine() {
    final migrationSupportEnds = this.migrationSupportEnds != null
        ? this.migrationSupportEnds!.formatDateForJson()
        : '';

    final sn = specialNeeds;
    final specialNeeds1 = sn != null && sn.isNotEmpty ? sn.first : '';
    final specialNeeds2 = sn != null && sn.length > 1 ? sn[1] : '';

    return [
      id.toString(),
      firstName,
      lastName,
      group,
      groupTutor,
      schoolGrade,
      specialNeeds1,
      specialNeeds2,
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
      deputyGroupTutor ?? '',
      nationality ?? '',
      schoolTransitionRecommendation ?? '',
    ].join(',');
  }

  bool isEqual(PupilIdentity other) {
    return id == other.id &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        group == other.group &&
        groupTutor == other.groupTutor &&
        deputyGroupTutor == other.deputyGroupTutor &&
        schoolGrade == other.schoolGrade &&
        const ListEquality<String>().equals(specialNeeds, other.specialNeeds) &&
        gender == other.gender &&
        language == other.language &&
        nationality == other.nationality &&
        family == other.family &&
        birthday == other.birthday &&
        migrationSupportEnds == other.migrationSupportEnds &&
        pupilSince == other.pupilSince &&
        afterSchoolCare == other.afterSchoolCare &&
        religion == other.religion &&
        religionLessonsSince == other.religionLessonsSince &&
        religionLessonsCancelledAt == other.religionLessonsCancelledAt &&
        familyLanguageLessonsSince == other.familyLanguageLessonsSince &&
        leavingDate == other.leavingDate &&
        schoolTransitionRecommendation == other.schoolTransitionRecommendation;
  }
}
