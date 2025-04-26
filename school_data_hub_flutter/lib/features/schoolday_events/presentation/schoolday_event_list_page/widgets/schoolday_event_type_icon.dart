import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';

class SchooldayEventTypeIcon extends StatelessWidget {
  final String category;
  const SchooldayEventTypeIcon({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    switch (category) {
      case 'Eg':
        return const Row(
          children: [
            Text('👪️'),
          ],
        );
      case 'rk':
        return const Icon(
          Icons.sim_card_alert_rounded,
          color: Colors.red,
        );
      case 'rkogs':
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
      case 'other':
        return const Icon(Icons.assignment_rounded,
            color: AppColors.backgroundColor);
      case 'choose':
        return Image.asset('assets/choose.png');
      case 'rkabh':
        return const Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            Icons.sim_card_alert_rounded,
            color: Colors.red,
          ),
          Gap(5),
          Icon(
            Icons.home,
            color: AppColors.accentColor,
          )
        ]);
      default:
        return const Icon(Icons.question_mark_rounded, color: Colors.red);
    }
  }
}
