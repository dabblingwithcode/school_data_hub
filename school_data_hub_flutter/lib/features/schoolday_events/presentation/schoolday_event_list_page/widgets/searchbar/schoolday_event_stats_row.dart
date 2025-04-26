import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';
import 'package:schuldaten_hub/features/pupil/domain/pupil_manager.dart';
import 'package:schuldaten_hub/features/schoolday_events/domain/schoolday_event_helper_functions.dart';

class SchooldayEventStats extends StatelessWidget {
  final int pupilsWithEventsCount;
  final SchooldayEventsCounts schooldayEventsCount;
  const SchooldayEventStats(
      {required this.pupilsWithEventsCount,
      required this.schooldayEventsCount,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.people_alt_rounded,
          color: AppColors.backgroundColor,
        ),
        const Gap(5),
        Text(
          '${pupilsWithEventsCount.toString()}/${locator<PupilManager>().allPupils.length}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(10),
        const Text('🗂️'),
        const Gap(5),
        Text(
          schooldayEventsCount.totalSchooldayEvents.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(10),
        const Icon(
          Icons.school_rounded,
          color: Colors.red,
        ),
        const Gap(5),
        Text(
          schooldayEventsCount.totalLessonSchooldayEvents.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(10),
        const Text(
          'OGS',
          style: TextStyle(
              fontSize: 13, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        const Gap(5),
        Text(schooldayEventsCount.totalOgsSchooldayEvents.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        const Gap(10),
        const Icon(
          Icons.home_rounded,
          color: Colors.red,
        ),
        const Gap(5),
        Text(schooldayEventsCount.totalSentHomeSchooldayEvents.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        const Gap(10),
        const Text(
          '👪️',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const Gap(5),
        Text(schooldayEventsCount.totalParentsMeetingSchooldayEvents.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
      ],
    );
  }
}
