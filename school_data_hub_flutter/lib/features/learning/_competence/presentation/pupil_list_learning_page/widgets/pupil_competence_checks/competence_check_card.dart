import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/hub_documents_section.dart';
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
    final isAuthorized = SessionHelper.isAuthorized(competenceCheck.createdBy);
    return InkWell(
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
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isAuthorized
                      ? InkWell(
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
                            style: TextStyle(
                              color: AppColors.interactiveColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : Text(
                          competenceCheck.createdAt.formatDateForUser(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                  const Spacer(),
                  const Text('Erstellt von:', style: TextStyle(fontSize: 16)),
                  const Gap(5),
                  // only admin can change the docummenting user
                  isAuthorized
                      ? InkWell(
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.backgroundColor,
                            ),
                          ),
                        )
                      : Text(
                          competenceCheck.createdBy,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                  const Gap(5),
                ],
              ),
              if (competenceCheck.groupCheckName != null &&
                  competenceCheck.groupCheckName!.isNotEmpty) ...[
                const Gap(5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.backgroundColor.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Gap(6),
                      Text(
                        competenceCheck.groupCheckName!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const Gap(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(5),
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
                                padding: const EdgeInsets.all(5.0),
                                child:
                                    CompetenceHelper.getCompetenceCheckSymbol(
                                      status: competenceCheck.score,
                                      size: 60,
                                    ),
                              ),
                        const Gap(3),
                        isAuthorized
                            ? Center(
                                child: InkWell(
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
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppColors.backgroundColor
                                            .withValues(alpha: 0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'x',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.interactiveColor,
                                          ),
                                        ),
                                        const Gap(4),
                                        Text(
                                          competenceCheck.valueFactor
                                              .toStringAsFixed(1),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.interactiveColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.backgroundColor.withValues(
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
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.backgroundColor,
                                      ),
                                    ),
                                    const Gap(4),
                                    Text(
                                      competenceCheck.valueFactor
                                          .toStringAsFixed(1),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.backgroundColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),

                  const Gap(10),

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
                    buttonsBackgroundColor: AppColors.backgroundColor,
                    buttonsIconColor: Colors.white,
                  ),
                ],
              ),
              const Gap(15),
              InkWell(
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
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      textAlign: TextAlign.left,
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Kommentar: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
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
      ),
    );
  }
}
