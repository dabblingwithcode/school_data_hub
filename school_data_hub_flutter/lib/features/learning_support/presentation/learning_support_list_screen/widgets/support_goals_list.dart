import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_goal/support_goal_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

class SupportGoalsList extends WatchingWidget {
  final PupilProxy pupil;
  const SupportGoalsList({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final proxy =
        di<LearningSupportManager>().getPupilSupportGoalsProxy(pupil.pupilId);
    watch(proxy);
    final supportGoals = proxy.supportGoals;
    return Column(
      children: [
        Gap(Style.spacing.xs),

        Row(
          children: [
            Text(
              'Förderziele',
              style: context.typography.title,
            ),
          ],
        ),
        Gap(Style.spacing.md),
        supportGoals.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: supportGoals.length,
                itemBuilder: (context, int index) {
                  return SupportGoalCard(pupil: pupil, goalIndex: index);
                },
              )
            : const Column(
                children: [Text('Noch keine Förderziele festgelegt!')],
              ),
        Gap(Style.spacing.md),
      ],
    );
  }
}
