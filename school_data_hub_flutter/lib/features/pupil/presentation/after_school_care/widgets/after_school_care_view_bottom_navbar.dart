import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/filter_button.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/after_school_care/widgets/after_school_care_filter_bottom_sheet.dart';

class AfterSchoolCareListPageBottomNavBar extends StatelessWidget {
  final bool filtersOn;
  const AfterSchoolCareListPageBottomNavBar({
    required this.filtersOn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(10),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(Icons.arrow_back, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(30),
              FilterButton(
                isSearchBar: true,
                showBottomSheetFunction: () =>
                    showOgsFilterBottomSheet(context),
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
