import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/competence_list_sortable_page/widgets/competence_tree_list_sortable.dart';

class CompetenceTreeSortable extends StatelessWidget {
  final List<Competence> competences;
  final Function({int? competenceId, Competence? competence})
      navigateToNewOrPatchCompetencePage;

  const CompetenceTreeSortable({
    super.key,
    required this.competences,
    required this.navigateToNewOrPatchCompetencePage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: buildCommonCompetenceTreeSortable(
        navigateToNewOrPatchCompetencePage: navigateToNewOrPatchCompetencePage,
        parentId: null,
        indentation: 0,
        backgroundColor: null,
        competences: competences,
        context: context,
      ),
    );
  }
}
