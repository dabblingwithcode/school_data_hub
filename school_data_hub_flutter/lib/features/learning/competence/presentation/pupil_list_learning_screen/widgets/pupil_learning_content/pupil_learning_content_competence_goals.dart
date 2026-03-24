import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/generic_async_action_button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/pupil_learning_content/pupil_learning_goals_widget.dart';

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
            context.push(
              RoutePaths.learningCompetenceSelect,
              extra: (BuildContext ctx, Competence competence) {
                ctx.pushReplacement(
                  RoutePaths.learningCompetenceGoalNew,
                  extra: {
                    'pupilId': pupil.pupilId,
                    'competenceId': competence.publicId,
                  },
                );
              },
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
