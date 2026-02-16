import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_goal/support_category_badge.dart';

class CategoryTreeAncestors extends StatelessWidget {
  final bool? showBadge;
  final int categoryId;

  const CategoryTreeAncestors({
    required this.categoryId,
    this.showBadge = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final learningSupportManager = di<SupportCategoryManager>();
    final rootCategoryId = learningSupportManager
        .getRootSupportCategory(categoryId)
        .categoryId;

    final ancestorNames = <Widget>[];

    void collectAncestors(int currentCategoryId) {
      final SupportCategory currentCategory = learningSupportManager
          .getSupportCategory(currentCategoryId);

      // Recurse into parent first so ancestors are ordered root -> leaf
      if (currentCategory.parentCategory != null) {
        collectAncestors(currentCategory.parentCategory!);
      }

      // Intermediate ancestors (not root, not current category)
      if (currentCategory.categoryId != rootCategoryId &&
          currentCategory.categoryId != categoryId) {
        ancestorNames.add(
          Text(
            currentCategory.name,
            style: const TextStyle(
              //color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        );
      }
    }

    collectAncestors(categoryId);

    // Add the current category name as the last entry
    final currentCategory = learningSupportManager.getSupportCategory(
      categoryId,
    );
    final categoryColor = learningSupportManager.getCategoryColor(categoryId);
    ancestorNames.add(
      Text(
        currentCategory.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: categoryColor,
        ),
      ),
    );

    return Row(
      children: [
        if (showBadge == true) ...[
          SupportCategoryBadge(categoryId: categoryId, size: 40.0),
          const Gap(10),
        ],

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: ancestorNames,
          ),
        ),
      ],
    );
  }
}
