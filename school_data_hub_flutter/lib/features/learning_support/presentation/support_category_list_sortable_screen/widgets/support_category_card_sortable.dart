import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/reorderable_list.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_screen/select_parent_category_screen.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_screen/widgets/support_category_leaf_card_sortable.dart';

class SupportCategoryCardSortable extends WatchingStatefulWidget {
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

  @override
  void initState() {
    super.initState();
    _childOrder = _buildChildOrder();
  }

  @override
  void didUpdateWidget(SupportCategoryCardSortable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.allCategories != oldWidget.allCategories) {
      _childOrder = _buildChildOrder();
    }
  }

  List<int> _buildChildOrder() {
    final children =
        widget.allCategories
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
    final result = await context.push<int>(
      RoutePaths.learningSupportCategorySelectParent,
      extra: widget.category.categoryId,
    );
    if (result != null && context.mounted) {
      final newParent = result == SelectParentCategoryScreen.rootSentinel
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

    final parentId = widget.category.categoryId;
    if (hasChildren) {
      return SupportCategoryCardSortable(
        key: ValueKey('child_${parentId}_$categoryId'),
        index: index,
        category: category,
        backgroundColor: widget.backgroundColor,
        allCategories: widget.allCategories,
      );
    } else {
      return Padding(
        key: ValueKey('child_${parentId}_$categoryId'),
        padding: EdgeInsets.all(Style.spacing.xs),
        child: SupportCategoryLeafCardSortable(
          index: index,
          category: category,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final expansionController = createOnce(() => ExpansionController());
    final isExpanded = watch(expansionController.isExpanded).value;
    final isRoot = widget.category.parentCategory == null;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isRoot ? 3 : 0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(Style.radii.medium),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Style.spacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(Style.spacing.md),
                  Expanded(
                    child: GestureDetector(
                      onLongPress: () => _navigateToSelectParent(context),
                      child: Text(
                        widget.category.name,
                        maxLines: 4,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: style.colors.background,
                          fontWeight: FontWeight.bold,
                          fontSize: isRoot ? 20 : 16,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: style.colors.background,
                      size: 22,
                    ),
                    onPressed: () {
                      context.push(
                        RoutePaths.learningSupportCategoryEdit,
                        extra: {'category': widget.category},
                      );
                    },
                    tooltip: 'Kategorie bearbeiten',
                  ),
                  Checkbox(
                    value: widget.category.printable ?? false,
                    checkColor: widget.backgroundColor,
                    fillColor: WidgetStateProperty.all(style.colors.background),
                    onChanged: (value) {
                      di<SupportCategoryManager>()
                          .updateSupportCategoryPrintable(
                            categoryId: widget.category.categoryId,
                            printable: value ?? false,
                          );
                    },
                  ),
                  if (_childOrder.isNotEmpty) ...[
                    ExpansionHeader(expansionController: expansionController),
                  ],
                  if (isExpanded)
                    const SizedBox(width: 36)
                  else
                    ReorderableDragStartListener(
                      index: widget.index,
                      child: Icon(
                        Icons.drag_handle,
                        color: style.colors.background.withValues(alpha: 0.7),
                      ),
                    ),
                ],
              ),
            ),
            if (_childOrder.isNotEmpty)
              ExpansionBody(
                tileController: expansionController,
                widgetList: [
                  ReorderableList(
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
