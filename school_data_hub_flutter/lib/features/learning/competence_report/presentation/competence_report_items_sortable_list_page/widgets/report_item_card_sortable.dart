import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/reorderable_list.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
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
        padding: EdgeInsets.symmetric(horizontal: Style.spacing.xs),
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
    final expansionController = createOnce(() => ExpansionController());
    final isExpanded = watch(expansionController.isExpanded).value;
    final isRoot = widget.item.parentItem == null;
    final style = Style.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isRoot ? 3 : 0),
      child: CardBox(
        padding: EdgeInsets.zero,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: style.colors.accent,
            borderRadius: BorderRadius.circular(Style.radii.medium),
          ),
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
                          style: isRoot
                              ? context.typography.title.withColor(style.colors.background)
                              : context.typography.subtitle.bold.withColor(style.colors.background),
                        ),
                      ),
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
      ),
    );
  }
}
