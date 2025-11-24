// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_selector_filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:watch_it/watch_it.dart';

class PupilProxy with ChangeNotifier {
  PupilProxy({
    required PupilData pupilData,
    required PupilIdentity pupilIdentity,
  }) : _pupilIdentity = pupilIdentity {
    updatePupil(pupilData);
  }

  static List<Filter<Object>> groupFilters = di<PupilsFilter>().groupFilters;

  static List<SchoolGradeFilter> schoolGradeFilters = [
    SchoolGradeFilter(SchoolGrade.E1),
    SchoolGradeFilter(SchoolGrade.E2),
    SchoolGradeFilter(SchoolGrade.E3),
    SchoolGradeFilter(SchoolGrade.K3),
    SchoolGradeFilter(SchoolGrade.K4),
  ];

  static List<GenderFilter> genderFilters = [
    GenderFilter(Gender.male),
    GenderFilter(Gender.female),
  ];

  static List<ReligionCourseFilter> religionCourseFilters = [
    ReligionCourseFilter(ReligionCourse.islam),
    ReligionCourseFilter(ReligionCourse.catholic),
    ReligionCourseFilter(ReligionCourse.none),
  ];

  late PupilData _pupilData;
  PupilIdentity _pupilIdentity;

  bool pupilIsDirty = false;

  void updatePupil(PupilData pupilData) {
    //- TODO ADVICE: Would it make sense?
    //if (pupilData == _pupilData) return;
    _pupilData = pupilData;
    // ignore: prefer_for_elements_to_map_fromiterable
    // _missedSchooldays = Map.fromIterable(pupilData.missedSchooldays,
    //     key: (e) => e.missedDay, value: (e) => e);

    pupilIsDirty = true;
    notifyListeners();
  }

  void updatePupilIdentity(PupilIdentity pupilIdentity) {
    if (_pupilIdentity != pupilIdentity) {
      _pupilIdentity = pupilIdentity;
      pupilIsDirty = true;
      notifyListeners();
    }
  }

  //- PupilIdentity GETTERS

  String get firstName => _pupilIdentity.firstName;
  String get lastName => _pupilIdentity.lastName;

  String get group => _pupilIdentity.group;
  String get groupId => _pupilIdentity.group;

  SchoolGrade get schoolGrade => _pupilIdentity.schoolGrade;

  String? get specialNeeds => _pupilIdentity.specialNeeds;
  String get gender => _pupilIdentity.gender;
  String get language => _pupilIdentity.language;
  String? get family => _pupilIdentity.family;
  DateTime get birthday => _pupilIdentity.birthday;
  int get age {
    final today = DateTime.now().toUtc();
    int age = today.year - _pupilIdentity.birthday.year;
    if (today.month < _pupilIdentity.birthday.month ||
        (today.month == _pupilIdentity.birthday.month &&
            today.day < _pupilIdentity.birthday.day)) {
      age--;
    }
    return age;
  }

  String? get groupTutor => _pupilIdentity.groupTutor;

  DateTime? get migrationSupportEnds => _pupilIdentity.migrationSupportEnds;
  DateTime get pupilSince => _pupilIdentity.pupilSince;

  DateTime? get familyLanguageLessonsSince =>
      _pupilIdentity.familyLanguageLessonsSince;
  DateTime? get religionLessonsSince => _pupilIdentity.religionLessonsSince;

  String? get religion => _pupilIdentity.religion;
  //- PUPIL DATA GETTERS

  int get pupilId => _pupilData.id!;
  PupilStatus get active => _pupilData.status;
  int get internalId => _pupilData.internalId;

  // preschool related
  PreSchoolMedical? get preSchoolMedical => _pupilData.preSchoolMedical;
  Kindergarden? get kindergarden => _pupilData.kindergarden;
  KindergardenInfo? get kindergardenInfo => _pupilData.kindergardenData;
  PreSchoolTest? get preSchoolTest => _pupilData.preSchoolTest;

  // avatar related

  HubDocument? get avatar => _pupilData.avatar;
  int? get avatarId => _pupilData.avatarId;
  HubDocument? get avatarAuth => _pupilData.avatarAuth;
  int? get avatarAuthId => _pupilData.avatarAuthId;

  // public media related
  PublicMediaAuth get publicMediaAuth => _pupilData.publicMediaAuth;
  HubDocument? get publicMediaAuthDocument =>
      _pupilData.publicMediaAuthDocument;
  int? get publicMediaAuthDocumentId => _pupilData.publicMediaAuthDocumentId;

  // Communication and tutor related
  String? get contact => _pupilData.contact;

  CommunicationSkills? get communicationPupil => _pupilData.communicationPupil;

  String? get specialInformation => _pupilData.specialInformation;

  TutorInfo? get tutorInfo => _pupilData.tutorInfo;

  List<PupilAuthorization>? get authorizations => _pupilData.authorizations;

  // after school care related

  AfterSchoolCare? get afterSchoolCare => _pupilData.afterSchoolCare;

  // Legacy OGS getters for backward compatibility
  // TODO URGENT: Remove these after migrating all OGS code to use proper afterSchoolCare model
  bool get ogs => afterSchoolCare != null;

  String? pickUpTime(AfterSchoolCareWeekday weekday) {
    final pickUpTimes = afterSchoolCare?.pickUpTimes;
    if (pickUpTimes == null) return null;

    switch (weekday) {
      case AfterSchoolCareWeekday.monday:
        return pickUpTimes.monday?.time;
      case AfterSchoolCareWeekday.tuesday:
        return pickUpTimes.tuesday?.time;
      case AfterSchoolCareWeekday.wednesday:
        return pickUpTimes.wednesday?.time;
      case AfterSchoolCareWeekday.thursday:
        return pickUpTimes.thursday?.time;
      case AfterSchoolCareWeekday.friday:
        return pickUpTimes.friday?.time;
    }
  }

  String? get ogsInfo => afterSchoolCare?.afterSchoolCareInfo;

  // rewards related

  int get credit => _pupilData.credit;

  int get creditEarned => _pupilData.creditEarned;

  List<CreditTransaction>? get creditTransactions =>
      _pupilData.creditTransactions;

  // learning related

  DateTime? get schoolyearHeldBackAt => _pupilData.schoolyearHeldBackAt;

  List<CompetenceCheck>? get competenceChecks => _pupilData.competenceChecks;

  List<CompetenceGoal>? get competenceGoals => _pupilData.competenceGoals;

  List<PupilWorkbook>? get pupilWorkbooks => _pupilData.pupilWorkbooks;

  List<PupilBookLending>? get pupilBookLendings => _pupilData.pupilBookLendings;

  // learning support related

  SupportLevel? get latestSupportLevel {
    final history = _pupilData.supportLevelHistory;
    if (history == null || history.isEmpty) {
      return null;
    }

    // Sort by created date in descending order (newest first)
    history.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return history.first;
  }

  List<SupportLevel>? get supportLevelHistory => _pupilData.supportLevelHistory;

  List<SupportCategoryStatus>? get supportCategoryStatuses =>
      _pupilData.supportCategoryStatuses;

  List<SupportGoal>? get supportGoals => _pupilData.supportGoals;

  List<LearningSupportPlan>? get learningSupportPlans =>
      _pupilData.learningSupportPlans;

  // schoolday related

  List<MissedSchoolday>? get missedSchooldays => _pupilData.missedSchooldays;
  List<SchooldayEvent>? get schooldayEvents => _pupilData.schooldayEvents;
}
