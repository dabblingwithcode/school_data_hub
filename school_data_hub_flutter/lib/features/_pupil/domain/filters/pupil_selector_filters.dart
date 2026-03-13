import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_helper.dart';

class SchoolGradeFilter extends SelectorFilter<PupilProxy, SchoolGrade> {
  SchoolGradeFilter(SchoolGrade schoolGrade)
    : super(name: schoolGrade.name, selector: (proxy) => proxy.schoolGrade);

  @override
  bool matches(PupilProxy item) {
    return selector(item).name == name;
  }
}

class ReligionCourseFilter extends SelectorFilter<PupilProxy, ReligionCourse> {
  ReligionCourseFilter(ReligionCourse religion)
    : super(
        name: religion.value,
        selector: (proxy) =>
            ReligionCourse.stringToValue[proxy.religion!] ??
            ReligionCourse.none,
      );

  @override
  bool matches(PupilProxy item) {
    return (selector(item).value == name) &&
        (item.religionLessonsSince != null &&
            item.religionLessonsSince != null);
  }
}

class FamilyLanguageFilter extends SelectorFilter<PupilProxy, FamilyLanguage> {
  FamilyLanguageFilter(FamilyLanguage familyLanguage)
    : super(
        name: familyLanguage.value,
        selector: (proxy) =>
            FamilyLanguage.stringToValue[proxy.language] ??
            FamilyLanguage.other,
      );

  @override
  bool matches(PupilProxy item) {
    return selector(item).value == name;
  }
}

class GroupFilter extends SelectorFilter<PupilProxy, String> {
  GroupFilter(String group)
    : super(name: group, selector: (proxy) => proxy.groupId);

  @override
  bool matches(PupilProxy item) {
    return selector(item) == name;
  }
}

class GenderFilter extends SelectorFilter<PupilProxy, Gender> {
  GenderFilter(Gender gender)
    : super(
        name: gender.value == 'm' ? '♂️' : '♀️',
        selector: (proxy) => Gender.stringToValue[proxy.gender]!,
      );

  @override
  bool matches(PupilProxy item) {
    return selector(item).value == (name == '♂️' ? 'm' : 'w');
  }
}

class AfterSchoolCareFilter extends Filter<PupilProxy> {
  final bool hasAfterSchoolCare;
  AfterSchoolCareFilter({required this.hasAfterSchoolCare})
    : super(name: hasAfterSchoolCare ? 'OGS' : 'nicht OGS');

  @override
  bool matches(PupilProxy item) => hasAfterSchoolCare
      ? item.afterSchoolCare != null
      : item.afterSchoolCare == null;
}

class MigrationSupportFilter extends Filter<PupilProxy> {
  MigrationSupportFilter() : super(name: 'Erstförderung');

  @override
  bool matches(PupilProxy item) =>
      PupilProxyHelper.hasLanguageSupport(item.migrationSupportEnds);
}
