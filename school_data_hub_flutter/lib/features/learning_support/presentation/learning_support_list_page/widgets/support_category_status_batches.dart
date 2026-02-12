import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class SupportCategoryStatusBatches extends StatelessWidget {
  final PupilProxy pupil;
  const SupportCategoryStatusBatches({super.key, required this.pupil});

  @override
  Widget build(BuildContext context) {
    final learningSupportManager = di<SupportCategoryManager>();
    List<SupportCategoryStatus> supportCategoryStatuses =
        pupil.supportCategoryStatuses!;
    List<Widget> widgetList = [];
    Map<int, int> categoryCounts = {};
    Set<int> countedCategoryIds = {};

    // Calculate counts
    for (SupportCategoryStatus supportCategoryStatus
        in supportCategoryStatuses) {
      if (countedCategoryIds.contains(
        supportCategoryStatus.supportCategoryId,
      )) {
        continue;
      }
      countedCategoryIds.add(supportCategoryStatus.supportCategoryId);
      int rootCategoryId = learningSupportManager
          .getRootSupportCategory(supportCategoryStatus.supportCategoryId)
          .categoryId;
      if (categoryCounts.containsKey(rootCategoryId)) {
        categoryCounts[rootCategoryId] = categoryCounts[rootCategoryId]! + 1;
      } else {
        categoryCounts[rootCategoryId] = 1;
      }
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
              width: 35.0,
              height: 35.0,
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
                  width: 40.0,
                  height: 40.0,
                ),
              ),
            ),
            const Gap(2),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
