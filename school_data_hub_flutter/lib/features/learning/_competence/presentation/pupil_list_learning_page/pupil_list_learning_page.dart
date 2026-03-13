import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/learning_list_card/learning_list_card.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/learning_list_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_list_learning_search_bar/_pupil_list_learning_search_bar.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/select_competence_page/select_competence_view_model.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/services/learning_goals_pdf_generator.dart';

class PupilListLearningPage extends WatchingWidget {
  const PupilListLearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pupilsFilter = di<PupilsFilter>();
    bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);
    final selectedContent = watchValue(
      (CompetenceManager m) => m.selectedLearningContent,
    );

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.lightbulb_rounded,
        title: 'Lernen',
      ),
      body: RefreshIndicator(
        onRefresh: () async => di<PupilProxyManager>().fetchAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: CustomScrollView(
              slivers: [
                GenericSliverAppBarWithSearchWidget(
                  height: 180,
                  searchWidgetWithStatsRow: PupilListLearningSearchBar(
                    filtersOn: filtersOn,
                  ),
                ),
                GenericSliverListWithEmptyListCheck(
                  itemsListenable: pupilsFilter.filteredPupils,
                  itemBuilder: (_, pupil) => LearningListCard(pupil),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          if (di<HubSessionManager>().isAdmin &&
              selectedContent == SelectedContent.competenceStatuses)
            IconButton(
              tooltip: 'Kompetenz hinzufügen',
              icon: const Icon(Icons.add_a_photo_rounded, size: 30),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (ctx) => const SelectCompetence(),
                  ),
                );
              },
            ),

          if (di<HubSessionManager>().isAdmin &&
              selectedContent == SelectedContent.competenceGoals)
            IconButton(
              tooltip: 'PDF drucken',
              icon: const Icon(Icons.print_rounded, size: 30),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => PdfViewerPage(
                      pdfGenerator: () =>
                          LearningGoalsPdfGenerator.generateLearningGoalsPdf(
                            pupils: pupilsFilter.filteredPupils.value,
                          ),
                      title: 'Lernziele PDF',
                      iconData: Icons.lightbulb_rounded,
                    ),
                  ),
                );
              },
            ),
          GenericFilterButton(
            isSearchBar: false,
            filtersActive: di<FiltersStateManager>().filtersActive,
            onLongPress: () => di<FiltersStateManager>().resetFilters(),
            showBottomSheetFunction: showLearningFilterBottomSheet,
          ),
        ],
      ),

      // PupilListLearningBottomNavBar(filtersOn: filtersOn),
    );
  }
}
