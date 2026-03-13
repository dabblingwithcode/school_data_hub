import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/filters/attendance_pupil_filter.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:flutter_it/flutter_it.dart';

class AttendanceFilters extends WatchingWidget {
  const AttendanceFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final pupilsFilter = di<PupilsFilter>();
    final ogsFilters = pupilsFilter.afterSchoolCareFilters;

    final attendanceFilterLocator = di<AttendancePupilFilterManager>();
    final Map<AttendancePupilFilter, bool> activeAttendanceFilters = watchValue(
      (AttendancePupilFilterManager x) => x.attendancePupilFilterState,
    );

    bool valuePresent = activeAttendanceFilters[AttendancePupilFilter.present]!;

    bool valueNotPresent =
        activeAttendanceFilters[AttendancePupilFilter.notPresent]!;

    bool valueUnexcused =
        activeAttendanceFilters[AttendancePupilFilter.unexcused]!;

    // OGS filter: index 0 = has after school care, index 1 = no after school care
    final ogsFilter = ogsFilters[0];
    final notOgsFilter = ogsFilters[1];
    bool valueOgs = watch(ogsFilter).isActive;
    bool valueNotOgs = watch(notOgsFilter).isActive;

    return Column(
      children: [
        const Row(children: [Text('Anwesenheit', style: AppStyles.subtitle)]),
        const Gap(5),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
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
            ThemedFilterChip(
              label: 'nicht da unent.',
              selected: valueUnexcused,
              onSelected: (val) {
                // in case unexcused is selected, present should be deselected
                if (val) {
                  attendanceFilterLocator.setAttendancePupilFilter(
                    attendancePupilFilterRecords: [
                      (
                        attendancePupilFilter: AttendancePupilFilter.unexcused,
                        value: val,
                      ),
                      (
                        attendancePupilFilter: AttendancePupilFilter.notPresent,
                        value: false,
                      ),
                      (
                        attendancePupilFilter: AttendancePupilFilter.present,
                        value: false,
                      ),
                    ],
                  );
                  return;
                }
                attendanceFilterLocator.setAttendancePupilFilter(
                  attendancePupilFilterRecords: [
                    (
                      attendancePupilFilter: AttendancePupilFilter.unexcused,
                      value: val,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: 'OGS',
              selected: valueOgs,
              onSelected: (val) {
                if (val) {
                  notOgsFilter.reset();
                }
                ogsFilter.toggle(val);
              },
            ),
            ThemedFilterChip(
              label: 'nicht OGS',
              selected: valueNotOgs,
              onSelected: (val) {
                if (val) {
                  ogsFilter.reset();
                }
                notOgsFilter.toggle(val);
              },
            ),
          ],
        ),
      ],
    );
  }
}
