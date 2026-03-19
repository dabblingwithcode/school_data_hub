import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/competence_list_screen/widgets/competence_filters_widget.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/multi_pupil_competence_check_screen/multi_pupil_competence_check_screen.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/select_competence_screen/select_competence_view_model.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/select_competence_screen/selectable_competence_tree.dart';

class SelectCompetenceScreen extends StatelessWidget {
  final SelectCompetenceViewModel viewModel;
  const SelectCompetenceScreen(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: style.colors.background,
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.all(style.colors.background),
        ),
      ),
      child: Scaffold(
        backgroundColor: style.colors.canvas,
        appBar: AppBar(
          foregroundColor: style.colors.background,
          centerTitle: true,
          backgroundColor: style.colors.accent,
          title: Text(
            'Kompetenz auswählen',
            style: context.typography.heading.withColor(
              style.colors.background,
            ),
          ),
        ),
        body: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(Style.spacing.sm),
                child: RadioGroup<int>(
                  groupValue: viewModel.selectedCompetenceId,
                  onChanged: (int? value) {
                    if (value != null) viewModel.selectCompetence(value);
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(Style.spacing.sm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Bitte eine Kompetenz auswählen!',
                              style: context.typography.title,
                            ),
                          ],
                        ),
                      ),
                      ...selectableCompetenceTree(
                        context: context,
                        indentation: 0,
                        viewModel: viewModel,
                      ),
                      Gap(Style.spacing.xl),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: viewModel.selectedCompetenceId != null
              ? style.colors.accent
              : style.colors.mutedForeground,
          onPressed: viewModel.selectedCompetenceId != null
              ? () {
                  if (viewModel.widget.onSelected != null) {
                    viewModel.widget.onSelected!(
                      context,
                      viewModel.selectedCompetence!,
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (ctx) => MultiPupilCompetenceCheckScreen(
                          competence: viewModel.selectedCompetence!,
                        ),
                      ),
                    );
                  }
                }
              : null,
          child: Icon(Icons.check, color: style.colors.background, size: 35),
        ),
        bottomNavigationBar: ActionBar(
          actions: [
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
      ),
    );
  }
}
