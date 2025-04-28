// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:schuldaten_hub/common/theme/app_colors.dart';
// import 'package:schuldaten_hub/features/pupil/domain/pupil_helper_functions.dart';

// Widget communicationValues(String values) {
//   String understandingValue = values.substring(0, 1);
//   String speakingValue = values.substring(1, 2);
//   String readingValue = values.substring(2, 3);
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Icon(Icons.hearing),
//           const Gap(10),
//           Text(
//             communicationPredicate(understandingValue),
//             style: const TextStyle(
//                 fontSize: 16, color: AppColors.interactiveColor),
//           ),
//         ],
//       ),
//       const Gap(10),
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Icon(Icons.chat_bubble_outline_rounded),
//           const Gap(10),
//           Text(
//             communicationPredicate(speakingValue),
//             style: const TextStyle(
//                 fontSize: 16, color: AppColors.interactiveColor),
//           ),
//         ],
//       ),
//       const Gap(5),
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Icon(Icons.book),
//           const Gap(10),
//           Text(
//             communicationPredicate(readingValue),
//             style: const TextStyle(
//                 fontSize: 16, color: AppColors.interactiveColor),
//           ),
//         ],
//       ),
//       const Gap(5),
//     ],
//   );
// }
