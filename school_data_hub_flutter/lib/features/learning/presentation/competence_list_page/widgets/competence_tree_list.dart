// import 'package:flutter/material.dart';
// import 'package:schuldaten_hub/common/services/locator.dart';
// import 'package:schuldaten_hub/common/widgets/dialogs/confirmation_dialog.dart';
// import 'package:schuldaten_hub/features/competence/domain/competence_helper.dart';
// import 'package:schuldaten_hub/features/competence/domain/competence_manager.dart';
// import 'package:schuldaten_hub/features/competence/domain/models/competence.dart';
// import 'package:schuldaten_hub/features/competence/presentation/competence_list_page/widgets/common_competence_card.dart';
// import 'package:schuldaten_hub/features/competence/presentation/competence_list_page/widgets/last_child_competence_card.dart';

// List<Widget> buildCommonCompetenceTree({
//   required Function({int? competenceId, Competence? competence})
//       navigateToNewOrPatchCompetencePage,
//   required int? parentId,
//   required int indentation,
//   required Color? backgroundColor,
//   required List<Competence> competences,
//   required BuildContext context,
// }) {
//   List<Widget> competenceWidgets = [];

//   late Color competenceBackgroundColor;
//   for (var competence in competences) {
//     if (backgroundColor == null) {
//       competenceBackgroundColor =
//           CompetenceHelper.getCompetenceColor(competence.competenceId);
//     } else {
//       competenceBackgroundColor = backgroundColor;
//     }
//     if (competence.parentCompetence == parentId) {
//       final children = buildCommonCompetenceTree(
//           navigateToNewOrPatchCompetencePage:
//               navigateToNewOrPatchCompetencePage,
//           parentId: competence.competenceId,
//           indentation: indentation + 1,
//           backgroundColor: competenceBackgroundColor,
//           competences: competences,
//           context: context);

//       competenceWidgets.add(
//         children.isNotEmpty
//             ? Wrap(
//                 key: ValueKey(competence.competenceId),
//                 children: [
//                   CommonCompetenceCard(
//                       competence: competence,
//                       competenceBackgroundColor: competenceBackgroundColor,
//                       navigateToNewOrPatchCompetencePage:
//                           navigateToNewOrPatchCompetencePage,
//                       children: children)
//                 ],
//               )
//             : Padding(
//                 key: ValueKey(competence.competenceId),
//                 padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                 child: InkWell(
//                   onLongPress: () async {
//                     final confirm = await confirmationDialog(
//                         context: context,
//                         title: 'Kompetenz löschen',
//                         message: 'Sind Sie sicher?');
//                     if (confirm!) {
//                       locator<CompetenceManager>()
//                           .deleteCompetence(competence.competenceId);
//                     }
//                   },
//                   child: LastChildCompetenceCard(
//                     competence: competence,
//                     navigateToNewOrPatchCompetencePage:
//                         navigateToNewOrPatchCompetencePage,
//                   ),
//                 ),
//               ),
//       );
//     }
//   }
//   return competenceWidgets;
// }
