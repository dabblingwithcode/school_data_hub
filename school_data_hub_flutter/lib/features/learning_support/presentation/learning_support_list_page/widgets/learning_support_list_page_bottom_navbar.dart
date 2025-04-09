// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
// import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
// import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/learning_support_list_filter_bottom_sheet.dart';

// class LearningSupportListPageBottomNavBar extends StatelessWidget {
//   final bool filtersOn;
//   const LearningSupportListPageBottomNavBar(
//       {required this.filtersOn, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavBarLayout(
//       bottomNavBar: BottomAppBar(
//         height: 60,
//         //padding: const EdgeInsets.all(15),
//         shape: null,
//         color: AppColors.backgroundColor,
//         child: IconTheme(
//           data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
//           child: Row(
//             children: <Widget>[
//               const Spacer(),
//               InkWell(
//                 onTap: () => Navigator.pop(context),
//                 child: const Icon(
//                   Icons.arrow_back,
//                   size: 30,
//                 ),
//               ),
//               const Gap(30),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (ctx) => const SelectCompetence()));
//                 },
//                 child: const Icon(
//                   Icons.group_add,
//                   size: 30,
//                 ),
//               ),
//               const Gap(30),
//               InkWell(
//                 onTap: () => showLearningSupportFilterBottomSheet(context),
//                 onLongPress: () =>
//                     locator<FiltersStateManager>().resetFilters(),
//                 child: Icon(
//                   Icons.filter_list,
//                   color: filtersOn ? Colors.deepOrange : Colors.white,
//                   size: 30,
//                 ),
//               ),
//               const Gap(15)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
