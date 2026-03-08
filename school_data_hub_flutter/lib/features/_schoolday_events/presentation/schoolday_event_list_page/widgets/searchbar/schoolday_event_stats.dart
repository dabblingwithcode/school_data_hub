import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_helper_functions.dart';

class SchooldayEventStats extends WatchingWidget {
  final int pupilsWithEventsCount;

  const SchooldayEventStats({required this.pupilsWithEventsCount, super.key});

  @override
  Widget build(BuildContext context) {
    final filteredPupils = watchValue((PupilsFilter x) => x.filteredPupils);
    final schooldayEventsCount = SchoolDayEventHelper.getSchooldayEventsCounts(
      filteredPupils,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Gap(10),
        Icon(Icons.people_alt_rounded, color: AppColors.backgroundColor),
        const Gap(5),
        Text(
          '${pupilsWithEventsCount.toString()}/${filteredPupils.length}',
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
        const Icon(Icons.school_rounded, color: Colors.red),
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
            fontSize: 13,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(5),
        Text(
          schooldayEventsCount.totalOgsSchooldayEvents.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(10),
        const Icon(Icons.home_rounded, color: Colors.red),
        const Gap(5),
        Text(
          schooldayEventsCount.totalSentHomeSchooldayEvents.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(10),
        const Text('👪️', style: TextStyle(fontSize: 18)),
        const Gap(5),
        Text(
          schooldayEventsCount.totalParentsMeetingSchooldayEvents.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
