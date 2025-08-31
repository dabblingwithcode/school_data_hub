import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:watch_it/watch_it.dart';

import 'widgets/action_buttons.dart';
import 'widgets/end_time_field.dart';
import 'widgets/start_time_field.dart';
import 'widgets/weekday_dropdown.dart';

class NewTimetableSlotPage extends WatchingWidget {
  final TimetableManager timetableManager;
  final TimetableSlot? timetableSlot;

  const NewTimetableSlotPage({
    super.key,
    required this.timetableManager,
    this.timetableSlot,
  });

  @override
  Widget build(BuildContext context) {
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
            ? _weekdayToSelection(timetableSlot!.day!)
            : null,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          timetableSlot == null ? 'Neuer Zeitslot' : 'Zeitslot bearbeiten',
        ),
        backgroundColor: AppColors.interactiveColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardInCardColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.cardInCardBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timetableSlot == null
                            ? 'Neuen Zeitslot erstellen'
                            : 'Zeitslot bearbeiten',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        'Definieren Sie die Zeiten und den Wochentag für diesen Zeitslot.',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      if (timetableSlot == null) ...[
                        const Gap(8),
                        Text(
                          'Wählen Sie "Alle Wochentage" um denselben Zeitslot für alle Wochentage zu erstellen.',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Gap(20),

                // Form
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        WeekdayDropdown(
                          selectedWeekday: selectedWeekday,
                          selectedWeekdayOption: selectedWeekdayOption,
                        ),
                        const Gap(16),
                        StartTimeField(controller: startTimeController),
                        const Gap(16),
                        EndTimeField(controller: endTimeController),
                        const Gap(32),
                      ],
                    ),
                  ),
                ),

                // Action Buttons
                ActionButtons(
                  onSave:
                      () => _saveTimetableSlot(
                        context,
                        startTimeController,
                        endTimeController,
                        selectedWeekday,
                        selectedWeekdayOption,
                      ),
                  onCancel: () => Navigator.of(context).pop(),
                  onDelete:
                      timetableSlot != null
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
    // Validation

    if (selectedWeekdayOption.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte wählen Sie einen Wochentag aus.'),
          backgroundColor: AppColors.snackBarErrorColor,
        ),
      );
      return;
    }

    if (startTimeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte geben Sie eine Startzeit ein.'),
          backgroundColor: AppColors.snackBarErrorColor,
        ),
      );
      return;
    }

    if (endTimeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte geben Sie eine Endzeit ein.'),
          backgroundColor: AppColors.snackBarErrorColor,
        ),
      );
      return;
    }

    try {
      final timetable = timetableManager.timetable.value;
      print(
        'Current timetable in manager: ${timetable?.name} (ID: ${timetable?.id})',
      );

      if (timetable == null) {
        print('No timetable available. Debug info:');
        print(
          '- TimetableManager has timetable: ${timetableManager.timetable.value != null}',
        );
        print(
          '- TimetableManager has slots: ${timetableManager.timetableSlots.value.length}',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Kein Stundenplan ausgewählt. Bitte erstellen Sie zuerst einen Stundenplan.',
            ),
            backgroundColor: AppColors.snackBarErrorColor,
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
              print('Error creating slot for $weekday: $e');
            }
          }

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$createdCount Zeitslots erfolgreich erstellt.'),
                backgroundColor: AppColors.snackBarSuccessColor,
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
              const SnackBar(
                content: Text('Zeitslot erfolgreich erstellt.'),
                backgroundColor: AppColors.snackBarSuccessColor,
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
            const SnackBar(
              content: Text('Zeitslot erfolgreich aktualisiert.'),
              backgroundColor: AppColors.snackBarSuccessColor,
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
            backgroundColor: AppColors.snackBarErrorColor,
          ),
        );
      }
    }
  }

  Future<void> _deleteTimetableSlot(BuildContext context) async {
    if (timetableSlot == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
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
                  foregroundColor: AppColors.dangerButtonColor,
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
            const SnackBar(
              content: Text('Zeitslot erfolgreich gelöscht.'),
              backgroundColor: AppColors.snackBarSuccessColor,
            ),
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Fehler beim Löschen: $e'),
              backgroundColor: AppColors.snackBarErrorColor,
            ),
          );
        }
      }
    }
  }
}
