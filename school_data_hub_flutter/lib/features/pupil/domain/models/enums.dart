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
