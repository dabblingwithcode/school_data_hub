import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:schuldaten_hub/common/domain/env_manager.dart';
import 'package:schuldaten_hub/common/domain/models/enums.dart';
import 'package:schuldaten_hub/common/domain/session_helper_functions.dart';
import 'package:schuldaten_hub/common/domain/session_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_service.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:schuldaten_hub/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:schuldaten_hub/common/widgets/document_image.dart';
import 'package:schuldaten_hub/common/widgets/upload_image.dart';
import 'package:schuldaten_hub/features/schoolday_events/data/schoolday_event_api_service.dart';
import 'package:schuldaten_hub/features/schoolday_events/domain/models/schoolday_event.dart';
import 'package:schuldaten_hub/features/schoolday_events/domain/schoolday_event_manager.dart';
import 'package:schuldaten_hub/features/schoolday_events/presentation/schoolday_event_list_page/widgets/dialogues/schoolday_event_type_dialog.dart';
import 'package:schuldaten_hub/features/schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_reason_chips.dart';
import 'package:schuldaten_hub/features/schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_type_icon.dart';
import 'package:schuldaten_hub/features/schooldays/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

class PupilSchooldayEventCard extends WatchingWidget {
  final SchooldayEvent schooldayEvent;
  const PupilSchooldayEventCard({required this.schooldayEvent, super.key});

