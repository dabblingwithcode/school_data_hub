import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';

class BookTagManagementBottomNavBar extends StatelessWidget {
  final VoidCallback onAddPressed;

  const BookTagManagementBottomNavBar({
    super.key,
    required this.onAddPressed,
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Spacer(),
              IconButton(
                tooltip: 'Zurück',
                icon: const Icon(Icons.arrow_back, size: 35),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(15),
              IconButton(
                tooltip: 'Neues Tag erstellen',
                icon: const Icon(Icons.add, size: 35),
                onPressed: onAddPressed,
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}

