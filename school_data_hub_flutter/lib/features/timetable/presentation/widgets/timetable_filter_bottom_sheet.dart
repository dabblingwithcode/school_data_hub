import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/learning_group_list_page/learning_group_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/new_lesson_group_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/timetable_utils.dart';
import 'package:watch_it/watch_it.dart';

class TimetableFilterBottomSheet extends WatchingWidget {
  const TimetableFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();
    final lessonGroups = watchValue((TimetableManager x) => x.lessonGroups);
    final selectedGroupIds = watchValue(
      (TimetableManager x) => x.selectedLessonGroupIds,
    );

    void _toggleLessonGroupSelection(LessonGroup group) {
      if (selectedGroupIds.contains(group.id)) {
        timetableManager.removeLessonGroupFromSelection(group);
      } else {
        timetableManager.addLessonGroupToSelection(group);
      }
    }

    void _clearAllSelections() {
      timetableManager.clearLessonGroupSelection();
    }

    void _navigateToNewLessonGroup() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const NewLessonGroupPage()),
      );
    }

    void _navigateToLearningGroupList() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const LearningGroupListPage()),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Klassen Filter', style: AppStyles.title),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Neue Klasse hinzufügen',
                    icon: const Icon(Icons.add_circle_outline, size: 24),
                    onPressed: _navigateToNewLessonGroup,
                  ),
                  IconButton(
                    tooltip: 'Klassen verwalten',
                    icon: const Icon(Icons.settings, size: 24),
                    onPressed: _navigateToLearningGroupList,
                  ),
                  IconButton.filled(
                    iconSize: 35,
                    color: Colors.amber,
                    onPressed: _clearAllSelections,
                    icon: const Icon(Icons.restart_alt_rounded),
                    tooltip: 'Alle Filter zurücksetzen',
                  ),
                ],
              ),
              const Gap(16),
              Row(
                children: [
                  const Text('Klassen auswählen:', style: AppStyles.subtitle),
                  const Gap(8),
                  if (selectedGroupIds.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade300),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.filter_list,
                            size: 16,
                            color: Colors.blue.shade700,
                          ),
                          const Gap(6),
                          Text(
                            '${selectedGroupIds.length} ausgewählt',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              const Gap(12),
              if (lessonGroups.isEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.grey),
                      const Gap(8),
                      const Expanded(
                        child: Text(
                          'Keine Klassen verfügbar. Erstellen Sie zuerst Klassen.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    // "Alle" option
                    FilterChip(
                      label: const Text('Alle Klassen'),
                      selected: selectedGroupIds.isEmpty,
                      onSelected: (selected) {
                        if (selected) {
                          timetableManager.clearLessonGroupSelection();
                        }
                      },
                      selectedColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      checkmarkColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      avatar:
                          selectedGroupIds.isEmpty
                              ? const Icon(Icons.check, size: 16)
                              : null,
                    ),
                    // Individual lesson groups
                    ...lessonGroups.map((group) {
                      final isSelected = selectedGroupIds.contains(group.id);
                      return FilterChip(
                        label: Text(group.name),
                        selected: isSelected,
                        onSelected: (selected) {
                          _toggleLessonGroupSelection(group);
                        },
                        selectedColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        checkmarkColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                        backgroundColor:
                            group.color != null
                                ? TimetableUtils.parseColor(
                                  group.color!,
                                )?.withValues(alpha: 0.1)
                                : null,
                        avatar:
                            isSelected
                                ? const Icon(Icons.check, size: 16)
                                : null,
                      );
                    }).toList(),
                  ],
                ),
              const Gap(20),
              Row(
                children: [
                  const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      'Wählen Sie eine oder mehrere Klassen aus, um nur deren Stunden im Stundenplan anzuzeigen.',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showTimetableFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => const TimetableFilterBottomSheet(),
  );
}
