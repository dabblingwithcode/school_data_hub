// import 'package:flutter/material.dart';
// import 'package:flutter_it/flutter_it.dart';
// import 'package:gap/gap.dart';
// import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
// import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
// import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
// import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
// import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_search_text_field.dart';
// import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_helper_functions.dart';
// import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
// import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_filter_bottom_sheet.dart';
// import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/searchbar/schoolday_event_stats.dart';

// class SchooldayEventListSearchBar extends WatchingWidget {
//   const SchooldayEventListSearchBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final pupilsFilter = di<PupilsFilter>();

//     final filtersStateManager = di<FiltersStateManager>();
//     final pupils = watchValue((PupilsFilter x) => x.filteredPupils);

//     // we need to watch the schoolday events to refresh the counts for the stats
//     watchValue((SchooldayEventManager m) => m.schooldayEvents);

//     final filtersActive = watchValue(
//       (FiltersStateManager x) => x.filtersActive,
//     );

//     // Let's get the total numbers for the schoolday events variants

//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.canvasColor,
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       child: Column(
//         children: [
//           const Gap(5),
//           Flexible(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10.00),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: SchooldayEventStats(
//                   pupilsWithEventsCount:
//                       SchoolDayEventHelper.pupilsWithSchoolDayEvents(),
//                   schooldayEventsCount: schooldayEventsCounts,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: GenericSearchTextField(
//                     searchType: SearchType.pupil,
//                     hintText: 'Schüler/in suchen',
//                     refreshFunction: pupilsFilter.refresh,
//                     onChanged: (value) =>
//                         pupilsFilter.textFilter.setFilterText(value),
//                     searchTextSource: pupilsFilter.textFilter,
//                     filtersActive: filtersStateManager.filtersActive,
//                     onResetFilters: filtersStateManager.resetFilters,
//                   ),
//                 ),
//                 const Gap(5),
//                 InkWell(
//                   onTap: () => showSchooldayEventFilterBottomSheet(context),
//                   onLongPress: () {
//                     filtersStateManager.resetFilters();
//                   },
//                   child: Icon(
//                     Icons.filter_list,
//                     color: filtersActive ? Colors.deepOrange : Colors.grey,
//                     size: 30,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
