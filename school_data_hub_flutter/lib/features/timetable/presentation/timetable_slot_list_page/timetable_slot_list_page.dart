import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager_refactored.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_timetable_slot_page/new_timetable_slot_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_slot_list_page/widgets/timetable_slot_list.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_slot_list_page/widgets/timetable_slot_list_page_bottom_nav_bar.dart';
import 'package:watch_it/watch_it.dart';

class TimetableSlotListPage extends WatchingWidget {
  const TimetableSlotListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the timetable slots
    final timetableManager = di<TimetableManager>();
    final timetableSlots = watch(timetableManager.timetableSlots);

    Future<void> _navigateToNewTimetableSlot(BuildContext context) async {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) =>
                  NewTimetableSlotPage(timetableManager: timetableManager),
        ),
      );
      // Refresh data after returning from the new slot page
      await timetableManager.refreshData();
    }

    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.schedule,
        title: 'Zeitslots verwalten',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                // Header with info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue[600]),
                      const Gap(8),
                      Expanded(
                        child: Text(
                          'Zeitslots definieren die verfügbaren Unterrichtszeiten für jeden Wochentag.',
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(20),

                // Timetable slots list
                Expanded(
                  child: TimetableSlotList(
                    timetableSlots: timetableSlots.value,
                    timetableManager: timetableManager,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: TimetableSlotListPageBottomNavBar(
        onAddSlot: () => _navigateToNewTimetableSlot(context),
      ),
    );
  }
}
