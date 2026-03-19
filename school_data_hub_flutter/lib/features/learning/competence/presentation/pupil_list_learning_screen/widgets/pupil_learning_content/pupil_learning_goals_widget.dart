import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/pupil_competence_goals/competence_goal_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

class PupilLearningGoals extends WatchingWidget {
  final PupilProxy pupil;
  const PupilLearningGoals({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final proxy = di<CompetenceManager>().getPupilCompetenceGoalsProxy(
      pupil.pupilId,
    );
    watch(proxy);
    final competenceGoals = proxy.competenceGoals;
    return Column(
      children: [
        competenceGoals.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: competenceGoals.length,
                itemBuilder: (context, int index) {
                  return CompetenceGoalCard(
                    pupil: pupil,
                    pupilGoal: competenceGoals[index],
                  );
                },
              )
            : const SizedBox.shrink(),
        Gap(Style.spacing.md),
      ],
    );
  }
}
