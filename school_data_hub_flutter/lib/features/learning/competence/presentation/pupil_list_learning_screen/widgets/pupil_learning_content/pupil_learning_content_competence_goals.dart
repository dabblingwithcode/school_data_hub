import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/generic_async_action_button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/pupil_competence_goals/new_competence_goal_page.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/pupil_learning_content/pupil_learning_goals_widget.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/select_competence_screen/select_competence_view_model.dart';

class PupilLearningContentCompetenceGoals extends WatchingWidget {
  final PupilProxy pupil;
  const PupilLearningContentCompetenceGoals({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    callOnce((_) => di<CompetenceManager>().fetchGoalsForPupil(pupil.pupilId));
    return Column(
      children: [
        Row(children: [Text('Lernziele', style: context.typography.title)]),
        GenericAsyncActionButton(
          onPressed: () async {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => SelectCompetence(
                  onSelected: (ctx, competence) {
                    Navigator.of(ctx).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (context) => NewCompetenceGoalPage(
                          pupilId: pupil.pupilId,
                          competenceId: competence.publicId,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
          title: "NEUES LERNZIEL",
          buttonType: ButtonType.action,
        ),

        PupilLearningGoals(pupil: pupil),
      ],
    );
  }
}
