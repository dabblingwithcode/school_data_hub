import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_page/select_parent_category_page.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_page/widgets/support_category_leaf_card_sortable.dart';

class SupportCategoryCardSortable extends StatefulWidget {
  final SupportCategory category;
  final Color backgroundColor;
  final int index;
  final List<SupportCategory> allCategories;

  const SupportCategoryCardSortable({
    required this.category,
    required this.backgroundColor,
    required this.index,
    required this.allCategories,
    super.key,
  });

  @override
  State<SupportCategoryCardSortable> createState() =>
      _SupportCategoryCardSortableState();
}

class _SupportCategoryCardSortableState
    extends State<SupportCategoryCardSortable> {
  late List<int> _childOrder;
  late final CustomExpansionTileController _expansionController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _childOrder = _buildChildOrder();
    _expansionController = CustomExpansionTileController();
  }

  @override
  void didUpdateWidget(SupportCategoryCardSortable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.allCategories != oldWidget.allCategories) {
      _childOrder = _buildChildOrder();
    }
  }

  List<int> _buildChildOrder() {
    final children = widget.allCategories
        .where((c) => c.parentCategory == widget.category.categoryId)
        .toList()
      ..sort((a, b) {
        if (a.order != null && b.order != null) {
          return a.order!.compareTo(b.order!);
        }
        if (a.order != null) return -1;
        if (b.order != null) return 1;
        return a.categoryId.compareTo(b.categoryId);
      });
    return children.map((c) => c.categoryId).toList();
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final id = _childOrder.removeAt(oldIndex);
      _childOrder.insert(newIndex, id);

      for (int i = 0; i < _childOrder.length; i++) {
        final category = di<SupportCategoryManager>().getSupportCategory(
          _childOrder[i],
        );
        if (category.order != i) {
          di<SupportCategoryManager>().updateSupportCategoryOrder(
            categoryId: _childOrder[i],
            order: i,
          );
        }
      }
    });
  }

  Future<void> _navigateToSelectParent(BuildContext context) async {
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (ctx) => SelectParentCategoryPage(
          movingCategoryId: widget.category.categoryId,
        ),
      ),
    );
    if (result != null && context.mounted) {
      final newParent = result == SelectParentCategoryPage.rootSentinel
          ? null
          : result;
      await di<SupportCategoryManager>().updateSupportCategoryParent(
        categoryId: widget.category.categoryId,
        parentCategory: newParent,
      );
    }
  }

  Widget _buildChildItem(int index, int categoryId) {
    final category = widget.allCategories.firstWhere(
      (c) => c.categoryId == categoryId,
    );
    final hasChildren = widget.allCategories.any(
      (c) => c.parentCategory == categoryId,
    );

    if (hasChildren) {
      return SupportCategoryCardSortable(
        key: ValueKey(categoryId),
        index: index,
        category: category,
        backgroundColor: widget.backgroundColor,
        allCategories: widget.allCategories,
      );
    } else {
      return Padding(
        key: ValueKey(categoryId),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SupportCategoryLeafCardSortable(
          index: index,
          category: category,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRoot = widget.category.parentCategory == null;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isRoot ? 3 : 0),
      child: Card(
        color: widget.backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(10),
                  Expanded(
                    child: InkWell(
                      onLongPress: () => _navigateToSelectParent(context),
                      child: Text(
                        widget.category.name,
                        maxLines: 4,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isRoot ? 20 : 16,
                        ),
                      ),
                    ),
                  ),
                  Checkbox(
                    value: widget.category.printable ?? false,
                    checkColor: widget.backgroundColor,
                    fillColor: WidgetStateProperty.all(Colors.white),
                    onChanged: (value) {
                      di<SupportCategoryManager>()
                          .updateSupportCategoryPrintable(
                            categoryId: widget.category.categoryId,
                            printable: value ?? false,
                          );
                    },
                  ),
                  if (_childOrder.isNotEmpty) ...[
                    CustomExpansionTileSwitch(
                      customExpansionTileController: _expansionController,
                      onChanged: (expanded) {
                        setState(() {
                          _isExpanded = expanded;
                        });
                      },
                    ),
                  ],
                  if (_isExpanded)
                    const SizedBox(width: 36)
                  else
                    ReorderableDragStartListener(
                      index: widget.index,
                      child: const Icon(
                        Icons.drag_handle,
                        color: Colors.white70,
                      ),
                    ),
                ],
              ),
            ),
            if (_childOrder.isNotEmpty)
              CustomExpansionTileContent(
                tileController: _expansionController,
                widgetList: [
                  ReorderableListView(
                    buildDefaultDragHandles: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    onReorder: _onReorder,
                    children: [
                      for (int i = 0; i < _childOrder.length; i++)
                        _buildChildItem(i, _childOrder[i]),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
