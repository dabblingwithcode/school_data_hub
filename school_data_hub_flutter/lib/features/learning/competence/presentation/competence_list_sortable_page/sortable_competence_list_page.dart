import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_button.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/filters/competence_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/competence_list_page/widgets/competence_filters_widget.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/competence_list_sortable_page/widgets/competence_tree_sortable.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/post_or_patch_competence_page/post_or_patch_competence_page.dart';

class SortableCompetenceListPage extends WatchingWidget {
  const SortableCompetenceListPage({super.key});

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

    onDispose(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        di<CompetenceManager>().sortAndNotifyCompetences();
      });
    });

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
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          IconButton(
            tooltip: 'Reihenfolge ändern',
            icon: const Icon(Icons.sort_rounded),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const SortableCompetenceListPage(),
                ),
              );
            },
          ),

          // IconButton(
          //   tooltip: 'aktualisieren',
          //   icon: const Icon(Icons.update_rounded),
          //   onPressed: () {
          //     di<CompetenceFilterManager>().refreshFilteredCompetences(
          //       competences,
          //     );
          //   },
          // ),
          GenericFilterButton(
            isSearchBar: false,
            filtersActive: di<FiltersStateManager>().filtersActive,
            onLongPress: () => di<FiltersStateManager>().resetFilters(),
            showBottomSheetFunction: (context) => showGenericFilterBottomSheet(
              context: context,
              filterList: [const CompetenceFilters()],
            ),
          ),
        ],
      ),
    );
  }
}
