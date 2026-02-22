import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/pupil_list_learning_content_nav_bar.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/pupil_list_learning_search_bar/learning_goals_infos.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/pupil_list_learning_search_bar/pupil_book_lendings_infos.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/pupil_list_learning_search_bar/pupil_workbooks_infos.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/learning_support_list_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_search_text_field.dart';

class PupilListLearningSearchBar extends StatelessWidget {
  //final List<PupilProxy> pupils;
  final bool filtersOn;
  const PupilListLearningSearchBar({
    required this.filtersOn,
    // required this.pupils,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.canvasColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Gap(5),
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
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: PupilSearchTextField(
                    searchType: SearchType.pupil,
                    hintText: 'Schüler/in suchen',
                    refreshFunction: di<PupilsFilter>().refreshs,
                  ),
                ),
                InkWell(
                  onTap: () => showLearningSupportFilterBottomSheet(context),
                  onLongPress: () => di<PupilsFilter>().resetFilters(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.filter_list,
                      color: filtersOn ? Colors.deepOrange : Colors.grey,
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
    final selectedContent = watchValue(
      (CompetenceManager m) => m.selectedLearningContent,
    );
    final pupils = watchValue((PupilsFilter m) => m.filteredPupils);

    switch (selectedContent) {
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
            Icon(Icons.people_alt_rounded, color: AppColors.backgroundColor),
            const Gap(10),
            Text(
              pupils.length.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Gap(15),
            const Text(
              'Dokumentiert: ',
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
            const Gap(5),
            Text(
              totalCompetenceChecks.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
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
