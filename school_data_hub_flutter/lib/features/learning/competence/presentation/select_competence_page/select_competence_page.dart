import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_button.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/competence_list_page/widgets/competence_filters_widget.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/multi_pupil_competence_check_page/multi_pupil_competence_check_page.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/select_competence_page/select_competence_view_model.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/select_competence_page/selectable_competence_tree.dart';

class SelectCompetencePage extends StatelessWidget {
  final SelectCompetenceViewModel viewModel;
  const SelectCompetencePage(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.white,
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.all(Colors.white),
          // overlayColor: MaterialStateProperty.all(Colors.green),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: AppColors.backgroundColor,
          title: const Text(
            'Kompetenz auswählen',
            style: AppStyles.appBarTextStyle,
          ),
          // automaticallyImplyLeading: false,
        ),
        body: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RadioGroup<int>(
                  groupValue: viewModel.selectedCompetenceId,
                  onChanged: (int? value) {
                    if (value != null) viewModel.selectCompetence(value);
                  },
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Bitte eine Kompetenz auswählen!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...selectableCompetenceTree(
                        indentation: 0,
                        viewModel: viewModel,
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: viewModel.selectedCompetenceId != null
              ? AppColors.backgroundColor
              : Colors.grey,
          onPressed: viewModel.selectedCompetenceId != null
              ? () {
                  if (viewModel.widget.onSelected != null) {
                    viewModel.widget.onSelected!(
                      context,
                      viewModel.selectedCompetence!,
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => MultiPupilCompetenceCheckPage(
                          competence: viewModel.selectedCompetence!,
                        ),
                      ),
                    );
                  }
                }
              : null,
          child: const Icon(Icons.check, color: Colors.white, size: 35),
        ),
        bottomNavigationBar: GenericBottomNavBar(
          actions: [
            GenericFilterButton(
              isSearchBar: false,
              filtersActive: di<FiltersStateManager>().filtersActive,
              onLongPress: () => di<FiltersStateManager>().resetFilters(),
              showBottomSheetFunction: (context) =>
                  showGenericFilterBottomSheet(
                    context: context,
                    filterList: [const CompetenceFilters()],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
