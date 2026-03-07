import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/learning_group_list_page/widgets/learning_group_list_card.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/new_lesson_group_page.dart';
import 'package:flutter_it/flutter_it.dart';

class LearningGroupListPage extends WatchingWidget {
  const LearningGroupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();

    return GenericListPage<LessonGroup>(
      backgroundColor: AppColors.canvasColor,
      iconData: Icons.group,
      title: 'Lerngruppen verwalten',
      itemsListenable: timetableManager.lessonGroups,
      itemBuilder: (context, lessonGroup) => LearningGroupListCard(
        lessonGroup: lessonGroup,
        onEdit: () =>
            _navigateToEditLessonGroup(context, lessonGroup),
        onDelete: () => _showDeleteConfirmation(
          context,
          lessonGroup,
          timetableManager,
        ),
      ),
      onRefresh: () async => timetableManager.refreshData(),
      maxWidth: 700,
      bottomBarActions: [
        IconButton(
          tooltip: 'Neue Klasse hinzufügen',
          icon: const Icon(Icons.add, size: 35),
          onPressed: () => _navigateToNewLessonGroup(context),
        ),
      ],
    );
  }

  void _navigateToNewLessonGroup(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewLessonGroupPage()),
    );
  }

  void _navigateToEditLessonGroup(
    BuildContext context,
    LessonGroup group,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewLessonGroupPage(lessonGroup: group),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    LessonGroup group,
    TimetableManager timetableManager,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Klasse löschen'),
          content: Text(
            'Sind Sie sicher, dass Sie die Klasse "${group.name}" löschen möchten?\n\n'
            'Diese Aktion kann nicht rückgängig gemacht werden.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteLessonGroup(group, timetableManager);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Klasse "${group.name}" wurde gelöscht'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Löschen'),
            ),
          ],
        );
      },
    );
  }

  void _deleteLessonGroup(
    LessonGroup group,
    TimetableManager timetableManager,
  ) {
    if (group.id != null) {
      timetableManager.removeLessonGroup(group.id!);
    }
  }
}
