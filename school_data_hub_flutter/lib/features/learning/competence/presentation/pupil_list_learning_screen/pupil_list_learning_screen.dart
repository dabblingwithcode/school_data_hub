import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/content_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/sliver_search_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/learning_content_selection.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/learning_list_card/learning_list_card.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/learning_list_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/pupil_list_learning_search_bar/_pupil_list_learning_search_bar.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/select_competence_screen/select_competence_view_model.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_screen.dart';
import 'package:school_data_hub_flutter/features/learning/services/learning_goals_pdf_generator.dart';

class PupilListLearningScreen extends WatchingWidget {
  const PupilListLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pupilsFilter = di<PupilsFilter>();
    bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);
    final selectedContent = watchValue(
      (LearningContentSelection s) => s.selectedContent,
    );

    return Scaffold(
      backgroundColor: Style.of(context).colors.canvas,
      appBar: const AppHeader(
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
                SliverSearchBar(
                  height: 180,
                  searchWidgetWithStatsRow: PupilListLearningSearchBar(
                    filtersOn: filtersOn,
                  ),
                ),
                ContentSliverList(
                  itemsListenable: pupilsFilter.filteredPupils,
                  itemBuilder: (_, pupil) => LearningListCard(pupil),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ActionBar(
        actions: [
          if (di<HubSessionManager>().isAdmin &&
              selectedContent == SelectedContent.competenceStatuses)
            TappableIcon(
              tooltip: 'Kompetenz hinzufuegen',
              icon: const Icon(Icons.add_a_photo_rounded, size: 30),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute<void>(
                    builder: (ctx) => const SelectCompetence(),
                  ),
                );
              },
            ),

          if (di<HubSessionManager>().isAdmin &&
              selectedContent == SelectedContent.competenceGoals)
            TappableIcon(
              tooltip: 'PDF drucken',
              icon: const Icon(Icons.print_rounded, size: 30),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute<void>(
                    builder: (context) => PdfViewerScreen(
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
          FilterButton(
            isSearchBar: false,
            filtersActive: di<FiltersStateManager>().filtersActive,
            onLongPress: () => di<FiltersStateManager>().resetFilters(),
            showBottomSheetFunction: showLearningFilterBottomSheet,
          ),
        ],
      ),
    );
  }
}
