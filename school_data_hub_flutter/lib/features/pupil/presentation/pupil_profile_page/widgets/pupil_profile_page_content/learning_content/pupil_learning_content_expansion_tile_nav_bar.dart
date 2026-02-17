import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/pupil_learning_content/pupil_learning_content_books.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/pupil_learning_content/pupil_learning_content_competence_goals.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/pupil_learning_content/pupil_learning_content_competence_statuses.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/pupil_learning_content/pupil_learning_content_workbooks.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/pupil_list_learning_content_nav_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class PupilLearningContentExpansionTileNavBar extends WatchingWidget {
  final PupilProxy pupil;

  const PupilLearningContentExpansionTileNavBar({
    required this.pupil,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedContent = watchValue(
      (CompetenceManager m) => m.selectedLearningContent,
    );

    return Column(
      children: [
        const PupilListLearningContentNavBar(),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: (selectedContent == SelectedContent.competenceStatuses)
              ? PupilLearningContentCompetenceStatuses(pupil: pupil)
              : (selectedContent == SelectedContent.competenceGoals)
              ? PupilLearningContentCompetenceGoals(pupil: pupil)
              : (selectedContent == SelectedContent.workbooks)
              ? PupilLearningContentWorkbooks(pupil: pupil)
              :
                //  (selectedContent == SelectedContent.books):
                PupilLearningContentBooks(pupil: pupil),
        ),
      ],
    );
  }
}
