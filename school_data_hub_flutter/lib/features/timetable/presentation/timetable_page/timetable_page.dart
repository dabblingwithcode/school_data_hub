import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/classroom_list_page/classroom_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/learning_group_list_page/learning_group_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/new_lesson_group_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/new_scheduled_lesson_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_timetable_page/new_timetable_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/subject_list_page/subject_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_slot_list_page/timetable_slot_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/timetable_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/timetable_grid.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/weekday_selector.dart';
import 'package:watch_it/watch_it.dart';

class TimetablePage extends WatchingWidget {
  // TODO: Implement a warning if there are no timetable slots created!
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();

    // Debug the current state
    timetableManager.debugPrintState();

    // Watch the timetable data to make the page reactive
    final timetable = watch(timetableManager.timetable);
    final timetableSlots = watch(timetableManager.timetableSlots);
    final scheduledLessons = watch(timetableManager.scheduledLessons);

    // Show loading or empty state if no timetable
    if (timetable == null) {
      return Scaffold(
        backgroundColor: AppColors.canvasColor,
        appBar: const GenericAppBar(
          iconData: Icons.calendar_month,
          title: 'Stundenplan',
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.schedule, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'Kein Stundenplan verfügbar',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              const Text(
                'Erstellen Sie einen neuen Stundenplan',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  print('Manual refresh triggered');
                  await timetableManager.refreshData();
                },
                child: const Text('Daten neu laden'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NewTimetablePage(),
                    ),
                  );
                  // Refresh data when returning from NewTimetablePage
                  await timetableManager.refreshData();
                },
                child: const Text('Neuen Stundenplan erstellen'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: TimetableBottomNavBar(onManageLessonGroups: () {}),
      );
    }
    void _navigateToNewLesson() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) =>
                  NewScheduledLessonPage(timetableManager: timetableManager),
        ),
      );
    }

    void _navigateToNewLessonGroup() async {
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const NewLessonGroupPage()),
      );
      // Refresh data when returning from NewLessonGroupPage
      await timetableManager.refreshData();
    }

    void _onLessonTap(int lessonId) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => NewScheduledLessonPage(
                timetableManager: timetableManager,
                editingLessonId: lessonId,
              ),
        ),
      );
    }

    void _onEmptySlotTap(int slotId) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => NewScheduledLessonPage(
                timetableManager: timetableManager,
                preselectedSlotId: slotId,
              ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.calendar_month,
        title: 'Stundenplan',
      ),

      body: Column(
        children: [
          // Weekday Selector with max width constraint
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Container(
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

          // Timetable Grid for selected weekday - takes full width
          Expanded(
            child: TimetableGrid(
              timetableManager: timetableManager,
              onLessonTap: _onLessonTap,
              onEmptySlotTap: _onEmptySlotTap,
            ),
          ),
        ],
      ),
      bottomNavigationBar: TimetableBottomNavBar(
        onManageLessonGroups: _navigateToNewLessonGroup,
      ),
    );
  }
}

class TimetableBottomNavBar extends StatelessWidget {
  final VoidCallback onManageLessonGroups;

  const TimetableBottomNavBar({super.key, required this.onManageLessonGroups});

  @override
  Widget build(BuildContext context) {
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(9),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(Icons.arrow_back, size: 35),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              IconButton(
                tooltip: 'Zeitslots verwalten',
                icon: const Icon(Icons.punch_clock_rounded, size: 35),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TimetableSlotListPage(),
                    ),
                  );
                  // Refresh data when returning from NewTimetablePage
                  await di<TimetableManager>().refreshData();
                },
              ),
              IconButton(
                tooltip: 'Neuer Stundenplan',
                icon: const Icon(Icons.calendar_month, size: 35),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewTimetablePage(),
                    ),
                  );
                  // Refresh data when returning from NewTimetablePage
                  await di<TimetableManager>().refreshData();
                },
              ),
              IconButton(
                tooltip: 'Lerngruppen',
                icon: const Icon(Icons.groups, size: 35),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LearningGroupListPage(),
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
                    MaterialPageRoute(
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
                    MaterialPageRoute(
                      builder: (context) => const SubjectListPage(),
                    ),
                  );
                },
              ),
              const Gap(AppPaddings.bottomNavBarButtonGap),
              IconButton(
                tooltip: 'Filter & Klassen verwalten',
                icon: const Icon(Icons.filter_list, size: 35),
                onPressed: () {
                  showTimetableFilterBottomSheet(context);
                },
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
