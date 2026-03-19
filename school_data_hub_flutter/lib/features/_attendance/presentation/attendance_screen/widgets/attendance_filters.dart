import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/filters/attendance_pupil_filter.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';

class AttendanceFilters extends WatchingWidget {
  const AttendanceFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final pupilsFilter = di<PupilsFilter>();
    final afterSchoolCareFilters = pupilsFilter.afterSchoolCareFilters;

    final attendanceFilterManager = di<AttendancePupilFilterManager>();
    final Map<AttendancePupilFilter, bool> activeAttendanceFilters = watchValue(
      (AttendancePupilFilterManager x) => x.attendancePupilFilterState,
    );

    bool valuePresent = activeAttendanceFilters[AttendancePupilFilter.present]!;

    bool valueNotPresent =
        activeAttendanceFilters[AttendancePupilFilter.notPresent]!;

    bool valueUnexcused =
        activeAttendanceFilters[AttendancePupilFilter.unexcused]!;

    // after school care filter: index 0 = has after school care, index 1 = no after school care
    final afterSchoolCareFilter = afterSchoolCareFilters[0];
    final noAfterSchoolCareFilter = afterSchoolCareFilters[1];
    bool valueOgs = watch(afterSchoolCareFilter).isActive;
    bool valueNotOgs = watch(noAfterSchoolCareFilter).isActive;

    return Column(
      children: [
        Row(children: [
          Text('Anwesenheit', style: context.typography.subtitle.bold),
        ]),
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
                if (val) {
                  attendanceFilterManager.setAttendancePupilFilter(
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
                attendanceFilterManager.setAttendancePupilFilter(
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
                if (val) {
                  attendanceFilterManager.setAttendancePupilFilter(
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

                attendanceFilterManager.setAttendancePupilFilter(
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
                if (val) {
                  attendanceFilterManager.setAttendancePupilFilter(
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
                attendanceFilterManager.setAttendancePupilFilter(
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
                  noAfterSchoolCareFilter.reset();
                }
                afterSchoolCareFilter.toggle(val);
              },
            ),
            ThemedFilterChip(
              label: 'nicht OGS',
              selected: valueNotOgs,
              onSelected: (val) {
                if (val) {
                  afterSchoolCareFilter.reset();
                }
                noAfterSchoolCareFilter.toggle(val);
              },
            ),
          ],
        ),
      ],
    );
  }
}
