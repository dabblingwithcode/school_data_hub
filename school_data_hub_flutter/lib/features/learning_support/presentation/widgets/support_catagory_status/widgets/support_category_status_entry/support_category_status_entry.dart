import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
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
    final style = Style.of(context);
    final bool authorizedToChangeStatus =
        LearningSupportHelper.isAuthorizedToChangeStatus(status);
    return Padding(
      padding: EdgeInsets.only(left: Style.spacing.sm, right: Style.spacing.sm, bottom: Style.spacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(Style.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date row
                Row(
                  children: [
                    Expanded(
                      child: authorizedToChangeStatus
                          ? GestureDetector(
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
                                style: context.typography.title.withColor(
                                  style.colors.interactive,
                                ),
                              ),
                            )
                          : Text(
                              status.createdAt.formatDateForUser(),
                              style: context.typography.title,
                            ),
                    ),
                  ],
                ),

                // Created by row
                Wrap(
                  children: [
                    Text(
                      'Eingetragen von ',
                      style: context.typography.body,
                    ),
                    Gap(Style.spacing.xs),
                    authorizedToChangeStatus
                        ? GestureDetector(
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
                              style: context.typography.body.bold.withColor(
                                style.colors.interactive,
                              ),
                            ),
                          )
                        : Text(
                            status.createdBy,
                            style: context.typography.body.bold,
                          ),
                  ],
                ),

                Gap(Style.spacing.xs),

                // Comment row with edit icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: authorizedToChangeStatus
                          ? GestureDetector(
                              onTap: () =>
                                  _editComment(context, learningSupportManager),
                              child: Text(
                                status.comment ?? 'nicht vorhanden',
                                style: context.typography.body.bold.withColor(
                                  style.colors.interactive,
                                ),
                              ),
                            )
                          : Text(status.comment ?? 'nicht vorhanden'),
                    ),
                    if (authorizedToChangeStatus)
                      GestureDetector(
                        onTap: () =>
                            _editComment(context, learningSupportManager),
                        child: Tooltip(
                          message: 'Kommentar bearbeiten',
                          child: Icon(
                            Icons.edit,
                            size: 18,
                            color: style.colors.interactive,
                          ),
                        ),
                      ),
                  ],
                ),
                Gap(Style.spacing.xs),
              ],
            ),
          ),
          Column(
            children: [
              authorizedToChangeStatus
                  ? GestureDetector(
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
    final style = Style.of(context);
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Ist-Zustand ändern',
            textAlign: TextAlign.center,
            style: context.typography.title,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              final score = index + 1;
              final isSelected = score == currentScore;
              return GestureDetector(
                onTap: () => Navigator.of(context).pop(score),
                child: Container(
                  padding: EdgeInsets.all(Style.spacing.sm),
                  decoration: BoxDecoration(
                    border: isSelected
                        ? Border.all(
                            color: style.colors.interactive,
                            width: 3,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(Style.radii.small),
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
