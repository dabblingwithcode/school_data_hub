// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:schuldaten_hub/common/services/locator.dart';
// import 'package:schuldaten_hub/common/theme/app_colors.dart';
// import 'package:schuldaten_hub/common/theme/paddings.dart';
// import 'package:schuldaten_hub/common/widgets/dialogs/confirmation_dialog.dart';
// import 'package:schuldaten_hub/common/widgets/dialogs/long_textfield_dialog.dart';
// import 'package:schuldaten_hub/features/ogs/widgets/dialogs/ogs_pickup_time_dialog.dart';
// import 'package:schuldaten_hub/features/pupil/domain/models/pupil_proxy.dart';
// import 'package:schuldaten_hub/features/pupil/domain/pupil_helper_functions.dart';
// import 'package:schuldaten_hub/features/pupil/domain/pupil_manager.dart';

// class PupilOgsContent extends StatelessWidget {
//   final PupilProxy pupil;
//   const PupilOgsContent({required this.pupil, super.key});

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
//             Text('OGS-Informationen',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.backgroundColor,
//                 ))
//           ]),
//           const Gap(15),
//           Row(
//             children: [
//               const Text('Notbetreuungsberechtigt: '),
//               const Gap(5),
//               InkWell(
//                 onTap: () async {
//                   final bool? confirm = await confirmationDialog(
//                       context: context,
//                       title: 'Notbetreuungsberechtigung ändern',
//                       message:
//                           'Notbetreuungsberechtigung für dieses Kind ändern?');
//                   if (confirm == false || confirm == null) return;
//                   await locator<PupilManager>().patchOnePupilProperty(
//                       pupilId: pupil.internalId,
//                       jsonKey: 'emergency_care',
//                       value: pupil.emergencyCare == true ? 'false' : 'true');
//                 },
//                 child: Text(
//                   pupil.emergencyCare == true ? 'Ja' : 'Nein',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: AppColors.backgroundColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           if (pupil.ogs == false)
//             const Row(
//               children: [
//                 Gap(25),
//                 Text(
//                   'Nicht angemeldet.',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: AppColors.backgroundColor,
//                   ),
//                 ),
//               ],
//             )
//           else
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     const Gap(25),
//                     Flexible(
//                       child: InkWell(
//                         onTap: () async {
//                           final String? ogsInfo = await longTextFieldDialog(
//                               title: 'OGS Informationen',
//                               labelText: 'OGS Informationen',
//                               textinField: pupil.ogsInfo ?? '',
//                               parentContext: context);
//                           if (ogsInfo == null) return;
//                           await locator<PupilManager>().patchOnePupilProperty(
//                               pupilId: pupil.internalId,
//                               jsonKey: 'ogs_info',
//                               value: ogsInfo);
//                         },
//                         onLongPress: () async {
//                           if (pupil.ogsInfo == null) return;
//                           final bool? confirm = await confirmationDialog(
//                               context: context,
//                               title: 'OGS Infos löschen',
//                               message:
//                                   'OGS Informationen für dieses Kind löschen?');
//                           if (confirm == false || confirm == null) return;
//                           await locator<PupilManager>().patchOnePupilProperty(
//                               pupilId: pupil.internalId,
//                               jsonKey: 'ogs_info',
//                               value: null);
//                         },
//                         child: Text(
//                           pupil.ogsInfo == null || pupil.ogsInfo!.isEmpty
//                               ? 'keine Infos'
//                               : pupil.ogsInfo!,
//                           overflow: TextOverflow.ellipsis,
//                           softWrap: true,
//                           maxLines: 3,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: AppColors.backgroundColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Gap(15),
//                 Row(
//                   children: [
//                     const Gap(25),
//                     Row(
//                       children: [
//                         const Text('Abholzeit:'),
//                         const Gap(5),
//                         InkWell(
//                           onTap: () => pickUpTimeDialog(
//                               context, pupil, pupil.pickUpTime),
//                           child: Text(
//                             pickUpValue(pupil.pickUpTime),
//                             style: const TextStyle(
//                                 fontSize: 23,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.backgroundColor),
//                           ),
//                         ),
//                         const Gap(5),
//                         const Text('Uhr'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//         ]),
//       ),
//     );
//   }
// }
