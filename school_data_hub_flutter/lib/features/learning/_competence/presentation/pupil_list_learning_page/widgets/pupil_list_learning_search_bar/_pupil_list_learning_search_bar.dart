import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/learning_content_selection.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_list_learning_content_nav_bar.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_list_learning_search_bar/learning_goals_infos.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_list_learning_search_bar/pupil_book_lendings_infos.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_list_learning_search_bar/pupil_workbooks_infos.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/learning_support_list_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_search_text_field.dart';

class PupilListLearningSearchBar extends StatelessWidget {
  final bool filtersOn;
  const PupilListLearningSearchBar({
    required this.filtersOn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Container(
      decoration: BoxDecoration(
        color: style.colors.canvas,
        borderRadius: BorderRadius.circular(Style.radii.small),
      ),
      child: Column(
        children: [
          Gap(Style.spacing.xs),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              height: 30,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: PupilListLearningSearchBarInfos(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Style.spacing.md, left: Style.spacing.md, right: Style.spacing.md),
            child: Row(
              children: [
                Expanded(
                  child: GenericSearchTextField(
                    searchType: SearchType.pupil,
                    hintText: 'Schueler/in suchen',
                    refreshFunction: di<PupilsFilter>().refresh,
                    onChanged: (value) =>
                        di<PupilsFilter>().textFilter.setFilterText(value),
                    searchTextSource: di<PupilsFilter>().textFilter,
                    filtersActive: di<FiltersStateManager>().filtersActive,
                    onResetFilters: di<PupilsFilter>().resetFilters,
                  ),
                ),
                GestureDetector(
                  onTap: () => showLearningSupportFilterBottomSheet(context),
                  onLongPress: () => di<PupilsFilter>().resetFilters(),
                  child: Padding(
                    padding: EdgeInsets.all(Style.spacing.md),
                    child: Icon(
                      Icons.filter_list,
                      color: filtersOn ? Style.of(context).colors.warning : Style.of(context).colors.mutedForeground,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const PupilListLearningContentNavBar(),
        ],
      ),
    );
  }
}

class PupilListLearningSearchBarInfos extends WatchingWidget {
  const PupilListLearningSearchBarInfos({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final selectedContent = watchValue(
      (LearningContentSelection s) => s.selectedContent,
    );
    final pupils = watchValue((PupilsFilter m) => m.filteredPupils);

    switch (selectedContent) {
      case SelectedContent.competenceReports:
        return const Placeholder();
      case SelectedContent.competenceStatuses:
        // Calculate total competence checks across all filtered pupils
        int totalCompetenceChecks = 0;
        for (final pupil in pupils) {
          if (pupil.competenceChecks != null) {
            totalCompetenceChecks += pupil.competenceChecks!.length;
          }
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.people_alt_rounded, color: style.colors.accent),
            Gap(Style.spacing.md),
            Text(
              pupils.length.toString(),
              style: context.typography.title,
            ),
            Gap(Style.spacing.lg),
            Text(
              'Dokumentiert: ',
              style: context.typography.bodySmall.withColor(style.colors.foreground),
            ),
            Gap(Style.spacing.xs),
            Text(
              totalCompetenceChecks.toString(),
              style: context.typography.title,
            ),
          ],
        );
      case SelectedContent.competenceGoals:
        return const LearningGoalsInfos();
      case SelectedContent.workbooks:
        return const PupilWorkbooksInfos();
      case SelectedContent.books:
        return const PupilBookLendingsInfos();
      case SelectedContent.none:
        return const PupilBookLendingsInfos();
    }
  }
}
