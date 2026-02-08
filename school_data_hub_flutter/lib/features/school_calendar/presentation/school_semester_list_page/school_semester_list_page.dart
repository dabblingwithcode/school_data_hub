import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/new_school_semester_page/new_school_semester_page.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/school_semester_list_page/widgets/school_semester_list_card.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/school_semester_list_page/widgets/school_semester_list_page_bottom_navbar.dart';

class SchoolSemesterListPage extends WatchingWidget {
  const SchoolSemesterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final semesters = watchValue(
      (SchoolCalendarManager m) => m.schoolSemesters,
    );
    final currentSemester = watchValue(
      (SchoolCalendarManager m) => m.currentSemester,
    );
    final schoolCalendarManager = di<SchoolCalendarManager>();

    // Sort semesters by start date (newest first)
    final sortedSemesters = List<SchoolSemester>.from(semesters)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.calendar_view_month_rounded,
        title: 'Schulhalbjahre verwalten',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await schoolCalendarManager.fetchSchoolSemesters();
        },
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                GenericSliverListWithEmptyListCheck(
                  items: sortedSemesters,
                  itemBuilder: (_, semester) {
                    final isCurrent = currentSemester?.id == semester.id;
                    return SchoolSemesterListCard(
                      semester: semester,
                      isCurrentSemester: isCurrent,
                      onEdit: () => _navigateToEditSemester(
                        context,
                        semester,
                        schoolCalendarManager,
                      ),
                      onDelete: () => _showDeleteConfirmation(
                        context,
                        semester,
                        schoolCalendarManager,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SchoolSemesterListPageBottomNavBar(
        onAddNewSemester: () =>
            _navigateToNewSemester(context, schoolCalendarManager),
      ),
    );
  }

  void _navigateToNewSemester(
    BuildContext context,
    SchoolCalendarManager manager,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewSchoolSemesterPage()),
    );
    // Refresh data when returning from NewSchoolSemesterPage
    await manager.fetchSchoolSemesters();
  }

  void _navigateToEditSemester(
    BuildContext context,
    SchoolSemester semester,
    SchoolCalendarManager manager,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewSchoolSemesterPage(semester: semester),
      ),
    );
    // Refresh data when returning from edit page
    await manager.fetchSchoolSemesters();
  }

  void _showDeleteConfirmation(
    BuildContext context,
    SchoolSemester semester,
    SchoolCalendarManager manager,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Schulhalbjahr löschen'),
          content: Text(
            'Sind Sie sicher, dass Sie das Schulhalbjahr "${semester.schoolYear} - ${semester.isFirst ? "1. Halbjahr" : "2. Halbjahr"}" löschen möchten?\n\n'
            'Achtung: Alle zugehörigen Schultage werden ebenfalls gelöscht!\n\n'
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
                _deleteSemester(context, semester, manager);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Löschen'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSemester(
    BuildContext context,
    SchoolSemester semester,
    SchoolCalendarManager manager,
  ) async {
    if (semester.id != null) {
      await manager.deleteSchoolSemester(semester);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Schulhalbjahr "${semester.schoolYear} - ${semester.isFirst ? "1. Halbjahr" : "2. Halbjahr"}" wurde gelöscht',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
