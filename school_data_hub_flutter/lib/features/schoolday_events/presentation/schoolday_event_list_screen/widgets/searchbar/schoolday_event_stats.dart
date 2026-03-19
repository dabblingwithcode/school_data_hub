import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/schoolday_event_helper_functions.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/schoolday_event_list_screen/widgets/schoolday_event_type_icon.dart';

class SchooldayEventStats extends WatchingWidget {
  final int pupilsWithEventsCount;

  const SchooldayEventStats({required this.pupilsWithEventsCount, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final filteredPupils = watchValue((PupilsFilter x) => x.filteredPupils);
    final filterState = watchValue(
      (SchooldayEventFilterManager x) => x.schooldayEventsFilterState,
    );
    final pupilIds = watchValue(
      (SchooldayEventFilterManager x) => x.pupilIdsWithFilteredSchooldayEvents,
    );
    // Rebuild when events change (add/update/delete via hub or CRUD)
    watchValue((SchooldayEventManager x) => x.schooldayEvents);
    // Use same effective list as the list screen: when event filter is on, restrict by pupilIds
    final List<PupilProxy> effectivePupils =
        filterState.values.any((x) => x == true)
        ? filteredPupils.where((p) => pupilIds.contains(p.pupilId)).toList()
        : filteredPupils;
    final schooldayEventsCount = SchoolDayEventHelper.getSchooldayEventsCounts(
      effectivePupils,
    );

    final statsTextStyle = context.typography.subtitle.bold
        .withColor(style.colors.foreground)
        .copyWith(fontSize: 20);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Gap(Style.spacing.sm),
        Icon(Icons.people_alt_rounded, color: style.colors.accent),
        Gap(Style.spacing.xs),
        Text(
          '${pupilsWithEventsCount.toString()}/${effectivePupils.length}',
          style: statsTextStyle,
        ),
        Gap(Style.spacing.sm),
        const Text('🗂️'),
        Gap(Style.spacing.xs),
        Text(
          schooldayEventsCount.totalSchooldayEvents.toString(),
          style: statsTextStyle,
        ),
        Gap(Style.spacing.sm),
        const SchooldayEventTypeIcon(
          type: SchooldayEventType.admonition,
          iconSize: 20,
        ),
        Gap(Style.spacing.xs),
        Text(
          schooldayEventsCount.totalLessonSchooldayEvents.toString(),
          style: statsTextStyle,
        ),
        Gap(Style.spacing.sm),
        const SchooldayEventTypeIcon(
          type: SchooldayEventType.afternoonCareAdmonition,
          iconSize: 20,
        ),
        Gap(Style.spacing.xs),
        Text(
          schooldayEventsCount.totalOgsSchooldayEvents.toString(),
          style: statsTextStyle,
        ),
        Gap(Style.spacing.sm),
        const SchooldayEventTypeIcon(
          type: SchooldayEventType.admonitionAndBanned,
          iconSize: 20,
        ),
        Gap(Style.spacing.xs),
        Text(
          schooldayEventsCount.totalSentHomeSchooldayEvents.toString(),
          style: statsTextStyle,
        ),
        Gap(Style.spacing.sm),
        const SchooldayEventTypeIcon(
          type: SchooldayEventType.parentsMeeting,
          iconSize: 20,
        ),
        Gap(Style.spacing.xs),
        Text(
          schooldayEventsCount.totalParentsMeetingSchooldayEvents.toString(),
          style: statsTextStyle,
        ),
      ],
    );
  }
}
