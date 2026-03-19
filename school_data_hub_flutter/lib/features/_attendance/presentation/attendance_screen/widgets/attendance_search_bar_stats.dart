import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_stats_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class AttendanceSearchBarStatsWidget extends WatchingWidget {
  const AttendanceSearchBarStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pupils = watchValue((PupilsFilter x) => x.filteredPupils);

    watchValue((AttendanceManager x) => x.missedSchooldays);

    DateTime thisDate = watchValue((SchoolCalendarManager x) => x.thisDate);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Style.spacing.md),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_alt_rounded, color: style.colors.accent),

            const Gap(10),

            Text(
              pupils.length.toString(),
              style: context.typography.subtitle.bold,
            ),

            const Gap(15),

            Text(
              'Anwesend: ',
              style: context.typography.bodySmall,
            ),

            const Gap(5),

            Text(
              (pupils.length -
                      AttendanceStatsHelper.missedPupilsSum(pupils, thisDate))
                  .toString(),
              style: context.typography.subtitle.bold,
            ),

            const Gap(15),

            Text(
              'Unent. ',
              style: context.typography.bodySmall,
            ),

            const Gap(5),

            Text(
              AttendanceStatsHelper.missedAndUnexcusedPupilsSum(
                pupils,
                thisDate,
              ).toString(),
              style: context.typography.subtitle.bold,
            ),
          ],
        ),
      ),
    );
  }
}
