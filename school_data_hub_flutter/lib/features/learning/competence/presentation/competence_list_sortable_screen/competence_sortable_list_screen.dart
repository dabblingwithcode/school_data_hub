import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/filters/competence_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/competence_list_screen/widgets/competence_filters_widget.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/competence_list_sortable_screen/widgets/competence_tree_sortable.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/post_or_patch_competence_screen/post_or_patch_competence_screen.dart';

class CompetenceSortableListScreen extends WatchingWidget {
  const CompetenceSortableListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToNewOrPatchCompetencePage({
      int? competenceId,
      Competence? competence,
    }) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (ctx) => PostOrPatchCompetenceScreen(
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
      backgroundColor: Style.of(context).colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.lightbulb_rounded,
        title: 'Kompetenzreihenfolge ändern',
      ),
      body: RefreshIndicator(
        onRefresh: () async => di<CompetenceManager>().fetchCompetences(),
        child: Padding(
          padding: EdgeInsets.only(
            top: Style.spacing.sm,
            left: Style.spacing.sm,
            right: Style.spacing.sm,
            bottom: Style.spacing.sm,
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
      bottomNavigationBar: ActionBar(
        actions: [
          TappableIcon(
            tooltip: 'Reihenfolge ändern',
            icon: const Icon(Icons.sort_rounded, size: 30),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (ctx) => const CompetenceSortableListScreen(),
                ),
              );
            },
          ),
          TappableIcon(
            tooltip: 'übergeordnete Kompetenz erstellen',
            icon: const Icon(Icons.add_rounded, size: 30),
            onPressed: () => navigateToNewOrPatchCompetencePage(),
          ),
          FilterButton(
            isSearchBar: false,
            filtersActive: di<FiltersStateManager>().filtersActive,
            onLongPress: () => di<FiltersStateManager>().resetFilters(),
            showBottomSheetFunction: (context) => showFilterSheet(
              context: context,
              filterList: [const CompetenceFilters()],
            ),
          ),
        ],
      ),
    );
  }
}
