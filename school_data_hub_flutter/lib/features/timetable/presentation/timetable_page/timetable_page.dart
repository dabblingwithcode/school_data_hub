import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/classroom_list_page/classroom_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/new_lesson_group_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/new_scheduled_lesson_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/timetable_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/timetable_grid.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/weekday_selector.dart';
import 'package:watch_it/watch_it.dart';

final _timetableManager = di<TimetableManager>();

class TimetablePage extends WatchingWidget {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    void _navigateToNewLesson() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) =>
                  NewScheduledLessonPage(timetableManager: _timetableManager),
        ),
      );
    }

    void _navigateToNewLessonGroup() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const NewLessonGroupPage()),
      );
    }

    void _onLessonTap(int lessonId) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => NewScheduledLessonPage(
                timetableManager: _timetableManager,
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
                timetableManager: _timetableManager,
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
                    WeekdaySelector(timetableManager: _timetableManager),
                  ],
                ),
              ),
            ),
          ),

          // Timetable Grid for selected weekday - takes full width
          Expanded(
            child: TimetableGrid(
              timetableManager: _timetableManager,
              onLessonTap: _onLessonTap,
              onEmptySlotTap: _onEmptySlotTap,
            ),
          ),
        ],
      ),
      bottomNavigationBar: TimetableBottomNavBar(
        onAddLesson: _navigateToNewLesson,
        onManageLessonGroups: _navigateToNewLessonGroup,
      ),
    );
  }
}

class TimetableBottomNavBar extends StatelessWidget {
  final VoidCallback onAddLesson;
  final VoidCallback onManageLessonGroups;

  const TimetableBottomNavBar({
    super.key,
    required this.onAddLesson,
    required this.onManageLessonGroups,
  });

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
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(Icons.arrow_back, size: 35),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(AppPaddings.bottomNavBarButtonGap),
              IconButton(
                tooltip: 'Neue Stunde',
                icon: const Icon(Icons.add, size: 35),
                onPressed: onAddLesson,
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
