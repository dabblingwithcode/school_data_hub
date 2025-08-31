import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager_refactored.dart';

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
    if (timetableSlots.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.schedule, size: 64, color: Colors.grey),
            const Gap(16),
            Text(
              'Keine Zeitslots verfügbar',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const Gap(8),
            Text(
              'Erstellen Sie Zeitslots um Unterrichtszeiten zu definieren',
              style: TextStyle(fontSize: 14, color: Colors.grey),
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

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Row(
              children: [
                Icon(
                  _getWeekdayIcon(weekday),
                  color: _getWeekdayColor(weekday),
                ),
                const Gap(8),
                Text(
                  _getWeekdayName(weekday),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${slotsForDay.length} Slots',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            children:
                slotsForDay
                    .map((slot) => _buildSlotTile(context, slot))
                    .toList(),
          ),
        );
      },
    );
  }

  Widget _buildSlotTile(BuildContext context, TimetableSlot slot) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.access_time, color: Colors.green[700], size: 20),
      ),
      title: Text(
        '${slot.startTime} - ${slot.endTime}',
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text('Slot ID: ${slot.id}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () => _editSlot(context, slot),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _deleteSlot(context, slot),
          ),
        ],
      ),
    );
  }

  void _editSlot(BuildContext context, TimetableSlot slot) {
    // TODO: Navigate to edit slot page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Slot bearbeiten wird implementiert...'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _deleteSlot(BuildContext context, TimetableSlot slot) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
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
                onPressed: () {
                  Navigator.of(context).pop();
                  // TODO: Implement slot deletion
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Slot-Löschung wird implementiert...'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
                child: const Text(
                  'Löschen',
                  style: TextStyle(color: Colors.red),
                ),
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

  Color _getWeekdayColor(Weekday weekday) {
    switch (weekday) {
      case Weekday.monday:
        return Colors.red;
      case Weekday.tuesday:
        return Colors.orange;
      case Weekday.wednesday:
        return Colors.yellow[700]!;
      case Weekday.thursday:
        return Colors.green;
      case Weekday.friday:
        return Colors.blue;
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
