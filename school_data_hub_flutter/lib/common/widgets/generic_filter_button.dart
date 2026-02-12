import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';

class GenericFilterButton extends WatchingWidget {
  final bool isSearchBar;

  final Function showBottomSheetFunction;
  const GenericFilterButton({
    required this.isSearchBar,
    required this.showBottomSheetFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final filtersActive = watchValue(
      (FiltersStateManager x) => x.filtersActive,
    );

    return InkWell(
      onTap: () => showBottomSheetFunction(),
      onLongPress: () {
        di<FiltersStateManager>().resetFilters();
      },
      child: Icon(
        Icons.filter_list,
        color: filtersActive
            ? Colors.deepOrange
            : isSearchBar
            ? Colors.grey
            : Colors.white,
        size: 30,
      ),
    );
  }
}
