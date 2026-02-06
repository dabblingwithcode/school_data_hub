// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:schuldaten_hub/common/constants/enums.dart';
// import 'package:schuldaten_hub/common/constants/styles.dart';
// import 'package:schuldaten_hub/common/services/locator.dart';
// import 'package:schuldaten_hub/common/services/notification_service.dart';
// import 'package:schuldaten_hub/common/utils/scanner.dart';
// import 'package:schuldaten_hub/features/competence/pages/learning_pupil_list_page/widgets/pupil_competence_checks/pupil_competence_status_tree.dart';
// import 'package:schuldaten_hub/features/competence/pages/learning_pupil_list_page/widgets/pupil_learning_content/pupil_learning_goals_widget.dart';
// import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
// import 'package:schuldaten_hub/features/workbooks/models/pupil_workbook.dart';
// import 'package:schuldaten_hub/features/workbooks/pages/new_workbook_page/new_workbook_page.dart';
// import 'package:schuldaten_hub/features/workbooks/pages/workbook_list_page/widgets/pupil_workbook_card.dart';
// import 'package:schuldaten_hub/features/workbooks/services/workbook_manager.dart';

// class PupilLearningContentList extends StatelessWidget {
//   final PupilProxy pupil;
//   const PupilLearningContentList({required this.pupil, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ExpansionTile(
//           title: const Row(
//             children: [
//               Text(
//                 'Arbeitshefte',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               )
//             ],
//           ),
//           children: [
//             const Gap(10),
//             ElevatedButton(
//               style: actionButtonStyle,
//               //- TODO: strip this logic and use a controller instead
//               onPressed: () async {
//                 final scanResult = await scanner(context, 'ISBN code scannen');
//                 if (scanResult != null) {
//                   final scannedIsbn = int.parse(scanResult);
//                   if (!locator<WorkbookManager>()
//                       .workbooks
//                       .value
//                       .any((element) => element.isbn == scannedIsbn)) {
//                     if (context.mounted) {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (ctx) => NewWorkbookPage(
//                                 isEdit: false,
//                                 wbIsbn: scannedIsbn,
//                               )));
//                     }
//                     locator<NotificationService>().showInformationDialog(
//                         'Das Arbeitsheft wurde noch nicht erfasst. Bitte hinzufügen!');
//                     return;
//                   }
//                   if (pupil.pupilWorkbooks!.isNotEmpty) {
//                     if (pupil.pupilWorkbooks!.any((element) =>
//                         element.workbookIsbn == int.parse(scanResult))) {
//                       locator<NotificationService>().showSnackBar(
//                           NotificationType.error,
//                           'Dieses Arbeitsheft ist schon erfasst!');
//                       return;
//                     }
//                   }
//                   locator<WorkbookManager>().newPupilWorkbook(
//                       pupil.internalId, int.parse(scanResult));
//                   return;
//                 }
//                 locator<NotificationService>().showSnackBar(
//                     NotificationType.error, 'Fehler beim Scannen');
//               },
//               child: const Text(
//                 "NEUES ARBEITSHEFT",
//                 style: buttonTextStyle,
//               ),
//             ),
//             if (pupil.pupilWorkbooks!.isNotEmpty) ...[
//               const Gap(15),
//               ListView.builder(
//                 padding: const EdgeInsets.all(0),
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: pupil.pupilWorkbooks!.length,
//                 itemBuilder: (context, int index) {
//                   List<PupilWorkbook> pupilWorkbooks = pupil.pupilWorkbooks!;

//                   return ClipRRect(
//                     borderRadius: BorderRadius.circular(25.0),
//                     child: Column(
//                       children: [
//                         PupilWorkbookCard(
//                             pupilWorkbook: pupilWorkbooks[index],
//                             pupilId: pupil.internalId),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ],
//         ),

//         ExpansionTile(
//           title: const Row(
//             children: [
//               Text(
//                 'Lernziele',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           children: [
//             const Gap(10),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     style: actionButtonStyle,
//                     onPressed: () async {},
//                     child: const Text(
//                       "NEUES LERNZIEL",
//                       style: buttonTextStyle,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             PupilLearningGoals(pupil: pupil),
//           ],
//         ),

//         const Gap(20),
//         const Row(
//           children: [
//             Text(
//               'Status Kompetenzen',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         // PupilCompetenceStatusTree(
//         //     pupil: pupil, parentId: null, indentation: 0, context: context),
//         ...buildPupilCompetenceStatusTree(
//             pupil: pupil,
//             parentId: null,
//             indentation: 0,
//             passedBackGroundColor: null,
//             context: context),
//         const Gap(15),
//       ],
//     );
//   }
// }

