// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_selector_filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_identity_extensions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:watch_it/watch_it.dart';

typedef SiblingsResolver = List<PupilProxy> Function(PupilProxy pupil);

final _log = Logger('PupilProxy');

class PupilProxy with ChangeNotifier {
  PupilProxy({
    required PupilData pupilData,
    required PupilIdentity pupilIdentity,
    SiblingsResolver? siblingsResolver,
  }) : _pupilIdentity = pupilIdentity {
    _siblingsResolver = siblingsResolver;
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

  static List<FamilyLanguageFilter> familyLanguageFilters = [
    FamilyLanguageFilter(FamilyLanguage.turkish),
    FamilyLanguageFilter(FamilyLanguage.arabic),
    FamilyLanguageFilter(FamilyLanguage.albanian),
    FamilyLanguageFilter(FamilyLanguage.other),
  ];

  late PupilData _pupilData;
  PupilIdentity _pupilIdentity;

  SiblingsResolver? _siblingsResolver;
  List<PupilProxy>? _cachedSiblings;
  List<int>? _cachedSiblingIds;
  String? _cachedFamilyKey;

  bool pupilIsDirty = false;

  void updatePupil(PupilData pupilData) {
    // TODO: Revisit for equality check
    _pupilData = pupilData;

    pupilIsDirty = true;
    notifyListeners();
  }

  void updatePupilIdentity(PupilIdentity pupilIdentity) {
    if (!_pupilIdentity.isEqual(pupilIdentity)) _pupilIdentity = pupilIdentity;
    pupilIsDirty = true;
    notifyListeners();
  }

  /// Cached siblings based on family identifier; resolves once per family value.
  List<PupilProxy> get siblings {
    _siblingsResolver ??= di<PupilProxyManager>().getSiblings;
    final resolver = _siblingsResolver;
    final familyValue = family;
    if (resolver == null || familyValue == null) {
      return const [];
    }

    if (_cachedSiblings != null && _cachedFamilyKey == familyValue) {
      return _cachedSiblings!;
    }

    final resolved = resolver(this);
    // Guard against accidental self-inclusion or mismatched families.
    final filtered = resolved
        .where((p) => p.pupilId != pupilId && p.family == family)
        .toList(growable: false);

    _cachedSiblings = filtered;
    _cachedSiblingIds = filtered.map((p) => p.pupilId).toList(growable: false);
    _cachedFamilyKey = familyValue;
    return filtered;
  }

  List<int> get siblingIds {
    if (_cachedSiblingIds != null && _cachedFamilyKey == family) {
      return _cachedSiblingIds!;
    }

    final resolved = siblings;
    if (_cachedSiblingIds != null && _cachedFamilyKey == family) {
      return _cachedSiblingIds!;
    }

    return resolved.map((p) => p.pupilId).toList(growable: false);
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

  bool get isBirthdayToday {
    final today = DateTime.now();
    return today.month == birthday.month && today.day == birthday.day;
  }

  int get age {
    final today = DateTime.now();
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
  DateTime? get religionLessonsCancelledAt =>
      _pupilIdentity.religionLessonsCancelledAt;

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

  String? get afterSchoolCareInfo => afterSchoolCare?.afterSchoolCareInfo;

  // rewards related

  int get credit => _pupilData.credit;

  int get creditEarned => _pupilData.creditEarned;

  List<CreditTransaction>? get creditTransactions =>
      _pupilData.creditTransactions;

  // learning related

  DateTime? get schoolyearHeldBackAt =>
      _pupilData.schoolyearHeldBackAt?.toLocal();

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

  List<MissedSchoolday>? get missedSchooldays =>
      di<AttendanceManager>().getAllPupilMissedSchooldays(pupilId);
  List<SchooldayEvent>? get schooldayEvents => _pupilData.schooldayEvents;
}
