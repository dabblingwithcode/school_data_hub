import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_slot/new_timetable_slot_page/new_timetable_slot_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_slot/timetable_slot_list_page/widgets/timetable_slot_list.dart';

class TimetableSlotListPage extends WatchingWidget {
  const TimetableSlotListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the timetable slots
    final timetableManager = di<TimetableManager>();
    final timetableSlots = watch(timetableManager.data.timetableSlots);
    final activeTimetable = watch(timetableManager.data.timetable);

    Future<void> navigateToNewTimetableSlot(BuildContext context) async {
      // Check if there's an active timetable
      if (timetableManager.data.timetable.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Kein Stundenplan ausgewählt. Bitte erstellen Sie zuerst einen Stundenplan.',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) =>
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                      if (activeTimetable.value != null) ...[
                        const Gap(8),
                        Text(
                          'Aktiver Stundenplan: ${activeTimetable.value!.name}',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ] else ...[
                        const Gap(8),
                        Text(
                          'Kein aktiver Stundenplan verfügbar',
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          if (activeTimetable.value != null)
            IconButton(
              tooltip: 'Neuen Zeitslot erstellen',
              icon: const Icon(Icons.add, size: 30),
              onPressed: () => navigateToNewTimetableSlot(context),
            ),
        ],
      ),
    );
  }
}
