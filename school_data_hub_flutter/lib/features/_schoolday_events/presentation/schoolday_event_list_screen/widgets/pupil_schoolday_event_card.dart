import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/encrypted_document_image.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_screen/widgets/dialogues/schoolday_event_reason_dialog.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_screen/widgets/dialogues/schoolday_event_type_dialog.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_screen/widgets/schoolday_event_reason_chips.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_screen/widgets/schoolday_event_type_icon.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/select_users/select_users_screen.dart';

/// Document image/placeholder for one schoolday event. Rebuilds only when this
/// event's document part changes (via .select on the manager's event list).
class _SchooldayEventDocumentImage extends WatchingWidget {
  final SchooldayEvent schooldayEvent;

  const _SchooldayEventDocumentImage({required this.schooldayEvent});

  @override
  Widget build(BuildContext context) {
    final manager = di<SchooldayEventManager>();
    final eventId = schooldayEvent.id!;
    final documentPart = createOnce(() {
      final m = di<SchooldayEventManager>();
      final id = schooldayEvent.id!;
      return m.schooldayEvents.select((list) {
        final e = list.firstWhereOrNull((e) => e.id == id);
        return e?.documentId;
      });
    });
    watch(documentPart);

    final list = manager.schooldayEvents.value;
    final event =
        list.firstWhereOrNull((e) => e.id == eventId) ?? schooldayEvent;

    if (event.document != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            event.document!.createdAt.formatDateForUser(),
            style: context.typography.caption.bold,
          ),
          EncryptedDocumentImage(
            documentId: event.document!.documentId,
            size: 70,
          ),
          Row(
            children: [
              Text(
                event.document!.createdBy,
                style: context.typography.caption.bold,
              ),
            ],
          ),
        ],
      );
    }
    return Column(
      children: [
        const Gap(13),
        SizedBox(
          height: 70,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Style.radii.small),
            child: Image.asset('assets/document_camera.png'),
          ),
        ),
      ],
    );
  }
}

