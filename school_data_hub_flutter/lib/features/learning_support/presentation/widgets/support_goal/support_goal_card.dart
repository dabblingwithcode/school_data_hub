import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/audio/audio.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/hub_documents_section.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_page/controller/new_support_category_status_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/support_goal_check_dialog.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_entry/support_category_status_entry.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_entry/support_category_status_symbol.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_goal/support_category_badge.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

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
    final learningSupportManager = di<SupportCategoryManager>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: InkWell(
          onLongPress: () async {
            final bool? delete = await confirmationDialog(
              context: context,
              title: 'Förderziel löschen',
              message: 'Förderziel löschen?',
            );
            if (delete == true) {
              await di<LearningSupportManager>().deleteSupportGoal(
                pupilId: pupil.pupilId,
                supportGoalId: pupil.supportGoals![goalIndex].id!,
              );
              return;
            }
            return;
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: AppColors.cardInCardBorderColor,
                width: 2,
              ),
            ),
            color: AppColors.cardInCardColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(5),
                if (showCategoryBadge)
                  Row(
                    children: [
                      const Gap(5),
                      ...[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 8,
                            left: 10,
                            right: 10,
                          ),
                          child: SupportCategoryBadge(
                            categoryId: pupil
                                .supportGoals![goalIndex]
                                .supportCategoryId,
                            size: 40,
                          ),
                        ),
                        const Gap(5),
                      ],
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            final categoryId = pupil
                                .supportGoals![goalIndex]
                                .supportCategoryId;
                            final statuses =
                                pupil.supportCategoryStatuses
                                    ?.where(
                                      (s) => s.supportCategoryId == categoryId,
                                    )
                                    .toList() ??
                                [];
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 500,
                                    maxHeight: 600,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SupportCategoryBadge(
                                              categoryId: categoryId,
                                            ),
                                            const Gap(10),
                                            Flexible(
                                              child: Text(
                                                learningSupportManager
                                                    .getSupportCategory(
                                                      categoryId,
                                                    )
                                                    .name,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        if (statuses.isEmpty)
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            child: Text(
                                              'Keine Status vorhanden',
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.grey,
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
                            learningSupportManager
                                .getSupportCategory(
                                  pupil
                                      .supportGoals![goalIndex]
                                      .supportCategoryId,
                                )
                                .name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.interactiveColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LastSupportCategoryStatusSymbol(
                              size: 40,
                              pupil: pupil,
                              categoryId: pupil
                                  .supportGoals![goalIndex]
                                  .supportCategoryId,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                const Gap(5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(15),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => NewSupportCategoryStatus(
                                appBarTitle: 'Förderziel bearbeiten',
                                pupilId: pupil.pupilId,
                                goalCategoryId: pupil
                                    .supportGoals![goalIndex]
                                    .supportCategoryId,
                                elementType: 'goal',
                                existingGoal: pupil.supportGoals![goalIndex],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          pupil.supportGoals![goalIndex].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.groupColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _StrategiesSection(
                  strategies: pupil.supportGoals![goalIndex].strategies,
                ),
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Erstellt von:', style: TextStyle(fontSize: 12)),
                    const Gap(5),
                    Text(
                      pupil.supportGoals![goalIndex].createdBy,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const Gap(5),
                    const Text('am', style: TextStyle(fontSize: 12)),
                    const Gap(5),
                    Text(
                      pupil.supportGoals![goalIndex].createdAt
                          .toLocal()
                          .formatDateForUser(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
                const Gap(10),

                // Goal Checks Section
                _GoalChecksSection(
                  goal: pupil.supportGoals![goalIndex],
                  pupilId: pupil.pupilId,
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StrategiesSection extends WatchingWidget {
  final String strategies;
  const _StrategiesSection({required this.strategies});

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(() => CustomExpansionTileController());
    final isExpanded = watch(tileController.isExpanded).value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => tileController.toggle(),
          child: Row(
            children: [
              const Gap(15),
              const Text(
                'Strategien',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                size: 30,
              ),
              const Gap(10),
            ],
          ),
        ),
        CustomExpansionTileContent(
          tileController: tileController,
          widgetList: [
            Row(
              children: [
                const Gap(15),
                Flexible(
                  child: Text(strategies, style: const TextStyle(fontSize: 16)),
                ),
                const Gap(10),
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
/// Uses [CustomExpansionTileContent] to make the checks list collapsible.
/// The title row is always visible and acts as an expansion toggle.
class _GoalChecksSection extends WatchingWidget {
  final SupportGoal goal;
  final int pupilId;

  const _GoalChecksSection({required this.goal, required this.pupilId});

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(() => CustomExpansionTileController());
    final isExpanded = watch(tileController.isExpanded).value;
    final learningSupportManager = di<LearningSupportManager>();
    final goalChecks = goal.goalChecks ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => tileController.toggle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                goalChecks.isEmpty
                    ? 'keine Ziel-Checks'
                    : '${goalChecks.length} Ziel-Checks  |  zuletzt am ${goalChecks.last.createdAt.toLocal().formatDateForUser()}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: goalChecks.isEmpty
                      ? FontWeight.normal
                      : FontWeight.bold,
                  color: goalChecks.isEmpty
                      ? Colors.grey[400]
                      : AppColors.interactiveColor,
                ),
              ),
              const Gap(5),
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                size: 30,
              ),
              const Gap(10),
            ],
          ),
        ),
        const Gap(8),
        CustomExpansionTileContent(
          tileController: tileController,
          widgetList: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: ElevatedButton(
                style: AppStyles.actionButtonStyle,
                onPressed: () async {
                  final check = await supportGoalCheckDialog(
                    context: context,
                    goal: goal,
                  );
                  if (check != null) {
                    await learningSupportManager.postSupportGoalCheck(
                      supportGoalId: goal.id!,
                      pupilId: pupilId,
                      score: check.score,
                      comment: check.comment,
                    );
                  }
                },
                child: const Text(
                  'NEUER CHECK',
                  style: AppStyles.buttonTextStyle,
                ),
              ),
            ),
            const Gap(5),
            if (goalChecks.isEmpty) ...[
              const Padding(
                padding: EdgeInsets.only(top: 15, left: 15, bottom: 8),
                child: Text(
                  'Noch keine Checks vorhanden',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ),
            ] else
              ...goalChecks.map<Widget>(
                (check) => _GoalCheckEntry(
                  check: check,
                  supportGoalId: goal.id!,
                  pupilId: pupilId,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Whether [doc] represents an audio file based on its extension.
bool _isAudioDocument(HubDocument doc) {
  return isAudioDocument(doc.documentId);
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
    final learningSupportManager = di<LearningSupportManager>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: InkWell(
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.cardInCardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.cardInCardBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Score icon
                  const Gap(10),
                  // Comment and metadata
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          check.comment,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(4),
                        Text(
                          '${check.createdBy} - ${check.createdAt.toLocal().formatDateForUser()}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GrowthIcon(score: check.score, size: 40),
                  const Gap(4),
                ],
              ),
              const Gap(8),
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
