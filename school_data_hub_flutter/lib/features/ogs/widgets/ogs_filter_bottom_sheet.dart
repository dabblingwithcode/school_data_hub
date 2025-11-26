import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/filters/attendance_pupil_filter.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:watch_it/watch_it.dart';

class OgsFilterBottomSheet extends WatchingWidget {
  const OgsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final _attendanceFilterLocator = di<AttendancePupilFilterManager>();
    final Map<AttendancePupilFilter, bool> activeAttendanceFilters = watchValue(
      (AttendancePupilFilterManager x) => x.attendancePupilFilterState,
    );

    bool valuePresent = activeAttendanceFilters[AttendancePupilFilter.present]!;

    bool valueNotPresent =
        activeAttendanceFilters[AttendancePupilFilter.notPresent]!;
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const FilterHeading(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CommonPupilFiltersWidget(),
                  const Row(
                    children: [Text('OGS-Filter', style: AppStyles.subtitle)],
                  ),
                  Wrap(
                    children: [
                      ThemedFilterChip(
                        label: 'anwesend',
                        selected: valuePresent,
                        onSelected: (val) {
                          // in case present is selected, not present and unexcused should be deselected

                          if (val) {
                            _attendanceFilterLocator.setAttendancePupilFilter(
                              attendancePupilFilterRecords: [
                                (
                                  attendancePupilFilter:
                                      AttendancePupilFilter.notPresent,
                                  value: false,
                                ),
                                (
                                  attendancePupilFilter:
                                      AttendancePupilFilter.unexcused,
                                  value: false,
                                ),
                                (
                                  attendancePupilFilter:
                                      AttendancePupilFilter.present,
                                  value: val,
                                ),
                              ],
                            );
                            return;
                          }
                          _attendanceFilterLocator.setAttendancePupilFilter(
                            attendancePupilFilterRecords: [
                              (
                                attendancePupilFilter:
                                    AttendancePupilFilter.present,
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
                            _attendanceFilterLocator.setAttendancePupilFilter(
                              attendancePupilFilterRecords: [
                                (
                                  attendancePupilFilter:
                                      AttendancePupilFilter.notPresent,
                                  value: val,
                                ),
                                (
                                  attendancePupilFilter:
                                      AttendancePupilFilter.present,
                                  value: false,
                                ),
                                (
                                  attendancePupilFilter:
                                      AttendancePupilFilter.unexcused,
                                  value: false,
                                ),
                              ],
                            );
                            return;
                          }

                          _attendanceFilterLocator.setAttendancePupilFilter(
                            attendancePupilFilterRecords: [
                              (
                                attendancePupilFilter:
                                    AttendancePupilFilter.notPresent,
                                value: val,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

showOgsFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => const OgsFilterBottomSheet(),
  );
}