class PupilSchooldayEventCard extends StatelessWidget {
  final SchooldayEvent schooldayEvent;
  const PupilSchooldayEventCard({required this.schooldayEvent, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final hubSessionManager = di<HubSessionManager>();
    final schooldayEventManager = di<SchooldayEventManager>();
    final schoolCalendarManager = di<SchoolCalendarManager>();
    final notificationService = di<NotificationManager>();
    final isAuthorized = SessionHelper.isAuthorized(schooldayEvent.createdBy);
    final isAdmin = hubSessionManager.isAdmin;

    return CardBox(
      variant: CardBoxVariant.filled,
      padding: EdgeInsets.all(Style.spacing.sm),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: !schooldayEvent.processed
              ? style.colors.notProcessed
              : style.colors.cardInCard,
          borderRadius: BorderRadius.circular(Style.radii.small),
        ),
        child: Padding(
          padding: EdgeInsets.all(Style.spacing.md),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (!isAuthorized) {
                                    notificationService.showSnackBar(
                                      NotificationType.error,
                                      'Nicht berechtigt!',
                                    );
                                    return;
                                  }
                                  DateTime? date = await selectSchooldayDate(
                                    context,
                                    schoolCalendarManager.thisDate.value,
                                  );
                                  if (date == null) return;
                                  final schooldayId = schoolCalendarManager
                                      .getSchooldayByDate(date)
                                      ?.id;

                                  await schooldayEventManager
                                      .updateSchooldayEvent(
                                        eventToUpdate: schooldayEvent,
                                        schooldayId: schooldayId,
                                      );
                                  notificationService.showSnackBar(
                                    NotificationType.success,
                                    'Ereignis als bearbeitet markiert!',
                                  );
                                },
                                child: Text(
                                  schooldayEvent.schoolday!.schoolday
                                      .formatDateForUser(),
                                  style: context.typography.subtitle.bold
                                      .withColor(
                                        isAuthorized
                                            ? style.colors.interactive
                                            : style.colors.foreground,
                                      )
                                      .copyWith(fontSize: 20, height: 1.0),
                                ),
                              ),
                              Gap(Style.spacing.xs),
                              GestureDetector(
                                onLongPress: () {
                                  if (!SessionHelper.isAuthorized(
                                    schooldayEvent.createdBy,
                                  )) {
                                    notificationService.showSnackBar(
                                      NotificationType.error,
                                      'Nicht berechtigt!',
                                    );
                                    return;
                                  }
                                  SchooldayEventTypeDialog.show(
                                    context: context,
                                    schooldayEvent: schooldayEvent,
                                  );
                                },
                                child: SchooldayEventTypeIcon(
                                  type: schooldayEvent.eventType,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time,
                              color: style.colors.interactive,
                              size: 20,
                            ),
                            Gap(Style.spacing.xs),
                            GestureDetector(
                              onTap: () async {
                                if (!isAuthorized) {
                                  notificationService.showSnackBar(
                                    NotificationType.error,
                                    'Nicht berechtigt!',
                                  );
                                  return;
                                }
                                final eventTime =
                                    schooldayEvent.eventTime ?? '00:00';
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(
                                    hour: int.parse(eventTime.split(':')[0]),
                                    minute: int.parse(eventTime.split(':')[1]),
                                  ),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true,
                                          ),
                                          child: child!,
                                        );
                                      },
                                );
                                if (picked != null) {
                                  final newEventTime =
                                      '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                                  await schooldayEventManager
                                      .updateSchooldayEvent(
                                        eventToUpdate: schooldayEvent,
                                        eventTime: newEventTime,
                                      );
                                  notificationService.showSnackBar(
                                    NotificationType.success,
                                    'Uhrzeit erfolgreich geändert!',
                                  );
                                }
                              },
                              child: Text(
                                schooldayEvent.eventTime ?? '--:--',
                                style: context.typography.subtitle.bold
                                    .withColor(
                                      isAuthorized
                                          ? style.colors.interactive
                                          : style.colors.foreground,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Gap(Style.spacing.xs),
                        GestureDetector(
                          onTap: () {
                            if (!isAuthorized) {
                              notificationService.showSnackBar(
                                NotificationType.error,
                                'Nicht berechtigt!',
                              );
                              return;
                            }
                            SchooldayEventReasonDialog.show(
                              context: context,
                              schooldayEvent: schooldayEvent,
                            );
                          },
                          child: Wrap(
                            direction: Axis.horizontal,
                            spacing: Style.spacing.xs,
                            children: [
                              ...schooldayEventReasonChips(
                                schooldayEvent.eventReason,
                              ),
                            ],
                          ),
                        ),
                        Gap(Style.spacing.sm),
                        Row(
                          children: [
                            Text(
                              'Erstellt von:',
                              style: context.typography.subtitle,
                            ),
                            Gap(Style.spacing.xs),

                            isAuthorized
                                ? GestureDetector(
                                    onTap: () async {
                                      final users =
                                          di<UserManager>().users.value;
                                      final List<User>? selectedUsers =
                                          await Navigator.of(context).push(
                                            MaterialPageRoute<List<User>>(
                                              builder: (ctx) =>
                                                  SelectUsersScreen(
                                                    selectableUsers: users,
                                                    authorizedUsers:
                                                        schooldayEvent
                                                            .createdBy,
                                                    isMultiSelectMode: false,
                                                  ),
                                            ),
                                          );
                                      if (selectedUsers == null ||
                                          selectedUsers.isEmpty) {
                                        return;
                                      }
                                      if (selectedUsers
                                              .first
                                              .userInfo!
                                              .userName ==
                                          schooldayEvent.createdBy) {
                                        return;
                                      }

                                      await schooldayEventManager
                                          .updateSchooldayEvent(
                                            eventToUpdate: schooldayEvent,
                                            createdBy: selectedUsers
                                                .first
                                                .userInfo!
                                                .userName!,
                                            processed: false,
                                          );
                                    },
                                    child: Text(
                                      schooldayEvent.createdBy,
                                      style: context.typography.title.withColor(
                                        style.colors.accent,
                                      ),
                                    ),
                                  )
                                : Text(
                                    schooldayEvent.createdBy,
                                    style: context.typography.title,
                                  ),
                            Gap(Style.spacing.sm),
                          ],
                        ),
                        Gap(Style.spacing.xs),
                      ],
                    ),
                  ),
                  Gap(Style.spacing.sm),
                  //- Image for event processing description
                  if (schooldayEvent.processed)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Gap(13),
                        GestureDetector(
                          onTap: () async {
                            final File? file = await createAndCropImageFile(
                              context,
                            );
                            if (file == null) return;
                            await schooldayEventManager
                                .updateSchooldayEventFile(
                                  imageFile: file,
                                  schooldayEventId: schooldayEvent.id!,
                                  isProcessed: true,
                                );
                          },
                          onLongPress: () async {
                            if (schooldayEvent.processedDocumentId == null) {
                              notificationService.showSnackBar(
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
                            await schooldayEventManager
                                .deleteSchooldayEventFile(
                                  schooldayEvent.id!,
                                  schooldayEvent.processedDocument!.documentId,
                                  true,
                                );
                            notificationService.showSnackBar(
                              NotificationType.success,
                              'Dokument gelöscht!',
                            );
                          },
                          child: schooldayEvent.processedDocumentId != null
                              ? EncryptedDocumentImage(
                                  documentId: schooldayEvent
                                      .processedDocument!
                                      .documentId,
                                  size: 70,
                                )
                              : SizedBox(
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      Style.radii.small,
                                    ),
                                    child: Image.asset(
                                      'assets/document_camera.png',
                                    ),
                                  ),
                                ),
                        ),
                        const Gap(13),
                      ],
                    ),
                  Gap(Style.spacing.sm),
                  //- Image for Event description
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final File? file = await createAndCropImageFile(
                            context,
                          );
                          if (file == null) return;
                          await schooldayEventManager.updateSchooldayEventFile(
                            imageFile: file,
                            schooldayEventId: schooldayEvent.id!,
                            isProcessed: false,
                          );
                        },
                        onLongPress: () async {
                          if (schooldayEvent.documentId == null) {
                            notificationService.showSnackBar(
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
                          await schooldayEventManager.deleteSchooldayEventFile(
                            schooldayEvent.id!,
                            schooldayEvent.document!.documentId,
                            false,
                          );
                          notificationService.showSnackBar(
                            NotificationType.success,
                            'Dokument gelöscht!',
                          );
                        },
                        child: _SchooldayEventDocumentImage(
                          schooldayEvent: schooldayEvent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Gap(Style.spacing.xs),
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              bool? confirm = await confirmationDialog(
                                context: context,
                                title: 'Ereignis bearbeitet?',
                                message: 'Ereignis als bearbeitet markieren?',
                              );
                              if (confirm! == false) return;
                              await schooldayEventManager.updateSchooldayEvent(
                                eventToUpdate: schooldayEvent,
                                processed: true,
                              );
                              notificationService.showSnackBar(
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
                              await schooldayEventManager.updateSchooldayEvent(
                                eventToUpdate: schooldayEvent,
                                processed: false,
                                processedBy: (value: null),
                              );
                            },
                            child: Text(
                              schooldayEvent.processed
                                  ? 'Bearbeitet von'
                                  : 'Nicht bearbeitet',
                              style: context.typography.subtitle.withColor(
                                style.colors.accent,
                              ),
                            ),
                          ),
                          Gap(Style.spacing.sm),
                          if (schooldayEvent.processedBy != null)
                            isAdmin
                                ? GestureDetector(
                                    onTap: () async {
                                      final users =
                                          di<UserManager>().users.value;
                                      final List<User>? selectedUsers =
                                          await Navigator.of(context).push(
                                            MaterialPageRoute<List<User>>(
                                              builder: (ctx) =>
                                                  SelectUsersScreen(
                                                    selectableUsers: users,
                                                    authorizedUsers:
                                                        schooldayEvent
                                                            .processedBy,
                                                    isMultiSelectMode: false,
                                                  ),
                                            ),
                                          );
                                      if (selectedUsers == null ||
                                          selectedUsers.isEmpty) {
                                        return;
                                      }
                                      if (selectedUsers
                                              .first
                                              .userInfo!
                                              .userName ==
                                          schooldayEvent.processedBy) {
                                        return;
                                      }

                                      await schooldayEventManager
                                          .updateSchooldayEvent(
                                            eventToUpdate: schooldayEvent,
                                            processedBy: (
                                              value: selectedUsers
                                                  .first
                                                  .userInfo!
                                                  .userName!,
                                            ),
                                          );
                                    },
                                    child: Text(
                                      schooldayEvent.processedBy!,
                                      style: context.typography.title.withColor(
                                        style.colors.interactive,
                                      ),
                                    ),
                                  )
                                : Text(
                                    schooldayEvent.processedBy!,
                                    style: context.typography.title,
                                  ),
                          if (schooldayEvent.processedAt != null)
                            Gap(Style.spacing.sm),
                          if (schooldayEvent.processedAt != null)
                            hubSessionManager.isAdmin
                                ? GestureDetector(
                                    onTap: () async {
                                      final DateTime? newDate =
                                          await selectSchooldayDate(
                                            context,
                                            schooldayEvent.processedAt!,
                                          );

                                      if (newDate != null) {
                                        await schooldayEventManager
                                            .updateSchooldayEvent(
                                              eventToUpdate: schooldayEvent,
                                              processedAt: (value: newDate),
                                            );
                                      }
                                    },
                                    child: Text(
                                      'am ${schooldayEvent.processedAt!.formatDateForUser()}',
                                      style: context.typography.title.withColor(
                                        style.colors.interactive,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'am ${schooldayEvent.processedAt!.formatDateForUser()}',
                                    style: context.typography.title,
                                  ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap(Style.spacing.xs),
              GestureDetector(
                onTap: () async {
                  final String? comment = await shortTextfieldDialog(
                    context: context,
                    title: 'Kommentar',
                    labelText: 'Kommentar',
                    hintText: 'Kommentar',
                    textinField: schooldayEvent.comment ?? '',
                    obscureText: false,
                  );
                  if (comment != null) {
                    await schooldayEventManager.updateSchooldayEvent(
                      eventToUpdate: schooldayEvent,
                      comment: (value: comment),
                    );
                  }
                },
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
                          text: schooldayEvent.comment ?? 'Kein Kommentar',
                        ),
                      ],
                    ),
                    softWrap: true,
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
