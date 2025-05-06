// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:schuldaten_hub/common/utils/extensions.dart';
// import 'package:schuldaten_hub/features/learning_support/models/support_category/support_category_status.dart';
// import 'package:schuldaten_hub/features/learning_support/services/learning_support_helper_functions.dart';
// import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';

// Widget getSupportCategoryStatusComment(PupilProxy pupil, int goalCategoryId) {
//   if (pupil.supportCategoryStatuses!.isNotEmpty) {
//     final SupportCategoryStatus? categoryStatus =
//         LearningSupportHelper.getCategoryStatus(pupil, goalCategoryId);
//     if (categoryStatus != null) {
//       return Padding(
//         padding: const EdgeInsets.only(left: 35),
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   categoryStatus.comment,
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
//                   categoryStatus.createdBy,
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
//                   categoryStatus.createdAt.formatForUser(),
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
