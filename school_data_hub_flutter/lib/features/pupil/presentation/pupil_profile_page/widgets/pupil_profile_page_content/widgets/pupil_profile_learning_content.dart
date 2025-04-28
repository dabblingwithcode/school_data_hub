// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:schuldaten_hub/common/services/locator.dart';
// import 'package:schuldaten_hub/common/theme/app_colors.dart';
// import 'package:schuldaten_hub/common/theme/paddings.dart';
// import 'package:schuldaten_hub/common/utils/extensions.dart';
// import 'package:schuldaten_hub/common/widgets/dialogs/confirmation_dialog.dart';
// import 'package:schuldaten_hub/features/competence/presentation/pupil_competence_list_page/widgets/pupil_competence_checks/competence_checks_badges.dart';
// import 'package:schuldaten_hub/features/competence/presentation/widgets/pupil_learning_content_expansion_tile_nav_bar.dart';
// import 'package:schuldaten_hub/features/pupil/domain/models/pupil_proxy.dart';
// import 'package:schuldaten_hub/features/pupil/domain/pupil_manager.dart';

// class PupilLearningContent extends StatelessWidget {
//   final PupilProxy pupil;
//   const PupilLearningContent({required this.pupil, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.pupilProfileCardColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: AppPaddings.pupilProfileCardPadding,
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
//             Icon(
//               Icons.lightbulb,
//               color: AppColors.accentColor,
//               size: 24,
//             ),
//             Gap(5),
//             Text('Lernen',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.backgroundColor,
//                 ))
//           ]),
//           const Gap(10),
//           Row(
//             children: [
//               const Gap(5),
//               const Text('3 Jahre Eingangsphase?'),
//               const Gap(5),
//               InkWell(
//                 onTap: () async {
//                   final date = await showCalendarDatePicker2Dialog(
//                     context: context,
//                     config: CalendarDatePicker2WithActionButtonsConfig(
//                       // selectableDayPredicate: (day) =>
//                       //     !schooldayDates.any((element) => element.isSameDate(day)),
//                       calendarType: CalendarDatePicker2Type.single,
//                     ),
//                     dialogSize: const Size(325, 400),
//                     value: [], //schooldayDates,
//                     borderRadius: BorderRadius.circular(15),
//                   );

//                   if (date != null && date.isNotEmpty) {
//                     locator<PupilManager>().patchOnePupilProperty(
//                         pupilId: pupil.internalId,
//                         jsonKey: 'five_years',
//                         value: date.first!.formatForJson());
//                   }
//                 },
//                 onLongPress: () async {
//                   if (pupil.fiveYears == null) return;
//                   final confirmation = await confirmationDialog(
//                       context: context,
//                       title: 'Eintrag löschen',
//                       message: 'Eintrag wirklich löschen?');
//                   if (confirmation != true) return;
//                   locator<PupilManager>().patchOnePupilProperty(
//                       pupilId: pupil.internalId,
//                       jsonKey: 'five_years',
//                       value: null);
//                 },
//                 child: Text(
//                   pupil.fiveYears != null
//                       ? 'Entscheidung vom ${pupil.fiveYears!.formatForUser()}'
//                       : 'nein',
//                   style: const TextStyle(
//                     color: AppColors.interactiveColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const Gap(10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CompetenceChecksBadges(pupil: pupil),
//             ],
//           ),
//           PupilLearningContentExpansionTileNavBar(
//             pupil: pupil,
//           ),
//         ]),
//       ),
//     );
//   }
// }
