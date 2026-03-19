import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/set_bulk_support_categoies_status_screen/manager/set_bulk_support_categories_status_manager.dart';

/// Displays a recursive tree of support categories for a given pupil,
/// with branch nodes as [ExpansionTile]s and leaf nodes with [GrowthDropdown]
/// for scoring.
class ScorableSupportCategoryTree extends WatchingWidget {
  final PupilProxy pupil;
  final int? parentCategoryId;
  final double indentation;
  final Color? backGroundColor;
  final SetBuldSupportCategoriesStatusManager manager;

  const ScorableSupportCategoryTree({
    required this.pupil,
    this.parentCategoryId,
    this.indentation = 0,
    this.backGroundColor,
    required this.manager,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final supportCategories =
        di<SupportCategoryManager>().supportCategories.value;

    return Column(
      children: [
        for (final category in supportCategories)
          if (category.parentCategory == parentCategoryId)
            _CategoryNode(
              category: category,
              pupil: pupil,
              indentation: indentation,
              inheritedColor: backGroundColor,
              manager: manager,
            ),
      ],
    );
  }
}

/// A single node in the support category tree.
///
/// Renders as a [_BranchNode] (expandable) if it has child categories,
/// or as a [_LeafNode] (scorable with GrowthDropdown) otherwise.
class _CategoryNode extends StatelessWidget {
  final SupportCategory category;
  final PupilProxy pupil;
  final double indentation;
  final Color? inheritedColor;
  final SetBuldSupportCategoriesStatusManager manager;

  const _CategoryNode({
    required this.category,
    required this.pupil,
    required this.indentation,
    required this.inheritedColor,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        inheritedColor ??
        LearningSupportHelper.getRootSupportCategoryColor(category);

    final supportCategories =
        di<SupportCategoryManager>().supportCategories.value;

    final hasChildren = supportCategories.any(
      (c) => c.parentCategory == category.categoryId,
    );

    return Padding(
      padding: EdgeInsets.only(top: Style.spacing.md, left: indentation),
      child: hasChildren
          ? _BranchNode(
              category: category,
              pupil: pupil,
              indentation: indentation,
              color: color,
              manager: manager,
            )
          : _LeafNode(
              category: category,
              pupil: pupil,
              color: color,
              manager: manager,
            ),
    );
  }
}

/// A branch node displayed as an [ExpansionTile] containing a nested
/// [ScorableSupportCategoryTree]. Branch nodes can also be scored.
class _BranchNode extends WatchingWidget {
  final SupportCategory category;
  final PupilProxy pupil;
  final double indentation;
  final Color color;
  final SetBuldSupportCategoriesStatusManager manager;

  const _BranchNode({
    required this.category,
    required this.pupil,
    required this.indentation,
    required this.color,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    // Watch pending scores to react to changes
    watch(manager.pendingScores);

    final isScorable =
        category.parentCategory != null && category.printable == true;
    final currentScore = manager.getScoreForCategory(category.categoryId) ?? 0;
    final hasExisting = manager.hasExistingStatus(category.categoryId);

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Style.radii.medium),
      ),
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        iconColor: style.colors.background,
        collapsedTextColor: style.colors.background,
        collapsedIconColor: style.colors.background,
        textColor: style.colors.background,
        maintainState: false,
        backgroundColor: color,
        collapsedBackgroundColor: color,
        title: Row(
          children: [
            if (isScorable) ...[
              _ScoreIndicator(hasExisting: hasExisting),
              Gap(Style.spacing.xs),
            ],
            Expanded(
              child: Text(
                category.name,
                maxLines: 3,
                style: context.typography.subtitle.bold.withColor(
                  style.colors.background,
                ),
              ),
            ),
            if (isScorable) ...[
              Gap(Style.spacing.xs),
              GrowthDropdown(
                dropdownValue: currentScore,
                onChangedFunction: (value) {
                  manager.setScore(category.categoryId, value);
                },
              ),
            ],
          ],
        ),
        children: [
          ScorableSupportCategoryTree(
            pupil: pupil,
            parentCategoryId: category.categoryId,
            indentation: indentation + 15,
            backGroundColor: color,
            manager: manager,
          ),
        ],
      ),
    );
  }
}

/// A leaf node displayed as a scorable row with a [GrowthDropdown].
class _LeafNode extends WatchingWidget {
  final SupportCategory category;
  final PupilProxy pupil;
  final Color color;
  final SetBuldSupportCategoriesStatusManager manager;

  const _LeafNode({
    required this.category,
    required this.pupil,
    required this.color,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    // Watch pending scores to react to changes
    watch(manager.pendingScores);

    final isScorable =
        category.parentCategory != null && category.printable == true;
    final currentScore = manager.getScoreForCategory(category.categoryId) ?? 0;
    final hasExisting = manager.hasExistingStatus(category.categoryId);

    return Padding(
      padding: EdgeInsets.all(Style.spacing.sm),
      child: Row(
        children: [
          if (isScorable) ...[
            _ScoreIndicator(hasExisting: hasExisting),
            Gap(Style.spacing.xs),
          ],
          Expanded(
            child: Text(
              category.name,
              maxLines: 4,
              textAlign: TextAlign.start,
              style: context.typography.subtitle.bold.withColor(
                style.colors.background,
              ),
            ),
          ),
          if (isScorable) ...[
            Gap(Style.spacing.md),
            GrowthDropdown(
              dropdownValue: currentScore,
              onChangedFunction: (value) {
                manager.setScore(category.categoryId, value);
              },
            ),
          ],
        ],
      ),
    );
  }
}

/// Visual indicator showing if a category already has an existing status
class _ScoreIndicator extends StatelessWidget {
  final bool hasExisting;

  const _ScoreIndicator({required this.hasExisting});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: hasExisting
            ? Style.of(context).colors.success
            : const Color(0x00000000),
        border: Border.all(
          color: hasExisting
              ? Style.of(context).colors.success
              : Style.of(context).colors.background.withValues(alpha: 0.54),
          width: 1,
        ),
      ),
    );
  }
}
