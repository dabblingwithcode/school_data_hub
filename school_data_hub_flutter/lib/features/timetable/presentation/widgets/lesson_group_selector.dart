import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:watch_it/watch_it.dart';

class LessonGroupSelector extends WatchingWidget {
  final TimetableManager timetableManager;

  const LessonGroupSelector({super.key, required this.timetableManager});

  @override
  Widget build(BuildContext context) {
    final lessonGroups = watchValue((TimetableManager x) => x.lessonGroups);

    if (lessonGroups.isEmpty) {
      return const SizedBox.shrink();
    }

    return ValueListenableBuilder<LessonGroup?>(
      valueListenable: timetableManager.selectedLessonGroup,
      builder: (context, selectedGroup, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Klasse auswählen:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: [
                // "Alle" option
                FilterChip(
                  label: const Text('Alle'),
                  selected: selectedGroup == null,
                  onSelected: (selected) {
                    if (selected) {
                      timetableManager.selectLessonGroup(null);
                    }
                  },
                  selectedColor: Theme.of(context).colorScheme.primaryContainer,
                  checkmarkColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                // Individual lesson groups
                ...lessonGroups.map((group) {
                  final isSelected = selectedGroup?.id == group.id;
                  return FilterChip(
                    label: Text(group.name),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        timetableManager.selectLessonGroup(group);
                      }
                    },
                    selectedColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    checkmarkColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                    backgroundColor:
                        group.color != null
                            ? _parseColor(group.color!)?.withValues(alpha: 0.1)
                            : null,
                  );
                }).toList(),
              ],
            ),
          ],
        );
      },
    );
  }

  Color? _parseColor(String colorString) {
    try {
      String hexColor = colorString;
      if (!hexColor.startsWith('#')) {
        hexColor = '#$hexColor';
      }

      if (hexColor.length == 7) {
        return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
      }
    } catch (e) {
      // Return null if color parsing fails
    }
    return null;
  }
}
