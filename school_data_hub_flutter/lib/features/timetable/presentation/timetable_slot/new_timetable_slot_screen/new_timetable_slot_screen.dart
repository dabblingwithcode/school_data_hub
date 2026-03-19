import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:flutter_it/flutter_it.dart';

import 'widgets/action_buttons.dart';
import 'widgets/end_time_field.dart';
import 'widgets/start_time_field.dart';
import 'widgets/weekday_dropdown.dart';

final _log = Logger('NewTimetableSlotScreen');

class NewTimetableSlotScreen extends WatchingWidget {
  final TimetableManager timetableManager;
  final TimetableSlot? timetableSlot;

  const NewTimetableSlotScreen({
    super.key,
    required this.timetableManager,
    this.timetableSlot,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final startTimeController = createOnce(
      () => TextEditingController(text: timetableSlot?.startTime ?? ''),
    );
    final endTimeController = createOnce(
      () => TextEditingController(text: timetableSlot?.endTime ?? ''),
    );
    final selectedWeekday = createOnce(
      () => ValueNotifier<Weekday?>(timetableSlot?.day),
    );
    final selectedWeekdayOption = createOnce(
      () => ValueNotifier<WeekdaySelection?>(
        timetableSlot?.day != null
            ? _weekdayToSelection(timetableSlot!.day)
            : null,
      ),
    );

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: AppBar(
        title: Text(
          timetableSlot == null ? 'Neuer Zeitslot' : 'Zeitslot bearbeiten',
        ),
        backgroundColor: style.colors.interactive,
        foregroundColor: style.colors.background,
      ),
      body: Padding(
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Style.spacing.lg),
                  decoration: BoxDecoration(
                    color: style.colors.cardInCard,
                    borderRadius: BorderRadius.circular(Style.radii.small),
                    border: Border.all(color: style.colors.cardInCardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timetableSlot == null
                            ? 'Neuen Zeitslot erstellen'
                            : 'Zeitslot bearbeiten',
                        style: context.typography.title
                            .withColor(style.colors.foreground),
                      ),
                      Gap(Style.spacing.sm),
                      Text(
                        'Definieren Sie die Zeiten und den Wochentag für diesen Zeitslot.',
                        style: context.typography.body
                            .withColor(style.colors.mutedForeground),
                      ),
                      if (timetableSlot == null) ...[
                        Gap(Style.spacing.sm),
                        Text(
                          'Wählen Sie "Alle Wochentage" um denselben Zeitslot für alle Wochentage zu erstellen.',
                          style: context.typography.bodySmall
                              .withColor(style.colors.accent)
                              .copyWith(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ],
                  ),
                ),
                Gap(Style.spacing.xl),

                // Form
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        WeekdayDropdown(
                          selectedWeekday: selectedWeekday,
                          selectedWeekdayOption: selectedWeekdayOption,
                        ),
                        Gap(Style.spacing.lg),
                        StartTimeField(controller: startTimeController),
                        Gap(Style.spacing.lg),
                        EndTimeField(controller: endTimeController),
                        Gap(Style.spacing.xxl),
                      ],
                    ),
                  ),
                ),

                // Action Buttons
                ActionButtons(
                  onSave: () => _saveTimetableSlot(
                    context,
                    startTimeController,
                    endTimeController,
                    selectedWeekday,
                    selectedWeekdayOption,
                  ),
                  onCancel: () => Navigator.of(context).pop(),
                  onDelete: timetableSlot != null
                      ? () => _deleteTimetableSlot(context)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  WeekdaySelection _weekdayToSelection(Weekday weekday) {
    switch (weekday) {
      case Weekday.monday:
        return WeekdaySelection.monday;
      case Weekday.tuesday:
        return WeekdaySelection.tuesday;
      case Weekday.wednesday:
        return WeekdaySelection.wednesday;
      case Weekday.thursday:
        return WeekdaySelection.thursday;
      case Weekday.friday:
        return WeekdaySelection.friday;
    }
  }

  Future<void> _saveTimetableSlot(
    BuildContext context,
    TextEditingController startTimeController,
    TextEditingController endTimeController,
    ValueNotifier<Weekday?> selectedWeekday,
    ValueNotifier<WeekdaySelection?> selectedWeekdayOption,
  ) async {
    final style = Style.of(context);
    // Validation

    if (selectedWeekdayOption.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Bitte wählen Sie einen Wochentag aus.'),
          backgroundColor: style.colors.error,
        ),
      );
      return;
    }

    if (startTimeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Bitte geben Sie eine Startzeit ein.'),
          backgroundColor: style.colors.error,
        ),
      );
      return;
    }

    if (endTimeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Bitte geben Sie eine Endzeit ein.'),
          backgroundColor: style.colors.error,
        ),
      );
      return;
    }

    try {
      final timetable = timetableManager.data.timetable.value;
      _log.info(
        'Current timetable in manager: ${timetable?.name} (ID: ${timetable?.id})',
      );

      if (timetable == null) {
        _log.severe('No timetable available. Debug info:');
        _log.severe(
          '- TimetableManager has timetable: ${timetableManager.data.timetable.value != null}',
        );
        _log.severe(
          '- TimetableManager has slots: ${timetableManager.data.timetableSlots.value.length}',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Kein Stundenplan ausgewählt. Bitte erstellen Sie zuerst einen Stundenplan.',
            ),
            backgroundColor: style.colors.error,
          ),
        );
        return;
      }

      final startTime = startTimeController.text.trim();
      final endTime = endTimeController.text.trim();
      final isBulkCreation =
          selectedWeekdayOption.value == WeekdaySelection.allWeekdays;

      if (timetableSlot == null) {
        // Creating new slot(s)
        if (isBulkCreation) {
          // Create slots for all weekdays
          int createdCount = 0;
          for (final weekday in Weekday.values) {
            final newTimetableSlot = TimetableSlot(
              day: weekday,
              startTime: startTime,
              endTime: endTime,
              timetableId: timetable.id ?? 0,
              timetable: timetable,
            );

            try {
              await timetableManager.addTimetableSlot(newTimetableSlot);
              createdCount++;
            } catch (e) {
              _log.severe('Error creating slot for $weekday: $e');
            }
          }

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$createdCount Zeitslots erfolgreich erstellt.'),
                backgroundColor: style.colors.success,
              ),
            );
          }
        } else {
          // Create single slot
          final newTimetableSlot = TimetableSlot(
            day: selectedWeekday.value!,
            startTime: startTime,
            endTime: endTime,
            timetableId: timetable.id ?? 0,
            timetable: timetable,
          );

          await timetableManager.addTimetableSlot(newTimetableSlot);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Zeitslot erfolgreich erstellt.'),
                backgroundColor: style.colors.success,
              ),
            );
          }
        }
      } else {
        // Updating existing slot (bulk not allowed for editing)
        final updatedTimetableSlot = TimetableSlot(
          id: timetableSlot!.id,
          day: selectedWeekday.value!,
          startTime: startTime,
          endTime: endTime,
          timetableId: timetable.id ?? 0,
          timetable: timetable,
        );

        await timetableManager.updateTimetableSlot(updatedTimetableSlot);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Zeitslot erfolgreich aktualisiert.'),
              backgroundColor: style.colors.success,
            ),
          );
        }
      }

      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Fehler beim ${timetableSlot == null ? 'Erstellen' : 'Aktualisieren'} des Zeitslots: $e',
            ),
            backgroundColor: style.colors.error,
          ),
        );
      }
    }
  }

  Future<void> _deleteTimetableSlot(BuildContext context) async {
    if (timetableSlot == null) return;
    final style = Style.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Zeitslot löschen'),
        content: const Text(
          'Sind Sie sicher, dass Sie diesen Zeitslot löschen möchten?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: style.colors.button.destructive,
            ),
            child: const Text('Löschen'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await timetableManager.removeTimetableSlot(timetableSlot!);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Zeitslot erfolgreich gelöscht.'),
              backgroundColor: style.colors.success,
            ),
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Fehler beim Löschen: $e'),
              backgroundColor: style.colors.error,
            ),
          );
        }
      }
    }
  }
}
