import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

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
