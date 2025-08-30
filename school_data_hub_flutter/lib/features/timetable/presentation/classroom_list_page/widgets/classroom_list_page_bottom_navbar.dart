import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';

class ClassroomListPageBottomNavBar extends StatelessWidget {
  final VoidCallback onAddNewClassroom;

  const ClassroomListPageBottomNavBar({
    super.key,
    required this.onAddNewClassroom,
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
            children: <Widget>[
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(Icons.arrow_back, size: 35),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(AppPaddings.bottomNavBarButtonGap),
              IconButton(
                tooltip: 'Neuen Raum hinzufügen',
                icon: const Icon(Icons.add, size: 35),
                onPressed: onAddNewClassroom,
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
