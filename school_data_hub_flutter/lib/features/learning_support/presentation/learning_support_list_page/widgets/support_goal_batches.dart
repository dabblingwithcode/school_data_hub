import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';

class SupportGoalBatches extends StatelessWidget {
  final PupilProxy pupil;
  const SupportGoalBatches({super.key, required this.pupil});

  @override
  Widget build(BuildContext context) {
    final learningSupportManager = di<SupportCategoryManager>();
    final supportGoals = pupil.supportGoals;
    List<Widget> widgetList = [];
    Map<int, int> categoryCounts = {};

    // Calculate counts of support goals per root category
    for (final supportGoal in supportGoals) {
      int rootCategoryId = learningSupportManager
          .getRootSupportCategory(supportGoal.supportCategoryId)
          .categoryId;
      categoryCounts[rootCategoryId] =
          (categoryCounts[rootCategoryId] ?? 0) + 1;
    }

    categoryCounts.forEach((categoryId, count) {
      final rootCategory = learningSupportManager.getRootSupportCategory(
        categoryId,
      );
      widgetList.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: LearningSupportHelper.getRootSupportCategoryColor(
                  rootCategory,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  LearningSupportHelper.getRootSupportCategoryIcon(
                    rootCategory,
                  ),
                  width: 35.0,
                  height: 35.0,
                ),
              ),
            ),
            const Gap(2),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
      widgetList.add(const Gap(5));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [...widgetList],
    );
  }
}
