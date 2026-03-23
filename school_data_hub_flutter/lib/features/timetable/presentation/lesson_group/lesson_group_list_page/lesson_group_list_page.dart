import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/list_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/lesson_group/lesson_group_list_page/widgets/lesson_group_list_card.dart';

class LessonGroupListScreen extends WatchingWidget {
  const LessonGroupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();

    return ListScreen<LessonGroup>(
      backgroundColor: Style.of(context).colors.canvas,
      iconData: Icons.group,
      title: 'Lerngruppen verwalten',
      itemsListenable: timetableManager.data.lessonGroups,
      itemBuilder: (context, lessonGroup) => LessonGroupListCard(
        lessonGroup: lessonGroup,
        onEdit: () => _navigateToEditLessonGroup(context, lessonGroup),
        onDelete: () =>
            _showDeleteConfirmation(context, lessonGroup, timetableManager),
      ),
      onRefresh: () async => timetableManager.refreshData(),
      maxWidth: 700,
      bottomBarActions: [
        TappableIcon(
          icon: const Icon(Icons.add, size: 30),
          onPressed: () => _navigateToNewLessonGroup(context),
          tooltip: 'Neue Klasse hinzufügen',
        ),
      ],
    );
  }

  void _navigateToNewLessonGroup(BuildContext context) async {
    await context.push(RoutePaths.toolsTimetableNewLessonGroup);
  }

  void _navigateToEditLessonGroup(
    BuildContext context,
    LessonGroup group,
  ) async {
    await context.push(RoutePaths.toolsTimetableNewLessonGroup, extra: group);
  }

  void _showDeleteConfirmation(
    BuildContext context,
    LessonGroup group,
    TimetableManager timetableManager,
  ) {
    showDialog<void>(
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
