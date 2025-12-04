import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventPupilStats extends WatchingWidget {
  final PupilProxy pupil;
  const SchooldayEventPupilStats({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final _schooldayEventFilterManager = di<SchooldayEventFilterManager>();
    final _schooldayEventManager = di<SchooldayEventManager>();
    Color admonitionsColor = AppColors.backgroundColor;
    Color afternoonAdmonitionsColor = AppColors.backgroundColor;
    final unfilteredEvents = watch(
      _schooldayEventManager.getPupilSchooldayEventsProxy(pupil.pupilId),
    ).schooldayEvents;
    final schooldavEvents = _schooldayEventFilterManager
        .filteredSchooldayEvents(unfilteredEvents.values.toList());
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
        admonitionsColor = AppColors.accentColor;
      }
    }
    if (afternoonCareAdmonitions.isNotEmpty) {
      if (afternoonCareAdmonitions.any((adm) => adm.processed == false)) {
        afternoonAdmonitionsColor = AppColors.accentColor;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.school_rounded, color: Colors.red),
        const Gap(10),
        Text(
          admonitions.length.toString(),
          style: TextStyle(
            color: admonitionsColor,
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
          afternoonCareAdmonitions.length.toString(),
          style: TextStyle(
            color: afternoonAdmonitionsColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(10),
        const Text('👪️', style: TextStyle(fontSize: 18)),
        const Gap(5),
        Text(
          parentsMeeting.length.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(10),
        const Text('🗒️'),
        const Gap(5),
        Text(
          otherEvents.length.toString(),
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
