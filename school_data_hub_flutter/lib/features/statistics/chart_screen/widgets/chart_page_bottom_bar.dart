import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

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
    final style = Style.of(context);
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: style.colors.accent,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Row(
            children: [
              IconButton(
                tooltip: 'Zurück',
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: style.colors.accentForeground,
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
                      return TextStyle(
                        color: style.colors.accentForeground,
                        fontWeight: FontWeight.w500,
                      );
                    }),
                    iconTheme: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return null; // Keep default theme for selected state (usually contrasting with indicator)
                      }
                      return IconThemeData(color: style.colors.accentForeground);
                    }),
                  ),
                  child: NavigationBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    indicatorColor: Theme.of(
                      context,
                    ).colorScheme.secondaryContainer,
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
                      NavigationDestination(
                        icon: Icon(Icons.menu_book_outlined),
                        selectedIcon: Icon(Icons.menu_book),
                        label: 'Ausleihen',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.account_balance_wallet_outlined),
                        selectedIcon: Icon(Icons.account_balance_wallet),
                        label: 'Kredite',
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
