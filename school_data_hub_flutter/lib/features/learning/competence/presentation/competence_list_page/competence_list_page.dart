import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/filters/competence_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/competence_list_page/widgets/competence_list_view_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/competence_list_page/widgets/competence_tree.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/post_or_patch_competence_page/post_or_patch_competence_page.dart';
import 'package:flutter_it/flutter_it.dart';

class CompetenceListPage extends WatchingWidget {
  const CompetenceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final competenceManager = di<CompetenceManager>();
    void navigateToNewOrPatchCompetencePage({
      int? competenceId,
      Competence? competence,
    }) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => PostOrPatchCompetencePage(
            parentCompetence: competenceId,
            competence: competence,
          ),
        ),
      );
    }

    List<Competence> competences = watchValue(
      (CompetenceFilterManager x) => x.filteredCompetences,
    );
    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.lightbulb_rounded,
        title: 'Kompetenzen',
      ),
      body: RefreshIndicator(
        onRefresh: () async => competenceManager.fetchCompetences(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: CompetenceTree(
                  competences: competences,
                  parentId: null,
                  navigateToNewOrPatchCompetencePage:
                      navigateToNewOrPatchCompetencePage,
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CompetenceListPageBottomNavBar(
        competences: competences,
      ),
    );
  }
}
