import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/schoolday_events/domain/models/schoolday_event_enums.dart';
import 'package:schuldaten_hub/features/schoolday_events/domain/schoolday_event_manager.dart';
import 'package:schuldaten_hub/features/schoolday_events/domain/schoolday_event_providers.dart';

class SchooldayEventTypeDialog extends HookConsumerWidget {
  // Change HookWidget to HookConsumerWidget
  final String schooldayEventId;

  const SchooldayEventTypeDialog({
    super.key,
    required this.schooldayEventId,
  });

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
  Widget build(BuildContext context, WidgetRef ref) {
    ref.invalidate(dropdownProvider); // Invalidate the provider
    final selectedEventType =
        ref.watch(dropdownProvider); // Access state using ref.watch
    final notifier =
        ref.read(dropdownProvider.notifier); // Access notifier with ref.read

    return AlertDialog(
      title: const Text('Select Event Type'),
      content: DropdownButton<SchooldayEventType>(
        isDense: true,
        underline: Container(),
        style: const TextStyle(fontSize: 20),
        value: selectedEventType,
        onChanged: (SchooldayEventType? newValue) {
          notifier.selectEventType(newValue);
          if (newValue == SchooldayEventType.notSet) return;
          Navigator.of(context).pop();
          locator<SchooldayEventManager>().patchSchooldayEvent(
            schooldayEventId: schooldayEventId,
            schoolEventType: newValue!.value,
          );
        },
        items:
            SchooldayEventType.values.map<DropdownMenuItem<SchooldayEventType>>(
          (SchooldayEventType value) {
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
          },
        ).toList(),
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