  @override
  Widget build(BuildContext context) {
    final isAuthorized = SessionHelper.isAuthorized(schooldayEvent.createdBy);
    return Card(
      color: !schooldayEvent.processed
          ? AppColors.notProcessedColor
          : AppColors.cardInCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: !schooldayEvent.processed
              ? Border.all(
                  color: Colors
                      .orangeAccent, // Specify the color of the border here
                  width: 3, // Specify the width of the border here
                )
              : Border.all(
                  color: AppColors
                      .cardInCardBorderColor, // Specify the color of the border here
                  width: 2,
                ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              isAuthorized
                                  ? InkWell(
                                      onTap: () async {
                                        DateTime? date =
                                            await selectSchooldayDate(
                                                context,
                                                locator<SchooldayManager>()
                                                    .thisDate
                                                    .value);
                                        if (date == null) return;
                                        await locator<SchooldayEventManager>()
                                            .patchSchooldayEvent(
                                                schooldayEventId: schooldayEvent
                                                    .schooldayEventId,
                                                schoolEventDay: date);
                                        locator<NotificationService>().showSnackBar(
                                            NotificationType.success,
                                            'Ereignis als bearbeitet markiert!');
                                      },
                                      child: Text(
                                        schooldayEvent.schooldayEventDate
                                            .formatForUser(),
                                        style: const TextStyle(
                                          color: AppColors.interactiveColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      schooldayEvent.schooldayEventDate
                                          .formatForUser(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                              const Gap(5),
                              InkWell(
                                onLongPress: () {
                                  if (!SessionHelper.isAuthorized(
                                      schooldayEvent.createdBy)) {
                                    locator<NotificationService>().showSnackBar(
                                        NotificationType.error,
                                        'Nicht berechtigt!');
                                    return;
                                  }

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SchooldayEventTypeDialog(
                                        schooldayEventId:
                                            schooldayEvent.schooldayEventId,
                                      );
                                    },
                                  );
                                },
                                child: SchooldayEventTypeIcon(
                                    category:
                                        schooldayEvent.schooldayEventType),
                              )
                            ],
                          ),
                        ),
                        const Gap(5),
                        //-TODO: Add the possibility to change the admonishing reasons
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 5,
                          children: [
                            ...schooldayEventReasonChips(
                                schooldayEvent.schooldayEventReason),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            const Text('Erstellt von:',
                                style: TextStyle(fontSize: 16)),
                            const Gap(5),
                            // only admin can change the admonishing user
                            locator<SessionManager>().isAdmin.value
                                ? InkWell(
                                    onTap: () async {
                                      final String? createdBy =
                                          await shortTextfieldDialog(
                                              context: context,
                                              title: 'Erstellt von:',
                                              labelText: 'Kürzel eingeben',
                                              hintText: 'Kürzel eingeben',
                                              obscureText: false);
                                      if (createdBy != null) {
                                        await locator<SchooldayEventManager>()
                                            .patchSchooldayEvent(
                                          schooldayEventId:
                                              schooldayEvent.schooldayEventId,
                                          createdBy: createdBy,
                                          processed: null,
                                        );
                                      }
                                    },
                                    child: Text(
                                      schooldayEvent.createdBy,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: AppColors.backgroundColor),
                                    ),
                                  )
                                : Text(
                                    schooldayEvent.createdBy,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                            const Gap(10),
                          ],
                        ),
                        const Gap(5),
                      ],
                    ),
                  ),
                  const Gap(10),
                  //- Image for event processing description
                  if (schooldayEvent.processed)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            final File? file = await uploadImageFile(context);
                            if (file == null) return;
                            await locator<SchooldayEventManager>()
                                .patchSchooldayEventWithFile(file,
                                    schooldayEvent.schooldayEventId, true);
                            locator<NotificationService>().showSnackBar(
                                NotificationType.success, 'Vorfall geändert!');
                          },
                          onLongPress: () async {
                            bool? confirm = await confirmationDialog(
                                context: context,
                                title: 'Dokument löschen',
                                message: 'Dokument löschen?');
                            if (confirm != true) {
                              return;
                            }
                            await locator<SchooldayEventManager>()
                                .deleteSchooldayEventFile(
                                    schooldayEvent.schooldayEventId,
                                    schooldayEvent.processedFileId!,
                                    true);
                            locator<NotificationService>().showSnackBar(
                                NotificationType.success, 'Dokument gelöscht!');
                          },
                          child: schooldayEvent.processedFileId != null
                              ? Provider<DocumentImageData>.value(
                                  updateShouldNotify: (oldValue, newValue) =>
                                      oldValue.documentUrl !=
                                      newValue.documentUrl,
                                  value: DocumentImageData(
                                      documentTag:
                                          '${schooldayEvent.processedFileId}',
                                      documentUrl:
                                          '${locator<EnvManager>().env!.serverUrl}${SchooldayEventApiService().getSchooldayEventProcessedFileUrl(schooldayEvent.schooldayEventId)}',
                                      size: 70),
                                  child: const DocumentImage(),
                                )
                              : SizedBox(
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                        'assets/document_camera.png'),
                                  ),
                                ),
                        )
                      ],
                    ),
                  const Gap(10),
                  //- Image for Event description
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          final File? file = await uploadImageFile(context);
                          if (file == null) return;
                          await locator<SchooldayEventManager>()
                              .patchSchooldayEventWithFile(
                                  file, schooldayEvent.schooldayEventId, false);
                          locator<NotificationService>().showSnackBar(
                            NotificationType.success,
                            'Ereignis gespeichert!',
                          );
                        },
                        onLongPress: () async {
                          if (schooldayEvent.fileId == null) {
                            locator<NotificationService>().showSnackBar(
                                NotificationType.warning,
                                'Kein Dokument vorhanden!');
                            return;
                          }
                          bool? confirm = await confirmationDialog(
                              context: context,
                              title: 'Dokument löschen',
                              message: 'Dokument löschen?');
                          if (confirm == null || confirm == false) {
                            return;
                          }
                          await locator<SchooldayEventManager>()
                              .deleteSchooldayEventFile(
                                  schooldayEvent.schooldayEventId,
                                  schooldayEvent.fileId!,
                                  false);
                          locator<NotificationService>().showSnackBar(
                              NotificationType.success, 'Dokument gelöscht!');
                        },
                        child: schooldayEvent.fileId != null
                            ? Provider<DocumentImageData>.value(
                                updateShouldNotify: (oldValue, newValue) =>
                                    oldValue.documentUrl !=
                                    newValue.documentUrl,
                                value: DocumentImageData(
                                    documentTag: '${schooldayEvent.fileId}',
                                    documentUrl:
                                        '${locator<EnvManager>().env!.serverUrl}${SchooldayEventApiService().getSchooldayEventFileUrl(schooldayEvent.schooldayEventId)}',
                                    size: 70),
                                child: const DocumentImage(),
                              )
                            : SizedBox(
                                height: 70,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child:
                                      Image.asset('assets/document_camera.png'),
                                ),
                              ),
                      )
                    ],
                  )
                ],
              ),
              const Gap(5),
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              bool? confirm = await confirmationDialog(
                                  context: context,
                                  title: 'Ereignis bearbeitet?',
                                  message:
                                      'Ereignis als bearbeitet markieren?');
                              if (confirm! == false) return;
                              await locator<SchooldayEventManager>()
                                  .patchSchooldayEvent(
                                      schooldayEventId:
                                          schooldayEvent.schooldayEventId,
                                      processed: true);
                              locator<NotificationService>().showSnackBar(
                                  NotificationType.success,
                                  'Ereignis als bearbeitet markiert!');
                            },
                            onLongPress: () async {
                              bool? confirm = await confirmationDialog(
                                  context: context,
                                  title: 'Ereignis unbearbeitet?',
                                  message:
                                      'Ereignis als unbearbeitet markieren?');
                              if (confirm! == false) return;
                              await locator<SchooldayEventManager>()
                                  .patchSchooldayEvent(
                                schooldayEventId:
                                    schooldayEvent.schooldayEventId,
                                processed: false,
                                processedBy: 'none',
                              );
                            },
                            child: Text(
                                schooldayEvent.processed
                                    ? 'Bearbeitet von'
                                    : 'Nicht bearbeitet',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.backgroundColor)),
                          ),
                          const Gap(10),
                          if (schooldayEvent.processedBy != null)
                            locator<SessionManager>().isAdmin.value
                                ? InkWell(
                                    onTap: () async {
                                      final String? processingUser =
                                          await shortTextfieldDialog(
                                              context: context,
                                              title: 'Bearbeitet von:',
                                              labelText: 'Kürzel eingeben',
                                              hintText: 'Kürzel eingeben',
                                              obscureText: false);
                                      if (processingUser != null) {
                                        await locator<SchooldayEventManager>()
                                            .patchSchooldayEvent(
                                          schooldayEventId:
                                              schooldayEvent.schooldayEventId,
                                          processedBy: processingUser,
                                        );
                                      }
                                    },
                                    child: Text(
                                      schooldayEvent.processedBy!,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.interactiveColor),
                                    ),
                                  )
                                : Text(
                                    schooldayEvent.processedBy!,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                          if (schooldayEvent.processedAt != null) const Gap(10),
                          if (schooldayEvent.processedAt != null)
                            locator<SessionManager>().isAdmin.value
                                ? InkWell(
                                    onTap: () async {
                                      final DateTime? newDate =
                                          await selectSchooldayDate(
                                              context, DateTime.now());

                                      if (newDate != null) {
                                        await locator<SchooldayEventManager>()
                                            .patchSchooldayEvent(
                                                schooldayEventId: schooldayEvent
                                                    .schooldayEventId,
                                                processedAt: newDate);
                                      }
                                    },
                                    child: Text(
                                      'am ${schooldayEvent.processedAt!.formatForUser()}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: AppColors.interactiveColor),
                                    ),
                                  )
                                : Text(
                                    'am ${schooldayEvent.processedAt!.formatForUser()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
