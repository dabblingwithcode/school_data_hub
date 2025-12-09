import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/learning_list_card/workbooks_info_switch.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_competence_checks/competence_checks_badges.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_learning_content/pupil_learning_content_books.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_learning_content/pupil_learning_content_competence_goals.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_learning_content/pupil_learning_content_competence_statuses.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_learning_content/pupil_learning_content_workbooks.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/widgets/pupil_learning_content_expansion_tile_nav_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

class LearningListCard extends WatchingWidget {
  final PupilProxy pupil;
  const LearningListCard(this.pupil, {super.key});

  @override
  Widget build(BuildContext context) {
    watch(pupil);

    final expansionTileController = createOnce<CustomExpansionTileController>(
      () => CustomExpansionTileController(),
    );
    final selectedContentNotifier = SelectedLearningContentNotifier();
    final selectedContent = watchPropertyValue(
      (m) => m.selectedContent,
      target: selectedContentNotifier,
    );
    final competenceCheckstats = CompetenceHelper.competenceChecksStats(pupil);
    final totalCompetencesToReport = competenceCheckstats.total;
    final totalCompetencesChecked = competenceCheckstats.checked;

    // Calculate book lending statistics for this pupil
    final pupilBookLendings = pupil.pupilBookLendings ?? [];
    final totalLendings = pupilBookLendings.length;
    final notReturnedLendings = pupilBookLendings
        .where((lending) => lending.returnedAt == null)
        .length;

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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) =>
                                        PupilProfilePage(pupil: pupil),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    pupil.firstName,
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
                                    pupil.lastName,
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
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Gap(5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.book,
                                  size: 30,
                                  color: AppColors.interactiveColor,
                                ),
                                const Gap(5),
                                const Text(
                                  'Gelesen: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            if (selectedContent ==
                                SelectedContent.competenceStatuses) ...[
                              CustomExpansionTileSwitch(
                                includeSwitch: true,
                                switchColor: AppColors.interactiveColor,
                                customExpansionTileController:
                                    expansionTileController,
                                expansionSwitchWidget: CompetenceChecksBadges(
                                  pupil: pupil,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('Items dokumentiert: '),
                                  const Gap(5),
                                  Text(
                                    '$totalCompetencesChecked/$totalCompetencesToReport',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.backgroundColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            if (selectedContent ==
                                SelectedContent.competenceGoals) ...[
                              CustomExpansionTileSwitch(
                                customExpansionTileController:
                                    expansionTileController,
                                expansionSwitchWidget: const Text(
                                  'Lernziele sind noch nicht implementiert',
                                ),
                              ),
                            ],
                            if (selectedContent ==
                                SelectedContent.workbooks) ...[
                              CustomExpansionTileSwitch(
                                customExpansionTileController:
                                    expansionTileController,
                                expansionSwitchWidget: WorkbooksInfoSwitch(
                                  pupil: pupil,
                                ),
                                includeSwitch: true,
                                switchColor: AppColors.interactiveColor,
                              ),
                            ],
                            if (selectedContent == SelectedContent.books) ...[
                              CustomExpansionTileSwitch(
                                customExpansionTileController:
                                    expansionTileController,
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
                                        const Text(
                                          'gesamt',
                                          style: TextStyle(fontSize: 10),
                                        ),
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
                                        const Text(
                                          'aktiv',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    const Gap(15),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(5),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
          //   child: PupilLearningContentExpansionTileNavBar(
          //     pupil: pupil,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
            child: CustomExpansionTileContent(
              title: null,
              tileController: expansionTileController,
              widgetList: [
                if (selectedContent == SelectedContent.competenceStatuses)
                  PupilLearningContentCompetenceStatuses(pupil: pupil),
                if (selectedContent == SelectedContent.competenceGoals)
                  PupilLearningContentCompetenceGoals(pupil: pupil),
                if (selectedContent == SelectedContent.workbooks)
                  PupilLearningContentWorkbooks(pupil: pupil),
                if (selectedContent == SelectedContent.books)
                  PupilLearningContentBooks(pupil: pupil),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
