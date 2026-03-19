import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/generic_async_action_button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/hub_documents_section.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/pupil_proxy_learning_support_ext.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_page/controller/new_support_category_status_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/support_goal_check_dialog.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_entry/support_category_status_entry.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_entry/support_category_status_symbol.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_goal/support_category_badge.dart';

class SupportGoalCard extends WatchingWidget {
  final PupilProxy pupil;
  final int goalIndex;
  final bool showCategoryBadge;
  const SupportGoalCard({
    required this.pupil,
    required this.goalIndex,
    this.showCategoryBadge = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    return Padding(
      padding: EdgeInsets.only(bottom: Style.spacing.sm),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Style.radii.large),
        child: GestureDetector(
          onLongPress: () async {
            final bool? delete = await confirmationDialog(
              context: context,
              title: 'Förderziel löschen',
              message: 'Förderziel löschen?',
            );
            if (delete == true) {
              await di<LearningSupportManager>().deleteSupportGoal(
                pupilId: pupil.pupilId,
                supportGoalId: pupil.supportGoals[goalIndex].id!,
              );
              return;
            }
            return;
          },
          child: CardBox(
            variant: CardBoxVariant.filledSecondary,
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(Style.spacing.xs),
                if (showCategoryBadge)
                  _CategoryBadgeRow(pupil: pupil, goalIndex: goalIndex),
                Gap(Style.spacing.xs),
                _GoalDescriptionRow(pupil: pupil, goalIndex: goalIndex),
                _StrategiesSection(pupil: pupil, goalIndex: goalIndex),
                Gap(Style.spacing.xs),
                _CreatedByRow(pupil: pupil, goalIndex: goalIndex),
                Gap(Style.spacing.md),
                _GoalChecksSection(pupil: pupil, goalIndex: goalIndex),
                Gap(Style.spacing.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryBadgeRow extends WatchingWidget {
  final PupilProxy pupil;
  final int goalIndex;
  const _CategoryBadgeRow({required this.pupil, required this.goalIndex});

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    final style = Style.of(context);
    final learningSupportManager = di<SupportCategoryManager>();
    final goal = pupil.supportGoals[goalIndex];
    final categoryId = goal.supportCategoryId;

    return Row(
      children: [
        Gap(Style.spacing.xs),
        Padding(
          padding: EdgeInsets.only(
            top: Style.spacing.sm,
            bottom: Style.spacing.sm,
            left: Style.spacing.md,
            right: Style.spacing.md,
          ),
          child: SupportCategoryBadge(categoryId: categoryId, size: 40),
        ),
        Gap(Style.spacing.xs),
        Expanded(
          child: GestureDetector(
            onTap: () {
              final statuses =
                  pupil.supportCategoryStatuses
                      ?.where((s) => s.supportCategoryId == categoryId)
                      .toList() ??
                  [];
              showDialog<void>(
                context: context,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Style.radii.large),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                      maxHeight: 600,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(Style.spacing.lg),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SupportCategoryBadge(categoryId: categoryId),
                              Gap(Style.spacing.md),
                              Flexible(
                                child: Text(
                                  learningSupportManager
                                      .getSupportCategory(categoryId)
                                      .name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.typography.title,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          if (statuses.isEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: Style.spacing.lg),
                              child: Text(
                                'Keine Status vorhanden',
                                style: context.typography.body.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: style.colors.mutedForeground,
                                ),
                              ),
                            )
                          else
                            Flexible(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: statuses.length,
                                itemBuilder: (context, index) {
                                  return SupportCategoryStatusEntry(
                                    pupil: pupil,
                                    status: statuses[index],
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Text(
              learningSupportManager.getSupportCategory(categoryId).name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.typography.subtitle.bold.withColor(
                style.colors.interactive,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: Style.spacing.xs, right: Style.spacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LastSupportCategoryStatusSymbol(
                size: 40,
                pupil: pupil,
                categoryId: categoryId,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GoalDescriptionRow extends WatchingWidget {
  final PupilProxy pupil;
  final int goalIndex;
  const _GoalDescriptionRow({required this.pupil, required this.goalIndex});

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    final style = Style.of(context);
    final goal = pupil.supportGoals[goalIndex];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(Style.spacing.lg),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (ctx) => NewSupportCategoryStatus(
                    appBarTitle: 'Förderziel bearbeiten',
                    pupilId: pupil.pupilId,
                    goalCategoryId: goal.supportCategoryId,
                    elementType: 'goal',
                    existingGoal: goal,
                  ),
                ),
              );
            },
            child: Text(
              goal.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.typography.title.withColor(
                style.colors.mutedForeground,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CreatedByRow extends WatchingWidget {
  final PupilProxy pupil;
  final int goalIndex;
  const _CreatedByRow({required this.pupil, required this.goalIndex});

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    final goal = pupil.supportGoals[goalIndex];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Erstellt von:', style: context.typography.bodySmall),
        Gap(Style.spacing.xs),
        Text(
          goal.createdBy,
          style: context.typography.bodySmall.bold,
        ),
        Gap(Style.spacing.xs),
        Text('am', style: context.typography.bodySmall),
        Gap(Style.spacing.xs),
        Text(
          goal.createdAt.toLocal().formatDateForUser(),
          style: context.typography.bodySmall.bold,
        ),
        Gap(Style.spacing.md),
      ],
    );
  }
}

class _StrategiesSection extends WatchingWidget {
  final PupilProxy pupil;
  final int goalIndex;
  const _StrategiesSection({required this.pupil, required this.goalIndex});

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    final tileController = createOnce(() => ExpansionController());
    final isExpanded = watch(tileController.isExpanded).value;
    final strategies = pupil.supportGoals[goalIndex].strategies;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => tileController.toggle(),
          child: Row(
            children: [
              Gap(Style.spacing.lg),
              Text(
                'Strategien',
                style: context.typography.body.bold,
              ),
              const Spacer(),
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                size: 30,
              ),
              Gap(Style.spacing.md),
            ],
          ),
        ),
        ExpansionBody(
          tileController: tileController,
          widgetList: [
            Row(
              children: [
                Gap(Style.spacing.lg),
                Flexible(
                  child: Text(strategies, style: context.typography.subtitle),
                ),
                Gap(Style.spacing.md),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Section displaying existing goal checks and a button to add new ones.
///
/// Uses [ExpansionBody] to make the checks list collapsible.
/// The title row is always visible and acts as an expansion toggle.
class _GoalChecksSection extends WatchingWidget {
  final PupilProxy pupil;
  final int goalIndex;

  const _GoalChecksSection({required this.pupil, required this.goalIndex});

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    final style = Style.of(context);
    final tileController = createOnce(() => ExpansionController());
    final isExpanded = watch(tileController.isExpanded).value;
    final learningSupportManager = di<LearningSupportManager>();
    final goal = pupil.supportGoals[goalIndex];
    final goalChecks = goal.goalChecks ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => tileController.toggle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                goalChecks.isEmpty
                    ? 'keine Ziel-Checks'
                    : '${goalChecks.length} Ziel-Checks  |  zuletzt am ${goalChecks.last.createdAt.toLocal().formatDateForUser()}',
                style: context.typography.bodySmall.copyWith(
                  fontWeight: goalChecks.isEmpty
                      ? FontWeight.normal
                      : FontWeight.bold,
                  color: goalChecks.isEmpty
                      ? style.colors.mutedForeground
                      : style.colors.interactive,
                ),
              ),
              Gap(Style.spacing.xs),
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                size: 30,
              ),
              Gap(Style.spacing.md),
            ],
          ),
        ),
        Gap(Style.spacing.sm),
        ExpansionBody(
          tileController: tileController,
          widgetList: [
            GenericAsyncActionButton(
              onPressed: () async {
                final check = await supportGoalCheckDialog(
                  context: context,
                  goal: goal,
                );
                if (check != null) {
                  await learningSupportManager.postSupportGoalCheck(
                    supportGoalId: goal.id!,
                    pupilId: pupil.pupilId,
                    score: check.score,
                    comment: check.comment,
                  );
                }
              },
              title: 'NEUER CHECK',
              buttonType: ButtonType.action,
            ),

            Gap(Style.spacing.xs),
            if (goalChecks.isEmpty) ...[
              Padding(
                padding: EdgeInsets.only(top: Style.spacing.lg, left: Style.spacing.lg, bottom: Style.spacing.sm),
                child: Text(
                  'Noch keine Checks vorhanden',
                  style: context.typography.body.copyWith(
                    fontStyle: FontStyle.italic,
                    color: style.colors.mutedForeground,
                  ),
                ),
              ),
            ] else
              ...goalChecks.map<Widget>(
                (check) => _GoalCheckEntry(
                  check: check,
                  supportGoalId: goal.id!,
                  pupilId: pupil.pupilId,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// A single goal check entry display.
class _GoalCheckEntry extends StatelessWidget {
  final SupportGoalCheck check;
  final int supportGoalId;
  final int pupilId;

  const _GoalCheckEntry({
    required this.check,
    required this.supportGoalId,
    required this.pupilId,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final learningSupportManager = di<LearningSupportManager>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Style.spacing.md, vertical: Style.spacing.xs),
      child: GestureDetector(
        onLongPress: () async {
          final delete = await confirmationDialog(
            context: context,
            title: 'Ziel-Check löschen',
            message: 'Diesen Ziel-Check wirklich löschen?',
          );
          if (delete == true) {
            await learningSupportManager.deleteSupportGoalCheck(
              supportGoalId: supportGoalId,
              supportGoalCheckId: check.id!,
              pupilId: pupilId,
            );
          }
        },
        child: Container(
          padding: EdgeInsets.all(Style.spacing.md),
          decoration: BoxDecoration(
            color: style.colors.cardInCard,
            borderRadius: BorderRadius.circular(Style.radii.small),
            border: Border.all(color: style.colors.cardInCardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Score icon
                  Gap(Style.spacing.md),
                  // Comment and metadata
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          check.comment,
                          style: context.typography.body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gap(Style.spacing.xs),
                        Text(
                          '${check.createdBy} - ${check.createdAt.toLocal().formatDateForUser()}',
                          style: context.typography.bodySmall.withColor(
                            style.colors.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GrowthIcon(score: check.score, size: 40),
                  Gap(Style.spacing.xs),
                ],
              ),
              Gap(Style.spacing.sm),
              HubDocumentsSectionWidget(
                documents: check.documents ?? [],
                withSpacerToButtons: true,
                onImageFileCaptured: (file) async {
                  if (file == null) return;
                  await learningSupportManager.addFileToSupportGoalCheck(
                    supportGoalId: supportGoalId,
                    supportGoalCheckId: check.id!,
                    pupilId: pupilId,
                    file: file,
                  );
                },
                onAudioFileRecorded: (file, fileInfo) async {
                  if (file == null) return;
                  await learningSupportManager.addFileToSupportGoalCheck(
                    supportGoalId: supportGoalId,
                    supportGoalCheckId: check.id!,
                    pupilId: pupilId,
                    file: file,
                    fileInfo: fileInfo,
                  );
                },
                onDeleteDocument: (documentId) async {
                  final confirm = await confirmationDialog(
                    context: context,
                    title: 'Dokument löschen',
                    message: 'Dieses Dokument wirklich löschen?',
                  );
                  if (confirm != true) return;

                  await learningSupportManager.removeFileFromSupportGoalCheck(
                    supportGoalId: supportGoalId,
                    supportGoalCheckId: check.id!,
                    pupilId: pupilId,
                    documentId: documentId,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
