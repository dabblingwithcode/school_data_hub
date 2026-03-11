import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_reorderable_list_view.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_item_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_items_sortable_list_page/widgets/report_item_leaf_card_sortable.dart';

class ReportItemCardSortable extends WatchingStatefulWidget {
  final CompetenceReportItem item;
  final int index;
  final List<CompetenceReportItem> allItems;
  final void Function({int? parentItemId, CompetenceReportItem? item})
  navigateToPostOrPatch;

  const ReportItemCardSortable({
    required this.item,
    required this.index,
    required this.allItems,
    required this.navigateToPostOrPatch,
    super.key,
  });

  @override
  State<ReportItemCardSortable> createState() => _ReportItemCardSortableState();
}

class _ReportItemCardSortableState extends State<ReportItemCardSortable> {
  late List<int> _childOrder;

  @override
  void initState() {
    super.initState();
    _childOrder = _buildChildOrder();
  }

  @override
  void didUpdateWidget(ReportItemCardSortable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.allItems != oldWidget.allItems) {
      _childOrder = _buildChildOrder();
    }
  }

  List<int> _buildChildOrder() {
    final children =
        widget.allItems
            .where((i) => i.parentItem == widget.item.publicId)
            .toList()
          ..sort((a, b) {
            if (a.order != null && b.order != null) {
              return a.order!.compareTo(b.order!);
            }
            if (a.order != null) return -1;
            if (b.order != null) return 1;
            return a.publicId.compareTo(b.publicId);
          });
    return children.map((i) => i.publicId).toList();
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final id = _childOrder.removeAt(oldIndex);
      _childOrder.insert(newIndex, id);

      for (int i = 0; i < _childOrder.length; i++) {
        final item = di<CompetenceReportItemManager>().findItemById(
          _childOrder[i],
        );
        if (item.order != i) {
          di<CompetenceReportItemManager>().updateItemOrder(
            publicId: _childOrder[i],
            order: i,
          );
        }
      }
    });
  }

  Widget _buildChildItem(int index, int publicId) {
    final item = widget.allItems.firstWhere((i) => i.publicId == publicId);
    final hasChildren = widget.allItems.any((i) => i.parentItem == publicId);

    if (hasChildren) {
      return ReportItemCardSortable(
        key: ValueKey(publicId),
        index: index,
        item: item,
        allItems: widget.allItems,
        navigateToPostOrPatch: widget.navigateToPostOrPatch,
      );
    } else {
      return Padding(
        key: ValueKey(publicId),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ReportItemLeafCardSortable(
          index: index,
          item: item,
          navigateToPostOrPatch: widget.navigateToPostOrPatch,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final expansionController = createOnce(
      () => CustomExpansionTileController(),
    );
    final isExpanded = watch(expansionController.isExpanded).value;
    final isRoot = widget.item.parentItem == null;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isRoot ? 3 : 0),
      child: Card(
        color: AppColors.backgroundColor,
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
                      onTap: () =>
                          widget.navigateToPostOrPatch(item: widget.item),
                      onLongPress: () => widget.navigateToPostOrPatch(
                        parentItemId: widget.item.publicId,
                      ),
                      child: Text(
                        widget.item.name,
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
                  if (_childOrder.isNotEmpty) ...[
                    CustomExpansionTileSwitch(
                      customExpansionTileController: expansionController,
                    ),
                  ],
                  if (isExpanded)
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
                tileController: expansionController,
                widgetList: [
                  GenericReorderableListView(
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
