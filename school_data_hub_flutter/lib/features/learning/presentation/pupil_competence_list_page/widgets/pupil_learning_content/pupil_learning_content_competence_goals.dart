import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_competence_goals/dialogs/add_competence_goal_dialog.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_learning_content/pupil_learning_goals_widget.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/select_competence_page/select_competence_view_model.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class PupilLearningContentCompetenceGoals extends StatelessWidget {
  final PupilProxy pupil;
  const PupilLearningContentCompetenceGoals({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Lernziele',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Gap(10),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                style: AppStyles.actionButtonStyle,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SelectCompetence(
                        onSelected: (ctx, competence) async {
                          Navigator.of(ctx).pop();
                          await showDialog(
                            context: context,
                            builder: (context) => AddCompetenceGoalDialog(
                              pupilId: pupil.pupilId,
                              competenceId: competence.publicId,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                child: const Text(
                  "NEUES LERNZIEL",
                  style: AppStyles.buttonTextStyle,
                ),
              ),
            ),
          ],
        ),
        const Gap(15),
        PupilLearningGoals(pupil: pupil),
      ],
    );
  }
}
