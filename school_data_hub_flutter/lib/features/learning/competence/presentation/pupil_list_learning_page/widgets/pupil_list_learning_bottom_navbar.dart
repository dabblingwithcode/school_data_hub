import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/services/learning_goals_pdf_generator.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_page/widgets/learning_list_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/select_competence_page/select_competence_view_model.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';

class PupilListLearningBottomNavBar extends WatchingWidget {
  final bool filtersOn;
  const PupilListLearningBottomNavBar({required this.filtersOn, super.key});

  @override
  Widget build(BuildContext context) {
    final selectedContent = watchValue(
      (CompetenceManager m) => m.selectedLearningContent,
    );
    final pupils = watchValue((PupilsFilter x) => x.filteredPupils);
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        //padding: const EdgeInsets.all(15),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              const Spacer(),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, size: 30),
              ),

              if (di<HubSessionManager>().isAdmin &&
                  selectedContent == SelectedContent.competenceStatuses) ...[
                const Gap(30),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const SelectCompetence(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add_a_photo_rounded, size: 30),
                ),
              ],

              if (di<HubSessionManager>().isAdmin &&
                  selectedContent == SelectedContent.competenceGoals) ...[
                const Gap(30),
                InkWell(
                  onTap: () async {
                    try {
                      final pdfFile =
                          await LearningGoalsPdfGenerator.generateLearningGoalsPdf(
                            pupils: pupils,
                          );
                      if (context.mounted) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                LearningGoalsPdfViewPage(pdfFile: pdfFile),
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Fehler beim Erstellen der PDF: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: const Icon(Icons.print_rounded, size: 30),
                ),
                // IconButton(
                //   tooltip: 'PDF drucken',
                //   icon: const Icon(Icons.print_rounded, size: 30),
                //   onPressed:
                // ),
              ],
              const Gap(30),
              InkWell(
                onTap: () => showLearningFilterBottomSheet(context),
                onLongPress: () => di<FiltersStateManager>().resetFilters(),
                child: Icon(
                  Icons.filter_list,
                  color: filtersOn ? Colors.deepOrange : Colors.white,
                  size: 30,
                ),
              ),

              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
