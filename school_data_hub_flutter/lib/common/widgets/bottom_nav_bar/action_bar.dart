import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';

class ActionBar extends StatelessWidget {
  final List<Widget>? actions;
  const ActionBar({this.actions, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(10),
        shape: null,
        color: style.colors.accent,
        child: IconTheme(
          data: IconThemeData(color: style.colors.background),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Row(
              children: [
                const Spacer(),
                TappableIcon(
                  tooltip: 'zurück',
                  icon: const Icon(Icons.arrow_back, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                if (actions != null)
                  for (var action in actions!) ...[
                    Gap(Style.spacing.lg),
                    action,
                  ],
                Gap(Style.spacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
