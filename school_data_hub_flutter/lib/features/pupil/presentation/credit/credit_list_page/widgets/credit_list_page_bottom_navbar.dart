import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/show_generic_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/credit/credit_list_page/widgets/credit_filter_bottom_sheet.dart';
import 'package:watch_it/watch_it.dart';

class CreditListPageBottomNavBar extends WatchingWidget {
  const CreditListPageBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final filtersActive =
        watchValue((FiltersStateManager x) => x.filtersActive);
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
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Gap(30),
                InkWell(
                  onTap: () => showGenericBottomSheet(
                      context, const CreditFilterBottomSheet()),
                  onLongPress: () {
                    di<FiltersStateManager>().resetFilters();
                  },
                  child: Icon(
                    Icons.filter_list,
                    color: filtersActive ? Colors.deepOrange : Colors.white,
                    size: 30,
                  ),
                ),
                const Gap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
