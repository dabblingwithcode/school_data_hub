import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/domain/search_text_source.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/search_input.dart';

/// Generic search bar with optional stats/header row and a search row (text field + filter button).
/// Pass listenables and callbacks; this widget does not watch or use [di].
class SearchRow extends StatelessWidget {
  final Widget? statsWidget;
  final List<Widget>? middleWidgets;
  final SearchType searchType;
  final String hintText;
  final VoidCallback refreshFunction;
  final ValueChanged<String> onChanged;
  final SearchTextSource? searchTextSource;
  final ValueListenable<bool> filtersActive;
  final VoidCallback onResetFilters;
  final void Function(BuildContext context) showFilterBottomSheet;

  const SearchRow({
    super.key,
    this.statsWidget,
    this.middleWidgets,
    required this.searchType,
    required this.hintText,
    required this.refreshFunction,
    required this.onChanged,
    this.searchTextSource,
    required this.filtersActive,
    required this.onResetFilters,
    required this.showFilterBottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.canvasColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(5),
          if (statsWidget != null) statsWidget!,
          if (middleWidgets != null && middleWidgets!.isNotEmpty) ...middleWidgets!,
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: SearchInput(
                    searchType: searchType,
                    hintText: hintText,
                    refreshFunction: refreshFunction,
                    onChanged: onChanged,
                    searchTextSource: searchTextSource,
                    filtersActive: filtersActive,
                    onResetFilters: onResetFilters,
                  ),
                ),
                FilterButton(
                  isSearchBar: true,
                  filtersActive: filtersActive,
                  onLongPress: onResetFilters,
                  showBottomSheetFunction: showFilterBottomSheet,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
