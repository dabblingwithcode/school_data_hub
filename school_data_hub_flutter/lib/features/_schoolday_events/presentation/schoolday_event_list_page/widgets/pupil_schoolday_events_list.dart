import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/generic_async_action_button.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/new_schoolday_event_page/new_schoolday_event_page.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/pupil_schoolday_event_card.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class PupilSchooldayEventsList extends WatchingWidget {
  final PupilProxy pupil;
  const PupilSchooldayEventsList({super.key, required this.pupil});

  @override
  Widget build(BuildContext context) {
    final schooldayEventFilterManager = di<SchooldayEventFilterManager>();
    final schooldayEventManager = di<SchooldayEventManager>();
    final notificationService = di<NotificationService>();
    final pupil = this.pupil;
    final unfilteredEvents = watch(
      schooldayEventManager.getPupilSchooldayEventsProxy(pupil.pupilId),
    ).schooldayEvents;
    final List<SchooldayEvent> filteredSchooldayEvents =
        schooldayEventFilterManager.filteredSchooldayEvents(
          unfilteredEvents.values.toList(),
        );
    return Column(
      children: [
        if (filteredSchooldayEvents.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Keine Ereignisse gefunden',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ),
        GenericAsyncActionButton(
          onPressed: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => NewSchooldayEventPage(pupilId: pupil.pupilId),
              ),
            );
          },
          title: "NEUES EREIGNIS",
          buttonType: ButtonType.action,
        ),

        ListView.builder(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredSchooldayEvents.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.5),
              child: GestureDetector(
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
                    title: 'Ereignis löschen',
                    message: 'Das Ereignis löschen?',
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
              ),
            );
          },
        ),
      ],
    );
  }
}
