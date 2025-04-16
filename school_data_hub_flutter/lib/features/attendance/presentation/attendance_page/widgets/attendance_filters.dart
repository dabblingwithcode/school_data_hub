import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/filters/attendance_pupil_filter.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

final _pupilFilterLocator = di<PupilFilterManager>();

final _attendanceFilterLocator = di<AttendancePupilFilterManager>();

class AttendanceFilters extends WatchingWidget {
  const AttendanceFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<AttendancePupilFilter, bool> activeAttendanceFilters = watchValue(
        (AttendancePupilFilterManager x) => x.attendancePupilFilterState);

    bool valuePresent = activeAttendanceFilters[AttendancePupilFilter.present]!;

    bool valueNotPresent =
        activeAttendanceFilters[AttendancePupilFilter.notPresent]!;

    bool valueUnexcused =
        activeAttendanceFilters[AttendancePupilFilter.unexcused]!;

    Map<PupilFilter, bool> activePupilFilters =
        watchValue((PupilFilterManager x) => x.pupilFilterState);

    bool valueOgs = activePupilFilters[PupilFilter.ogs]!;

    bool valueNotOgs = activePupilFilters[PupilFilter.notOgs]!;

    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Anwesenheit',
              style: AppStyles.subtitle,
            )
          ],
        ),
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
                  _attendanceFilterLocator
                      .setAttendancePupilFilter(attendancePupilFilterRecords: [
                    (
                      attendancePupilFilter: AttendancePupilFilter.notPresent,
                      value: false
                    ),
                    (
                      attendancePupilFilter: AttendancePupilFilter.unexcused,
                      value: false
                    ),
                    (
                      attendancePupilFilter: AttendancePupilFilter.present,
                      value: val
                    )
                  ]);
                  return;
                }
                _attendanceFilterLocator.setAttendancePupilFilter(
                    attendancePupilFilterRecords: [
                      (
                        attendancePupilFilter: AttendancePupilFilter.present,
                        value: val
                      )
                    ]);
              },
            ),
            ThemedFilterChip(
              label: 'nicht da',
              selected: valueNotPresent,
              onSelected: (val) {
                // in case not present is selected, present should be deselected
                if (val) {
                  //_valuePresent = false;
                  _attendanceFilterLocator
                      .setAttendancePupilFilter(attendancePupilFilterRecords: [
                    (
                      attendancePupilFilter: AttendancePupilFilter.notPresent,
                      value: val
                    ),
                    (
                      attendancePupilFilter: AttendancePupilFilter.present,
                      value: false
                    ),
                    (
                      attendancePupilFilter: AttendancePupilFilter.unexcused,
                      value: false
                    )
                  ]);
                  return;
                }

                _attendanceFilterLocator.setAttendancePupilFilter(
                    attendancePupilFilterRecords: [
                      (
                        attendancePupilFilter: AttendancePupilFilter.notPresent,
                        value: val
                      )
                    ]);
              },
            ),
            ThemedFilterChip(
              label: 'nicht da unent.',
              selected: valueUnexcused,
              onSelected: (val) {
                // in case unexcused is selected, present should be deselected
                if (val) {
                  _attendanceFilterLocator
                      .setAttendancePupilFilter(attendancePupilFilterRecords: [
                    (
                      attendancePupilFilter: AttendancePupilFilter.unexcused,
                      value: val
                    ),
                    (
                      attendancePupilFilter: AttendancePupilFilter.notPresent,
                      value: false
                    ),
                    (
                      attendancePupilFilter: AttendancePupilFilter.present,
                      value: false
                    )
                  ]);
                  return;
                }
                _attendanceFilterLocator.setAttendancePupilFilter(
                    attendancePupilFilterRecords: [
                      (
                        attendancePupilFilter: AttendancePupilFilter.unexcused,
                        value: val
                      )
                    ]);
              },
            ),
            ThemedFilterChip(
              label: 'OGS',
              selected: valueOgs,
              onSelected: (val) {
                if (val == true) {
                  // in case ogs is selected, not ogs should be deselected

                  _pupilFilterLocator.setPupilFilter(pupilFilterRecords: [
                    (filter: PupilFilter.notOgs, value: false),
                    (filter: PupilFilter.ogs, value: val)
                  ]);
                  return;
                }

                _pupilFilterLocator.setPupilFilter(pupilFilterRecords: [
                  (filter: PupilFilter.ogs, value: val)
                ]);
              },
            ),
            ThemedFilterChip(
              label: 'nicht OGS',
              selected: valueNotOgs,
              onSelected: (val) {
                if (val == true) {
                  // in case not ogs is selected, ogs should be deselected
                  _pupilFilterLocator.setPupilFilter(pupilFilterRecords: [
                    (filter: PupilFilter.ogs, value: false),
                    (filter: PupilFilter.notOgs, value: val)
                  ]);
                  return;
                }
                _pupilFilterLocator.setPupilFilter(pupilFilterRecords: [
                  (filter: PupilFilter.notOgs, value: val)
                ]);
              },
            ),
          ],
        ),
      ],
    );
  }
}
