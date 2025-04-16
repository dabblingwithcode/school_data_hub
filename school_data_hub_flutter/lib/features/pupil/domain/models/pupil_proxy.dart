// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_selector_filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_identity.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

final _schooldayManager = di<SchooldayManager>();

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

  //- TODO - remove this method

  void updatePupilIdentity(PupilIdentity pupilIdentity) {
    if (_pupilIdentity != pupilIdentity) {
      _pupilIdentity = pupilIdentity;
      pupilIsDirty = true;
      notifyListeners();
    }
  }

  void updatePupilIdentityFromMoreRecentSource(PupilIdentity pupilIdentity) {
    if (_pupilIdentity != pupilIdentity) {
      _pupilIdentity = pupilIdentity;
      pupilIsDirty = true;
      notifyListeners();
    }
  }

  void clearAvatar() {
    _avatarIdOverride = null;
    _avatarUpdated = true;
    pupilIsDirty = true;
    notifyListeners();
  }

  void updateFromMissedClassesOnASchoolday(
      List<MissedClass> allMissedClassesThisDay) {
    pupilIsDirty = false;

    if (allMissedClassesThisDay
        .any((missedClass) => missedClass.pupilId == _pupilData.internalId)) {
      final missedClass = allMissedClassesThisDay.firstWhere(
          (missedClass) => missedClass.pupilId == _pupilData.internalId);
      // if the missed class is not already in the missed classes
      // or if the missed class is different from the one in the missed classes
      // write it
      if (!_missedClasses.containsKey(missedClass.schoolday!.schoolday) ||
          !(_missedClasses[missedClass.schoolday!.schoolday] == missedClass)) {
        _missedClasses[missedClass.schoolday!.schoolday] = missedClass;
        pupilIsDirty = true;
      }
    } else {
      // there is no missed class for this pupil on this date
      // if there is a missed class for this date in the pupil's missed classes in memory
      // remove it
      if (_missedClasses.containsKey(_schooldayManager.thisDate.value)) {
        _missedClasses.remove(di<SchooldayManager>().thisDate.value);
        pupilIsDirty = true;
      }
    }

    if (pupilIsDirty) {
      notifyListeners();
    }
  }

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
    final today = DateTime.now();
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

  // TODO: This has to be checked, uncommented and tested

  String? _avatarIdOverride;
  bool _avatarUpdated = false;

  HubDocument? get avatar => _pupilData.avatar;
  // String? get avatarId =>
  //     _avatarUpdated ? _avatarIdOverride : _pupilData.avatarId;
  HubDocument? get avatarAuth => _pupilData.avatarAuth;
  // String? get avatarAuthId => _pupilData.avatarAuthId;
  // PublicMediaAuth get publicMediaAuth => _pupilData.publicMediaAuth;
  // String? get publicMediaAuthId => _pupilData.publicMediaAuthId;
  // String? get communicationPupil => _pupilData.communicationPupil;
  // String? get communicationTutor1 =>
  //     _pupilData.pupilDataParentInfo?.communicationTutor1;
  // String? get communicationTutor2 =>
  //     _pupilData.pupilDataParentInfo?.communicationTutor2;
  // String? get contact => _pupilData.contact;
  // String? get parentsContact => _pupilData.parentsContact;
  int get credit => _pupilData.credit;
  int get creditEarned => _pupilData.creditEarned;
  int get pupilId => _pupilData.id!;
  DateTime? get schoolyearHeldBackAt => _pupilData.schoolyearHeldBackAt;
  SupportLevel? get latestSupportLevel => _pupilData.latestSupportLevel;
  List<SupportLevel>? get supportLevelHistory => _pupilData.supportLevelHistory;
  int get internalId => _pupilData.internalId;
  AfterSchoolCare? get afterSchoolCare => _pupilData.afterSchoolCare;

  // PreSchoolRevision? get preschoolRevision => _pupilData.preSchoolRevision;
  String? get specialInformation => _pupilData.specialInformation;

  List<CompetenceCheck>? get competenceChecks => _pupilData.competenceChecks;
  List<SupportCategoryStatus>? get supportCategoryStatuses =>
      _pupilData.supportCategoryStatuses;
  List<SchooldayEvent>? get schooldayEvents => _pupilData.schooldayEvents;
  List<PupilBookLending>? get pupilBooks => _pupilData.pupilBookLendings;
  List<SupportGoal>? get supportGoals => _pupilData.supportGoals;

  List<MissedClass>? get missedClasses => _missedClasses.values.toList();
  Map<DateTime, MissedClass> _missedClasses = {};

  List<PupilWorkbook>? get pupilWorkbooks => _pupilData.pupilWorkbooks;
  List<CreditTransaction>? get creditTransactions =>
      _pupilData.creditTransactions;
  List<CompetenceGoal>? get competenceGoals => _pupilData.competenceGoals;
}
