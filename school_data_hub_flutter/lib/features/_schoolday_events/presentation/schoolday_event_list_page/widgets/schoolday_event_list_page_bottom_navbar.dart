// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:schuldaten_hub/common/theme/colors.dart';
// import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
// import 'package:schuldaten_hub/common/widgets/filter_button.dart';
// import 'package:schuldaten_hub/features/schoolday_events/pages/schoolday_event_list_page/widgets/schoolday_event_filter_bottom_sheet.dart';
// import 'package:watch_it/watch_it.dart';

// class SchooldayEventListPageBottomNavBar extends WatchingWidget {
//   const SchooldayEventListPageBottomNavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavBarLayout(
//       bottomNavBar: BottomAppBar(
//         padding: const EdgeInsets.all(10),
//         shape: null,
//         color: AppColors.backgroundColor,
//         child: IconTheme(
//           data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 800),
//             child: Row(
//               children: [
//                 const Spacer(),
//                 IconButton(
//                   tooltip: 'zurück',
//                   icon: const Icon(
//                     Icons.arrow_back,
//                     size: 30,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 const Gap(30),
//                 const FilterButton(
//                     isSearchBar: false,
//                     showBottomSheetFunction:
//                         showSchooldayEventFilterBottomSheet),
//                 const Gap(15)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