// // List<Widget> pupilLearningContentList(PupilProxy pupil, BuildContext context) {
// //   return [
// //     const Row(
// //       children: [
// //         Text(
// //           'Arbeitshefte',
// //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //         )
// //       ],
// //     ),
// //     const Gap(10),
// //     ElevatedButton(
// //       style: actionButtonStyle,
// //       onPressed: () async {
// //         final scanResult = await scanner(context, 'ISBN code scannen');
// //         if (scanResult != null) {
// //           if (!locator<WorkbookManager>()
// //               .workbooks
// //               .value
// //               .any((element) => element.isbn == int.parse(scanResult))) {
// //             locator<NotificationService>().showSnackBar(NotificationType.error,
// //                 'Das Arbeitsheft wurde noch nicht erfasst. Bitte zuerst unter "Arbeitshefte" hinzufügen.');
// //             return;
// //           }
// //           if (pupil.pupilWorkbooks!.isNotEmpty) {
// //             if (pupil.pupilWorkbooks!.any(
// //                 (element) => element.workbookIsbn == int.parse(scanResult))) {
// //               locator<NotificationService>().showSnackBar(
// //                   NotificationType.error,
// //                   'Dieses Arbeitsheft ist schon erfasst!');
// //               return;
// //             }
// //           }
// //           locator<WorkbookManager>()
// //               .newPupilWorkbook(pupil.internalId, int.parse(scanResult));
// //           return;
// //         }
// //         locator<NotificationService>()
// //             .showSnackBar(NotificationType.error, 'Fehler beim Scannen');
// //       },
// //       child: const Text(
// //         "NEUES ARBEITSHEFT",
// //         style: buttonTextStyle,
// //       ),
// //     ),
// //     if (pupil.pupilWorkbooks!.isNotEmpty) ...[
// //       const Gap(15),
// //       ListView.builder(
// //         padding: const EdgeInsets.all(0),
// //         shrinkWrap: true,
// //         physics: const NeverScrollableScrollPhysics(),
// //         itemCount: pupil.pupilWorkbooks!.length,
// //         itemBuilder: (context, int index) {
// //           List<PupilWorkbook> pupilWorkbooks = pupil.pupilWorkbooks!;

// //           return ClipRRect(
// //             borderRadius: BorderRadius.circular(25.0),
// //             child: Card(
// //               child: Column(
// //                 children: [
// //                   PupilWorkbookCard(
// //                       pupilWorkbook: pupilWorkbooks[index],
// //                       pupilId: pupil.internalId),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     ],
// //     const Gap(20),
// //     const Text(' ⚠️ Ab hier ist Baustelle! ⚠️',
// //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// //     const Gap(20),
// //     const Text(' ⚠️ Preview ⚠️',
// //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// //     const Gap(20),
// //     const Row(
// //       children: [
// //         Text(
// //           'Lernziele',
// //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //         ),
// //       ],
// //     ),
// //     const Gap(10),
// //     ElevatedButton(
// //       style: actionButtonStyle,
// //       onPressed: () async {},
// //       child: const Text(
// //         "NEUES LERNZIEL",
// //         style: buttonTextStyle,
// //       ),
// //     ),
// //     pupil.competenceGoals!.isNotEmpty ? const Gap(15) : const SizedBox.shrink(),
// //     pupil.competenceGoals!.isNotEmpty
// //         ? ListView.builder(
// //             padding: const EdgeInsets.all(0),
// //             shrinkWrap: true,
// //             physics: const NeverScrollableScrollPhysics(),
// //             itemCount: pupil.competenceGoals!.length,
// //             itemBuilder: (context, int index) {
// //               List<CompetenceGoal> pupilGoals = pupil.competenceGoals!;
// //               return CompetenceGoalCard(
// //                 pupil: pupil,
// //                 pupilGoal: pupilGoals[index],
// //               );
// //             })
// //         : const SizedBox.shrink(),
// //     const Gap(20),
// //     const Row(
// //       children: [
// //         Text(
// //           'Status Kompetenzen',
// //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //         ),
// //       ],
// //     ),
// //     ...buildPupilCompetenceStatusTree(
// //         pupil: pupil,
// //         parentId: null,
// //         indentation: 0,
// //         passedBackGroundColor: null,
// //         context: context),
// //     const Gap(15),
// //   ];
// // }
