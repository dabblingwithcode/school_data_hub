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
                    ],
                  ),
                ),
                const Gap(20),

                // Form
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        WeekdayDropdown(selectedWeekday: selectedWeekday),
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

  Future<void> _saveTimetableSlot(
    BuildContext context,
    TextEditingController startTimeController,
    TextEditingController endTimeController,
    ValueNotifier<Weekday?> selectedWeekday,
  ) async {
    // Validation

    if (selectedWeekday.value == null) {
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
      if (timetable == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kein Stundenplan ausgewählt.'),
            backgroundColor: AppColors.snackBarErrorColor,
          ),
        );
        return;
      }

      final newTimetableSlot = TimetableSlot(
        id: timetableSlot?.id,
        day: selectedWeekday.value!,
        startTime: startTimeController.text.trim(),
        endTime: endTimeController.text.trim(),
        timetableId: timetable.id ?? 0,
        timetable: timetable,
      );

      if (timetableSlot == null) {
        await timetableManager.addTimetableSlot(newTimetableSlot);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Zeitslot erfolgreich erstellt.'),
              backgroundColor: AppColors.snackBarSuccessColor,
            ),
          );
        }
      } else {
        await timetableManager.updateTimetableSlot(newTimetableSlot);
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
            content: Text('Fehler beim Speichern: $e'),
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
