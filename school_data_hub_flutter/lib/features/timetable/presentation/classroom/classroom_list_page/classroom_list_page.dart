import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/classroom/classroom_list_page/widgets/classroom_list_card.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/classroom/new_classroom_page/new_classroom_page.dart';
import 'package:flutter_it/flutter_it.dart';

class ClassroomListPage extends WatchingWidget {
  const ClassroomListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();

    return GenericListPage<Classroom>(
      backgroundColor: AppColors.canvasColor,
      iconData: Icons.meeting_room,
      title: 'Räume verwalten',
      itemsListenable: timetableManager.classrooms,
      itemBuilder: (context, classroom) => ClassroomListCard(
        classroom: classroom,
        onEdit: () => _navigateToEditClassroom(context, classroom),
        onDelete: () =>
            _showDeleteConfirmation(context, classroom, timetableManager),
      ),
      onRefresh: () async => timetableManager.refreshData(),
      maxWidth: 700,
      bottomBarActions: [
        IconButton(
          tooltip: 'Neuen Raum hinzufügen',
          icon: const Icon(Icons.add, size: 35),
          onPressed: () => _navigateToNewClassroom(context),
        ),
      ],
    );
  }

  void _navigateToNewClassroom(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => const NewClassroomPage()),
    );
    await di<TimetableManager>().refreshData();
  }

  void _navigateToEditClassroom(
    BuildContext context,
    Classroom classroom,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => NewClassroomPage(classroom: classroom),
      ),
    );
    await di<TimetableManager>().refreshData();
  }

  void _showDeleteConfirmation(
    BuildContext context,
    Classroom classroom,
    TimetableManager timetableManager,
  ) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Raum löschen'),
          content: Text(
            'Sind Sie sicher, dass Sie den Raum "${classroom.roomCode} - ${classroom.roomName}" löschen möchten?\n\n'
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
                _deleteClassroom(classroom, timetableManager);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Raum "${classroom.roomCode} - ${classroom.roomName}" wurde gelöscht',
                    ),
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

  void _deleteClassroom(
    Classroom classroom,
    TimetableManager timetableManager,
  ) {
    if (classroom.id != null) {
      timetableManager.removeClassroom(classroom.id!);
    }
  }
}
