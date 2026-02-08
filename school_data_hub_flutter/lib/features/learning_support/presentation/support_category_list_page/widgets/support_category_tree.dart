import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:flutter_it/flutter_it.dart';

/// Displays the full support category hierarchy as a collapsible tree.
///
/// Root categories are color-coded. Branch nodes render as [ExpansionTile]s,
/// leaf nodes render as plain text rows.
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
    final color = inheritedColor ??
        LearningSupportHelper.getRootSupportCategoryColor(category);

    final supportCategories =
        di<SupportCategoryManager>().supportCategories.value;

    final hasChildren = supportCategories
        .any((c) => c.parentCategory == category.categoryId);

    return Padding(
      padding: EdgeInsets.only(top: 10, left: 5.0 * indentation),
      child: hasChildren
          ? _BranchNode(
              category: category,
              indentation: indentation,
              color: color,
            )
          : _LeafNode(category: category),
    );
  }
}

/// An expandable branch node containing a nested [SupportCategoryTree].
class _BranchNode extends StatelessWidget {
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
    final isRoot = category.parentCategory == null;

    return Card(
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: ExpansionTile(
        iconColor: Colors.white,
        collapsedTextColor: Colors.white,
        collapsedIconColor: Colors.white,
        textColor: Colors.white,
        maintainState: true,
        backgroundColor: color,
        collapsedBackgroundColor: color,
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            category.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isRoot ? 20 : 16,
            ),
          ),
        ),
        children: [
          SupportCategoryTree(
            parentId: category.categoryId,
            indentation: indentation + 1,
            backGroundColor: color,
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        category.name,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}
