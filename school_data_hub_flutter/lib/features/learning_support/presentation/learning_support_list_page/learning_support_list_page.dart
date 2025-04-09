// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:school_data_hub_flutter/common/widgets/list_view_components/generic_sliver_list.dart';
// import 'package:school_data_hub_flutter/common/widgets/list_view_components/generic_sliver_search_app_bar.dart';
// import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/learning_support_list_card.dart';
// import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/learning_support_list_page_bottom_navbar.dart';
// import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/learning_support_list_search_bar.dart';

// import 'package:watch_it/watch_it.dart';

// class LearningSupportListPage extends WatchingWidget {
//   const LearningSupportListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);
//     // These come from the PupilFilterManager

//     List<PupilProxy> pupils = watchValue((PupilsFilter x) => x.filteredPupils);
//     return Scaffold(
//       backgroundColor: AppColors.canvasColor,
//       appBar: const GenericAppBar(
//           iconData: Icons.support_rounded, title: 'Förderung'),
//       body: RefreshIndicator(
//         onRefresh: () async => locator<PupilManager>().updatePupilList(pupils),
//         child: Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 800),
//             child: CustomScrollView(
//               slivers: [
//                 const SliverGap(5),
//                 GenericSliverSearchAppBar(
//                   height: 110,
//                   title: LearningSupportListSearchBar(
//                       pupils: pupils, filtersOn: filtersOn),
//                 ),
//                 GenericSliverListWithEmptyListCheck(
//                     items: pupils,
//                     itemBuilder: (_, pupil) => LearningSupportCard(pupil)),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar:
//           LearningSupportListPageBottomNavBar(filtersOn: filtersOn),
//     );
//   }
// }
