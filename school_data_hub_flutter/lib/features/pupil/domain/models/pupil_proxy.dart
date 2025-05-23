// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_selector_filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_identity.dart';
import 'package:watch_it/watch_it.dart';

enum SchoolGrade {
  E1('E1'),
  E2('E2'),
  E3('E3'),
  S3('S3'),
  S4('S4');

  static const stringToValue = {
    'E1': SchoolGrade.E1,
    'E2': SchoolGrade.E2,
    'E3': SchoolGrade.E3,
    'S3': SchoolGrade.S3,
    'S4': SchoolGrade.S4,
  };

  final String value;
  const SchoolGrade(this.value);
}

enum Gender {
  male('m'),
  female('w');

  static const stringToValue = {
    'm': Gender.male,
    'w': Gender.female,
  };

  final String value;
  const Gender(this.value);
}

class PupilProxy with ChangeNotifier {
  PupilProxy(
      {required PupilData pupilData, required PupilIdentity pupilIdentity})
      : _pupilIdentity = pupilIdentity {
    updatePupil(pupilData);
  }

  static List<Filter<Object>> groupFilters = di<PupilsFilter>().groupFilters;

  static List<SchoolGradeFilter> schoolGradeFilters = [
    SchoolGradeFilter(SchoolGrade.E1),
    SchoolGradeFilter(SchoolGrade.E2),
    SchoolGradeFilter(SchoolGrade.E3),
    SchoolGradeFilter(SchoolGrade.S3),
    SchoolGradeFilter(SchoolGrade.S4),
  ];

  static List<GenderFilter> genderFilters = [
    GenderFilter(Gender.male),
    GenderFilter(Gender.female),
  ];

  late PupilData _pupilData;
  PupilIdentity _pupilIdentity;

  bool pupilIsDirty = false;

  void updatePupil(PupilData pupilData) {
    //if (pupilData == _pupilData) return;
    _pupilData = pupilData;
    // ignore: prefer_for_elements_to_map_fromiterable
    // _missedClasses = Map.fromIterable(pupilData.missedClasses,
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

  // void updateFromMissedClassesOnASchoolday(
  //     List<MissedClass> allMissedClassesThisDay) {
  //   pupilIsDirty = false;

  //   if (allMissedClassesThisDay
  //       .any((missedClass) => missedClass.pupilId == _pupilData.internalId)) {
  //     final missedClass = allMissedClassesThisDay.firstWhere(
  //         (missedClass) => missedClass.pupilId == _pupilData.internalId);
  //     // if the missed class is not already in the missed classes
  //     // or if the missed class is different from the one in the missed classes
  //     // write it
  //     if (!_missedClasses.containsKey(missedClass.schoolday!.schoolday) ||
  //         !(_missedClasses[missedClass.schoolday!.schoolday] == missedClass)) {
  //       _missedClasses[missedClass.schoolday!.schoolday] = missedClass;
  //       pupilIsDirty = true;
  //     }
  //   } else {
  //     // there is no missed class for this pupil on this date
  //     // if there is a missed class for this date in the pupil's missed classes in memory
  //     // remove it
  //     if (_missedClasses.containsKey(_schooldayManager.thisDate.value)) {
  //       _missedClasses.remove(di<SchooldayManager>().thisDate.value);
  //       pupilIsDirty = true;
  //     }
  //   }

  //   if (pupilIsDirty) {
  //     notifyListeners();
  //   }
  // }

  String get firstName => _pupilIdentity.firstName;
  String get lastName => _pupilIdentity.lastName;

  String get group => _pupilIdentity.group;
  String get groupId => _pupilIdentity.group;

  SchoolGrade get schoolGrade =>
      SchoolGrade.stringToValue[_pupilIdentity.schoolGrade]!;

  String get schoolyear => _pupilIdentity.schoolGrade;
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

  DateTime? get migrationSupportEnds => _pupilIdentity.migrationSupportEnds;
  DateTime get pupilSince => _pupilIdentity.pupilSince;

  //- PUPIL DATA GETTERS

  int get pupilId => _pupilData.id!;
  bool get active => _pupilData.active;
  int get internalId => _pupilData.internalId;

  // preschool related
  PreSchoolMedical? get preSchoolMedical => _pupilData.preSchoolMedical;
  String? get kindergarden => _pupilData.kindergarden;
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

  List<PupilBookLending>? get pupilBooks => _pupilData.pupilBookLendings;

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

// schoolday related

  List<SchooldayEvent>? get schooldayEvents => _pupilData.schooldayEvents;
}
