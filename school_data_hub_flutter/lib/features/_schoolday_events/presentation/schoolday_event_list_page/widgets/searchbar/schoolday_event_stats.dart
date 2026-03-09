import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_helper_functions.dart';

class SchooldayEventStats extends WatchingWidget {
  final int pupilsWithEventsCount;

  const SchooldayEventStats({required this.pupilsWithEventsCount, super.key});

  @override
  Widget build(BuildContext context) {
    final filteredPupils = watchValue((PupilsFilter x) => x.filteredPupils);
    final filterState = watchValue(
      (SchooldayEventFilterManager x) => x.schooldayEventsFilterState,
    );
    final pupilIds = watchValue(
      (SchooldayEventFilterManager x) => x.pupilIdsWithFilteredSchooldayEvents,
    );
    // Use same effective list as the list page: when event filter is on, restrict by pupilIds
    final List<PupilProxy> effectivePupils =
        filterState.values.any((x) => x == true)
        ? filteredPupils.where((p) => pupilIds.contains(p.pupilId)).toList()
        : filteredPupils;
    final schooldayEventsCount = SchoolDayEventHelper.getSchooldayEventsCounts(
      effectivePupils,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Gap(10),
        Icon(Icons.people_alt_rounded, color: AppColors.backgroundColor),
        const Gap(5),
        Text(
          '${pupilsWithEventsCount.toString()}/${effectivePupils.length}',
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
