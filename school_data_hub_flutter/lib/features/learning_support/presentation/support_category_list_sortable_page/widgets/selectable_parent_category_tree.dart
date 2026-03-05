import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';

const _categoryTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

/// A recursive category tree with radio buttons for selecting a new parent
/// category. Excludes [excludedCategoryIds] to prevent circular references.
class SelectableParentCategoryTree extends StatelessWidget {
  final int? parentCategoryId;
  final double indentation;
  final Color? backgroundColor;
  final Set<int> excludedCategoryIds;
  final ValueNotifier<int?> selectedParentId;

  const SelectableParentCategoryTree({
    this.parentCategoryId,
    this.indentation = 0,
    this.backgroundColor,
    required this.excludedCategoryIds,
    required this.selectedParentId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final supportCategories =
        di<SupportCategoryManager>().supportCategories.value;

    return Column(
      children: [
        for (final category in supportCategories)
          if (category.parentCategory == parentCategoryId &&
              !excludedCategoryIds.contains(category.categoryId))
            _CategoryNode(
              category: category,
              indentation: indentation,
              inheritedColor: backgroundColor,
              excludedCategoryIds: excludedCategoryIds,
              selectedParentId: selectedParentId,
            ),
      ],
    );
  }
}

class _CategoryNode extends StatelessWidget {
  final SupportCategory category;
  final double indentation;
  final Color? inheritedColor;
  final Set<int> excludedCategoryIds;
  final ValueNotifier<int?> selectedParentId;

  const _CategoryNode({
    required this.category,
    required this.indentation,
    required this.inheritedColor,
    required this.excludedCategoryIds,
    required this.selectedParentId,
  });

  @override
  Widget build(BuildContext context) {
    final color = inheritedColor ??
        LearningSupportHelper.getRootSupportCategoryColor(category);

    final supportCategories =
        di<SupportCategoryManager>().supportCategories.value;

    final hasChildren = supportCategories.any(
      (c) =>
          c.parentCategory == category.categoryId &&
          !excludedCategoryIds.contains(c.categoryId),
    );

    return Padding(
      padding: EdgeInsets.only(top: 10, left: indentation),
      child: hasChildren
          ? _BranchNode(
              category: category,
              indentation: indentation,
              color: color,
              excludedCategoryIds: excludedCategoryIds,
              selectedParentId: selectedParentId,
            )
          : _LeafNode(
              category: category,
              color: color,
              selectedParentId: selectedParentId,
            ),
    );
  }
}

class _BranchNode extends StatelessWidget {
  final SupportCategory category;
  final double indentation;
  final Color color;
  final Set<int> excludedCategoryIds;
  final ValueNotifier<int?> selectedParentId;

  const _BranchNode({
    required this.category,
    required this.indentation,
    required this.color,
    required this.excludedCategoryIds,
    required this.selectedParentId,
  });

  @override
  Widget build(BuildContext context) {
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
            Radio<int?>(
              value: category.categoryId,
              fillColor: WidgetStateProperty.all(Colors.white),
            ),
            const Gap(5),
            Expanded(
              child: InkWell(
                onTap: () {
                  selectedParentId.value = category.categoryId;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    category.name,
                    maxLines: 3,
                    style: _categoryTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
        children: [
          SelectableParentCategoryTree(
            parentCategoryId: category.categoryId,
            indentation: indentation + 15,
            backgroundColor: color,
            excludedCategoryIds: excludedCategoryIds,
            selectedParentId: selectedParentId,
          ),
        ],
      ),
    );
  }
}

class _LeafNode extends StatelessWidget {
  final SupportCategory category;
  final Color color;
  final ValueNotifier<int?> selectedParentId;

  const _LeafNode({
    required this.category,
    required this.color,
    required this.selectedParentId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Radio<int?>(
              value: category.categoryId,
              fillColor: WidgetStateProperty.all(Colors.white),
            ),
            const Gap(5),
            Flexible(
              child: InkWell(
                onTap: () {
                  selectedParentId.value = category.categoryId;
                },
                child: Text(
                  category.name,
                  maxLines: 4,
                  textAlign: TextAlign.start,
                  style: _categoryTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
