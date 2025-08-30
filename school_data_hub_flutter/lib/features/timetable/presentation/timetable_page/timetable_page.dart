import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/new_scheduled_lesson_page.dart';
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
      appBar: AppBar(
        title: const Text('Stundenplan'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToNewLesson,
            tooltip: 'Neue Stunde hinzufügen',
          ),
        ],
      ),
      body: Column(
        children: [
          // Weekday Selector (more prominent now)
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Wochentag auswählen:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                WeekdaySelector(timetableManager: _timetableManager),
              ],
            ),
          ),
          const Divider(height: 1),
          // Timetable Grid for selected weekday
          Expanded(
            child: TimetableGrid(
              timetableManager: _timetableManager,
              onLessonTap: _onLessonTap,
              onEmptySlotTap: _onEmptySlotTap,
            ),
          ),
        ],
      ),
    );
  }
}
