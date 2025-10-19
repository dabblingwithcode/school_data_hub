import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/competence_list_sortable_page/widgets/common_competence_card_sortable.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/competence_list_sortable_page/widgets/last_child_competence_card_sortable.dart';
import 'package:watch_it/watch_it.dart';

List<Widget> buildCommonCompetenceTreeSortable({
  required Function({int? competenceId, Competence? competence})
  navigateToNewOrPatchCompetencePage,
  required int? parentId,
  required int indentation,
  required Color? backgroundColor,
  required List<Competence> competences,
  required BuildContext context,
}) {
  // // Separate competences into two lists: one for those without a parent competence and one for those with a parent competence
  // List<Competence> rootCompetences = [];
  // List<Competence> childCompetences = [];

  // for (var competence in competences) {
  //   if (competence.parentCompetence == null) {
  //     rootCompetences.add(competence);
  //   } else {
  //     childCompetences.add(competence);
  //   }
  // }

  // // Sort the child competences list based on parentCompetence and order values
  // childCompetences.sort((a, b) {
  //   if (a.parentCompetence == b.parentCompetence) {
  //     if (a.order == null && b.order == null) return 0;
  //     if (a.order == null) return 1;
  //     if (b.order == null) return -1;
  //     return a.order!.compareTo(b.order!);
  //   }
  //   return (a.parentCompetence ?? 0).compareTo(b.parentCompetence ?? 0);
  // });

  // // Combine the root competences and sorted child competences
  // List<Competence> sortedCompetences = [
  //   ...rootCompetences,
  //   ...childCompetences
  // ];

  List<Widget> competenceWidgets = [];

  late Color competenceBackgroundColor;
  for (var competence in competences) {
    if (backgroundColor == null) {
      competenceBackgroundColor = CompetenceHelper.getCompetenceColor(
        competence.publicId,
      );
    } else {
      competenceBackgroundColor = backgroundColor;
    }
    if (competence.parentCompetence == parentId) {
      final children = buildCommonCompetenceTreeSortable(
        navigateToNewOrPatchCompetencePage: navigateToNewOrPatchCompetencePage,
        parentId: competence.publicId,
        indentation: indentation + 1,
        backgroundColor: competenceBackgroundColor,
        competences: competences,
        context: context,
      );

      competenceWidgets.add(
        children.isNotEmpty
            ? Wrap(
                key: ValueKey(competence.publicId),
                children: [
                  CommonCompetenceCardSortable(
                    competence: competence,
                    competenceBackgroundColor: competenceBackgroundColor,
                    navigateToNewOrPatchCompetencePage:
                        navigateToNewOrPatchCompetencePage,
                    children: children,
                  ),
                ],
              )
            : Padding(
                key: ValueKey(competence.publicId),
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: InkWell(
                  onLongPress: () async {
                    final confirm = await confirmationDialog(
                      context: context,
                      title: 'Kompetenz löschen',
                      message: 'Sind Sie sicher?',
                    );
                    if (confirm!) {
                      di<CompetenceManager>().deleteCompetence(
                        competence.publicId,
                      );
                    }
                  },
                  child: LastChildCompetenceCardSortable(
                    key: ValueKey(competence.publicId),
                    competence: competence,
                    navigateToNewOrPatchCompetencePage:
                        navigateToNewOrPatchCompetencePage,
                  ),
                ),
              ),
      );
    }
  }
  return competenceWidgets;
}
