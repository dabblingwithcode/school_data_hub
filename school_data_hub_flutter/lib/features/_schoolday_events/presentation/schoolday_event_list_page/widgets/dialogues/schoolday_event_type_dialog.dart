import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventTypeDialog extends WatchingWidget {
  // Change HookWidget to HookConsumerWidget
  final SchooldayEvent schooldayEvent;

  const SchooldayEventTypeDialog({super.key, required this.schooldayEvent});

  SchooldayEventManager get _schooldayEventManager =>
      di<SchooldayEventManager>();

  String _getDropdownItemText(SchooldayEventType reason) {
    switch (reason) {
      case SchooldayEventType.notSet:
        return 'bitte wählen';
      case SchooldayEventType.admonition:
        return 'rote Karte';
      case SchooldayEventType.afternoonCareAdmonition:
        return 'rote Karte - OGS';
      case SchooldayEventType.admonitionAndBanned:
        return 'rote Karte + abholen';
      case SchooldayEventType.parentsMeeting:
        return 'Elterngespräch';
      case SchooldayEventType.otherEvent:
        return 'sonstiges';
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedEventType = createOnce(
      () => ValueNotifier<SchooldayEventType>(SchooldayEventType.notSet),
    );

    return AlertDialog(
      title: const Text(
        'Ereignisart ändern',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: DropdownButton<SchooldayEventType>(
        isDense: true,
        underline: Container(),
        style: const TextStyle(fontSize: 20),
        value: selectedEventType.value,
        onChanged: (SchooldayEventType? newValue) {
          selectedEventType.value = newValue!;
          if (newValue == SchooldayEventType.notSet) return;
          Navigator.of(context).pop();
          _schooldayEventManager.updateSchooldayEvent(
            eventToUpdate: schooldayEvent,
            schoolEventType: newValue,
          );
        },
        items: SchooldayEventType.values
            .map<DropdownMenuItem<SchooldayEventType>>((
              SchooldayEventType value,
            ) {
              return DropdownMenuItem<SchooldayEventType>(
                value: value,
                child: Text(
                  _getDropdownItemText(value),
                  style: TextStyle(
                    color: value == SchooldayEventType.notSet
                        ? Colors.red
                        : Colors.black,
                    fontSize: 20,
                  ),
                ),
              );
            })
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
