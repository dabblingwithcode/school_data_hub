import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/new_schoolday_event_screen/new_schoolday_event_screen.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/schoolday_event_list_screen/widgets/pupil_schoolday_event_card.dart';

class PupilSchooldayEventsList extends WatchingWidget {
  final PupilProxy pupil;
  const PupilSchooldayEventsList({super.key, required this.pupil});

  @override
  Widget build(BuildContext context) {
    final schooldayEventFilterManager = di<SchooldayEventFilterManager>();
    final schooldayEventManager = di<SchooldayEventManager>();
    final notificationService = di<NotificationManager>();
    final pupil = this.pupil;
    final proxy = schooldayEventManager.getPupilSchooldayEventsProxy(
      pupil.pupilId,
    );
    final merged = createOnce(
      () => Listenable.merge([
        proxy,
        schooldayEventFilterManager.schooldayEventsFilterState,
      ]),
    );
    watchPropertyValue(
      (Listenable _) => schooldayEventFilterManager
          .filteredSchooldayEvents(proxy.schooldayEvents.values.toList())
          .map((e) => (e.id, e.documentId))
          .toList(),
      target: merged,
    );
    final filteredSchooldayEvents = schooldayEventFilterManager
        .filteredSchooldayEvents(proxy.schooldayEvents.values.toList());
    return Column(
      children: [
        if (filteredSchooldayEvents.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.all(Style.spacing.lg),
              child: Text(
                'Keine Ereignisse gefunden',
                style: context.typography.body,
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Style.spacing.md,
            vertical: Style.spacing.sm,
          ),
          child: Button(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute<void>(
                  builder: (ctx) =>
                      NewSchooldayEventScreen(pupilId: pupil.pupilId),
                ),
              );
            },
            label: 'NEUES EREIGNIS',
            variant: ButtonVariant.primary,
          ),
        ),

        ListView.builder(
          padding: EdgeInsets.only(bottom: Style.spacing.sm),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredSchooldayEvents.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                //- TO-DO: change schooldayEvent
              },
              onLongPress: () async {
                if (filteredSchooldayEvents[index].processed) {
                  notificationService.showSnackBar(
                    NotificationType.error,
                    'Ereignis wurde bereits bearbeitet!',
                  );

                  return;
                }
                bool? confirm = await confirmationDialog(
                  context: context,
                  title: 'Ereignis löschen',
                  message: 'Das Ereignis löschen?',
                );
                if (confirm! == false) return;
                await schooldayEventManager.deleteSchooldayEvent(
                  filteredSchooldayEvents[index].id!,
                );
                notificationService.showSnackBar(
                  NotificationType.success,
                  'Das Ereignis wurde gelöscht!',
                );
              },
              child: PupilSchooldayEventCard(
                schooldayEvent: filteredSchooldayEvents[index],
              ),
            );
          },
        ),
      ],
    );
  }
}
