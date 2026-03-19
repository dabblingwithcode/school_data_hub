import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/learning_goals_statistics.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';

class LearningGoalsInfos extends WatchingWidget {
  const LearningGoalsInfos({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pupils = watchValue((PupilsFilter m) => m.filteredPupils);
    final stats = LearningGoalsStatistics.calculateStats(pupils);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.people_alt_rounded, color: style.colors.accent),
        Gap(Style.spacing.md),
        Text(
          pupils.length.toString(),
          style: context.typography.title,
        ),
        Gap(Style.spacing.lg),
        Text(
          'Ziele: ',
          style: context.typography.bodySmall.withColor(style.colors.foreground),
        ),
        Gap(Style.spacing.xs),
        Text(
          (stats.totalGoals).toString(),
          style: context.typography.title,
        ),
        Gap(Style.spacing.lg),
        Text(
          'offen: ',
          style: context.typography.bodySmall.withColor(style.colors.foreground),
        ),
        Gap(Style.spacing.xs),
        Text(
          (stats.totalOpenGoals).toString(),
          style: context.typography.title,
        ),
        Gap(Style.spacing.lg),
        Text(
          'erreicht: ',
          style: context.typography.bodySmall.withColor(style.colors.foreground),
        ),
        Gap(Style.spacing.xs),
        Text(
          (stats.totalAchievedGoals).toString(),
          style: context.typography.title,
        ),
      ],
    );
  }
}
