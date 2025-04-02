// import 'package:flutter/material.dart';
// import 'package:school_data_hub_flutter/theme/app_colors.dart';
// import 'package:schuldaten_hub/common/theme/app_colors.dart';
// import 'package:schuldaten_hub/common/widgets/document_image.dart';
// import 'package:schuldaten_hub/common/widgets/download_or_cached_and_decrypt_image.dart';
// import 'package:widget_zoom/widget_zoom.dart';

// class UnencryptedImageInCard extends StatelessWidget {
//   final DocumentImageData documentImageData;
//   const UnencryptedImageInCard({required this.documentImageData, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: documentImageData.size,
//       width: (21 / 30) * documentImageData.size,
//       child: Center(
//         child: WidgetZoom(
//           heroAnimationTag: documentImageData.documentTag,
//           zoomWidget: FutureBuilder<Image>(
//             future: cachedOrDownloadImage(
//                 imageUrl: documentImageData.documentUrl,
//                 cacheKey: documentImageData.documentTag,
//                 decrypt: false),
//             builder: (context, snapshot) {
//               Widget child;
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 // Display a loading indicator while the future is not complete
//                 child = const SizedBox(
//                   height: 25,
//                   width: 25,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 5,
//                     color: AppColors.backgroundColor,
//                   ),
//                 );
//               } else if (snapshot.hasError) {
//                 // Display an error message if the future encounters an error
//                 child = Text('Error: ${snapshot.error}',
//                     style: const TextStyle(color: Colors.orange));
//               } else {
//                 // Display the result when the future is complete
//                 child = ClipRRect(
//                     borderRadius: const BorderRadius.all(Radius.circular(5)),
//                     child: snapshot.data!);
//               }
//               return AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 300), child: child);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
