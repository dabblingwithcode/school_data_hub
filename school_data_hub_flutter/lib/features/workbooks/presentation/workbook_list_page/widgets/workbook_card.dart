import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/isbn_extensions.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/grades_widget.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/common/widgets/upload_image.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/new_workbook_page/new_workbook_page.dart';
import 'package:watch_it/watch_it.dart';

class WorkbookCard extends WatchingWidget {
  const WorkbookCard({required this.workbook, super.key});
  final Workbook workbook;

  @override
  Widget build(BuildContext context) {
    final expansionTileController = createOnce<CustomExpansionTileController>(
      () => CustomExpansionTileController(),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: InkWell(
          // onTap: () {
          //   Navigator.of(context).push(MaterialPageRoute(
          //     builder: (ctx) => SchoolListPupils(
          //       workbook,
          //     ),
          //   ));
          // },
          onLongPress: () async {
            // if (!di<SessionManager>().isAdmin.value) {
            //   informationDialog(context, 'Keine Berechtigung',
            //       'Arbeitshefte können nur von Admins bearbeitet werden!');
            //   return;
            // }
            final bool? result = await confirmationDialog(
              context: context,
              title: 'Arbeitsheft löschen',
              message:
                  'Arbeitsheft "${workbook.name}" wirklich löschen? ACHTUNG: Alle Arbeitshefte dieser Art werden ebenfalls gelöscht!',
            );
            if (result == true) {
              await di<WorkbookManager>().deleteWorkbook(workbook);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 5),
            child: Row(
              children: [
                const Gap(15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(10),
                    InkWell(
                      onTap: () async {
                        final File? file = await createImageFile(context);
                        if (file == null) return;
                        // TODO: implement when ready
                        di<NotificationService>().showSnackBar(
                          NotificationType.warning,
                          'Not implemented yet',
                        );
                        // await di<WorkbookManager>()
                        //     .postWorkbookFile(file, workbook.isbn);
                      },
                      onLongPress: () async {
                        final bool? result = await confirmationDialog(
                          context: context,
                          title: 'Bild löschen',
                          message: 'Bild löschen?',
                        );
                        if (result != true) return;
                        // TODO: implement when ready
                        di<NotificationService>().showSnackBar(
                          NotificationType.warning,
                          'Not implemented yet',
                        );

                        // await di<WorkbookManager>()
                        //     .deleteWorkbookFile(workbook.isbn);
                      },
                      child: workbook.imageUrl != null
                          ? UnencryptedImageInCard(
                              cacheKey: workbook.isbn.toString(),
                              path: workbook.imageUrl,
                              size: 75,
                            )
                          : SizedBox(
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  'assets/document_camera.png',
                                ),
                              ),
                            ),
                    ),
                    const Gap(10),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 15,
                      bottom: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onLongPress: (di<HubSessionManager>().isAdmin)
                                    ? () async {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => NewWorkbookPage(
                                              workbook: workbook,
                                              name: workbook.name,
                                              isbn: workbook.isbn,
                                              subject: workbook.subject,
                                              level: workbook.level,
                                              isEdit: true,
                                            ),
                                          ),
                                        );
                                      }
                                    : () {},
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    workbook.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            const Text('ISBN:'),
                            const Gap(10),
                            SelectableText(
                              workbook.isbn.displayAsIsbn(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            const Text('Kompetenzbereich(e):'),
                            const Gap(10),
                            Text(
                              workbook.subject ?? 'nicht angegeben',
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            const Text('Kompetenzstufe:'),
                            const Gap(10),
                            workbook.level != null
                                ? GradesWidget(
                                    stringWithGrades: workbook.level!,
                                  )
                                : const Text(
                                    'nicht angegeben',
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            const Text('Bestand:'),
                            const Gap(10),
                            Text(
                              workbook.amount.toString(),
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            CustomExpansionTileSwitch(
                              expansionSwitchWidget: const Icon(
                                Icons.arrow_downward,
                              ),
                              customExpansionTileController:
                                  expansionTileController,
                            ),
                            const Gap(5),
                          ],
                        ),
                        const Gap(10),
                        CustomExpansionTileContent(
                          tileController: expansionTileController,
                          widgetList: [
                            // TODO: Add cards with pupilworkbooks
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
