import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:flutter_it/flutter_it.dart';

class SchooldayEventPupilStats extends WatchingWidget {
  final PupilProxy pupil;
  const SchooldayEventPupilStats({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final schooldayEventFilterManager = di<SchooldayEventFilterManager>();
    final schooldayEventManager = di<SchooldayEventManager>();
    Color admonitionsColor = style.colors.accent;
    Color afternoonAdmonitionsColor = style.colors.accent;
    final unfilteredEvents = watch(
      schooldayEventManager.getPupilSchooldayEventsProxy(pupil.pupilId),
    ).schooldayEvents;
    final schooldavEvents = schooldayEventFilterManager.filteredSchooldayEvents(
      unfilteredEvents.values.toList(),
    );
    final admonitions = schooldavEvents
        .where(
          (element) =>
              element.eventType == SchooldayEventType.admonition ||
              element.eventType == SchooldayEventType.admonitionAndBanned,
        )
        .toList();
    final afternoonCareAdmonitions = schooldavEvents
        .where(
          (element) =>
              element.eventType == SchooldayEventType.afternoonCareAdmonition,
        )
        .toList();
    final parentsMeeting = schooldavEvents
        .where(
          (element) => element.eventType == SchooldayEventType.parentsMeeting,
        )
        .toList();

    final otherEvents = schooldavEvents
        .where((element) => element.eventType == SchooldayEventType.otherEvent)
        .toList();
    if (admonitions.isNotEmpty) {
      if (admonitions.any((adm) => adm.processed == false)) {
        admonitionsColor = style.colors.warning;
      }
    }
    if (afternoonCareAdmonitions.isNotEmpty) {
      if (afternoonCareAdmonitions.any((adm) => adm.processed == false)) {
        afternoonAdmonitionsColor = style.colors.warning;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.school_rounded, color: style.colors.error),
        Gap(Style.spacing.sm),
        Text(
          admonitions.length.toString(),
          style: context.typography.subtitle.bold.withColor(admonitionsColor)
              .copyWith(fontSize: 20),
        ),
        Gap(Style.spacing.sm),
        Text(
          'OGS',
          style: context.typography.caption.bold.withColor(style.colors.error),
        ),
        Gap(Style.spacing.xs),
        Text(
          afternoonCareAdmonitions.length.toString(),
          style: context.typography.subtitle.bold
              .withColor(afternoonAdmonitionsColor)
              .copyWith(fontSize: 20),
        ),
        Gap(Style.spacing.sm),
        const Text('👪️', style: TextStyle(fontSize: 18)),
        Gap(Style.spacing.xs),
        Text(
          parentsMeeting.length.toString(),
          style: context.typography.subtitle.bold
              .withColor(style.colors.foreground)
              .copyWith(fontSize: 20),
        ),
        Gap(Style.spacing.sm),
        const Text('🗒️'),
        Gap(Style.spacing.xs),
        Text(
          otherEvents.length.toString(),
          style: context.typography.subtitle.bold
              .withColor(style.colors.foreground)
              .copyWith(fontSize: 20),
        ),
      ],
    );
  }
}
