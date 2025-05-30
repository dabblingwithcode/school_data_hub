import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/document_image.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/upload_image.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_helper.dart';
import 'package:school_data_hub_flutter/features/competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

class CompetenceCheckCard extends StatelessWidget {
  final CompetenceCheck competenceCheck;
  const CompetenceCheckCard({required this.competenceCheck, super.key});

  @override
  Widget build(BuildContext context) {
    final isAuthorized = SessionHelper.isAuthorized(competenceCheck.createdBy);
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: InkWell(
        onLongPress: () async {
          if (!isAuthorized) {
            informationDialog(context, 'Keine Berechtigung!',
                'Nur Admins und Ersteller:innen können Kompetenzchecks löschen.');
            return;
          }
          final bool? confirm = await confirmationDialog(
              context: context,
              title: 'Kompetenzcheck löschen',
              message: 'Kompetenzcheck löschen?');
          if (confirm == true) {
            di<CompetenceManager>()
                .deleteCompetenceCheck(competenceCheck.checkId);
          }
        },
        child: Card(
          color: AppColors.cardInCardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: AppColors.cardInCardBorderColor,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    isAuthorized
                        ? InkWell(
                            onTap: () async {
                              DateTime? date = await selectSchooldayDate(
                                  context,
                                  di<SchooldayManager>().thisDate.value);
                              if (date == null) return;
                              await di<CompetenceManager>()
                                  .updateCompetenceCheck(
                                      competenceCheckId:
                                          competenceCheck.checkId,
                                      createdAt: date);
                            },
                            child: Text(
                              competenceCheck.createdAt.formatForUser(),
                              style: const TextStyle(
                                color: AppColors.interactiveColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )
                        : Text(
                            competenceCheck.createdAt.formatForUser(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                    const Spacer(),
                    const Text('Erstellt von:', style: TextStyle(fontSize: 16)),
                    const Gap(5),
                    // only admin can change the admonishing user
                    isAuthorized
                        ? InkWell(
                            onTap: () async {
                              final String? user = await shortTextfieldDialog(
                                  context: context,
                                  title: 'Erstellt von:',
                                  labelText: 'Kürzel eingeben',
                                  hintText: 'Kürzel eingeben',
                                  obscureText: false);
                              if (user != null) {
                                await di<CompetenceManager>()
                                    .updateCompetenceCheck(
                                  competenceCheckId: competenceCheck.checkId,
                                  createdBy: user,
                                );
                              }
                            },
                            child: Text(
                              competenceCheck.createdBy,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.backgroundColor),
                            ),
                          )
                        : Text(
                            competenceCheck.createdBy,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                    const Gap(5),
                  ],
                ),
                const Gap(10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(5),
                    isAuthorized
                        ? GrowthDropdown(
                            dropdownValue: competenceCheck.score,
                            onChangedFunction: (int? value) async {
                              if (value == competenceCheck.score) {
                                return;
                              }
                              await di<CompetenceManager>()
                                  .updateCompetenceCheck(
                                      competenceCheckId:
                                          competenceCheck.checkId,
                                      competenceStatus: value);
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CompetenceHelper.getCompetenceCheckSymbol(
                                status: competenceCheck.score, size: 60),
                          ),
                    const Spacer(),
                    //- Take picture button only visible if there are less than 4 pictures
                    if (competenceCheck.documents == null ||
                        (competenceCheck.documents?.length ?? 0) < 4)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              final File? file = await createImageFile(context);
                              if (file == null) return;
                              await di<CompetenceManager>()
                                  .postCompetenceCheckFile(
                                      competenceCheckId:
                                          competenceCheck.checkId,
                                      file: file);
                            },
                            onLongPress: () async {},
                            child: SizedBox(
                              height: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child:
                                    Image.asset('assets/document_camera.png'),
                              ),
                            ),
                          )
                        ],
                      ),
                    if (competenceCheck.documents != null)
                      for (HubDocument file
                          in competenceCheck.documents!) ...<Widget>[
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                // final File? file = await uploadImage(context);
                                // if (file == null) return;
                                // await di<CompetenceManager>()
                                //     .patchCompetenceCheckWithFile(
                                //         file, competenceCheck.checkId, true);
                                // di<NotificationService>().showSnackBar(
                                //     NotificationType.success,
                                //     'Vorfall geändert!');
                              },
                              onLongPress: () async {
                                bool? confirm = await confirmationDialog(
                                    context: context,
                                    title: 'Dokument löschen',
                                    message: 'Dokument löschen?');
                                if (confirm != true) {
                                  return;
                                }
                                await di<CompetenceManager>()
                                    .deleteCompetenceCheckFile(
                                        competenceCheckId:
                                            competenceCheck.checkId,
                                        fileId: file.documentId);
                              },
                              child: DocumentImage(
                                documentId: file.documentId,
                                size: 70,
                              ),
                            )
                          ],
                        ),
                      ],

                    const Gap(5),
                  ],
                ),
                const Gap(15),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (isAuthorized) {
                          final String? comment = await longTextFieldDialog(
                            parentContext: context,
                            title: 'Status',
                            labelText: 'Status eingeben',
                            initialValue: competenceCheck.comment,
                          );
                          if (comment != null) {
                            await di<CompetenceManager>().updateCompetenceCheck(
                                competenceCheckId: competenceCheck.checkId,
                                competenceComment: comment);
                          }
                        }
                      },
                      child: const Text(
                        'Kommentar:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.interactiveColor,
                        ),
                      ),
                    ),
                    const Gap(5),
                    Flexible(
                      child: InkWell(
                        onTap: () async {
                          if (isAuthorized) {
                            final String? comment = await longTextFieldDialog(
                              parentContext: context,
                              title: 'Kommentar',
                              labelText: 'Kommentar eingeben',
                              initialValue: competenceCheck.comment,
                            );
                            if (comment != null) {
                              await di<CompetenceManager>()
                                  .updateCompetenceCheck(
                                      competenceCheckId:
                                          competenceCheck.checkId,
                                      competenceComment: comment);
                            }
                          }
                        },
                        child: Text(
                          (competenceCheck.comment == null ||
                                  competenceCheck.comment!.isEmpty)
                              ? 'Kein Kommentar'
                              : competenceCheck.comment!,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
