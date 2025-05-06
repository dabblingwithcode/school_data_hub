import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_goal/support_goal_card.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class SupportGoalsList extends StatelessWidget {
  final PupilProxy pupil;
  const SupportGoalsList({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(5),
        const Row(
          children: [
            Text(
              'Förderziele',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Gap(10),
        pupil.supportGoals != null
            ? pupil.supportGoals!.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pupil.supportGoals!.length,
                    itemBuilder: (context, int index) {
                      return SupportGoalCard(pupil: pupil, goalIndex: index);
                    })
                : const Column(
                    children: [
                      Text('Noch keine Förderziele festgelegt!'),
                    ],
                  )
            : const Column(
                children: [
                  Text('Noch keine Förderziele festgelegt!'),
                ],
              ),
        const Gap(10),
      ],
    );
  }
}
