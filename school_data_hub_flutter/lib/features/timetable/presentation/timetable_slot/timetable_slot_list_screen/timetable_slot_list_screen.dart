import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_slot/new_timetable_slot_screen/new_timetable_slot_screen.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_slot/timetable_slot_list_screen/widgets/timetable_slot_list.dart';

class TimetableSlotListScreen extends WatchingWidget {
  const TimetableSlotListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    // Watch the timetable slots
    final timetableManager = di<TimetableManager>();
    final timetableSlots = watch(timetableManager.data.timetableSlots);
    final activeTimetable = watch(timetableManager.data.timetable);

    Future<void> navigateToNewTimetableSlot(BuildContext context) async {
      // Check if there's an active timetable
      if (timetableManager.data.timetable.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Kein Stundenplan ausgewählt. Bitte erstellen Sie zuerst einen Stundenplan.',
            ),
            backgroundColor: style.colors.error,
          ),
        );
        return;
      }

      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) =>
              NewTimetableSlotScreen(timetableManager: timetableManager),
        ),
      );
      // Refresh data after returning from the new slot page
      await timetableManager.refreshData();
    }

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.schedule,
        title: 'Zeitslots verwalten',
      ),
      body: Padding(
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                // Header with info
                Container(
                  padding: EdgeInsets.all(Style.spacing.lg),
                  decoration: BoxDecoration(
                    color: style.colors.borderSubtle,
                    borderRadius: BorderRadius.circular(Style.radii.small),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: style.colors.accent),
                          Gap(Style.spacing.sm),
                          Expanded(
                            child: Text(
                              'Zeitslots definieren die verfügbaren Unterrichtszeiten für jeden Wochentag.',
                              style: context.typography.body.withColor(
                                style.colors.accent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (activeTimetable.value != null) ...[
                        Gap(Style.spacing.sm),
                        Text(
                          'Aktiver Stundenplan: ${activeTimetable.value!.name}',
                          style: context.typography.bodySmall
                              .withColor(style.colors.success)
                              .bold,
                        ),
                      ] else ...[
                        Gap(Style.spacing.sm),
                        Text(
                          'Kein aktiver Stundenplan verfügbar',
                          style: context.typography.bodySmall
                              .withColor(style.colors.error)
                              .bold,
                        ),
                      ],
                    ],
                  ),
                ),
                Gap(Style.spacing.xl),

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
      bottomNavigationBar: ActionBar(
        actions: [
          if (activeTimetable.value != null)
            TappableIcon(
              tooltip: 'Neuen Zeitslot erstellen',
              icon: const Icon(Icons.add, size: 30),
              onPressed: () => navigateToNewTimetableSlot(context),
            ),
        ],
      ),
    );
  }
}
