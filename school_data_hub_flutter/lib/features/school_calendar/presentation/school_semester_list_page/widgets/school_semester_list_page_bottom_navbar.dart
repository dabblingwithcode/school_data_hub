import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class SchoolSemesterListPageBottomNavBar extends StatelessWidget {
  final VoidCallback onAddNewSemester;

  const SchoolSemesterListPageBottomNavBar({
    super.key,
    required this.onAddNewSemester,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.all(10),
      shape: null,
      color: AppColors.backgroundColor,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: [
            IconButton(
              tooltip: 'Zurück',
              icon: const Icon(Icons.arrow_back, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
            const Spacer(),
            IconButton(
              tooltip: 'Neues Schulhalbjahr',
              icon: const Icon(Icons.add, size: 30),
              onPressed: onAddNewSemester,
            ),
          ],
        ),
      ),
    );
  }
}
