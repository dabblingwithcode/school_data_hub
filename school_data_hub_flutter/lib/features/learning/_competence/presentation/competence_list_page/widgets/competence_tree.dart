import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/competence_list_page/widgets/common_competence_card.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/competence_list_page/widgets/last_child_competence_card.dart';

class CompetenceTree extends StatelessWidget {
  final List<Competence> competences;
  final int? parentId;
  final Color? backgroundColor;
  final void Function({int? competenceId, Competence? competence})
  navigateToNewOrPatchCompetencePage;

  const CompetenceTree({
    required this.competences,
    required this.parentId,
    required this.navigateToNewOrPatchCompetencePage,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final children =
        competences.where((c) => c.parentCompetence == parentId).toList()
          ..sort((a, b) {
            if (a.order != null && b.order != null) {
              return a.order!.compareTo(b.order!);
            }
            if (a.order != null) return -1;
            if (b.order != null) return 1;
            return a.publicId.compareTo(b.publicId);
          });

    return Column(
      children: [
        for (final competence in children)
          _CompetenceNode(
            competence: competence,
            allCompetences: competences,
            backgroundColor: backgroundColor,
            navigateToNewOrPatchCompetencePage:
                navigateToNewOrPatchCompetencePage,
          ),
      ],
    );
  }
}

class _CompetenceNode extends StatelessWidget {
  final Competence competence;
  final List<Competence> allCompetences;
  final Color? backgroundColor;
  final void Function({int? competenceId, Competence? competence})
  navigateToNewOrPatchCompetencePage;

  const _CompetenceNode({
    required this.competence,
    required this.allCompetences,
    required this.backgroundColor,
    required this.navigateToNewOrPatchCompetencePage,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        backgroundColor ??
        CompetenceHelper.getCompetenceColor(competence.publicId);

    final hasChildren = allCompetences.any(
      (c) => c.parentCompetence == competence.publicId,
    );

    if (hasChildren) {
      return CommonCompetenceCard(
        competence: competence,
        competenceBackgroundColor: color,
        navigateToNewOrPatchCompetencePage: navigateToNewOrPatchCompetencePage,
        children: [
          CompetenceTree(
            competences: allCompetences,
            parentId: competence.publicId,
            backgroundColor: color,
            navigateToNewOrPatchCompetencePage:
                navigateToNewOrPatchCompetencePage,
          ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Style.spacing.xs),
      child: GestureDetector(
        onLongPress: () async {
          final confirm = await confirmationDialog(
            context: context,
            title: 'Kompetenz löschen',
            message: 'Sind Sie sicher?',
          );
          if (confirm!) {
            di<CompetenceManager>().deleteCompetence(competence.publicId);
          }
        },
        child: LastChildCompetenceCard(
          competence: competence,
          navigateToNewOrPatchCompetencePage:
              navigateToNewOrPatchCompetencePage,
        ),
      ),
    );
  }
}
