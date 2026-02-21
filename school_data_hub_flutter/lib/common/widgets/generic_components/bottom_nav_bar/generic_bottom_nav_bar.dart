import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';

class GenericBottomNavBar extends WatchingWidget {
  final Function specificFilterBottomSheetFunction;
  final Widget? bottomNavBarButtons;
  final bool? showFilterButton;

  const GenericBottomNavBar({
    required this.specificFilterBottomSheetFunction,
    required this.bottomNavBarButtons,
    this.showFilterButton = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final filtersActive = watchValue(
      (FiltersStateManager x) => x.filtersActive,
    );
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
                if (bottomNavBarButtons != null) bottomNavBarButtons!,
                if (showFilterButton == true) ...[
                  const Gap(AppPaddings.bottomNavBarButtonGap),
                  InkWell(
                    onTap: () => specificFilterBottomSheetFunction(context),
                    onLongPress: () {
                      di<FiltersStateManager>().resetFilters();
                    },
                    child: Icon(
                      Icons.filter_list,
                      color: filtersActive ? Colors.deepOrange : Colors.white,
                      size: 30,
                    ),
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
