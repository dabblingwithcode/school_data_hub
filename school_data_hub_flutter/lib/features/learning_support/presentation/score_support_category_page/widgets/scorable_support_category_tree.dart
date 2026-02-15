import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/score_support_category_page/manager/score_support_category_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

const _categoryTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

/// Displays a recursive tree of support categories for a given pupil,
/// with branch nodes as [ExpansionTile]s and leaf nodes with [GrowthDropdown]
/// for scoring.
class ScorableSupportCategoryTree extends WatchingWidget {
  final PupilProxy pupil;
  final int? parentCategoryId;
  final double indentation;
  final Color? backGroundColor;
  final ScoreSupportCategoryManager manager;

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
  final ScoreSupportCategoryManager manager;

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
      padding: EdgeInsets.only(top: 10, left: indentation),
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
  final ScoreSupportCategoryManager manager;

  const _BranchNode({
    required this.category,
    required this.pupil,
    required this.indentation,
    required this.color,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    // Watch pending scores to react to changes
    watch(manager.pendingScores);

    final isScorable =
        category.parentCategory != null && category.printable == true;
    final currentScore = manager.getScoreForCategory(category.categoryId) ?? 0;
    final hasExisting = manager.hasExistingStatus(category.categoryId);

    return Card(
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      child: ExpansionTile(
        iconColor: Colors.white,
        collapsedTextColor: Colors.white,
        collapsedIconColor: Colors.white,
        textColor: Colors.white,
        maintainState: false,
        backgroundColor: color,
        collapsedBackgroundColor: color,
        title: Row(
          children: [
            if (isScorable) ...[
              _ScoreIndicator(hasExisting: hasExisting),
              const Gap(5),
            ],
            Expanded(
              child: Text(
                category.name,
                maxLines: 3,
                style: _categoryTextStyle,
              ),
            ),
            if (isScorable) ...[
              const Gap(5),
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
  final ScoreSupportCategoryManager manager;

  const _LeafNode({
    required this.category,
    required this.pupil,
    required this.color,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    // Watch pending scores to react to changes
    watch(manager.pendingScores);

    final isScorable =
        category.parentCategory != null && category.printable == true;
    final currentScore = manager.getScoreForCategory(category.categoryId) ?? 0;
    final hasExisting = manager.hasExistingStatus(category.categoryId);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (isScorable) ...[
            _ScoreIndicator(hasExisting: hasExisting),
            const Gap(5),
          ],
          Expanded(
            child: Text(
              category.name,
              maxLines: 4,
              textAlign: TextAlign.start,
              style: _categoryTextStyle,
            ),
          ),
          if (isScorable) ...[
            const Gap(10),
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
        color: hasExisting ? Colors.greenAccent : Colors.transparent,
        border: Border.all(
          color: hasExisting ? Colors.greenAccent : Colors.white54,
          width: 1,
        ),
      ),
    );
  }
}
