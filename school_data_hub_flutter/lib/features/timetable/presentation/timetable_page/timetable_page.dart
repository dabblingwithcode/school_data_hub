import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/classroom/classroom_list_page/classroom_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/lesson_group/lesson_group_list_page/lesson_group_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_timetable_page/new_timetable_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/subject/subject_list_page/subject_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_page/widgets/timetable_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_page/widgets/weekday_selector.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_slot/timetable_slot_list_page/timetable_slot_list_page.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/features/timetable/services/timetable_pdf_generator.dart';

import 'widgets/timetable_grid_widget.dart';

/// Experimental page to visualize rooms (columns) vs 15-minute slots (rows)
/// and interact with ScheduledLesson / TimetableSlot placement.
class TimetablePage extends WatchingWidget {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();

    // Ensure data is initialized; in normal navigation flow this should
    // already be true, but calling debugPrintState here is consistent
    // with the existing TimetablePage.
    timetableManager.debugPrintState();

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.grid_on,
        title: 'Stundenplan',
      ),
      body: Column(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WeekdaySelector(timetableManager: timetableManager),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(child: TimetableGridWidget()),
        ],
      ),
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          IconButton(
            tooltip: 'Zeitslots verwalten',
            icon: const Icon(Icons.punch_clock_rounded, size: 35),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const TimetableSlotListPage(),
                ),
              );
              await di<TimetableManager>().refreshData();
            },
          ),
          IconButton(
            tooltip: 'Neuer Stundenplan',
            icon: const Icon(Icons.calendar_month, size: 35),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const NewTimetablePage(),
                ),
              );
              await di<TimetableManager>().refreshData();
            },
          ),
          IconButton(
            tooltip: 'Lerngruppen',
            icon: const Icon(Icons.groups, size: 35),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const LessonGroupListPage(),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Räume verwalten',
            icon: const Icon(Icons.door_front_door_rounded, size: 35),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const ClassroomListPage(),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Fächer verwalten',
            icon: const Icon(Icons.subject, size: 35),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const SubjectListPage(),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Stundenplan als PDF',
            icon: const Icon(Icons.picture_as_pdf, size: 35),
            onPressed: () async {
              final manager = di<TimetableManager>();
              if (!manager.hasActiveTimetable) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kein Stundenplan ausgewählt.'),
                    ),
                  );
                }
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => PdfViewerPage(
                    pdfGenerator: () =>
                        TimetablePdfGenerator.generateTimetablePdf(
                          timetableManager: manager,
                        ),
                    title: 'Stundenplan PDF',
                    showZoomButton: true,
                  ),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Filter & Klassen verwalten',
            icon: const Icon(Icons.filter_list, size: 35),
            onPressed: () => showTimetableFilterBottomSheet(context),
          ),
        ],
      ),
    );
  }
}
