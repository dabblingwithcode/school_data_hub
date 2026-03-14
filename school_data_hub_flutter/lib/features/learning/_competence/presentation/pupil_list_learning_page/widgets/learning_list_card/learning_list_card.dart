import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_book_lending_manager.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/learning_list_card/learning_goals_overview.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/learning_list_card/workbooks_competence_overview.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_competence_checks/competence_checks_badges.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_learning_content/pupil_learning_content_books.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_learning_content/pupil_learning_content_competence_goals.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_learning_content/pupil_learning_content_competence_reports.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_learning_content/pupil_learning_content_competence_statuses.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_learning_content/pupil_learning_content_workbooks.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/pupil_competence_report_page/pupil_competence_report_page.dart';

class LearningListCard extends WatchingWidget {
  final PupilProxy pupil;
  const LearningListCard(this.pupil, {super.key});

  @override
  Widget build(BuildContext context) {
    final expansionTileController = createOnce<CustomExpansionTileController>(
      () => CustomExpansionTileController(),
    );

    // callOnce(
    //   (_) => di<CompetenceReportManager>().fetchReportsForPupil(pupil.pupilId),
    // );

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin: const EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        top: 4.0,
        bottom: 4.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AvatarWithBadges(pupil: pupil, size: 80),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              onTap: () {
                                di<BottomNavManager>().setPupilProfileNavPage(
                                  ProfileNavigationState.learning.value,
                                );
                                Navigator.of(context).push<void>(
                                  MaterialPageRoute<void>(
                                    builder: (ctx) =>
                                        PupilProfilePage(pupil: pupil),
                                  ),
                                );
                              },
                              child: _LearningListNameRow(pupil: pupil),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    _LearningListContent(
                      pupil: pupil,
                      expansionTileController: expansionTileController,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(5),
          _LearningListExpansionContent(
            pupil: pupil,
            expansionTileController: expansionTileController,
          ),
        ],
      ),
    );
  }
}

/// Rebuilds only when [CompetenceManager.selectedLearningContent] changes.
class _LearningListContent extends WatchingWidget {
  final PupilProxy pupil;
  final CustomExpansionTileController expansionTileController;

  const _LearningListContent({
    required this.pupil,
    required this.expansionTileController,
  });

  @override
  Widget build(BuildContext context) {
    final selectedContent = watchValue(
      (CompetenceManager m) => m.selectedLearningContent,
    );

    final pupilBookLendingManager = di<PupilBookLendingManager>();
    final pupilBookLendings = pupilBookLendingManager.getPupilBookLendings(
      pupil.pupilId,
    );
    final totalLendings = pupilBookLendings.length;
    final notReturnedLendings = pupilBookLendings
        .where((lending) => lending.returnedAt == null)
        .length;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (selectedContent == SelectedContent.books)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.book, size: 30, color: AppColors.interactiveColor),
                  const Gap(5),
                  const Text(
                    'Gelesen: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...switch (selectedContent) {
              SelectedContent.competenceStatuses => [
                CustomExpansionTileSwitch(
                  includeSwitch: true,
                  switchColor: AppColors.interactiveColor,
                  customExpansionTileController: expansionTileController,
                  expansionSwitchWidget: CompetenceChecksBadges(pupil: pupil),
                ),
                _CompetenceStatsRow(pupil: pupil),
              ],
              SelectedContent.competenceGoals => [
                CustomExpansionTileSwitch(
                  includeSwitch: true,
                  switchColor: AppColors.interactiveColor,
                  customExpansionTileController: expansionTileController,
                  expansionSwitchWidget: LearningGoalsOverview(pupil: pupil),
                ),
              ],
              SelectedContent.workbooks => [
                CustomExpansionTileSwitch(
                  customExpansionTileController: expansionTileController,
                  expansionSwitchWidget: WorkbooksOverview(pupil: pupil),
                  includeSwitch: true,
                  switchColor: AppColors.interactiveColor,
                ),
              ],
              SelectedContent.books => [
                CustomExpansionTileSwitch(
                  customExpansionTileController: expansionTileController,
                  expansionSwitchWidget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Gap(10),
                      Column(
                        children: [
                          Text(
                            totalLendings.toString(),
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const Text('gesamt', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                      const Gap(10),
                      Column(
                        children: [
                          Text(
                            notReturnedLendings.toString(),
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          const Text('aktiv', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                      const Gap(15),
                    ],
                  ),
                ),
              ],
              SelectedContent.competenceReports => [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.assignment,
                        color: AppColors.interactiveColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(
                            builder: (ctx) =>
                                PupilCompetenceReportPage(pupil: pupil),
                          ),
                        );
                      },
                    ),
                    const Gap(10),
                    CustomExpansionTileSwitch(
                      customExpansionTileController: expansionTileController,
                      includeSwitch: true,
                      switchColor: AppColors.interactiveColor,
                    ),
                    const Gap(10),
                  ],
                ),
              ],
              SelectedContent.none => [],
            },
          ],
        ),
      ],
    );
  }
}

/// Rebuilds only when [CompetenceManager.selectedLearningContent] changes.
class _LearningListExpansionContent extends WatchingWidget {
  final PupilProxy pupil;
  final CustomExpansionTileController expansionTileController;

  const _LearningListExpansionContent({
    required this.pupil,
    required this.expansionTileController,
  });

  @override
  Widget build(BuildContext context) {
    final selectedContent = watchValue(
      (CompetenceManager m) => m.selectedLearningContent,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: CustomExpansionTileContent(
        title: null,
        tileController: expansionTileController,
        widgetList: [
          ...switch (selectedContent) {
            SelectedContent.competenceStatuses => [
              PupilLearningContentCompetenceStatuses(pupil: pupil),
            ],
            SelectedContent.competenceGoals => [
              PupilLearningContentCompetenceGoals(pupil: pupil),
            ],
            SelectedContent.workbooks => [
              PupilLearningContentWorkbooks(pupil: pupil),
            ],
            SelectedContent.books => [PupilLearningContentBooks(pupil: pupil)],
            SelectedContent.competenceReports => [
              PupilLearningContentCompetenceReports(pupil: pupil),
            ],
            SelectedContent.none => [],
          },
        ],
      ),
    );
  }
}

/// Rebuilds only when [pupil.competenceChecks] changes.
class _CompetenceStatsRow extends WatchingWidget {
  final PupilProxy pupil;

  const _CompetenceStatsRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    watchPropertyValue((m) => m.competenceChecks, target: pupil);
    final stats = CompetenceHelper.competenceChecksStats(pupil);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Items dokumentiert: '),
        const Gap(5),
        Text(
          '${stats.checked}/${stats.total}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.backgroundColor,
          ),
        ),
      ],
    );
  }
}

/// Rebuilds only when [pupil.firstName] or [pupil.lastName] changes.
class _LearningListNameRow extends WatchingWidget {
  final PupilProxy pupil;

  const _LearningListNameRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final firstName = watchPropertyValue((m) => m.firstName, target: pupil);
    final lastName = watchPropertyValue((m) => m.lastName, target: pupil);
    return Row(
      children: [
        Text(
          firstName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Gap(5),
        Text(
          lastName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
