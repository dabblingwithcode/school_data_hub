import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_card.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_goal/support_category_badge.dart';

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
        for (final rootCategoryId in leafCategoryIdsByRoot.keys)
          _RootCategoryExpansionTile(
            pupil: pupil,
            rootCategoryId: rootCategoryId,
            leafCategoryIds: leafCategoryIdsByRoot[rootCategoryId]!,
            statusesByCategoryId: statusesByCategoryId,
          ),
      ],
    );
  }
}

class _RootCategoryExpansionTile extends WatchingWidget {
  final PupilProxy pupil;
  final int rootCategoryId;
  final List<int> leafCategoryIds;
  final Map<int, List<SupportCategoryStatus>> statusesByCategoryId;

  const _RootCategoryExpansionTile({
    required this.pupil,
    required this.rootCategoryId,
    required this.leafCategoryIds,
    required this.statusesByCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(() => ExpansionController());
    final categoryManager = di<SupportCategoryManager>();
    final rootCategory = categoryManager.getSupportCategory(rootCategoryId);
    final color = LearningSupportHelper.getRootSupportCategoryColor(
      rootCategory,
    );

    // Calculate total number of statuses for this root category
    int totalStatuses = 0;
    for (final categoryId in leafCategoryIds) {
      totalStatuses += statusesByCategoryId[categoryId]?.length ?? 0;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Style.of(context).colors.cardInCard,
          borderRadius: BorderRadius.circular(Style.radii.medium),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => tileController.toggle(),
              child: Padding(
                padding: EdgeInsets.all(Style.spacing.md),
                child: Row(
                  children: [
                    SupportCategoryBadge(categoryId: rootCategoryId, size: 40.0),
                    Gap(Style.spacing.md),
                    Expanded(
                      child: Text(
                        rootCategory.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.typography.title.withColor(color),
                      ),
                    ),
                    Gap(Style.spacing.md),
                    Text(
                      totalStatuses.toString(),
                      style: context.typography.title.withColor(color),
                    ),
                    Gap(Style.spacing.md),
                    ExpansionHeader(
                      expansionController: tileController,
                      switchColor: color,
                    ),
                  ],
                ),
              ),
            ),
            ExpansionBody(
              tileController: tileController,
              widgetList: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Style.spacing.sm,
                    vertical: 4.0,
                  ),
                  child: Column(
                    children: [
                      for (final categoryId in leafCategoryIds)
                        Padding(
                          padding: EdgeInsets.only(bottom: Style.spacing.sm),
                          child: SupportCategoryStatusCard(
                            pupil: pupil,
                            statusesWithSameGoalCategory:
                                statusesByCategoryId[categoryId]!,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
