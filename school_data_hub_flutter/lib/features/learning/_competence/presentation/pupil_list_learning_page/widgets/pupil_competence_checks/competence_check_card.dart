import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/hub_documents_section.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_helper.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class CompetenceCheckCard extends StatelessWidget {
  final CompetenceCheck competenceCheck;
  const CompetenceCheckCard({required this.competenceCheck, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final isAuthorized = SessionHelper.isAuthorized(competenceCheck.createdBy);
    return GestureDetector(
      onLongPress: () async {
        if (!isAuthorized) {
          informationDialog(
            context,
            'Keine Berechtigung!',
            'Nur Admins und Ersteller:innen können Kompetenzchecks löschen.',
          );
          return;
        }
        final bool? confirm = await confirmationDialog(
          context: context,
          title: 'Kompetenzcheck löschen',
          message: 'Kompetenzcheck löschen?',
        );
        if (confirm == true) {
          di<CompetenceManager>().deleteCompetenceCheck(
            competenceCheck.checkId,
          );
        }
      },
      child: CardBox(
        padding: EdgeInsets.all(Style.spacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isAuthorized
                    ? GestureDetector(
                        onTap: () async {
                          DateTime? date = await selectSchooldayDate(
                            context,
                            di<SchoolCalendarManager>().thisDate.value,
                          );
                          if (date == null) return;

                          await di<CompetenceManager>().updateCompetenceCheck(
                            competenceCheckId: competenceCheck.checkId,
                            createdAt: (value: date),
                          );
                        },
                        child: Text(
                          competenceCheck.createdAt.formatDateForUser(),
                          style: context.typography.title.withColor(
                            style.colors.interactive,
                          ),
                        ),
                      )
                    : Text(
                        competenceCheck.createdAt.formatDateForUser(),
                        style: context.typography.title.withColor(
                          style.colors.foreground,
                        ),
                      ),
                const Spacer(),
                Text(
                  'Erstellt von:',
                  style: context.typography.subtitle,
                ),
                Gap(Style.spacing.xs),
                // only admin can change the docummenting user
                isAuthorized
                    ? GestureDetector(
                        onTap: () async {
                          final String? user = await shortTextfieldDialog(
                            context: context,
                            title: 'Erstellt von:',
                            labelText: 'Kürzel eingeben',
                            hintText: 'Kürzel eingeben',
                            obscureText: false,
                          );
                          if (user != null) {
                            await di<CompetenceManager>()
                                .updateCompetenceCheck(
                                  competenceCheckId: competenceCheck.checkId,
                                  createdBy: (value: user),
                                );
                          }
                        },
                        child: Text(
                          competenceCheck.createdBy,
                          style: context.typography.title.withColor(
                            style.colors.accent,
                          ),
                        ),
                      )
                    : Text(
                        competenceCheck.createdBy,
                        style: context.typography.title,
                      ),
                Gap(Style.spacing.xs),
              ],
            ),
            if (competenceCheck.groupCheckName != null &&
                competenceCheck.groupCheckName!.isNotEmpty) ...[
              Gap(Style.spacing.xs),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Style.spacing.md,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: style.colors.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(Style.radii.small),
                  border: Border.all(
                    color: style.colors.accent.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(Style.spacing.xs),
                    Text(
                      competenceCheck.groupCheckName!,
                      style: context.typography.body.w600.withColor(
                        style.colors.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Gap(Style.spacing.md),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(Style.spacing.xs),
                SizedBox(
                  width: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isAuthorized
                          ? GrowthDropdown(
                              dropdownValue: competenceCheck.score,
                              onChangedFunction: (int value) async {
                                if (value == competenceCheck.score) {
                                  return;
                                }
                                await di<CompetenceManager>()
                                    .updateCompetenceCheck(
                                      competenceCheckId:
                                          competenceCheck.checkId,
                                      score: (value: value),
                                    );
                                if (!context.mounted) return;
                                // Unfocus to prevent focus lock
                                FocusScope.of(context).unfocus();
                              },
                            )
                          : Padding(
                              padding: EdgeInsets.all(Style.spacing.xs),
                              child:
                                  CompetenceHelper.getCompetenceCheckSymbol(
                                    status: competenceCheck.score,
                                    size: 60,
                                  ),
                            ),
                      Gap(Style.spacing.xs),
                      isAuthorized
                          ? Center(
                              child: GestureDetector(
                                onTap: () async {
                                  final String? valueFactorText =
                                      await shortTextfieldDialog(
                                        context: context,
                                        title: 'Wertfaktor',
                                        labelText: 'Wertfaktor eingeben',
                                        hintText: 'z.B. 1.5',
                                        textinField: competenceCheck
                                            .valueFactor
                                            .toStringAsFixed(1),
                                        obscureText: false,
                                      );
                                  if (valueFactorText != null) {
                                    final double? valueFactor =
                                        double.tryParse(valueFactorText);
                                    if (valueFactor != null &&
                                        valueFactor > 0) {
                                      await di<CompetenceManager>()
                                          .updateCompetenceCheck(
                                            competenceCheckId:
                                                competenceCheck.checkId,
                                            valueFactor: (value: valueFactor),
                                          );
                                    } else {
                                      di<NotificationManager>().showSnackBar(
                                        NotificationType.error,
                                        'Ungültiger Wertfaktor. Bitte geben Sie eine positive Zahl ein.',
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Style.spacing.sm,
                                    vertical: Style.spacing.xs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: style.colors.accent
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(Style.radii.small),
                                    border: Border.all(
                                      color: style.colors.accent
                                          .withValues(alpha: 0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'x',
                                        style: context.typography.body.w500.withColor(
                                          style.colors.interactive,
                                        ),
                                      ),
                                      Gap(Style.spacing.xs),
                                      Text(
                                        competenceCheck.valueFactor
                                            .toStringAsFixed(1),
                                        style: context.typography.subtitle.bold.withColor(
                                          style.colors.interactive,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Style.spacing.sm,
                                vertical: Style.spacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: style.colors.accent.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(Style.radii.small),
                                border: Border.all(
                                  color: style.colors.accent.withValues(
                                    alpha: 0.3,
                                  ),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'x',
                                    style: context.typography.body.w500.withColor(
                                      style.colors.accent,
                                    ),
                                  ),
                                  Gap(Style.spacing.xs),
                                  Text(
                                    competenceCheck.valueFactor
                                        .toStringAsFixed(1),
                                    style: context.typography.subtitle.bold.withColor(
                                      style.colors.accent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),

                Gap(Style.spacing.md),

                // Value Factor Display
                const Spacer(),

                HubDocumentsSectionWidget(
                  documents: competenceCheck.documents,
                  withSpacerToButtons: false,
                  showMetadata: true,
                  onImageFileCaptured: (file) async {
                    if (file == null) return;
                    await di<CompetenceManager>().addFileToCompetenceCheck(
                      competenceCheckId: competenceCheck.checkId,
                      file: file,
                    );
                  },
                  onAudioFileRecorded: (file, fileInfo) async {
                    if (file == null) return;
                    await di<CompetenceManager>().addFileToCompetenceCheck(
                      competenceCheckId: competenceCheck.checkId,
                      file: file,
                      fileInfo: fileInfo,
                    );
                  },
                  onDeleteDocument: (documentId) async {
                    await di<CompetenceManager>()
                        .removeFileFromCompetenceCheck(
                          competenceCheckId: competenceCheck.checkId,
                          documentId: documentId,
                        );
                  },
                  buttonsBackgroundColor: style.colors.accent,
                  buttonsIconColor: style.colors.background,
                ),
              ],
            ),
            Gap(Style.spacing.lg),
            GestureDetector(
              onTap: () async {
                if (!isAuthorized) return;
                final result = await longTextFieldDialog(
                  parentContext: context,
                  title: 'Kommentar',
                  labelText: 'Kommentar eingeben',
                  initialValue: competenceCheck.comment,
                );
                if (result == null ||
                    result.value == competenceCheck.comment) {
                  return;
                }
                await di<CompetenceManager>().updateCompetenceCheck(
                  competenceCheckId: competenceCheck.checkId,
                  competenceComment: (value: result.value),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: Style.spacing.md),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    textAlign: TextAlign.left,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Kommentar: ',
                          style: context.typography.subtitle.bold,
                        ),
                        TextSpan(
                          text:
                              (competenceCheck.comment == null ||
                                  competenceCheck.comment!.isEmpty)
                              ? 'Kein Kommentar'
                              : competenceCheck.comment!,
                        ),
                      ],
                    ),
                    softWrap: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
