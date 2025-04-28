// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:schuldaten_hub/common/domain/session_manager.dart';
// import 'package:schuldaten_hub/common/services/locator.dart';
// import 'package:schuldaten_hub/common/theme/app_colors.dart';
// import 'package:schuldaten_hub/common/theme/styles.dart';
// import 'package:schuldaten_hub/common/utils/extensions.dart';
// import 'package:schuldaten_hub/common/widgets/dialogs/confirmation_dialog.dart';
// import 'package:schuldaten_hub/features/learning_support/presentation/learning_support_list_page/widgets/support_goals_list.dart';
// import 'package:schuldaten_hub/features/learning_support/presentation/new_support_category_status_page/controller/new_support_category_status_controller.dart';
// import 'package:schuldaten_hub/features/learning_support/presentation/widgets/dialogs/preschool_revision_dialog.dart';
// import 'package:schuldaten_hub/features/learning_support/presentation/widgets/dialogs/support_level_dialog.dart';
// import 'package:schuldaten_hub/features/learning_support/presentation/widgets/support_catagory_status/support_category_statuses_list.dart';
// import 'package:schuldaten_hub/features/pupil/domain/models/pupil_data.dart';
// import 'package:schuldaten_hub/features/pupil/domain/models/pupil_proxy.dart';
// import 'package:schuldaten_hub/features/pupil/domain/pupil_helper_functions.dart';
// import 'package:schuldaten_hub/features/pupil/domain/pupil_manager.dart';

