import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';

/// Displays the full support category hierarchy as a collapsible tree.
///
/// Root categories are color-coded. Branch nodes use [ExpansionBody]
/// and [ExpansionHeader], leaf nodes render as plain text rows.
class SupportCategoryTree extends StatelessWidget {
  final int? parentId;
  final int indentation;
  final Color? backGroundColor;

  const SupportCategoryTree({
    required this.parentId,
    required this.indentation,
    this.backGroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final supportCategories =
        di<SupportCategoryManager>().supportCategories.value;

    // Sibling order follows the manager's list order (no sort here).
    final nodes = [
      for (final category in supportCategories)
        if (category.parentCategory == parentId)
          _CategoryNode(
            category: category,
            indentation: indentation,
            inheritedColor: backGroundColor,
          ),
    ];

    return Column(children: nodes);
  }
}

/// A single node in the category tree.
///
/// Determines if the category has children and renders as a
/// [_BranchNode] (expandable) or [_LeafNode] (plain text) accordingly.
class _CategoryNode extends StatelessWidget {
  final SupportCategory category;
  final int indentation;
  final Color? inheritedColor;

  const _CategoryNode({
    required this.category,
    required this.indentation,
    required this.inheritedColor,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        inheritedColor ??
        LearningSupportHelper.getRootSupportCategoryColor(category);

    final supportCategories =
        di<SupportCategoryManager>().supportCategories.value;

    final children = supportCategories
        .where((c) => c.parentCategory == category.categoryId)
        .toList();
    final hasChildren = children.isNotEmpty;

    // Flatten single-child branch: show category and child as rows, no ExpansionTile.
    final isSingleLeafBranch =
        hasChildren &&
        children.length == 1 &&
        !supportCategories.any(
          (c) => c.parentCategory == children.single.categoryId,
        );

    return Padding(
      padding: EdgeInsets.only(top: Style.spacing.xs, left: 5.0 * indentation),
      child: hasChildren
          ? isSingleLeafBranch
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LeafNode(category: category),
                      SupportCategoryTree(
                        parentId: category.categoryId,
                        indentation: indentation + 1,
                        backGroundColor: color,
                      ),
                    ],
                  )
                : _BranchNode(
                    category: category,
                    indentation: indentation,
                    color: color,
                  )
          : _LeafNode(category: category),
    );
  }
}

/// An expandable branch node containing a nested [SupportCategoryTree].
class _BranchNode extends WatchingWidget {
  final SupportCategory category;
  final int indentation;
  final Color color;

  const _BranchNode({
    required this.category,
    required this.indentation,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final controller = createOnce(() => ExpansionController());
    final isRoot = category.parentCategory == null;

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Style.radii.small),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Style.spacing.md),
            child: Row(
              children: [
                Gap(Style.spacing.xs),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.toggle(),
                    child: Text(
                      category.name,
                      style: TextStyle(
                        color: style.colors.background,
                        fontWeight: FontWeight.bold,
                        fontSize: isRoot ? 20 : 16,
                      ),
                    ),
                  ),
                ),
                ExpansionHeader(
                  expansionController: controller,
                  switchColor: style.colors.background,
                ),
                Gap(Style.spacing.xs),
              ],
            ),
          ),
          ExpansionBody(
            tileController: controller,
            widgetList: [
              SupportCategoryTree(
                parentId: category.categoryId,
                indentation: indentation + 1,
                backGroundColor: color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A leaf node displaying the category name as plain text.
class _LeafNode extends StatelessWidget {
  final SupportCategory category;

  const _LeafNode({required this.category});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(Style.spacing.xs),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(Style.spacing.sm),
            child: Text(
              category.name,
              textAlign: TextAlign.start,
              style: context.typography.body.withColor(style.colors.background),
              softWrap: true,
            ),
          ),
        ),
      ],
    );
  }
}
