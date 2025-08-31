import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';

class SubjectListPageBottomNavBar extends StatelessWidget {
  final VoidCallback onAddSubject;

  const SubjectListPageBottomNavBar({super.key, required this.onAddSubject});

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
              const Spacer(),
              IconButton(
                tooltip: 'Neues Fach',
                icon: const Icon(Icons.add, size: 35),
                onPressed: onAddSubject,
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
