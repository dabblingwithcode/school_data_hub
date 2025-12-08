import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class SchooldayEventTypeIcon extends StatelessWidget {
  final SchooldayEventType type;
  const SchooldayEventTypeIcon({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SchooldayEventType.parentsMeeting:
        return const Row(
          children: [
            Text('👪️'),
          ],
        );
      case SchooldayEventType.admonition:
        return const Icon(
          Icons.sim_card_alert_rounded,
          color: Colors.red,
        );
      case SchooldayEventType.afternoonCareAdmonition:
        return const Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            Icons.sim_card_alert_rounded,
            color: Colors.red,
          ),
          Gap(5),
          Text('OGS',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ]);
      case SchooldayEventType.otherEvent:
        return Icon(Icons.assignment_rounded, color: AppColors.backgroundColor);
      case SchooldayEventType.notSet:
        return Image.asset('assets/choose.png');
      case SchooldayEventType.admonitionAndBanned:
        return Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(
            Icons.sim_card_alert_rounded,
            color: Colors.red,
          ),
          const Gap(5),
          Icon(
            Icons.home,
            color: AppColors.accentColor,
          )
        ]);
    }
  }
}
