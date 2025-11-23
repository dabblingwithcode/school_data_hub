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
  PupilSortMode.sortByLastNonProcessedSchooldayEvent: false,
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

enum ReligionCourse {
  islam('isl.'),
  catholic('kath.'),
  none('ohne B.');

  static const stringToValue = {
    'isl.': ReligionCourse.islam,
    'röm.kath.': ReligionCourse.catholic,
    'ohne B.': ReligionCourse.none,
  };

  final String value;
  const ReligionCourse(this.value);
}

enum Gender {
  male('m'),
  female('w');

  static const stringToValue = {'m': Gender.male, 'w': Gender.female};

  final String value;
  const Gender(this.value);
}

enum AfterSchoolCareWeekday { monday, tuesday, wednesday, thursday, friday }

/// Converts a DateTime to AfterSchoolCareWeekday
/// Handles UTC dates by converting to local time first
/// Returns null if the date is not a weekday (Saturday or Sunday)
AfterSchoolCareWeekday? dateTimeToAfterSchoolCareWeekday(DateTime date) {
  // Convert UTC to local time to get the correct weekday for the user's timezone
  final localDate = date.isUtc ? date.toLocal() : date;
  
  // DateTime.weekday: Monday=1, Tuesday=2, ..., Friday=5, Saturday=6, Sunday=7
  switch (localDate.weekday) {
    case 1:
      return AfterSchoolCareWeekday.monday;
    case 2:
      return AfterSchoolCareWeekday.tuesday;
    case 3:
      return AfterSchoolCareWeekday.wednesday;
    case 4:
      return AfterSchoolCareWeekday.thursday;
    case 5:
      return AfterSchoolCareWeekday.friday;
    default:
      return null; // Saturday or Sunday
  }
}

enum AfterSchoolCarePickUpModality {
  alone('allein'),
  anyRelative('Verwandte'),
  anyOther('Bekannte'),
  exception('Besondere Regelung'),
  notSet('bitte wählen');

  final String value;
  const AfterSchoolCarePickUpModality(this.value);
}
