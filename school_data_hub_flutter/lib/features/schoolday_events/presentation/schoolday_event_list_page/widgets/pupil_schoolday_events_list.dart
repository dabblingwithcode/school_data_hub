import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/new_schoolday_event_page/new_schoolday_event_page.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/schoolday_event_list_page/widgets/pupil_schoolday_event_card.dart';
import 'package:watch_it/watch_it.dart';

final _schooldayEventFilterManager = di<SchooldayEventFilterManager>();

final _schooldayEventManager = di<SchooldayEventManager>();

final _notificationService = di<NotificationService>();

class PupilSchooldayEventsList extends WatchingWidget {
  final PupilProxy pupil;
  const PupilSchooldayEventsList({super.key, required this.pupil});

  @override
  Widget build(BuildContext context) {
    final pupil = this.pupil;
    final unfilteredEvents = watch(
            _schooldayEventManager.getPupilSchooldayEventsProxy(pupil.pupilId))
        .schooldayEvents;
    final List<SchooldayEvent> filteredSchooldayEvents =
        _schooldayEventFilterManager.filteredSchooldayEvents(unfilteredEvents);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          //margin: const EdgeInsets.only(bottom: 16),
          width: double.infinity,
          child: ElevatedButton(
            style: AppStyles.actionButtonStyle,
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => NewSchooldayEventPage(
                  pupilId: pupil.pupilId,
                ),
              ));
            },
            child: const Text(
              "NEUES EREIGNIS",
              style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
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
                  _notificationService.showSnackBar(NotificationType.error,
                      'Ereignis wurde bereits bearbeitet!');

                  return;
                }
                bool? confirm = await confirmationDialog(
                    context: context,
                    title: 'Ereignis löschen',
                    message: 'Das Ereignis löschen?');
                if (confirm! == false) return;
                await _schooldayEventManager
                    .deleteSchooldayEvent(filteredSchooldayEvents[index].id!);
                _notificationService.showSnackBar(
                    NotificationType.success, 'Das Ereignis wurde gelöscht!');
              },
              child: PupilSchooldayEventCard(
                schooldayEvent: filteredSchooldayEvents[index],
              ),
            ),
          );
        },
      ),
    ]);
  }
}
