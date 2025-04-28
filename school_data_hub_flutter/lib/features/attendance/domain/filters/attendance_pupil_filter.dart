import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

final _filterStateManager = di<FiltersStateManager>();
final _pupilsFilter = di<PupilsFilter>();
final _schooldayManager = di<SchooldayManager>();
final _attendanceManager = di<AttendanceManager>();

class AttendancePupilFilterManager {
  final _attendancePupilFilterState =
      ValueNotifier<Map<AttendancePupilFilter, bool>>(
          initialAttendancePupilFilterValues);

  ValueListenable<Map<AttendancePupilFilter, bool>>
      get attendancePupilFilterState => _attendancePupilFilterState;

  AttendancePupilFilterManager();

  void setAttendancePupilFilter(
      {required List<AttendancePupilFilterRecord>
          attendancePupilFilterRecords}) {
    for (final record in attendancePupilFilterRecords) {
      _attendancePupilFilterState.value = {
        ..._attendancePupilFilterState.value,
        record.attendancePupilFilter: record.value,
      };
    }

    final bool attendanceFilterStateEqualsInitialState = const MapEquality()
        .equals(_attendancePupilFilterState.value,
            initialAttendancePupilFilterValues);

    _filterStateManager.setFilterState(
        filterState: FilterState.attendance,
        value: !attendanceFilterStateEqualsInitialState);
    _pupilsFilter.refreshs();
  }

  void resetFilters() {
    _attendancePupilFilterState.value = {...initialAttendancePupilFilterValues};
    _filterStateManager.setFilterState(
        filterState: FilterState.attendance, value: false);
  }

  bool isMatchedByAttendanceFilters(PupilProxy pupil) {
    final thisDate = _schooldayManager.thisDate.value;
    final missedClasses = _attendanceManager
        .getPupilMissedClassesList(pupil.pupilId)
        .missedClasses;

    final Map<AttendancePupilFilter, bool> attendanceActiveFilters =
        _attendancePupilFilterState.value;

    final MissedClass? attendanceEventThisDate = missedClasses.firstWhereOrNull(
        (missedClass) => missedClass.schoolday!.schoolday.isSameDate(thisDate));

    bool isMatched = true;
    //- Filter pupils present

    if ((attendanceActiveFilters[AttendancePupilFilter.present]! &&
        !(attendanceEventThisDate == null ||
            attendanceEventThisDate.missedType == MissedType.late))) {
      isMatched = false;
    }

    //- Filter pupils not present

    if (attendanceActiveFilters[AttendancePupilFilter.notPresent]! &&
        !(attendanceEventThisDate != null &&
            attendanceEventThisDate.missedType != MissedType.late)) {
      isMatched = false;
    }

    //- Filter pupils not present AND unexcused

    if (attendanceActiveFilters[AttendancePupilFilter.unexcused]! &&
        !(attendanceEventThisDate != null &&
            attendanceEventThisDate.unexcused == true &&
            attendanceEventThisDate.missedType == MissedType.missed)) {
      isMatched = false;
    }

    if (isMatched) {
      return true;
    }
    // _filterStateManager
    //     .setFilterState(filterState: FilterState.attendance, value: true);
    return false;
  }
}
