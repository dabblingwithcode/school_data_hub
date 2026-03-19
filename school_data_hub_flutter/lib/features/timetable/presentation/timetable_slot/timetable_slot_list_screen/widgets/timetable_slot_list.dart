import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_slot/new_timetable_slot_screen/new_timetable_slot_screen.dart';

class TimetableSlotList extends StatelessWidget {
  final List<TimetableSlot> timetableSlots;
  final TimetableManager timetableManager;

  const TimetableSlotList({
    super.key,
    required this.timetableSlots,
    required this.timetableManager,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    if (timetableSlots.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.schedule, size: 64, color: style.colors.mutedForeground),
            Gap(Style.spacing.lg),
            Text(
              'Keine Zeitslots verfügbar',
              style: context.typography.subtitle.withColor(
                style.colors.mutedForeground,
              ),
            ),
            Gap(Style.spacing.sm),
            Text(
              'Erstellen Sie Zeitslots um Unterrichtszeiten zu definieren',
              style: context.typography.body.withColor(
                style.colors.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Group slots by weekday
    final slotsByWeekday = <Weekday, List<TimetableSlot>>{};
    for (final slot in timetableSlots) {
      slotsByWeekday.putIfAbsent(slot.day, () => []).add(slot);
    }

    // Sort weekdays
    final sortedWeekdays = Weekday.values.toList();

    return ListView.builder(
      itemCount: sortedWeekdays.length,
      itemBuilder: (context, index) {
        final weekday = sortedWeekdays[index];
        final slotsForDay = slotsByWeekday[weekday] ?? [];

        // Sort slots by start time
        slotsForDay.sort((a, b) => a.startTime.compareTo(b.startTime));

        return Padding(
          padding: EdgeInsets.only(bottom: Style.spacing.lg),
          child: CardBox(
            child: ExpansionTile(
              title: Row(
                children: [
                  Icon(
                    _getWeekdayIcon(weekday),
                    color: _getWeekdayColor(weekday, style),
                  ),
                  Gap(Style.spacing.sm),
                  Text(
                    _getWeekdayName(weekday),
                    style: context.typography.body.bold,
                  ),
                  Gap(Style.spacing.sm),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Style.spacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: style.colors.accent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(Style.radii.medium),
                    ),
                    child: Text(
                      '${slotsForDay.length} Slots',
                      style: context.typography.bodySmall
                          .withColor(style.colors.accent)
                          .w500,
                    ),
                  ),
                ],
              ),
              children: slotsForDay
                  .map((slot) => _buildSlotTile(context, slot))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSlotTile(BuildContext context, TimetableSlot slot) {
    final style = Style.of(context);

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: style.colors.success.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(Style.radii.small),
        ),
        child: Icon(Icons.access_time, color: style.colors.success, size: 20),
      ),
      title: Text(
        '${slot.startTime} - ${slot.endTime}',
        style: context.typography.body.w500,
      ),
      subtitle: Text('Slot ID: ${slot.id}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit, color: style.colors.accent),
            onPressed: () => _editSlot(context, slot),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: style.colors.error),
            onPressed: () => _deleteSlot(context, slot),
          ),
        ],
      ),
    );
  }

  void _editSlot(BuildContext context, TimetableSlot slot) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => NewTimetableSlotScreen(
          timetableManager: timetableManager,
          timetableSlot: slot,
        ),
      ),
    );
  }

  void _deleteSlot(BuildContext context, TimetableSlot slot) {
    final style = Style.of(context);

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Zeitslot löschen'),
        content: Text(
          'Sind Sie sicher, dass Sie den Zeitslot "${slot.startTime} - ${slot.endTime}" für ${_getWeekdayName(slot.day)} löschen möchten?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await timetableManager.removeTimetableSlot(slot);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Zeitslot erfolgreich gelöscht.'),
                      backgroundColor: style.colors.success,
                    ),
                  );
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
            },
            child: Text('Löschen', style: TextStyle(color: style.colors.error)),
          ),
        ],
      ),
    );
  }

  IconData _getWeekdayIcon(Weekday weekday) {
    switch (weekday) {
      case Weekday.monday:
        return Icons.calendar_today;
      case Weekday.tuesday:
        return Icons.calendar_today;
      case Weekday.wednesday:
        return Icons.calendar_today;
      case Weekday.thursday:
        return Icons.calendar_today;
      case Weekday.friday:
        return Icons.calendar_today;
    }
  }

  Color _getWeekdayColor(Weekday weekday, Style style) {
    switch (weekday) {
      case Weekday.monday:
        return style.colors.error;
      case Weekday.tuesday:
        return style.colors.warning;
      case Weekday.wednesday:
        return style.colors.warning;
      case Weekday.thursday:
        return style.colors.success;
      case Weekday.friday:
        return style.colors.accent;
    }
  }

  String _getWeekdayName(Weekday weekday) {
    switch (weekday) {
      case Weekday.monday:
        return 'Montag';
      case Weekday.tuesday:
        return 'Dienstag';
      case Weekday.wednesday:
        return 'Mittwoch';
      case Weekday.thursday:
        return 'Donnerstag';
      case Weekday.friday:
        return 'Freitag';
    }
  }
}
