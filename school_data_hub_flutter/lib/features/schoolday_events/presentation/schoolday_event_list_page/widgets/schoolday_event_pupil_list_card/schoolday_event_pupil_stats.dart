import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';
import 'package:schuldaten_hub/features/pupil/domain/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:schuldaten_hub/features/schoolday_events/domain/models/schoolday_event_enums.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventPupilStats extends WatchingWidget {
  final PupilProxy pupil;
  const SchooldayEventPupilStats({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    Color admonitionsColor = AppColors.backgroundColor;
    Color afternoonAdmonitionsColor = AppColors.backgroundColor;
    final schooldavEvents =
        locator<SchooldayEventFilterManager>().filteredSchooldayEvents(pupil);
    final admonitions = schooldavEvents
        .where((element) =>
            element.schooldayEventType == SchooldayEventType.admonition.value ||
            element.schooldayEventType ==
                SchooldayEventType.admonitionAndBanned.value)
        .toList();
    final afternoonCareAdmonitions = schooldavEvents
        .where((element) =>
            element.schooldayEventType ==
            SchooldayEventType.afternoonCareAdmonition.value)
        .toList();
    final parentsMeeting = schooldavEvents
        .where((element) =>
            element.schooldayEventType ==
            SchooldayEventType.parentsMeeting.value)
        .toList();

    final otherEvents = schooldavEvents
        .where((element) =>
            element.schooldayEventType == SchooldayEventType.otherEvent.value)
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
        const Icon(
          Icons.school_rounded,
          color: Colors.red,
        ),
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
              fontSize: 13, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        const Gap(5),
        Text(afternoonCareAdmonitions.length.toString(),
            style: TextStyle(
              color: afternoonAdmonitionsColor,
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
        Text(parentsMeeting.length.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
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
