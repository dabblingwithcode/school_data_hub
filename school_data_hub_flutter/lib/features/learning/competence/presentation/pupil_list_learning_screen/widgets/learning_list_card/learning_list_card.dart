import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_book_lending_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/learning_content_selection.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/learning_list_card/learning_goals_overview.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/learning_list_card/workbooks_competence_overview.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/pupil_competence_checks/competence_checks_badges.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/pupil_learning_content/pupil_learning_content_books.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/pupil_learning_content/pupil_learning_content_competence_goals.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/pupil_learning_content/pupil_learning_content_competence_reports.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/pupil_learning_content/pupil_learning_content_competence_statuses.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/widgets/pupil_learning_content/pupil_learning_content_workbooks.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/pupil_competence_report_screen/pupil_competence_report_screen.dart';

class LearningListCard extends WatchingWidget {
  final PupilProxy pupil;
  const LearningListCard(this.pupil, {super.key});

  @override
  Widget build(BuildContext context) {
    final expansionTileController = createOnce<ExpansionController>(
      () => ExpansionController(),
    );

    return CardBox(
      padding: EdgeInsets.all(Style.spacing.sm),
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
                    Gap(Style.spacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: GestureDetector(
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
                    Gap(Style.spacing.xs),
                    _LearningListContent(
                      pupil: pupil,
                      expansionTileController: expansionTileController,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(Style.spacing.xs),
          _LearningListExpansionContent(
            pupil: pupil,
            expansionTileController: expansionTileController,
          ),
        ],
      ),
    );
  }
}

/// Rebuilds only when [LearningContentSelection.selectedContent] changes.
class _LearningListContent extends WatchingWidget {
  final PupilProxy pupil;
  final ExpansionController expansionTileController;

  const _LearningListContent({
    required this.pupil,
    required this.expansionTileController,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final selectedContent = watchValue(
      (LearningContentSelection s) => s.selectedContent,
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (selectedContent == SelectedContent.books)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.book, size: 30, color: style.colors.interactive),
                  Gap(Style.spacing.xs),
                  Text('Gelesen: ', style: context.typography.subtitle.bold),
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
                ExpansionHeader(
                  includeSwitch: true,
                  switchColor: style.colors.interactive,
                  expansionController: expansionTileController,
                  expansionSwitchWidget: CompetenceChecksBadges(pupil: pupil),
                ),
                _CompetenceStatsRow(pupil: pupil),
              ],
              SelectedContent.competenceGoals => [
                ExpansionHeader(
                  includeSwitch: true,
                  switchColor: style.colors.interactive,
                  expansionController: expansionTileController,
                  expansionSwitchWidget: LearningGoalsOverview(pupil: pupil),
                ),
              ],
              SelectedContent.workbooks => [
                ExpansionHeader(
                  expansionController: expansionTileController,
                  expansionSwitchWidget: WorkbooksOverview(pupil: pupil),
                  includeSwitch: true,
                  switchColor: style.colors.interactive,
                ),
              ],
              SelectedContent.books => [
                ExpansionHeader(
                  expansionController: expansionTileController,
                  expansionSwitchWidget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Gap(Style.spacing.md),
                      Column(
                        children: [
                          Text(
                            totalLendings.toString(),
                            style: context.typography.display.withColor(
                              style.colors.success,
                            ),
                          ),
                          Text('gesamt', style: context.typography.caption),
                        ],
                      ),
                      Gap(Style.spacing.md),
                      Column(
                        children: [
                          Text(
                            notReturnedLendings.toString(),
                            style: context.typography.display.withColor(
                              style.colors.warning,
                            ),
                          ),
                          Text('aktiv', style: context.typography.caption),
                        ],
                      ),
                      Gap(Style.spacing.lg),
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
                        color: style.colors.interactive,
                      ),
                      onPressed: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(
                            builder: (ctx) =>
                                PupilCompetenceReportScreen(pupil: pupil),
                          ),
                        );
                      },
                    ),
                    Gap(Style.spacing.md),
                    ExpansionHeader(
                      expansionController: expansionTileController,
                      includeSwitch: true,
                      switchColor: style.colors.interactive,
                    ),
                    Gap(Style.spacing.md),
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

/// Rebuilds only when [LearningContentSelection.selectedContent] changes.
class _LearningListExpansionContent extends WatchingWidget {
  final PupilProxy pupil;
  final ExpansionController expansionTileController;

  const _LearningListExpansionContent({
    required this.pupil,
    required this.expansionTileController,
  });

  @override
  Widget build(BuildContext context) {
    final selectedContent = watchValue(
      (LearningContentSelection s) => s.selectedContent,
    );

    return Padding(
      padding: EdgeInsets.only(
        top: Style.spacing.xs,
        left: Style.spacing.xs,
        right: Style.spacing.xs,
      ),
      child: ExpansionBody(
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
    final style = Style.of(context);
    watchPropertyValue((m) => m.competenceChecks, target: pupil);
    final stats = CompetenceHelper.competenceChecksStats(pupil);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Items dokumentiert: '),
        Gap(Style.spacing.xs),
        Text(
          '${stats.checked}/${stats.total}',
          style: context.typography.bodySmall.bold.withColor(
            style.colors.accent,
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
    final style = Style.of(context);
    final firstName = watchPropertyValue((m) => m.firstName, target: pupil);
    final lastName = watchPropertyValue((m) => m.lastName, target: pupil);
    return Row(
      children: [
        Text(
          firstName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: context.typography.title.withColor(style.colors.foreground),
        ),
        Gap(Style.spacing.xs),
        Text(
          lastName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: context.typography.title.w400.withColor(
            style.colors.foreground,
          ),
        ),
      ],
    );
  }
}
