import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/grades_widget.dart';
import 'package:school_data_hub_flutter/common/widgets/upload_image.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/competence/domain/enums.dart';
import 'package:school_data_hub_flutter/features/competence/presentation/widgets/competence_check_dropdown.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:watch_it/watch_it.dart';

class PupilWorkbookCard extends WatchingWidget {
  const PupilWorkbookCard(
      {required this.pupilWorkbook, required this.pupilId, super.key});
  final PupilWorkbook pupilWorkbook;
  final int pupilId;

  void onChangedGrowthDropdown(int value) {
    di<PupilWorkbookManager>()
        .updatePupilWorkbook(pupilWorkbook: pupilWorkbook, score: value);
  }

  @override
  Widget build(BuildContext context) {
    final Workbook workbook =
        di<WorkbookManager>().getWorkbookByIsbn(pupilWorkbook.workbook!.isbn)!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
          child: InkWell(
        onLongPress: () async {
          if (pupilWorkbook.createdBy != di<HubSessionManager>().userName ||
              !di<HubSessionManager>().isAdmin) {
            informationDialog(context, 'Keine Berechtigung',
                'Arbeitshefte können nur von der eintragenden Person bearbeitet werden!');
            return;
          }
          final bool? result = await confirmationDialog(
              context: context,
              title: 'Arbeitsheft löschen',
              message: 'Arbeitsheft "${workbook.name}" wirklich löschen?');
          if (result == true) {
            di<PupilWorkbookManager>()
                .deletePupilWorkbook(pupilId, workbook.isbn);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          final File? file = await createImageFile(context);
                          if (file == null) return;
                          // TODO: Uncomment when API is ready
                          di<NotificationService>().showSnackBar(
                              NotificationType.warning, 'Not implemented yet');
                          // await di<WorkbookManager>()
                          //     .postWorkbookFile(file, workbook.isbn);
                        },
                        onLongPress: (workbook.imageUrl == null)
                            ? () {}
                            : () async {
                                if (workbook.imageUrl == null) {
                                  return;
                                }
                                final bool? result = await confirmationDialog(
                                    context: context,
                                    title: 'Bild löschen',
                                    message: 'Bild löschen?');
                                if (result != true) return;
                                // TODO: Uncomment when API is ready
                                di<NotificationService>().showSnackBar(
                                    NotificationType.warning,
                                    'Not implemented yet');
                                // await di<WorkbookManager>()
                                //     .deleteAuthorizationFile(
                                //   pupil.internalId,
                                //   authorizationId,
                                //   pupilAuthorization.fileId!,
                                // );
                              },
                        child:
                            //  workbook.imageUrl != null
                            //     ? Provider<DocumentImageData>.value(
                            //         updateShouldNotify: (oldValue, newValue) =>
                            //             oldValue.documentUrl !=
                            //             newValue.documentUrl,
                            //         value: DocumentImageData(
                            //             documentTag: workbook.imageUrl!,
                            //             documentUrl:
                            //                 '${di<EnvManager>().env!.serverUrl}${WorkbookApiService().getWorkbookImage(workbook.isbn)}',
                            //             size: 100),
                            //         child: const DocumentImage(),
                            //       )
                            //     :
                            SizedBox(
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset('assets/document_camera.png'),
                          ),
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    workbook.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const Gap(10),
                            ],
                          ),
                          const Gap(5),
                          // Row(
                          //   children: [
                          //     const Text('ISBN:'),
                          //     const Gap(10),
                          //     Text(
                          //       workbook.isbn.toString(),
                          //       style: const TextStyle(
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const Gap(5),
                          Row(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        RootCompetenceType
                                            .stringToValue[workbook.subject]!
                                            .value,
                                        overflow: TextOverflow.fade,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    const Gap(5),
                                    workbook.level != null
                                        ? GradesWidget(
                                            stringWithGrades: workbook.level!)
                                        : const Text(
                                            'nicht vorhanden',
                                          ),
                                  ],
                                ),
                                const Gap(5),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        if (!(di<HubSessionManager>()
                                                    .userName ==
                                                pupilWorkbook.createdBy) ||
                                            di<HubSessionManager>().isAdmin) {
                                          informationDialog(
                                              context,
                                              'Keine Berechtigung',
                                              'Arbeitshefte können nur von der eingetragenen Person oder von einem Admin bearbeitet werden!');
                                          return;
                                        }
                                        final createdBy =
                                            await shortTextfieldDialog(
                                                context: context,
                                                title: 'Betreuer:in ändern',
                                                labelText:
                                                    'Betreuer:in eintragen',
                                                hintText:
                                                    'Wer soll das Arbeitsheft betreuen?');
                                        if (createdBy == null) return;
                                        di<PupilWorkbookManager>()
                                            .updatePupilWorkbook(
                                                pupilWorkbook: pupilWorkbook,
                                                createdBy: createdBy);
                                      },
                                      child: Text(
                                        pupilWorkbook.createdBy,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Gap(2),
                                    const Icon(
                                      Icons.arrow_circle_right_rounded,
                                      color: Colors.orange,
                                    ),
                                    const Gap(2),
                                    Text(
                                      pupilWorkbook.createdAt.formatForUser(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                const Gap(10),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                GrowthDropdown(
                                    dropdownValue: 0,
                                    onChangedFunction: onChangedGrowthDropdown),
                              ],
                            )
                          ])
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              const Text('Kommentar:'),
              const Gap(5),
              InkWell(
                onTap: () async {
                  final comment = await longTextFieldDialog(
                      title: 'Kommentar',
                      initialValue: pupilWorkbook.comment ?? '',
                      labelText: 'Kommentar eintragen',
                      parentContext: context);
                  if (comment == null) return;
                  di<PupilWorkbookManager>().updatePupilWorkbook(
                      pupilWorkbook: pupilWorkbook, comment: (value: comment));
                },
                child: Text(
                  pupilWorkbook.comment == null || pupilWorkbook.comment! == ''
                      ? 'Kein Kommentar'
                      : pupilWorkbook.comment!,
                  style: const TextStyle(
                      fontSize: 16, color: AppColors.interactiveColor),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
