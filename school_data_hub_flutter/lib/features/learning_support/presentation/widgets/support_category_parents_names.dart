import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:watch_it/watch_it.dart';

// class CategoryTreeParentsNames extends StatelessWidget {
//   final int categoryId;
//   final Color categoryColor;

//   const CategoryTreeParentsNames(
//       {required this.categoryColor, required this.categoryId, super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> ancestors = [];
//     void collectAncestors(int currentCategoryId) {
//       final SupportCategory currentCategory = _learningSupportManager
//           .getSupportCategory(currentCategoryId);

//       // Check if parent category exists before recursion
//       if (currentCategory.parentCategory != null) {
//         collectAncestors(currentCategory.parentCategory!);
//       }
//       if (currentCategory.categoryId ==
//           _learningSupportManager
//               .getRootSupportCategory(categoryId)
//               .categoryId) {
//         ancestors.add(
//           Row(
//             children: [
//               const Gap(10),
//               Flexible(
//                 child: Text(
//                     _learningSupportManager
//                         .getRootSupportCategory(categoryId)
//                         .categoryName,
//                     style: const TextStyle(
//                       overflow: TextOverflow.fade,
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     )),
//               ),
//               const Gap(10),
//             ],
//           ),
//         );
//       }
//       // Add current category name to the list after recursion
//       if (currentCategory.categoryId !=
//           _learningSupportManager
//               .getRootSupportCategory(categoryId)
//               .categoryId) {
//         if (currentCategory.categoryId != categoryId) {
//           ancestors.add(
//             Row(
//               children: [
//                 const Gap(10),
//                 Flexible(
//                   child: Text(
//                     currentCategory.categoryName,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//                 const Gap(10),
//               ],
//             ),
//           );
//         }
//       }
//     }

//     return Container();
//   }
// }

List<Widget> categoryTreeAncestorsNames(
    {required int categoryId, required Color categoryColor}) {
  final _learningSupportManager = di<SupportCategoryManager>();
  // Create an empty list to store ancestors
  List<Widget> ancestors = [];

  // Use a recursive helper function to collect ancestors
  void collectAncestors(int currentCategoryId) {
    final SupportCategory currentCategory =
        _learningSupportManager.getSupportCategory(currentCategoryId);

    // Check if parent category exists before recursion
    if (currentCategory.parentCategory != null) {
      collectAncestors(currentCategory.parentCategory!);
    }

    if (currentCategory.categoryId ==
        _learningSupportManager.getRootSupportCategory(categoryId).categoryId) {
      ancestors.add(
        Row(
          children: [
            const Gap(10),
            Flexible(
              child: Text(
                  _learningSupportManager
                      .getRootSupportCategory(categoryId)
                      .name,
                  style: const TextStyle(
                    overflow: TextOverflow.fade,
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const Gap(10),
          ],
        ),
      );
    }
    // Add current category name to the list after recursion
    if (currentCategory.categoryId !=
        _learningSupportManager.getRootSupportCategory(categoryId).categoryId) {
      if (currentCategory.categoryId != categoryId) {
        ancestors.add(
          Row(
            children: [
              const Gap(10),
              Flexible(
                child: Text(
                  currentCategory.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const Gap(10),
            ],
          ),
        );
      }
    }
  }

  // Start the recursion from the input category
  collectAncestors(categoryId);

  ancestors.add(const Gap(5));
  return ancestors;
}
