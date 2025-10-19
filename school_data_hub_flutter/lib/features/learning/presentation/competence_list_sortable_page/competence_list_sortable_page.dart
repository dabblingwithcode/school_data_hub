import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/domain/filters/competence_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/competence_list_page/widgets/competence_list_view_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/competence_list_sortable_page/widgets/competence_tree_sortable.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/post_or_patch_competence_page/post_or_patch_competence_page.dart';
import 'package:watch_it/watch_it.dart';

class CompetenceListSortablePage extends WatchingWidget {
  const CompetenceListSortablePage({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: 'Kompetenzreihenfolge ändern',
      ),
      body: RefreshIndicator(
        onRefresh: () async => di<CompetenceManager>().fetchCompetences(),
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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: CompetenceTreeSortable(
                  competences: competences,
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
