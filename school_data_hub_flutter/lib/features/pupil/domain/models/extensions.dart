import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/datetime_extensions.dart';

extension PupilIdentityExtensions on PupilIdentity {
  bool isEqualTo(PupilIdentity other) {
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
        birthday.isSameDate(other.birthday) &&
        (migrationSupportEnds == other.migrationSupportEnds ||
            (migrationSupportEnds != null &&
                other.migrationSupportEnds != null &&
                migrationSupportEnds!.isSameDate(
                  other.migrationSupportEnds!,
                ))) &&
        pupilSince.isSameDate(other.pupilSince) &&
        afterSchoolCare == other.afterSchoolCare &&
        religion == other.religion &&
        (religionLessonsSince == other.religionLessonsSince ||
            (religionLessonsSince != null &&
                other.religionLessonsSince != null &&
                religionLessonsSince!.isSameDate(
                  other.religionLessonsSince!,
                ))) &&
        (familyLanguageLessonsSince == other.familyLanguageLessonsSince ||
            (familyLanguageLessonsSince != null &&
                other.familyLanguageLessonsSince != null &&
                familyLanguageLessonsSince!.isSameDate(
                  other.familyLanguageLessonsSince!,
                ))) &&
        (leavingDate == other.leavingDate ||
            (leavingDate != null &&
                other.leavingDate != null &&
                leavingDate!.isSameDate(other.leavingDate!)));
  }
}
