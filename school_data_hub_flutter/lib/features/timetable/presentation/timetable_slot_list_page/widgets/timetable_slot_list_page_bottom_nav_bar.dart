import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:flutter_it/flutter_it.dart';

class TimetableSlotListPageBottomNavBar extends WatchingWidget {
  final VoidCallback onAddSlot;

  const TimetableSlotListPageBottomNavBar({super.key, required this.onAddSlot});

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();
    final timetable = watch(timetableManager.timetable);
    final hasActiveTimetable = timetable.value != null;

    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(10),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  tooltip: 'zurück',
                  icon: const Icon(Icons.arrow_back, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                if (hasActiveTimetable) ...[
                  const Gap(30),
                  IconButton(
                    tooltip: 'Neuen Zeitslot erstellen',
                    icon: const Icon(Icons.add, size: 30),
                    onPressed: onAddSlot,
                  ),
                ],
                const Gap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
