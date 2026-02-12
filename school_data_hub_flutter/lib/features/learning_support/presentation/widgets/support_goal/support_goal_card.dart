import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/support_goal_check_dialog.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_entry/support_category_status_symbol.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_goal/support_category_badge.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class SupportGoalCard extends StatelessWidget {
  final PupilProxy pupil;
  final int goalIndex;
  const SupportGoalCard({
    required this.pupil,
    required this.goalIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              // TODO: uncomment when ready
              // await _learningSupportManager
              //     .deleteGoal(pupil.supportGoals![goalIndex].goalId);
              // return;
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
                Row(
                  children: [
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8,
                        left: 10,
                        right: 10,
                      ),
                      child: SupportCategoryBadge(
                        categoryId:
                            pupil.supportGoals![goalIndex].supportCategoryId,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      learningSupportManager
                          .getSupportCategory(
                            pupil.supportGoals![goalIndex].supportCategoryId,
                          )
                          .name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const Gap(5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Text(
                      pupil.supportGoals![goalIndex].description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.groupColor.withValues(alpha: 0.7),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: getLastCategoryStatusSymbol(
                              pupil,
                              pupil.supportGoals![goalIndex].supportCategoryId,
                            ),
                          ),
                          const Gap(10),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                const Row(
                  children: [
                    Gap(15),
                    Text(
                      'Strategien:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const Gap(15),
                    Flexible(
                      child: Text(
                        pupil.supportGoals![goalIndex].strategies,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const Gap(15),
                    const Text('Erstellt von:'),
                    const Gap(10),
                    Text(
                      pupil.supportGoals![goalIndex].createdBy,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Gap(15),
                    const Text('am'),
                    const Gap(10),
                    Text(
                      pupil.supportGoals![goalIndex].createdAt
                          .toLocal()
                          .formatDateForUser(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
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

/// Section displaying existing goal checks and a button to add new ones.
class _GoalChecksSection extends StatelessWidget {
  final SupportGoal goal;
  final int pupilId;

  const _GoalChecksSection({
    required this.goal,
    required this.pupilId,
  });

  @override
  Widget build(BuildContext context) {
    final learningSupportManager = di<LearningSupportManager>();
    final goalChecks = goal.goalChecks ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Row(
          children: [
            const Gap(15),
            const Text(
              'Ziel-Checks:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ElevatedButton.icon(
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
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Neuer Check'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.successButtonColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Gap(8),
        if (goalChecks.isEmpty)
          const Padding(
            padding: EdgeInsets.only(left: 15, bottom: 8),
            child: Text(
              'Noch keine Checks vorhanden',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          )
        else
          ...goalChecks.map<Widget>(
            (check) => _GoalCheckEntry(
              check: check,
              supportGoalId: goal.id!,
              pupilId: pupilId,
            ),
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
    final learningSupportManager = di<LearningSupportManager>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Score icon
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  'assets/images/growth_icons/growth_${check.score}-4.png',
                  fit: BoxFit.contain,
                ),
              ),
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
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
