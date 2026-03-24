import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/content_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/confirmation_popup.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/toast.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/school_semester_list_screen/widgets/school_semester_list_card.dart';

class SchoolSemesterListScreen extends WatchingWidget {
  const SchoolSemesterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final schoolCalendarManager = di<SchoolCalendarManager>();
    final semesters = watchValue(
      (SchoolCalendarManager m) => m.schoolSemesters,
    );
    final currentSemester = watchValue(
      (SchoolCalendarManager m) => m.currentSemester,
    );

    // Sort semesters by start date (newest first)
    final sortedSemesters = List<SchoolSemester>.from(semesters)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));
    final sortedSemestersListenable = createOnce(
      () => ValueNotifier<List<SchoolSemester>>([]),
    );
    sortedSemestersListenable.value = sortedSemesters;

    return Scaffold(
      backgroundColor: Style.of(context).colors.canvas,
      appBar: const AppHeader(
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
                ContentSliverList(
                  itemsListenable: sortedSemestersListenable,
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
      bottomNavigationBar: ActionBar(
        actions: [
          TappableIcon(
            icon: const Icon(Icons.add, size: 30),
            tooltip: 'Neues Schulhalbjahr',
            onPressed: () =>
                _navigateToNewSemester(context, schoolCalendarManager),
          ),
        ],
      ),
    );
  }

  void _navigateToNewSemester(
    BuildContext context,
    SchoolCalendarManager manager,
  ) async {
    await context.push(RoutePaths.schoolSemesterNew);
    // Refresh data when returning from NewSchoolSemesterScreen
    await manager.fetchSchoolSemesters();
  }

  void _navigateToEditSemester(
    BuildContext context,
    SchoolSemester semester,
    SchoolCalendarManager manager,
  ) async {
    await context.push(RoutePaths.schoolSemesterNew, extra: semester);
    // Refresh data when returning from edit screen
    await manager.fetchSchoolSemesters();
  }

  void _showDeleteConfirmation(
    BuildContext context,
    SchoolSemester semester,
    SchoolCalendarManager manager,
  ) {
    ConfirmationPopup.show(
      context: context,
      title: 'Schulhalbjahr l\u00f6schen',
      description:
          'Sind Sie sicher, dass Sie das Schulhalbjahr "${semester.schoolYear} - ${semester.isFirst ? "1. Halbjahr" : "2. Halbjahr"}" l\u00f6schen m\u00f6chten?\n\n'
          'Achtung: Alle zugeh\u00f6rigen Schultage werden ebenfalls gel\u00f6scht!\n\n'
          'Diese Aktion kann nicht r\u00fcckg\u00e4ngig gemacht werden.',
      confirmLabel: 'L\u00f6schen',
      cancelLabel: 'Abbrechen',
      destructive: true,
      onConfirm: () {
        _deleteSemester(context, semester, manager);
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
        Toast.show(
          context: context,
          message:
              'Schulhalbjahr "${semester.schoolYear} - ${semester.isFirst ? "1. Halbjahr" : "2. Halbjahr"}" wurde gel\u00f6scht',
          type: ToastType.error,
        );
      }
    }
  }
}