// List<Widget> pupilLearningSupportContentList(
//     PupilProxy pupil, BuildContext context) {
//   return [
//     const Row(
//       children: [
//         Text(
//           'Eingangsuntersuchung: ',
//           style: TextStyle(fontSize: 15.0),
//         ),
//         Gap(5),
//       ],
//     ),
//     const Gap(10),
//     Row(
//       children: [
//         InkWell(
//           onTap: () =>
//               preschoolRevisionDialog(context, pupil, pupil.preschoolRevision!),
//           child: Text(
//             preschoolRevisionPredicate(pupil.preschoolRevision!),
//             style: const TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.interactiveColor),
//           ),
//         )
//       ],
//     ),
//     const Gap(10),
//     pupil.supportLevelHistory.isNotEmpty
//         ? IndividualDevelopmentPlanExpansionTile(pupil: pupil)
//         : Row(
//             children: [
//               const Text('Förderebene:', style: TextStyle(fontSize: 15.0)),
//               const Gap(10),
//               InkWell(
//                 onTap: () =>
//                     supportLevelDialog(context, pupil, pupil.supportLevel),
//                 child: Text(
//                   pupil.supportLevel == 0
//                       ? 'kein Eintrag'
//                       : pupil.supportLevel == 1
//                           ? 'Förderebene 1'
//                           : pupil.supportLevel == 2
//                               ? 'Förderebene 2'
//                               : 'Förderebene 3',
//                   style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.interactiveColor),
//                 ),
//               )
//             ],
//           ),
//     const Gap(10),
//     Row(
//       children: [
//         const Text('Förderschwerpunkt: ', style: TextStyle(fontSize: 15.0)),
//         const Gap(5),
//         pupil.specialNeeds == '' || pupil.specialNeeds == null
//             ? const Text(
//                 'keins',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               )
//             : Text(
//                 '${pupil.specialNeeds}',
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               )
//       ],
//     ),
//     const Gap(10),
//     const Row(
//       children: [
//         Text('Förderbereiche',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//       ],
//     ),
//     const Gap(5),
//     Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: ElevatedButton(
//         style: AppStyles.actionButtonStyle,
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (ctx) => NewSupportCategoryStatus(
//                     appBarTitle: 'Neuer Förderbereich',
//                     pupilId: pupil.internalId,
//                     goalCategoryId: 0,
//                     elementType: 'status',
//                   )));
//         },
//         child: const Text(
//           "NEUER FÖRDERBEREICH",
//           style: AppStyles.buttonTextStyle,
//         ),
//       ),
//     ),
//     const Gap(5),
//     ...pupilCategoryStatusesList(pupil, context),

//     const Gap(5),
//     SupportGoalsList(pupil: pupil),

//     // const Gap(10),
//     // ...buildPupilCategoryTree(context, pupil, null, 0, null),
//     const Gap(15),
//   ];
// }

// class IndividualDevelopmentPlanExpansionTile extends StatefulWidget {
//   final PupilProxy pupil;
//   const IndividualDevelopmentPlanExpansionTile(
//       {required this.pupil, super.key});

//   @override
//   State<IndividualDevelopmentPlanExpansionTile> createState() =>
//       _IndividualDevelopmentPlanExpansionTileState();
// }

// class _IndividualDevelopmentPlanExpansionTileState
//     extends State<IndividualDevelopmentPlanExpansionTile> {
//   late ExpansionTileController _tileController;

//   @override
//   void initState() {
//     _tileController = ExpansionTileController();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final PupilProxy pupil = widget.pupil;
//     final List<SupportLevel> plans = widget.pupil.supportLevelHistory;
//     return ListTileTheme(
//       contentPadding: const EdgeInsets.all(0),
//       dense: true,
//       horizontalTitleGap: 0.0,
//       minLeadingWidth: 0,
//       minVerticalPadding: 0,
//       child: Theme(
//         data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//         child: ExpansionTile(
//             collapsedBackgroundColor: Colors.transparent,
//             tilePadding: const EdgeInsets.all(0),
//             title: Row(
//               children: [
//                 const Text('Förderebene:', style: TextStyle(fontSize: 15.0)),
//                 const Gap(10),
//                 InkWell(
//                   onTap: () =>
//                       supportLevelDialog(context, pupil, pupil.supportLevel),
//                   child: Text(
//                     pupil.supportLevel == 0
//                         ? 'kein Eintrag'
//                         : pupil.supportLevel == 1
//                             ? 'Förderebene 1'
//                             : pupil.supportLevel == 2
//                                 ? 'Förderebene 2'
//                                 : pupil.supportLevel == 3
//                                     ? 'Förderebene 3'
//                                     : 'Regenbogenförderung',
//                     style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.interactiveColor),
//                   ),
//                 )
//               ],
//             ),
//             controller: _tileController,
//             children: [
//               ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: widget.pupil.supportLevelHistory.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0),
//                       child: GestureDetector(
//                         onLongPress: () async {
//                           final confirmation = await confirmationDialog(
//                               context: context,
//                               title: 'Eintrag löschen',
//                               message: 'Eintrag wirklich löschen?');
//                           if (confirmation != true) return;
//                           if (locator<SessionManager>().isAdmin.value) {
//                             locator<PupilManager>()
//                                 .deleteSupportLevelHistoryItem(
//                                     pupilId: pupil.internalId,
//                                     supportLevelId:
//                                         plans[index].supportLevelId);
//                           }
//                         },
//                         child: Row(
//                           children: [
//                             Text(
//                               widget.pupil.supportLevelHistory[index].createdAt
//                                   .formatForUser(),
//                               style: const TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18),
//                             ),
//                             const Gap(20),
//                             const Text('Förderebene ',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18)),
//                             Text(
//                               widget.pupil.supportLevelHistory[index].level
//                                   .toString(),
//                               style: const TextStyle(
//                                   color: AppColors.backgroundColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18),
//                             ),
//                             const Gap(10),
//                             Text(pupil.supportLevelHistory[index].comment,
//                                 style: const TextStyle(
//                                     color: Colors.black, fontSize: 16)),
//                             const Spacer(),
//                             Text(pupil.supportLevelHistory[index].createdBy,
//                                 style: const TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18)),
//                             const Gap(10),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             ]),
//       ),
//     );
//   }
// }
