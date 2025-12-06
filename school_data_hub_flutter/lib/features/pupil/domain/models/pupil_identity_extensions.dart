import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

extension PupilIdentityExtension on PupilIdentity {
  String toTextLine() {
    final migrationSupportEnds = this.migrationSupportEnds != null
        ? this.migrationSupportEnds!.formatDateForJson()
        : '';

    final specialNeeds = this.specialNeeds ?? '';

    return [
      this.id.toString(),
      this.firstName,
      this.lastName,
      this.group,
      this.groupTutor,
      this.schoolGrade,
      specialNeeds,
      '', // this is a placeholder for the second special needs field in the administrative data source
      this.gender,
      this.language,
      this.family ?? '',
      this.birthday.formatDateForJson(),
      migrationSupportEnds,
      this.pupilSince.formatDateForJson(),
      this.afterSchoolCare ? 'OFFGANZ' : '',
      this.religion ?? '',
      this.religionLessonsSince?.formatDateForJson() ?? '',
      this.religionLessonsCancelledAt?.formatDateForJson() ?? '',
      this.familyLanguageLessonsSince?.formatDateForJson() ?? '',
      this.leavingDate?.formatDateForJson() ?? '',
    ].join(',');
  }

  bool isEqual(PupilIdentity other) {
    return this.id == other.id &&
        this.firstName == other.firstName &&
        this.lastName == other.lastName &&
        this.group == other.group &&
        this.groupTutor == other.groupTutor &&
        this.schoolGrade == other.schoolGrade &&
        this.specialNeeds == other.specialNeeds &&
        this.gender == other.gender &&
        this.language == other.language &&
        this.family == other.family &&
        this.birthday == other.birthday &&
        this.migrationSupportEnds == other.migrationSupportEnds &&
        this.pupilSince == other.pupilSince &&
        this.afterSchoolCare == other.afterSchoolCare &&
        this.religion == other.religion &&
        this.religionLessonsSince == other.religionLessonsSince &&
        this.religionLessonsCancelledAt == other.religionLessonsCancelledAt &&
        this.familyLanguageLessonsSince == other.familyLanguageLessonsSince &&
        this.leavingDate == other.leavingDate;
  }
}
