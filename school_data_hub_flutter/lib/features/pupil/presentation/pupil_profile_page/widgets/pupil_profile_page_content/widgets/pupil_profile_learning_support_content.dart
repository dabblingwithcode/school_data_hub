// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:schuldaten_hub/common/theme/app_colors.dart';
// import 'package:schuldaten_hub/common/theme/paddings.dart';
// import 'package:schuldaten_hub/common/widgets/dialogs/information_dialog.dart';
// import 'package:schuldaten_hub/features/learning_support/presentation/learning_support_list_page/learning_support_list_page.dart';
// import 'package:schuldaten_hub/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_learning_support_content_list.dart';
// import 'package:schuldaten_hub/features/pupil/domain/models/pupil_proxy.dart';

// class PupilLearningSupportContent extends StatelessWidget {
//   final PupilProxy pupil;
//   const PupilLearningSupportContent({required this.pupil, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.pupilProfileCardColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: AppPaddings.pupilProfileCardPadding,
//         child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//           Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
//             const Icon(
//               Icons.support_rounded,
//               color: Colors.red,
//               size: 24,
//             ),
//             const Gap(5),
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (ctx) => const LearningSupportListPage(),
//                 ));
//               },
//               child: const Text('Förderung',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.backgroundColor,
//                   )),
//             ),
//             const Spacer(),
//             IconButton(
//               onPressed: () async {
//                 informationDialog(context, 'Förderplan ausdrucken ',
//                     'Diese Funktion ist noch nicht verfügbar. Bitte wenden Sie sich an den Administrator.');
//                 // await generatePdf(pupil.internalId);
//               },
//               icon: const Icon(Icons.print_rounded),
//               color: AppColors.backgroundColor,
//               iconSize: 24,
//             ),
//           ]),
//           const Gap(15),
//           ...pupilLearningSupportContentList(pupil, context),
//         ]),
//       ),
//     );
//   }
// }
