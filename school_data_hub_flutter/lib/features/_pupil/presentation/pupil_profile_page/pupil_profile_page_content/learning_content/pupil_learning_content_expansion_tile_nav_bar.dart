import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/learning_content_selection.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_learning_content/pupil_learning_content_books.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_learning_content/pupil_learning_content_competence_goals.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_learning_content/pupil_learning_content_competence_statuses.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_learning_content/pupil_learning_content_workbooks.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_list_learning_content_nav_bar.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/pupil_competence_report_page/pupil_competence_report_page.dart';

class PupilLearningContentExpansionTileNavBar extends WatchingWidget {
  final PupilProxy pupil;

  const PupilLearningContentExpansionTileNavBar({
    required this.pupil,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedContent = watchValue(
      (LearningContentSelection s) => s.selectedContent,
    );

    return Column(
      children: [
        const PupilListLearningContentNavBar(),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: switch (selectedContent) {
            SelectedContent.competenceStatuses =>
              PupilLearningContentCompetenceStatuses(pupil: pupil),
            SelectedContent.competenceGoals =>
              PupilLearningContentCompetenceGoals(pupil: pupil),
            SelectedContent.competenceReports => Button(
              icon: const Icon(Icons.assignment),
              label: 'Zeugnisse öffnen',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => PupilCompetenceReportScreen(pupil: pupil),
                  ),
                );
              },
            ),
            SelectedContent.workbooks => PupilLearningContentWorkbooks(
              pupil: pupil,
            ),
            SelectedContent.books => PupilLearningContentBooks(pupil: pupil),
            SelectedContent.none => const SizedBox.shrink(),
          },
        ),
      ],
    );
  }
}
