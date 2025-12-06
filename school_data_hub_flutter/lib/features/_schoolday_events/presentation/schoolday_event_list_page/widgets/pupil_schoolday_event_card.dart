import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/document_image.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/dialogues/schoolday_event_reason_dialog.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/dialogues/schoolday_event_type_dialog.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_reason_chips.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_type_icon.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

class PupilSchooldayEventCard extends StatelessWidget {
  final SchooldayEvent schooldayEvent;
  const PupilSchooldayEventCard({required this.schooldayEvent, super.key});

  @override
  Widget build(BuildContext context) {
    final _hubSessionManager = di<HubSessionManager>();
    final _schooldayEventManager = di<SchooldayEventManager>();
    final _schoolCalendarManager = di<SchoolCalendarManager>();
    final _notificationService = di<NotificationService>();
    final isAuthorized = SessionHelper.isAuthorized(schooldayEvent.createdBy);
    final isAdmin = _hubSessionManager.isAdmin;

    return Card(
      color: !schooldayEvent.processed
          ? AppColors.notProcessedColor
          : AppColors.cardInCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                                        DateTime?
                                        date = await selectSchooldayDate(
                                          context,
                                          _schoolCalendarManager.thisDate.value,
                                        );
                                        if (date == null) return;
                                        final schooldayId =
                                            _schoolCalendarManager
                                                .getSchooldayByDate(date)
                                                ?.id;

                                        await _schooldayEventManager
                                            .updateSchooldayEvent(
                                              eventToUpdate: schooldayEvent,

                                              schooldayId: schooldayId,
                                            );
                                        _notificationService.showSnackBar(
                                          NotificationType.success,
                                          'Ereignis als bearbeitet markiert!',
                                        );
                                      },
                                      child: Text(
                                        schooldayEvent.schoolday!.schoolday
                                            .formatDateForUser(),

                                        style: const TextStyle(
                                          color: AppColors.interactiveColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      schooldayEvent.schoolday!.schoolday
                                          .formatDateForUser(),
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
                                    schooldayEvent.createdBy,
                                  )) {
                                    _notificationService.showSnackBar(
                                      NotificationType.error,
                                      'Nicht berechtigt!',
                                    );
                                    return;
                                  }

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SchooldayEventTypeDialog(
                                        schooldayEvent: schooldayEvent,
                                      );
                                    },
                                  );
                                },
                                child: SchooldayEventTypeIcon(
                                  type: schooldayEvent.eventType,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(5),
                        //-TODO: Add the possibility to change the admonishing reasons
                        InkWell(
                          onTap: () {
                            if (!isAuthorized) {
                              _notificationService.showSnackBar(
                                NotificationType.error,
                                'Nicht berechtigt!',
                              );
                              return;
                            }
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SchooldayEventReasonDialog(
                                  schooldayEvent: schooldayEvent,
                                );
                              },
                            );
                          },
                          child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 5,
                            children: [
                              ...schooldayEventReasonChips(
                                schooldayEvent.eventReason,
                              ),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            const Text(
                              'Erstellt von:',
                              style: TextStyle(fontSize: 16),
                            ),
                            const Gap(5),
                            // only admin can change the admonishing user
                            isAdmin
                                ? InkWell(
                                    onTap: () async {
                                      final String? createdBy =
                                          await shortTextfieldDialog(
                                            context: context,
                                            title: 'Erstellt von:',
                                            labelText: 'Kürzel eingeben',
                                            hintText: 'Kürzel eingeben',
                                            obscureText: false,
                                          );
                                      if (createdBy != null) {
                                        await _schooldayEventManager
                                            .updateSchooldayEvent(
                                              eventToUpdate: schooldayEvent,
                                              createdBy: createdBy,
                                              processed: false,
                                            );
                                      }
                                    },
                                    child: Text(
                                      schooldayEvent.createdBy,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppColors.backgroundColor,
                                      ),
                                    ),
                                  )
                                : Text(
                                    schooldayEvent.createdBy,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
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
                            final File? file = await createAndCropImageFile(
                              context,
                            );
                            if (file == null) return;
                            await _schooldayEventManager
                                .updateSchooldayEventFile(
                                  imageFile: file,
                                  schooldayEventId: schooldayEvent.id!,
                                  isProcessed: true,
                                );
                          },
                          onLongPress: () async {
                            if (schooldayEvent.processedDocumentId == null) {
                              _notificationService.showSnackBar(
                                NotificationType.error,
                                'Kein Dokument vorhanden!',
                              );
                              return;
                            }
                            bool? confirm = await confirmationDialog(
                              context: context,
                              title: 'Dokument löschen',
                              message: 'Dokument löschen?',
                            );
                            if (confirm != true) {
                              return;
                            }
                            await _schooldayEventManager
                                .deleteSchooldayEventFile(
                                  schooldayEvent.id!,
                                  schooldayEvent.processedDocument!.documentId,
                                  true,
                                );
                            _notificationService.showSnackBar(
                              NotificationType.success,
                              'Dokument gelöscht!',
                            );
                          },
                          child: schooldayEvent.processedDocumentId != null
                              ? DocumentImage(
                                  documentId: schooldayEvent
                                      .processedDocument!
                                      .documentId,
                                  size: 70,
                                )
                              : SizedBox(
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      'assets/document_camera.png',
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  const Gap(10),
                  //- Image for Event description
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          final File? file = await createAndCropImageFile(
                            context,
                          );
                          if (file == null) return;
                          await _schooldayEventManager.updateSchooldayEventFile(
                            imageFile: file,
                            schooldayEventId: schooldayEvent.id!,
                            isProcessed: false,
                          );
                        },
                        onLongPress: () async {
                          if (schooldayEvent.documentId == null) {
                            _notificationService.showSnackBar(
                              NotificationType.error,
                              'Kein Dokument vorhanden!',
                            );
                            return;
                          }
                          bool? confirm = await confirmationDialog(
                            context: context,
                            title: 'Dokument löschen',
                            message: 'Dokument löschen?',
                          );
                          if (confirm != true) {
                            return;
                          }
                          await _schooldayEventManager.deleteSchooldayEventFile(
                            schooldayEvent.id!,
                            schooldayEvent.document!.documentId,
                            false,
                          );
                          _notificationService.showSnackBar(
                            NotificationType.success,
                            'Dokument gelöscht!',
                          );
                        },
                        child: schooldayEvent.document != null
                            ? DocumentImage(
                                documentId: schooldayEvent.document!.documentId,
                                size: 70,
                              )
                            : SizedBox(
                                height: 70,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.asset(
                                    'assets/document_camera.png',
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
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
                                message: 'Ereignis als bearbeitet markieren?',
                              );
                              if (confirm! == false) return;
                              await _schooldayEventManager.updateSchooldayEvent(
                                eventToUpdate: schooldayEvent,
                                processed: true,
                              );
                              _notificationService.showSnackBar(
                                NotificationType.success,
                                'Ereignis als bearbeitet markiert!',
                              );
                            },
                            onLongPress: () async {
                              bool? confirm = await confirmationDialog(
                                context: context,
                                title: 'Ereignis unbearbeitet?',
                                message: 'Ereignis als unbearbeitet markieren?',
                              );
                              if (confirm! == false) return;
                              await _schooldayEventManager.updateSchooldayEvent(
                                eventToUpdate: schooldayEvent,
                                processed: false,
                                processedBy: (value: null),
                              );
                            },
                            child: Text(
                              schooldayEvent.processed
                                  ? 'Bearbeitet von'
                                  : 'Nicht bearbeitet',
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.backgroundColor,
                              ),
                            ),
                          ),
                          const Gap(10),
                          if (schooldayEvent.processedBy != null)
                            isAdmin
                                ? InkWell(
                                    onTap: () async {
                                      //-TODO: get the user from select user page
                                      final String? processingUser =
                                          await shortTextfieldDialog(
                                            context: context,
                                            title: 'Bearbeitet von:',
                                            labelText: 'Kürzel eingeben',
                                            hintText: 'Kürzel eingeben',
                                            obscureText: false,
                                          );
                                      if (processingUser != null) {
                                        await _schooldayEventManager
                                            .updateSchooldayEvent(
                                              eventToUpdate: schooldayEvent,
                                              processedBy: (
                                                value: processingUser,
                                              ),
                                            );
                                      }
                                    },
                                    child: Text(
                                      schooldayEvent.processedBy!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.interactiveColor,
                                      ),
                                    ),
                                  )
                                : Text(
                                    schooldayEvent.processedBy!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          if (schooldayEvent.processedAt != null) const Gap(10),
                          if (schooldayEvent.processedAt != null)
                            _hubSessionManager.isAdmin
                                ? InkWell(
                                    onTap: () async {
                                      final DateTime? newDate =
                                          await selectSchooldayDate(
                                            context,
                                            DateTime.now(),
                                          );

                                      if (newDate != null) {
                                        await _schooldayEventManager
                                            .updateSchooldayEvent(
                                              eventToUpdate: schooldayEvent,
                                              processedAt: (value: newDate),
                                            );
                                      }
                                    },
                                    child: Text(
                                      'am ${schooldayEvent.processedAt!.formatDateForUser()}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppColors.interactiveColor,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'am ${schooldayEvent.processedAt!.formatDateForUser()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(5),
              const Row(
                children: [Text('Kommentar:', style: TextStyle(fontSize: 16))],
              ),
              const Gap(5),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final String? comment = await shortTextfieldDialog(
                          context: context,
                          title: 'Kommentar',
                          labelText: 'Kommentar',
                          hintText: 'Kommentar',
                          obscureText: false,
                        );
                        if (comment != null) {
                          await _schooldayEventManager.updateSchooldayEvent(
                            eventToUpdate: schooldayEvent,
                            comment: (value: comment),
                          );
                        }
                      },
                      child: Text(
                        schooldayEvent.comment ?? 'Kommentar hinzufügen',
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.interactiveColor,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
