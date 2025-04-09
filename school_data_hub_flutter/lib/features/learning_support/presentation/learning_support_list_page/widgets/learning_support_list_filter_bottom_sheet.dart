// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:school_data_hub_client/school_data_hub_client.dart';
// import 'package:watch_it/watch_it.dart';

// class LearningSupportFilterBottomSheet extends WatchingWidget {
//   const LearningSupportFilterBottomSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Map<SupportLevel, bool> supportLevelFilters = watchValue(
//         (LearningSupportFilterManager x) => x.supportLevelFilterState);
//     Map<SupportArea, bool> supportAreaFilters = watchValue(
//         (LearningSupportFilterManager x) => x.supportAreaFilterState);
//     bool valueSpecialNeeds = supportLevelFilters[SupportLevel.specialNeeds]!;
//     bool valueSupportLevel1 = supportLevelFilters[SupportLevel.supportLevel1]!;
//     bool valueSupportLevel2 = supportLevelFilters[SupportLevel.supportLevel2]!;
//     bool valueSupportLevel3 = supportLevelFilters[SupportLevel.supportLevel3]!;
//     bool valueSupportLevel4 = supportLevelFilters[SupportLevel.supportLevel4]!;
//     bool valueMigrationSupport =
//         supportLevelFilters[SupportLevel.migrationSupport]!;
//     bool valueSupportAreaMotorics = supportAreaFilters[SupportArea.motorics]!;
//     bool valueSupportAreaEmotions = supportAreaFilters[SupportArea.emotions]!;
//     bool valueSupportAreaMath = supportAreaFilters[SupportArea.math]!;
//     bool valueSupportAreaLearning = supportAreaFilters[SupportArea.learning]!;
//     bool valueSupportAreaGerman = supportAreaFilters[SupportArea.german]!;
//     bool valueSupportAreaLanguage = supportAreaFilters[SupportArea.language]!;
//     final filterLocator = locator<LearningSupportFilterManager>();
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
//       child: Column(
//         children: [
//           const FilterHeading(),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(children: [
//                 const CommonPupilFiltersWidget(),
//                 const Row(
//                   children: [
//                     Text(
//                       'Förderebene',
//                       style: AppStyles.subtitle,
//                     )
//                   ],
//                 ),
//                 const Gap(5),
//                 Wrap(
//                   spacing: 5,
//                   crossAxisAlignment: WrapCrossAlignment.center,
//                   alignment: WrapAlignment.center,
//                   children: [
//                     ThemedFilterChip(
//                       label: 'Ebene 1',
//                       selected: valueSupportLevel1,
//                       onSelected: (val) {
//                         filterLocator
//                             .setSupportLevelFilter(supportLevelFilterRecords: [
//                           (
//                             filter: SupportLevel.supportLevel1,
//                             value: val,
//                           )
//                         ]);
//                       },
//                     ),
//                     ThemedFilterChip(
//                       label: 'Ebene 2',
//                       selected: valueSupportLevel2,
//                       onSelected: (val) {
//                         filterLocator
//                             .setSupportLevelFilter(supportLevelFilterRecords: [
//                           (
//                             filter: SupportLevel.supportLevel2,
//                             value: val,
//                           )
//                         ]);
//                       },
//                     ),
//                     ThemedFilterChip(
//                       label: 'Ebene 3',
//                       selected: valueSupportLevel3,
//                       onSelected: (val) {
//                         filterLocator
//                             .setSupportLevelFilter(supportLevelFilterRecords: [
//                           (
//                             filter: SupportLevel.supportLevel3,
//                             value: val,
//                           )
//                         ]);
//                       },
//                     ),
//                     ThemedFilterChip(
//                       label: 'Regenbogen',
//                       selected: valueSupportLevel4,
//                       onSelected: (val) {
//                         filterLocator
//                             .setSupportLevelFilter(supportLevelFilterRecords: [
//                           (
//                             filter: SupportLevel.supportLevel4,
//                             value: val,
//                           )
//                         ]);
//                       },
//                     ),
//                   ],
//                 ),
//                 const Row(
//                   children: [
//                     Text(
//                       'Förderbereich',
//                       style: AppStyles.subtitle,
//                     )
//                   ],
//                 ),
//                 const Gap(5),
//                 Wrap(
//                   spacing: 5,
//                   crossAxisAlignment: WrapCrossAlignment.center,
//                   alignment: WrapAlignment.center,
//                   children: [
//                     ThemedFilterChip(
//                       label: 'Motorik',
//                       selected: valueSupportAreaMotorics,
//                       onSelected: (val) {
//                         filterLocator
//                             .setSupportAreaFilter(supportAreaFilterRecords: [
//                           (
//                             filter: SupportArea.motorics,
//                             value: val,
//                           )
//                         ]);
//                       },
//                     ),
//                     ThemedFilterChip(
//                       label: 'ES',
//                       selected: valueSupportAreaEmotions,
//                       onSelected: (val) {
//                         filterLocator
//                             .setSupportAreaFilter(supportAreaFilterRecords: [
//                           (
//                             filter: SupportArea.emotions,
//                             value: val,
//                           )
//                         ]);
//                       },
//                     ),
//                     ThemedFilterChip(
//                       label: 'Mathe',
//                       selected: valueSupportAreaMath,
//                       onSelected: (val) {
//                         filterLocator
//                             .setSupportAreaFilter(supportAreaFilterRecords: [
//                           (
//                             filter: SupportArea.math,
//                             value: val,
//                           )
//                         ]);
//                       },
//                     ),
//                     ThemedFilterChip(
//                       label: 'Lernen',
//                       selected: valueSupportAreaLearning,
//                       onSelected: (val) {
//                         filterLocator
//                             .setSupportAreaFilter(supportAreaFilterRecords: [
//                           (
//                             filter: SupportArea.learning,
//                             value: val,
//                           )
//                         ]);
//                       },
//                     ),
//                     ThemedFilterChip(
//                       label: 'Deutsch',
//                       selected: valueSupportAreaGerman,
//                       onSelected: (val) {
//                         filterLocator
//                             .setSupportAreaFilter(supportAreaFilterRecords: [
//                           (
//                             filter: SupportArea.german,
//                             value: val,
//                           )
//                         ]);
//                       },
//                     ),
//                     ThemedFilterChip(
//                       label: 'Sprache',
//                       selected: valueSupportAreaLanguage,
//                       onSelected: (val) {
//                         filterLocator
//                             .setSupportAreaFilter(supportAreaFilterRecords: [
//                           (
//                             filter: SupportArea.language,
//                             value: val,
//                           )
//                         ]);
//                       },
//                     ),
//                   ],
//                 ),
//                 const Row(
//                   children: [
//                     Text(
//                       'Besondere Förderung',
//                       style: AppStyles.subtitle,
//                     )
//                   ],
//                 ),
//                 const Gap(5),
//                 Wrap(
//                   spacing: 5,
//                   crossAxisAlignment: WrapCrossAlignment.center,
//                   alignment: WrapAlignment.center,
//                   children: [
//                     ThemedFilterChip(
//                       label: 'Erstförderung',
//                       selected: valueMigrationSupport,
//                       onSelected: (val) {
//                         locator<LearningSupportFilterManager>()
//                             .setSupportLevelFilter(supportLevelFilterRecords: [
//                           (
//                             filter: SupportLevel.migrationSupport,
//                             value: val,
//                           )
//                         ]);
//                       },
//                     ),
//                     ThemedFilterChip(
//                         label: 'AO-SF',
//                         selected: valueSpecialNeeds,
//                         onSelected: (val) {
//                           filterLocator.setSupportLevelFilter(
//                               supportLevelFilterRecords: [
//                                 (
//                                   filter: SupportLevel.specialNeeds,
//                                   value: val,
//                                 )
//                               ]);
//                         }),
//                   ],
//                 ),
//                 const Gap(20),
//               ]),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// showLearningSupportFilterBottomSheet(BuildContext context) {
//   return showModalBottomSheet(
//     constraints: const BoxConstraints(maxWidth: 800),
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(20.0),
//         topRight: Radius.circular(20.0),
//       ),
//     ),
//     context: context,
//     builder: (_) => const LearningSupportFilterBottomSheet(),
//   );
// }
