// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:schuldaten_hub/common/utils/extensions.dart';
// import 'package:schuldaten_hub/features/competence/models/competence_check.dart';
// import 'package:schuldaten_hub/features/competence/services/competence_helper.dart';
// import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

// Widget getCompetenceCheckComment(PupilProxy pupil, int competenceId) {
//   if (pupil.supportCategoryStatuses!.isNotEmpty) {
//     final CompetenceCheck? competenceCheck =
//         CompetenceHelper.getLastCompetenceCheckOfCompetence(
//             pupil, competenceId);
//     if (competenceCheck != null) {
//       return Padding(
//         padding: const EdgeInsets.only(left: 35),
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   competenceCheck.comment,
//                   maxLines: 2,
//                   textAlign: TextAlign.start,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 15,
//                   ),
//                 ),
//               ],
//             ),
//             const Gap(5),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'eingetragen von ',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                   ),
//                 ),
//                 Text(
//                   competenceCheck.createdBy,
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const Gap(5),
//                 const Text(
//                   'am',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                   ),
//                 ),
//                 const Gap(5),
//                 Text(
//                   competenceCheck.createdAt.formatForUser(),
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             )
//           ],
//         ),
//       );
//     }
//     return const SizedBox.shrink();
//   }
//   return const SizedBox.shrink();
// }
