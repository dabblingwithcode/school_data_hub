import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_stats_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class AttendanceSearchBarStatsWidget extends WatchingWidget {
  const AttendanceSearchBarStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final pupils = watchValue((PupilsFilter x) => x.filteredPupils);

    watchValue((AttendanceManager x) => x.missedSchooldays);

    DateTime thisDate = watchValue((SchoolCalendarManager x) => x.thisDate);

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_alt_rounded, color: AppColors.backgroundColor),

            const Gap(10),

            Text(
              pupils.length.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const Gap(15),

            const Text(
              'Anwesend: ',
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),

            const Gap(5),

            Text(
              (pupils.length -
                      AttendanceStatsHelper.missedPupilsSum(pupils, thisDate))
                  .toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const Gap(15),

            const Text(
              'Unent. ',
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),

            const Gap(5),

            Text(
              AttendanceStatsHelper.missedAndUnexcusedPupilsSum(
                pupils,
                thisDate,
              ).toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
