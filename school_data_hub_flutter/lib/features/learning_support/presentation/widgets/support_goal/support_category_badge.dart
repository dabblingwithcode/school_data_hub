import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';

class SupportCategoryBadge extends StatelessWidget {
  final int categoryId;
  const SupportCategoryBadge({required this.categoryId, super.key});

  @override
  Widget build(BuildContext context) {
    final learningSupportManager = di<SupportCategoryManager>();
    final rootCategory = learningSupportManager.getRootSupportCategory(
      categoryId,
    );
    final rootCategoryColor = LearningSupportHelper.getRootSupportCategoryColor(
      rootCategory,
    );
    final rootCategoryIcon = LearningSupportHelper.getRootSupportCategoryIcon(
      rootCategory,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 35.0,
          height: 35.0,
          decoration: BoxDecoration(
            color: rootCategoryColor,
            shape: BoxShape.circle,
          ),
          child: Image.asset(rootCategoryIcon, width: 35.0, height: 35.0),
        ),
      ],
    );
  }
}
