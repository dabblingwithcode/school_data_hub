import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';

class PupilProfileBottomNavBar extends StatelessWidget {
  const PupilProfileBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return BottomNavBarProfileLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(10),
        shape: null,
        color: style.colors.accent,
        child: IconTheme(
          data: IconThemeData(color: style.colors.background),
          child: Row(
            children: [
              Gap(Style.spacing.lg),
              TappableIcon(
                tooltip: 'zurück',
                icon: const Icon(Icons.arrow_back, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
              const Spacer(),
              TappableIcon(
                tooltip: 'Home',
                icon: const Icon(Icons.home, size: 30),
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
              ),
              Gap(Style.spacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
