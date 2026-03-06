import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_entry/support_category_status_symbol.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

class SupportCategoryStatusEntry extends StatelessWidget {
  final PupilProxy pupil;
  final SupportCategoryStatus status;

  const SupportCategoryStatusEntry({
    required this.pupil,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final learningSupportManager = di<LearningSupportManager>();
    final bool authorizedToChangeStatus =
        LearningSupportHelper.isAuthorizedToChangeStatus(status);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date row
                Row(
                  children: [
                    Expanded(
                      child: authorizedToChangeStatus
                          ? InkWell(
                              onTap: () async {
                                final DateTime? correctedCreatedAt =
                                    await showDatePicker(
                                      context: context,
                                      initialDate: status.createdAt,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now().toUtc(),
                                    );
                                if (correctedCreatedAt != null &&
                                    correctedCreatedAt != status.createdAt) {
                                  await learningSupportManager
                                      .updateSupportCategoryStatus(
                                        pupilId: pupil.pupilId,
                                        statusId: status.id!,
                                        createdAt: correctedCreatedAt,
                                      );
                                }
                              },
                              onLongPress: () async {
                                if (!authorizedToChangeStatus) return;
                                bool? confirm = await confirmationDialog(
                                  context: context,
                                  title: 'Status löschen?',
                                  message: 'Status löschen?',
                                );
                                if (confirm != true) return;
                                learningSupportManager
                                    .deleteSupportCategoryStatus(
                                      pupil.pupilId,
                                      status.id!,
                                    );
                              },
                              child: Text(
                                status.createdAt.formatDateForUser(),
                                style: TextStyle(
                                  color: AppColors.interactiveColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : Text(
                              status.createdAt.formatDateForUser(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ],
                ),

                // Created by row
                Wrap(
                  children: [
                    const Text(
                      'Eingetragen von ',
                      style: TextStyle(fontSize: 14),
                    ),
                    const Gap(5),
                    authorizedToChangeStatus
                        ? InkWell(
                            onTap: () async {
                              final String? correctedCreatedBy =
                                  await shortTextfieldDialog(
                                    title: 'Ersteller ändern',
                                    obscureText: false,
                                    hintText: 'Kürzel eintragen',
                                    labelText: status.createdBy,
                                    context: context,
                                  );
                              if (correctedCreatedBy != null &&
                                  correctedCreatedBy != status.createdBy) {
                                await learningSupportManager
                                    .updateSupportCategoryStatus(
                                      pupilId: pupil.pupilId,
                                      statusId: status.id!,
                                      createdBy: correctedCreatedBy,
                                    );
                              }
                            },
                            child: Text(
                              status.createdBy,
                              style: TextStyle(
                                color: AppColors.interactiveColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Text(
                            status.createdBy,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ],
                ),

                const Gap(5),

                // Comment row with edit icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: authorizedToChangeStatus
                          ? InkWell(
                              onTap: () =>
                                  _editComment(context, learningSupportManager),
                              child: Text(
                                status.comment ?? 'nicht vorhanden',
                                style: TextStyle(
                                  color: AppColors.interactiveColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Text(status.comment ?? 'nicht vorhanden'),
                    ),
                    if (authorizedToChangeStatus)
                      IconButton(
                        icon: const Icon(Icons.edit, size: 18),
                        color: AppColors.interactiveColor,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: 'Kommentar bearbeiten',
                        onPressed: () =>
                            _editComment(context, learningSupportManager),
                      ),
                  ],
                ),
                const Gap(5),
              ],
            ),
          ),
          Column(
            children: [
              authorizedToChangeStatus
                  ? InkWell(
                      onTap: () async {
                        final int? newScore = await _showScoreEditDialog(
                          context,
                          status.score,
                        );
                        if (newScore != null && newScore != status.score) {
                          await learningSupportManager
                              .updateSupportCategoryStatus(
                                pupilId: pupil.pupilId,
                                statusId: status.id!,
                                score: newScore,
                              );
                        }
                      },
                      child: SupportCategoryStatusSymbol(
                        size: 40,
                        pupil: pupil,
                        categoryId: status.supportCategoryId,
                        statusId: status.id!,
                      ),
                    )
                  : SupportCategoryStatusSymbol(
                      size: 60,
                      pupil: pupil,
                      categoryId: status.supportCategoryId,
                      statusId: status.id!,
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _editComment(
    BuildContext context,
    LearningSupportManager learningSupportManager,
  ) async {
    final result = await longTextFieldDialog(
      title: 'Status korrigieren',
      labelText: 'Kommentar',
      initialValue: status.comment,
      parentContext: context,
    );
    if (result == null) return;
    // result.value is null when the user taps "LÖSCHEN"
    if (result.value == status.comment) return;
    await learningSupportManager.updateSupportCategoryStatus(
      pupilId: pupil.pupilId,
      statusId: status.id!,
      comment: result.value ?? '',
    );
  }

  Future<int?> _showScoreEditDialog(
    BuildContext context,
    int currentScore,
  ) async {
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Ist-Zustand ändern',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              final score = index + 1;
              final isSelected = score == currentScore;
              return GestureDetector(
                onTap: () => Navigator.of(context).pop(score),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: isSelected
                        ? Border.all(
                            color: AppColors.interactiveColor,
                            width: 3,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    'assets/images/growth_icons/growth_$score-4.png',
                    width: 50,
                    height: 50,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
