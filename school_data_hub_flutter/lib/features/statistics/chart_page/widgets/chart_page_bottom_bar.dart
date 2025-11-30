import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';

class ChartPageBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const ChartPageBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: AppColors.backgroundColor,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Row(
            children: [
              IconButton(
                tooltip: 'Zurück',
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(10),
              Expanded(
                child: NavigationBarTheme(
                  data: NavigationBarThemeData(
                    labelTextStyle: WidgetStateProperty.resolveWith((states) {
                      return const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      );
                    }),
                    iconTheme: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return null; // Keep default theme for selected state (usually contrasting with indicator)
                      }
                      return const IconThemeData(color: Colors.white);
                    }),
                  ),
                  child: NavigationBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    indicatorColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    selectedIndex: selectedIndex,
                    onDestinationSelected: onDestinationSelected,
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.people_outline),
                        selectedIcon: Icon(Icons.people),
                        label: 'Schüler',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.event_note_outlined),
                        selectedIcon: Icon(Icons.event_note),
                        label: 'Ereignisse',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.access_time_outlined),
                        selectedIcon: Icon(Icons.access_time),
                        label: 'Anwesenheit',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
