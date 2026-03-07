import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/generate_uuid.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_search_bar_with_stats.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_list_page/widgets/credit_list_search_bar_stats.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/multi_pupil_competence_check_page/widgets/competence_parents_names_widget.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/multi_pupil_competence_check_page/widgets/multi_pupil_competence_check_card.dart';

class MultiPupilCompetenceCheckPage extends WatchingWidget {
  final Competence competence;

  const MultiPupilCompetenceCheckPage({required this.competence, super.key});

  @override
  Widget build(BuildContext context) {
    // Create local observables once - auto-disposed when widget is destroyed
    final groupCheckNameController = createOnce(() => TextEditingController());
    final groupCheckNameNotifier = createOnce(() => ValueNotifier<String>(''));
    final groupId = createOnce(() => generateCustomUuid());

    // Watch the group check name reactively
    final groupCheckName = watch(groupCheckNameNotifier).value;

    // Watch filtered pupils and apply competence filter
    final pupilsFilter = di<PupilsFilter>();
    final filterStateManager = di<FiltersStateManager>();
    final filteredPupils = watchValue((PupilsFilter x) => x.filteredPupils);
    final competenceFilteredPupils = _getFilteredPupilsWithCompetence(
      competence: competence,
      pupilsToBeFiltered: filteredPupils,
    );
    final competenceFilteredPupilsListenable =
        createOnce(() => ValueNotifier<List<PupilProxy>>([]));
    competenceFilteredPupilsListenable.value = competenceFilteredPupils;

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        title: 'Kompetenz dokumentieren',
        iconData: Icons.group_add_rounded,
      ),
      body: RefreshIndicator(
        onRefresh: () async => di<PupilProxyManager>().fetchAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: CompetenceHelper.getCompetenceColor(
                        competence.publicId,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...competenceTreeAncestorsNames(
                                  competenceId: competence.publicId,
                                  categoryColor:
                                      CompetenceHelper.getCompetenceColor(
                                        competence.publicId,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  child: TextField(
                    controller: groupCheckNameController,
                    onChanged: (value) {
                      groupCheckNameNotifier.value = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Gruppenname (optional)',
                      hintText: 'z.B. Mathetest, Leseübung...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      // const SliverGap(5),
                      GenericSliverAppBarWithSearchWidget(
                        height: 110,
                        searchWidgetWithStatsRow: GenericListSearchBarWithStats(
                          statsWidget: CreditListSearchBarStats(
                            filteredPupils: competenceFilteredPupilsListenable,
                          ),
                          searchType: SearchType.pupil,
                          hintText: 'Schüler/in suchen',
                          refreshFunction: pupilsFilter.refreshs,
                          onChanged: (value) =>
                              pupilsFilter.textFilter.setFilterText(value),
                          searchTextSource: pupilsFilter.textFilter,
                          filtersActive: filterStateManager.filtersActive,
                          onResetFilters: filterStateManager.resetFilters,
                          showFilterBottomSheet: (context) =>
                              showGenericFilterBottomSheet(
                            context: context,
                            filterList: [const CommonPupilFiltersWidget()],
                          ),
                        ),
                      ),
                      GenericSliverListWithEmptyListCheck(
                        itemsListenable: competenceFilteredPupilsListenable,
                        itemBuilder: (_, pupil) =>
                            MultiPupilCompetenceCheckCard(
                              passedPupil: pupil,
                              groupId: groupId,
                              groupCheckName: groupCheckName.isEmpty
                                  ? null
                                  : groupCheckName,
                              competenceId: competence.publicId,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check, size: 30),
          ),
          GenericFilterButton(
            isSearchBar: false,
            filtersActive: di<FiltersStateManager>().filtersActive,
            onLongPress: () => di<FiltersStateManager>().resetFilters(),
            showBottomSheetFunction: (context) => showGenericFilterBottomSheet(
              context: context,
              filterList: [const CommonPupilFiltersWidget()],
            ),
          ),
        ],
      ),
      // const MultiPupilCompetenceCheckPageBottomNavBar(),
    );
  }

  // Filter pupils based on competence (helper method)
  List<PupilProxy> _getFilteredPupilsWithCompetence({
    required Competence competence,
    required List<PupilProxy> pupilsToBeFiltered,
  }) {
    List<PupilProxy> pupils = [];

    for (PupilProxy pupil in pupilsToBeFiltered) {
      if (pupil.specialNeeds != null && pupil.specialNeeds!.contains('LE')) {
        pupils.add(pupil);
        continue;
      } else {
        final allowedCompetences =
            CompetenceHelper.getAllowedCompetencesForThisPupil(pupil);

        if (allowedCompetences.contains(competence)) {
          pupils.add(pupil);
          continue;
        }
      }
    }
    return pupils;
  }
}
