import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/learning_goals_statistics.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';

class LearningGoalsInfos extends WatchingWidget {
  const LearningGoalsInfos({super.key});

  @override
  Widget build(BuildContext context) {
    final pupils = watchValue((PupilsFilter m) => m.filteredPupils);
    final stats = LearningGoalsStatistics.calculateStats(pupils);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.people_alt_rounded, color: AppColors.backgroundColor),
        const Gap(10),
        Text(
          pupils.length.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(15),
        const Text(
          'Ziele: ',
          style: TextStyle(color: Colors.black, fontSize: 13),
        ),
        const Gap(5),
        Text(
          (stats.totalGoals).toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(15),
        const Text(
          'offen: ',
          style: TextStyle(color: Colors.black, fontSize: 13),
        ),
        const Gap(5),
        Text(
          (stats.totalOpenGoals).toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(15),
        const Text(
          'erreicht: ',
          style: TextStyle(color: Colors.black, fontSize: 13),
        ),
        const Gap(5),
        Text(
          (stats.totalAchievedGoals).toString(),
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
