import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_card.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_goal/support_category_badge.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class SupportCategoryStatusesList extends WatchingWidget {
  final PupilProxy pupil;

  const SupportCategoryStatusesList({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    final statuses = pupil.supportCategoryStatuses;
    if (statuses == null || statuses.isEmpty) {
      return const SizedBox.shrink();
    }

    final categoryManager = di<SupportCategoryManager>();

    // Group statuses by their supportCategoryId
    final statusesByCategoryId = <int, List<SupportCategoryStatus>>{};
    for (final status in statuses) {
      statusesByCategoryId
          .putIfAbsent(status.supportCategoryId, () => [])
          .add(status);
    }

    // Group the leaf category entries by root category
    final leafCategoryIdsByRoot = <int, List<int>>{};
    for (final categoryId in statusesByCategoryId.keys) {
      final rootCategoryId = categoryManager.getRootSupportCategoryId(
        categoryId,
      );
      leafCategoryIdsByRoot
          .putIfAbsent(rootCategoryId, () => [])
          .add(categoryId);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final rootCategoryId in leafCategoryIdsByRoot.keys) ...[
          _RootCategoryHeader(rootCategoryId: rootCategoryId),
          for (final categoryId in leafCategoryIdsByRoot[rootCategoryId]!)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SupportCategoryStatusCard(
                pupil: pupil,
                statusesWithSameGoalCategory: statusesByCategoryId[categoryId]!,
              ),
            ),
        ],
      ],
    );
  }
}

class _RootCategoryHeader extends StatelessWidget {
  final int rootCategoryId;

  const _RootCategoryHeader({required this.rootCategoryId});

  @override
  Widget build(BuildContext context) {
    final categoryManager = di<SupportCategoryManager>();
    final rootCategory = categoryManager.getSupportCategory(rootCategoryId);
    final color = LearningSupportHelper.getRootSupportCategoryColor(
      rootCategory,
    );
    final iconPath = LearningSupportHelper.getRootSupportCategoryIcon(
      rootCategory,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SupportCategoryBadge(categoryId: rootCategoryId, size: 40.0),
          const Gap(10),
          Text(
            rootCategory.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
