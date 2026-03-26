import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/popup.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/schoolday_event_manager.dart';

class SchooldayEventTypeDialog extends WatchingWidget {
  final SchooldayEvent schooldayEvent;

  const SchooldayEventTypeDialog({super.key, required this.schooldayEvent});

  static Future<void> show({
    required BuildContext context,
    required SchooldayEvent schooldayEvent,
  }) {
    return Popup.show(
      context: context,
      title: 'Ereignisart ändern',
      child: SchooldayEventTypeDialog(schooldayEvent: schooldayEvent),
    );
  }

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
    final style = Style.of(context);
    final selectedEventType = createOnce(
      () => ValueNotifier<SchooldayEventType>(SchooldayEventType.notSet),
    );

    return Material(
      type: MaterialType.transparency,
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButton<SchooldayEventType>(
          isDense: true,
          underline: const SizedBox.shrink(),
          style: context.typography.subtitle,
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
                    style: context.typography.subtitle.w400.withColor(
                      value == SchooldayEventType.notSet
                          ? style.colors.error
                          : style.colors.foreground,
                    ),
                  ),
                );
              })
              .toList(),
        ),
        const SizedBox(height: 24),
        Button(
          label: 'ABBRECHEN',
          onPressed: () => Navigator.of(context).pop(),
          variant: ButtonVariant.secondary,
        ),
      ],
      ),
    );
  }
}
