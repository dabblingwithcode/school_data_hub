// import 'package:flutter/material.dart';
// import 'package:schuldaten_hub/common/domain/filters/filters_state_manager.dart';
// import 'package:schuldaten_hub/common/services/locator.dart';
// import 'package:watch_it/watch_it.dart';

// class FilterButton extends WatchingWidget {
//   final bool isSearchBar;
//   final Function showBottomSheetFunction;
//   const FilterButton(
//       {required this.isSearchBar,
//       required this.showBottomSheetFunction,
//       super.key});

//   @override
//   Widget build(BuildContext context) {
//     final filtersActive =
//         watchValue((FiltersStateManager x) => x.filtersActive);

//     return InkWell(
//       onTap: () => showBottomSheetFunction(),
//       onLongPress: () {
//         locator<FiltersStateManager>().resetFilters();
//       },
//       child: Icon(
//         Icons.filter_list,
//         color: filtersActive
//             ? Colors.deepOrange
//             : isSearchBar
//                 ? Colors.grey
//                 : Colors.white,
//         size: 30,
//       ),
//     );
//   }
// }
