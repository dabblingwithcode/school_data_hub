enum CommunicationSubject { pupil, tutor1, tutor2 }

enum PupilSortMode {
  sortByName,
  sortByMissedExcused,
  sortByMissedUnexcused,
  sortByContacted,
  sortByLate,
  sortByCredit,
  sortByCreditEarned,
  sortByGoneHome,
  sortBySchooldayEvents,
  sortByLastSchooldayEvent,
  sortByLastNonProcessedSchooldayEvent,
}

Map<PupilSortMode, bool> initialSortModeValues = {
  PupilSortMode.sortByName: true,
  PupilSortMode.sortByMissedExcused: false,
  PupilSortMode.sortByMissedUnexcused: false,
  PupilSortMode.sortByContacted: false,
  PupilSortMode.sortByLate: false,
  PupilSortMode.sortByCredit: false,
  PupilSortMode.sortByCreditEarned: false,
  PupilSortMode.sortByGoneHome: false,
  PupilSortMode.sortBySchooldayEvents: false,
  PupilSortMode.sortByLastSchooldayEvent: false,
  PupilSortMode.sortByLastNonProcessedSchooldayEvent: false
};

// enum SchoolGrade {
//   E1('E1'),
//   E2('E2'),
//   E3('E3'),
//   K3('K3'),
//   K4('K4');

//   static const stringToValue = {
//     'E1': SchoolGrade.E1,
//     'E2': SchoolGrade.E2,
//     'E3': SchoolGrade.E3,
//     'K3': SchoolGrade.K3,
//     'K4': SchoolGrade.K4,
//   };

//   final String value;
//   const SchoolGrade(this.value);
// }

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
