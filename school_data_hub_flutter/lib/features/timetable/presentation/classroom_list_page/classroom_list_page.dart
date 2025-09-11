import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/classroom_list_page/widgets/classroom_list_card.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/classroom_list_page/widgets/classroom_list_page_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_classroom_page/new_classroom_page.dart';
import 'package:watch_it/watch_it.dart';

class ClassroomListPage extends WatchingWidget {
  const ClassroomListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final classrooms = watchValue((TimetableManager x) => x.classrooms);
    final timetableManager = di<TimetableManager>();

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.meeting_room,
        title: 'Räume verwalten',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await timetableManager.refreshData();
        },
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                GenericSliverListWithEmptyListCheck(
                  items: classrooms,
                  itemBuilder:
                      (_, classroom) => ClassroomListCard(
                        classroom: classroom,
                        onEdit:
                            () => _navigateToEditClassroom(context, classroom),
                        onDelete:
                            () => _showDeleteConfirmation(
                              context,
                              classroom,
                              timetableManager,
                            ),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ClassroomListPageBottomNavBar(
        onAddNewClassroom: () => _navigateToNewClassroom(context),
      ),
    );
  }

  void _navigateToNewClassroom(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewClassroomPage()),
    );
    // Refresh data when returning from NewClassroomPage
    await di<TimetableManager>().refreshData();
  }

  void _navigateToEditClassroom(BuildContext context, Classroom classroom) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewClassroomPage(classroom: classroom),
      ),
    );
    // Refresh data when returning from NewClassroomPage
    await di<TimetableManager>().refreshData();
  }

  void _showDeleteConfirmation(
    BuildContext context,
    Classroom classroom,
    TimetableManager timetableManager,
  ) {
    showDialog(
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
