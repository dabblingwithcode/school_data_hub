import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/competence_list_sortable_page/widgets/competence_tree_list_sortable.dart';

class CompetenceTreeSortable extends StatefulWidget {
  final List<Competence> competences;
  final Function({int? competenceId, Competence? competence})
  navigateToNewOrPatchCompetencePage;

  const CompetenceTreeSortable({
    super.key,
    required this.competences,
    required this.navigateToNewOrPatchCompetencePage,
  });

  @override
  CompetenceTreeSortableState createState() => CompetenceTreeSortableState();
}

class CompetenceTreeSortableState extends State<CompetenceTreeSortable> {
  late List<Competence> _competences;

  @override
  void initState() {
    super.initState();
    _competences = widget.competences;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: buildCommonCompetenceTreeSortable(
        navigateToNewOrPatchCompetencePage:
            widget.navigateToNewOrPatchCompetencePage,
        parentId: null,
        indentation: 0,
        backgroundColor: null,
        competences: _competences,
        context: context,
      ),
    );
  }
}
