import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/competence_list_page/widgets/competence_list_view_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/multi_pupil_competence_check_page/multi_pupil_competence_check_view_model.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/select_competence_page/select_competence_view_model.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/select_competence_page/selectable_competence_tree.dart';

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
          )),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: AppColors.backgroundColor,
          title: const Text('Kompetenz auswählen',
              style: AppStyles.appBarTextStyle),
          // automaticallyImplyLeading: false,
        ),
        body: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Bitte eine Kompetenz auswählen!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  ...selectableCompetenceTree(
                    indentation: 0,
                    viewModel: viewModel,
                    //elementType: controller.widget.elementType
                  ),
                  const Gap(20),
                ]),
              ),
            ),
          ),
        ),
        floatingActionButton: viewModel.selectedCompetenceId != null
            ? FloatingActionButton(
                backgroundColor: AppColors.backgroundColor,
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => MultiPupilCompetenceCheck(
                        competence: viewModel.selectedCompetence!),
                  ));
                })
            : const SizedBox.shrink(),
        bottomNavigationBar:
            CompetenceListPageBottomNavBar(competences: viewModel.competences),
      ),
    );
  }
}
