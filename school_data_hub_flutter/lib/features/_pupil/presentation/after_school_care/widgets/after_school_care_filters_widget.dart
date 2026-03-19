import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/filters/attendance_pupil_filter.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/models/enums.dart';

class AfterSchoolCareFiltersWidget extends WatchingWidget {
  const AfterSchoolCareFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceFilterLocator = di<AttendancePupilFilterManager>();
    final Map<AttendancePupilFilter, bool> activeAttendanceFilters = watchValue(
      (AttendancePupilFilterManager x) => x.attendancePupilFilterState,
    );

    bool valuePresent = activeAttendanceFilters[AttendancePupilFilter.present]!;

    bool valueNotPresent =
        activeAttendanceFilters[AttendancePupilFilter.notPresent]!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(children: [Text('OGS-Filter', style: context.typography.subtitle)]),
        Wrap(
          children: [
            ThemedFilterChip(
              label: 'anwesend',
              selected: valuePresent,
              onSelected: (val) {
                // in case present is selected, not present and unexcused should be deselected

                if (val) {
                  attendanceFilterLocator.setAttendancePupilFilter(
                    attendancePupilFilterRecords: [
                      (
                        attendancePupilFilter: AttendancePupilFilter.notPresent,
                        value: false,
                      ),
                      (
                        attendancePupilFilter: AttendancePupilFilter.unexcused,
                        value: false,
                      ),
                      (
                        attendancePupilFilter: AttendancePupilFilter.present,
                        value: val,
                      ),
                    ],
                  );
                  return;
                }
                attendanceFilterLocator.setAttendancePupilFilter(
                  attendancePupilFilterRecords: [
                    (
                      attendancePupilFilter: AttendancePupilFilter.present,
                      value: val,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: 'nicht da',
              selected: valueNotPresent,
              onSelected: (val) {
                // in case not present is selected, present should be deselected
                if (val) {
                  //_valuePresent = false;
                  attendanceFilterLocator.setAttendancePupilFilter(
                    attendancePupilFilterRecords: [
                      (
                        attendancePupilFilter: AttendancePupilFilter.notPresent,
                        value: val,
                      ),
                      (
                        attendancePupilFilter: AttendancePupilFilter.present,
                        value: false,
                      ),
                      (
                        attendancePupilFilter: AttendancePupilFilter.unexcused,
                        value: false,
                      ),
                    ],
                  );
                  return;
                }

                attendanceFilterLocator.setAttendancePupilFilter(
                  attendancePupilFilterRecords: [
                    (
                      attendancePupilFilter: AttendancePupilFilter.notPresent,
                      value: val,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
