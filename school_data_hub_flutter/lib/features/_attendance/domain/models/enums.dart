// enum MissedType {
//   isLate('late'),
//   isMissed('missed'),
//   goneHome('home'),
//   notSet('none');

//   final String value;
//   const MissedType(this.value);
// }

// enum ContactedType {
//   notSet('0'),
//   contacted('1'),
//   calledBack('2'),
//   notReached('3');

//   final String value;
//   const ContactedType(this.value);
// }

enum AttendancePupilFilter {
  late,
  missed,
  home,
  unexcused,
  contacted,
  goneHome,
  present,
  notPresent,
}

final Map<AttendancePupilFilter, bool> initialAttendancePupilFilterValues = {
  AttendancePupilFilter.late: false,
  AttendancePupilFilter.missed: false,
  AttendancePupilFilter.home: false,
  AttendancePupilFilter.unexcused: false,
  AttendancePupilFilter.contacted: false,
  AttendancePupilFilter.goneHome: false,
  AttendancePupilFilter.present: false,
  AttendancePupilFilter.notPresent: false,
};

typedef AttendancePupilFilterRecord = ({
  AttendancePupilFilter attendancePupilFilter,
  bool value
});
