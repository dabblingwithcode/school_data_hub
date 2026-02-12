import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/app_utils/record_audio_file.dart';
import 'package:school_data_hub_flutter/common/audio/audio.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/encrypted_document_image.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/support_goal_check_dialog.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_entry/support_category_status_entry.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_entry/support_category_status_symbol.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_goal/support_category_badge.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class SupportGoalCard extends WatchingWidget {
  final PupilProxy pupil;
  final int goalIndex;
  const SupportGoalCard({
    required this.pupil,
    required this.goalIndex,
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
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          final categoryId =
                              pupil.supportGoals![goalIndex].supportCategoryId;
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Erstellt von:'),
                    const Gap(5),
                    Text(
                      pupil.supportGoals![goalIndex].createdBy,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Gap(10),
                    const Text('am'),
                    const Gap(5),
                    Text(
                      pupil.supportGoals![goalIndex].createdAt
                          .toLocal()
                          .formatDateForUser(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
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

/// Section displaying existing goal checks and a button to add new ones.
///
/// Uses [CustomExpansionTileContent] to make the checks list collapsible.
/// The title row is always visible and acts as an expansion toggle.
class _GoalChecksSection extends StatefulWidget {
  final SupportGoal goal;
  final int pupilId;

  const _GoalChecksSection({required this.goal, required this.pupilId});

  @override
  State<_GoalChecksSection> createState() => _GoalChecksSectionState();
}

class _GoalChecksSectionState extends State<_GoalChecksSection> {
  final CustomExpansionTileController _tileController =
      CustomExpansionTileController();

  @override
  Widget build(BuildContext context) {
    final learningSupportManager = di<LearningSupportManager>();
    final goalChecks = widget.goal.goalChecks ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            _tileController.isExpanded
                ? _tileController.collapse()
                : _tileController.expand();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                goalChecks.isEmpty
                    ? 'keine Ziel-Checks:'
                    : '${goalChecks.length} Ziel-Checks',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10),
            ],
          ),
        ),
        const Gap(8),
        CustomExpansionTileContent(
          tileController: _tileController,
          widgetList: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: ElevatedButton(
                style: AppStyles.actionButtonStyle,
                onPressed: () async {
                  final check = await supportGoalCheckDialog(
                    context: context,
                    goal: widget.goal,
                  );
                  if (check != null) {
                    await learningSupportManager.postSupportGoalCheck(
                      supportGoalId: widget.goal.id!,
                      pupilId: widget.pupilId,
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
                  supportGoalId: widget.goal.id!,
                  pupilId: widget.pupilId,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(8),
              _GoalCheckDocumentsSection(
                check: check,
                supportGoalId: supportGoalId,
                pupilId: pupilId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Displays existing documents/audio and buttons to add new ones for a
/// support goal check.
class _GoalCheckDocumentsSection extends StatelessWidget {
  const _GoalCheckDocumentsSection({
    required this.check,
    required this.supportGoalId,
    required this.pupilId,
  });

  final SupportGoalCheck check;
  final int supportGoalId;
  final int pupilId;

  @override
  Widget build(BuildContext context) {
    final files = check.documents;
    final isAdmin = di<HubSessionManager>().isAdmin;
    final imageFiles = files?.where((f) => !_isAudioDocument(f)).toList() ?? [];
    final audioFiles = files?.where((f) => _isAudioDocument(f)).toList() ?? [];
    final totalCount = files?.length ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dokumente:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const Gap(4),
        Row(
          children: [
            for (final file in imageFiles) ...[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    file.createdAt.formatDateForUser(),
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 600,
                              maxHeight: 800,
                            ),
                            child: EncryptedDocumentImage(
                              documentId: file.documentId,
                              size: 400,
                            ),
                          ),
                        ),
                      );
                    },
                    onLongPress: () async {
                      if (!isAdmin) {
                        di<NotificationService>().showSnackBar(
                          NotificationType.error,
                          'Nur Admins können Dokumente löschen',
                        );
                        return;
                      }
                      final confirm = await confirmationDialog(
                        context: context,
                        title: 'Dokument löschen',
                        message: 'Dokument wirklich löschen?',
                      );
                      if (confirm != true) return;

                      await di<LearningSupportManager>()
                          .removeFileFromSupportGoalCheck(
                            supportGoalId: supportGoalId,
                            supportGoalCheckId: check.id!,
                            pupilId: pupilId,
                            documentId: file.documentId,
                          );
                    },
                    child: EncryptedDocumentImage(
                      documentId: file.documentId,
                      size: 70,
                    ),
                  ),
                  Text(
                    file.createdBy,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Gap(10),
            ],
            for (final file in audioFiles) ...[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    file.createdAt.formatDateForUser(),
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AudioButton(
                    file: file,
                    onDelete: (file) async {
                      await di<LearningSupportManager>()
                          .removeFileFromSupportGoalCheck(
                            supportGoalId: supportGoalId,
                            supportGoalCheckId: check.id!,
                            pupilId: pupilId,
                            documentId: file.documentId,
                          );
                    },
                  ),
                  Text(
                    file.createdBy,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Gap(10),
            ],
            if (totalCount < 4) ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final File? file = await createAndCropImageFile(context);
                      if (file == null) return;

                      await di<LearningSupportManager>()
                          .addFileToSupportGoalCheck(
                            supportGoalId: supportGoalId,
                            supportGoalCheckId: check.id!,
                            pupilId: pupilId,
                            file: file,
                          );
                    },
                    child: SizedBox(
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('assets/document_camera.png'),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final ({File? file, String? fileInfo})? result =
                          await recordAudioFile(context);
                      if (result == null) return;

                      await di<LearningSupportManager>()
                          .addFileToSupportGoalCheck(
                            supportGoalId: supportGoalId,
                            supportGoalCheckId: check.id!,
                            pupilId: pupilId,
                            file: result.file!,
                            fileInfo: result.fileInfo!,
                          );
                    },
                    child: SizedBox(
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('assets/document_mic.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }
}
