import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:watch_it/watch_it.dart';

final _learningSupportManager = di<SupportCategoryManager>();

class SupportCategoryCardBanner extends StatelessWidget {
  final int categoryId;
  const SupportCategoryCardBanner({required this.categoryId, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: LearningSupportHelper.getRootSupportCategoryColor(
              _learningSupportManager.getRootSupportCategory(categoryId)),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _learningSupportManager
                        .getRootSupportCategory(categoryId)
                        .name,
                    style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
