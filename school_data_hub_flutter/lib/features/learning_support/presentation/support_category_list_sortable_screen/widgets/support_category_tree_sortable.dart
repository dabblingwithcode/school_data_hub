import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/reorderable_list.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_screen/widgets/support_category_leaf_card_sortable.dart';

import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_screen/widgets/support_category_card_sortable.dart';

class SupportCategoryTreeSortable extends StatefulWidget {
  final List<SupportCategory> categories;

  const SupportCategoryTreeSortable({super.key, required this.categories});

  @override
  State<SupportCategoryTreeSortable> createState() =>
      _SupportCategoryTreeSortableState();
}

class _SupportCategoryTreeSortableState
    extends State<SupportCategoryTreeSortable> {
  late List<int> _rootOrder;

  @override
  void initState() {
    super.initState();
    _rootOrder = _buildRootOrder();
  }

  @override
  void didUpdateWidget(SupportCategoryTreeSortable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.categories != oldWidget.categories) {
      _rootOrder = _buildRootOrder();
    }
  }

  List<int> _buildRootOrder() {
    final roots =
        widget.categories.where((c) => c.parentCategory == null).toList()
          ..sort((a, b) {
            if (a.order != null && b.order != null) {
              return a.order!.compareTo(b.order!);
            }
            if (a.order != null) return -1;
            if (b.order != null) return 1;
            return a.categoryId.compareTo(b.categoryId);
          });
    return roots.map((c) => c.categoryId).toList();
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final id = _rootOrder.removeAt(oldIndex);
      _rootOrder.insert(newIndex, id);

      for (int i = 0; i < _rootOrder.length; i++) {
        final category = di<SupportCategoryManager>().getSupportCategory(
          _rootOrder[i],
        );
        if (category.order != i) {
          di<SupportCategoryManager>().updateSupportCategoryOrder(
            categoryId: _rootOrder[i],
            order: i,
          );
        }
      }
    });
  }

  Widget _buildRootItem(int index, int categoryId) {
    final category = widget.categories.firstWhere(
      (c) => c.categoryId == categoryId,
    );
    final color = LearningSupportHelper.getRootSupportCategoryColor(category);
    final hasChildren = widget.categories.any(
      (c) => c.parentCategory == categoryId,
    );

    if (hasChildren) {
      return SupportCategoryCardSortable(
        key: ValueKey('root_$categoryId'),
        index: index,
        category: category,
        backgroundColor: color,
        allCategories: widget.categories,
      );
    } else {
      return Padding(
        key: ValueKey('root_$categoryId'),
        padding: EdgeInsets.symmetric(horizontal: Style.spacing.xs),
        child: SupportCategoryLeafCardSortable(
          index: index,
          category: category,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableList(
      onReorder: _onReorder,
      children: [
        for (int i = 0; i < _rootOrder.length; i++)
          _buildRootItem(i, _rootOrder[i]),
      ],
    );
  }
}
